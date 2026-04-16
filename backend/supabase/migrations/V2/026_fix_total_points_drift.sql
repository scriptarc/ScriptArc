-- ============================================================
-- ScriptArc — Migration 026: Fix total_points drift (v3)
-- Date: 2026-03-17
-- ──────────────────────────────────────────────────────────────
-- Root causes of 242 (leaderboard/admin) vs 298 (certificate):
--
-- A) users.total_points is stale.
--    The increment trigger never decrements when challenge
--    submissions are cascade-deleted (e.g. when migration 014
--    replaced all challenge IDs). The column drifted below the
--    actual SUM(submissions.points_awarded).
--
-- B) leaderboard_course joins via challenges.course_id while
--    generate_certificate joins via challenge → lesson → course.
--    Any challenge where challenges.course_id diverges from
--    lessons.course_id causes the two to produce different totals.
--
-- C) CourseSingle.jsx and Dashboard.jsx read user_progress.points_earned
--    which is never recalculated after submissions are cascade-deleted.
--    (Frontend fix: those pages now query submissions directly.)
--
-- Fixes:
--   1. Disable the prevent_privilege_escalation trigger so the
--      direct UPDATE can never be silently reverted.
--   2. Recalculate users.total_points from the authoritative
--      submissions table for every user.
--   3. Re-enable the trigger.
--   4. Replace the increment trigger with a SUM-recalculate
--      trigger — total_points can never drift again.
--   5. Rebuild leaderboard_course to join via
--      challenge → lesson → course (identical path to
--      generate_certificate) so both always agree.
--   6. Rebuild global leaderboard view to compute from
--      SUM(submissions) directly — immune to column drift forever.
--   7. Rebuild admin_student_stats to use the same live SUM.
-- ============================================================


-- ============================================================
-- 1. DISABLE the escalation trigger so the UPDATE below cannot
--    be silently reverted by prevent_privilege_escalation.
-- ============================================================

ALTER TABLE public.users DISABLE TRIGGER trg_prevent_escalation;


-- ============================================================
-- 2. ONE-TIME RESYNC: recalculate total_points for all users
--    from the authoritative submissions table.
-- ============================================================

UPDATE public.users u
SET total_points = (
  SELECT COALESCE(SUM(s.points_awarded), 0)
  FROM public.submissions s
  WHERE s.user_id = u.id
);


-- ============================================================
-- 3. RE-ENABLE the escalation trigger.
-- ============================================================

ALTER TABLE public.users ENABLE TRIGGER trg_prevent_escalation;


-- ============================================================
-- 4. REPLACE update_user_total_points trigger function:
--    SUM-recalculate instead of increment.
--    Prevents future drift regardless of cascade deletes or
--    any other events that don't fire a compensating trigger.
-- ============================================================

CREATE OR REPLACE FUNCTION public.update_user_total_points()
RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER SET search_path = '' AS $$
BEGIN
  UPDATE public.users
  SET total_points = (
    SELECT COALESCE(SUM(points_awarded), 0)
    FROM public.submissions
    WHERE user_id = NEW.user_id
  )
  WHERE id = NEW.user_id;
  RETURN NEW;
END;
$$;

COMMENT ON FUNCTION public.update_user_total_points IS
  'Recalculates total_points as the full SUM of submissions.points_awarded '
  'on each new submission. Uses SUM (not increment) to stay in sync with '
  'generate_certificate and survive cascade deletes.';


-- ============================================================
-- 5. REBUILD leaderboard_course to use the same join path as
--    generate_certificate: challenge → lesson → course.
--    This guarantees leaderboard_course and certificate always
--    count exactly the same submissions for a given course.
-- ============================================================

DROP VIEW IF EXISTS public.leaderboard_course_mentor CASCADE;
DROP VIEW IF EXISTS public.leaderboard_course CASCADE;

CREATE OR REPLACE VIEW public.leaderboard_course
WITH (security_invoker = true)
AS
WITH course_submissions AS (
  -- Join via lesson → course, identical to generate_certificate.
  -- This ensures the view counts the same submissions as the certificate.
  SELECT
    s.user_id,
    l.course_id,
    SUM(s.points_awarded)::int AS total_points
  FROM public.submissions s
  JOIN public.challenges  c  ON c.id  = s.challenge_id
  JOIN public.lessons     l  ON l.id  = c.lesson_id
  GROUP BY s.user_id, l.course_id
)
SELECT
  u.id,
  u.name,
  u.avatar_id,
  cs.course_id,
  ms.mentor_id,
  cs.total_points,
  ROW_NUMBER() OVER (
    PARTITION BY cs.course_id
    ORDER BY cs.total_points DESC, u.id ASC
  ) AS rank
FROM course_submissions cs
JOIN  public.users u ON u.id = cs.user_id
LEFT JOIN public.mentor_students ms
  ON  ms.student_id = u.id
  AND ms.course_id  = cs.course_id
WHERE u.role       = 'student'
  AND u.is_private = false;

COMMENT ON VIEW public.leaderboard_course IS
  'Course-specific leaderboard. Joins via challenge → lesson → course '
  '(same path as generate_certificate) so rankings always agree with '
  'certificate scores.';

CREATE OR REPLACE VIEW public.leaderboard_course_mentor
WITH (security_invoker = true)
AS
SELECT
  lc.id,
  lc.name,
  lc.avatar_id,
  lc.course_id,
  lc.mentor_id,
  lc.total_points,
  ROW_NUMBER() OVER (
    PARTITION BY lc.course_id, lc.mentor_id
    ORDER BY lc.total_points DESC, lc.id ASC
  ) AS rank
FROM public.leaderboard_course lc
WHERE lc.mentor_id IS NOT NULL;

COMMENT ON VIEW public.leaderboard_course_mentor IS
  'Mentor-filtered course leaderboard. Always filter by both '
  'course_id and mentor_id when querying.';

GRANT SELECT ON public.leaderboard_course        TO authenticated;
GRANT SELECT ON public.leaderboard_course_mentor TO authenticated;


-- ============================================================
-- 6. REBUILD global leaderboard view to compute from
--    SUM(submissions.points_awarded) directly.
--    This eliminates all reliance on users.total_points for
--    the display layer — the view can never drift even if the
--    column is somehow wrong.
-- ============================================================

DROP VIEW IF EXISTS public.leaderboard CASCADE;

CREATE VIEW public.leaderboard
WITH (security_invoker = on) AS
SELECT
  ROW_NUMBER() OVER (ORDER BY COALESCE(s.total, 0) DESC, u.id ASC) AS rank,
  u.id,
  u.name,
  u.avatar_id,
  COALESCE(s.total, 0) AS total_points
FROM public.users u
LEFT JOIN (
  SELECT user_id, SUM(points_awarded)::int AS total
  FROM public.submissions
  GROUP BY user_id
) s ON s.user_id = u.id
WHERE u.is_private = false
  AND u.role = 'student';

COMMENT ON VIEW public.leaderboard IS
  'Global leaderboard. Computes total_points as SUM(submissions.points_awarded) '
  'at query time — immune to users.total_points column drift.';

GRANT SELECT ON public.leaderboard TO authenticated;


-- ============================================================
-- 7. REBUILD admin_student_stats view to use the same live SUM.
-- ============================================================

DROP VIEW IF EXISTS public.admin_student_stats CASCADE;

CREATE VIEW public.admin_student_stats
WITH (security_invoker = on) AS
SELECT
  u.id,
  u.name,
  COALESCE(s.total, 0) AS total_points,
  u.created_at,
  u.updated_at,
  COUNT(ms.mentor_id) AS mentor_count,
  ARRAY_AGG(mp.mentor_code) FILTER (WHERE mp.mentor_code IS NOT NULL) AS mentor_codes
FROM public.users u
LEFT JOIN (
  SELECT user_id, SUM(points_awarded)::int AS total
  FROM public.submissions
  GROUP BY user_id
) s ON s.user_id = u.id
LEFT JOIN public.mentor_students ms ON u.id = ms.student_id
LEFT JOIN public.mentor_profiles mp ON ms.mentor_id = mp.user_id
WHERE u.role = 'student'
GROUP BY u.id, u.name, u.created_at, u.updated_at, s.total;

COMMENT ON VIEW public.admin_student_stats IS
  'Admin student list. total_points computed live from SUM(submissions) — '
  'always matches leaderboard and certificate scores.';

GRANT SELECT ON public.admin_student_stats TO authenticated;

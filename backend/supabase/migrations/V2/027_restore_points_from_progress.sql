-- ============================================================
-- ScriptArc — Migration 027: Restore points from user_progress
-- Date: 2026-03-17
-- ──────────────────────────────────────────────────────────────
-- After migration 014 replaced all challenge IDs, the ON DELETE
-- CASCADE on submissions.challenge_id wiped every student's
-- submission rows. The submissions table is now empty.
--
-- users.total_points was recalculated from submissions in
-- migration 026 → reset to 0 for all users.
--
-- user_progress.points_earned is the only surviving record of
-- points earned per lesson. This migration restores total_points
-- from that source and rebuilds the views to read from the
-- column (not from the empty submissions table).
--
-- Going forward, the increment trigger (total_points +=
-- NEW.points_awarded) accumulates new submissions on top of
-- the recovered totals correctly.
-- ============================================================


-- ============================================================
-- 1. DISABLE escalation trigger for the bulk UPDATE.
-- ============================================================

ALTER TABLE public.users DISABLE TRIGGER trg_prevent_escalation;


-- ============================================================
-- 2. ONE-TIME RESTORE: set total_points = SUM(points_earned)
--    across all lessons the user has progress for.
-- ============================================================

UPDATE public.users u
SET total_points = COALESCE(sub.recovered, 0)
FROM (
  SELECT user_id, SUM(points_earned)::int AS recovered
  FROM public.user_progress
  GROUP BY user_id
) sub
WHERE u.id = sub.user_id;

-- Zero out users with no progress rows (already 0, but be explicit).
UPDATE public.users
SET total_points = 0
WHERE id NOT IN (SELECT DISTINCT user_id FROM public.user_progress);


-- ============================================================
-- 3. RE-ENABLE escalation trigger.
-- ============================================================

ALTER TABLE public.users ENABLE TRIGGER trg_prevent_escalation;


-- ============================================================
-- 4. RESTORE increment trigger.
--    The SUM trigger introduced in migration 026 would overwrite
--    recovered totals with SUM(submissions) = 0 on the next
--    insert. Switch back to increment so new submissions add
--    on top of the recovered total correctly.
-- ============================================================

CREATE OR REPLACE FUNCTION public.update_user_total_points()
RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER SET search_path = '' AS $$
BEGIN
  UPDATE public.users
  SET total_points = total_points + NEW.points_awarded
  WHERE id = NEW.user_id;
  RETURN NEW;
END;
$$;

COMMENT ON FUNCTION public.update_user_total_points IS
  'Increments total_points on each new submission. '
  'After the 027 recovery, the base value is the SUM of '
  'user_progress.points_earned; new submissions add on top.';


-- ============================================================
-- 5. REBUILD global leaderboard view — reads users.total_points.
--    (Re-applied here because migration 026 step 6 rebuilt it
--    to use SUM(submissions), which is now empty.)
-- ============================================================

DROP VIEW IF EXISTS public.leaderboard CASCADE;

CREATE VIEW public.leaderboard
WITH (security_invoker = on) AS
SELECT
  ROW_NUMBER() OVER (ORDER BY u.total_points DESC, u.id ASC) AS rank,
  u.id,
  u.name,
  u.avatar_id,
  u.total_points
FROM public.users u
WHERE u.is_private = false
  AND u.role = 'student';

COMMENT ON VIEW public.leaderboard IS
  'Global leaderboard ordered by users.total_points. '
  'After migration 027 the column holds recovered + new points.';

GRANT SELECT ON public.leaderboard TO authenticated;


-- ============================================================
-- 6. REBUILD admin_student_stats — reads users.total_points.
-- ============================================================

DROP VIEW IF EXISTS public.admin_student_stats CASCADE;

CREATE VIEW public.admin_student_stats
WITH (security_invoker = on) AS
SELECT
  u.id,
  u.name,
  u.total_points,
  u.created_at,
  u.updated_at,
  COUNT(ms.mentor_id) AS mentor_count,
  ARRAY_AGG(mp.mentor_code) FILTER (WHERE mp.mentor_code IS NOT NULL) AS mentor_codes
FROM public.users u
LEFT JOIN public.mentor_students ms ON u.id = ms.student_id
LEFT JOIN public.mentor_profiles mp ON ms.mentor_id = mp.user_id
WHERE u.role = 'student'
GROUP BY u.id, u.name, u.total_points, u.created_at, u.updated_at;

COMMENT ON VIEW public.admin_student_stats IS
  'Admin student list. Reads users.total_points (recovered from '
  'user_progress + new submissions accumulated by trigger).';

GRANT SELECT ON public.admin_student_stats TO authenticated;


-- ============================================================
-- 7. REBUILD leaderboard_course — reads from user_progress
--    (submissions is empty after cascade delete; user_progress
--    is the only source of per-course point data).
-- ============================================================

DROP VIEW IF EXISTS public.leaderboard_course_mentor CASCADE;
DROP VIEW IF EXISTS public.leaderboard_course CASCADE;

CREATE OR REPLACE VIEW public.leaderboard_course
WITH (security_invoker = true)
AS
WITH course_points AS (
  SELECT
    up.user_id,
    l.course_id,
    SUM(up.points_earned)::int AS total_points
  FROM public.user_progress up
  JOIN public.lessons l ON l.id = up.lesson_id
  GROUP BY up.user_id, l.course_id
)
SELECT
  u.id,
  u.name,
  u.avatar_id,
  cp.course_id,
  ms.mentor_id,
  cp.total_points,
  ROW_NUMBER() OVER (
    PARTITION BY cp.course_id
    ORDER BY cp.total_points DESC, u.id ASC
  ) AS rank
FROM course_points cp
JOIN  public.users u ON u.id = cp.user_id
LEFT JOIN public.mentor_students ms
  ON  ms.student_id = u.id
  AND ms.course_id  = cp.course_id
WHERE u.role       = 'student'
  AND u.is_private = false;

COMMENT ON VIEW public.leaderboard_course IS
  'Course leaderboard. Aggregates user_progress.points_earned per '
  'lesson → course. Recovers correctly after submissions were '
  'wiped by cascade delete in migration 014.';

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

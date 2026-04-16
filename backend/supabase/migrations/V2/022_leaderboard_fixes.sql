-- ============================================================
-- ScriptArc - Supabase PostgreSQL Schema (V2)
-- Migration 022: Leaderboard view fixes
-- ============================================================
-- Fixes leaderboard_course CROSS JOIN noise:
--   Previously, every student appeared for every course with 0 points
--   (due to CROSS JOIN courses in the CTE). Now only students who have
--   at least one submission for the course appear in course rankings.
-- ============================================================

-- ============================================================
-- 1. DROP EXISTING VIEWS
-- ============================================================
DROP VIEW IF EXISTS public.leaderboard_course_mentor CASCADE;
DROP VIEW IF EXISTS public.leaderboard_course CASCADE;

-- ============================================================
-- 2. RECREATE leaderboard_course (submissions-only, no CROSS JOIN)
-- Only students who have at least one submission for the course appear.
-- Mentor filter still supported via mentor_id column.
-- ============================================================
CREATE OR REPLACE VIEW public.leaderboard_course
WITH (security_invoker = true)
AS
WITH course_points AS (
    SELECT
        s.user_id,
        ch.course_id,
        SUM(s.stars_awarded)::int AS total_points
    FROM public.submissions s
    INNER JOIN public.challenges ch ON ch.id = s.challenge_id
    WHERE s.stars_awarded > 0
    GROUP BY s.user_id, ch.course_id
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
INNER JOIN public.users u ON u.id = cp.user_id
LEFT JOIN public.mentor_students ms
    ON ms.student_id = u.id
   AND ms.course_id = cp.course_id
WHERE u.role = 'student'
  AND u.is_private = false;

COMMENT ON VIEW public.leaderboard_course IS
    'Course-specific leaderboard. Only includes students with at least one submission for the course. Filter by course_id for course-wide, or course_id + mentor_id for mentor-scoped rankings.';

-- ============================================================
-- 3. RECREATE leaderboard_course_mentor (re-ranks within mentor group)
-- ============================================================
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
    'Mentor-filtered course leaderboard. Always filter by both course_id and mentor_id when querying.';

-- ============================================================
-- 4. RESTORE ACCESS
-- ============================================================
ALTER VIEW public.leaderboard_course SET (security_invoker = true);
ALTER VIEW public.leaderboard_course_mentor SET (security_invoker = true);

GRANT SELECT ON public.leaderboard_course TO authenticated;
GRANT SELECT ON public.leaderboard_course_mentor TO authenticated;

-- ============================================================
-- END MIGRATION 022
-- ============================================================

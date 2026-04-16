-- ============================================================
-- ScriptArc - Supabase PostgreSQL Schema (V2)
-- Migration 021: Course and Mentor Leaderboard Views
-- ============================================================
-- Adds leaderboard_course view for course-specific rankings.
-- Supports filtering by mentor_id for mentor-scoped leaderboards.
-- ============================================================

-- ============================================================
-- 1. DROP EXISTING VIEWS (if they exist)
-- ============================================================
DROP VIEW IF EXISTS public.leaderboard_course CASCADE;
DROP VIEW IF EXISTS public.leaderboard_course_mentor CASCADE;

-- ============================================================
-- 2. CREATE leaderboard_course VIEW
-- Aggregates points by (user, course) with mentor info for filtering.
-- For use in course leaderboard page:
--   - Filter by course_id only: shows all students in course (course-wide ranking)
--   - Filter by course_id + mentor_id: shows only students under that mentor in that course
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
	GROUP BY s.user_id, ch.course_id
),
student_course_rows AS (
	SELECT
		u.id,
		u.name,
		u.avatar_id,
		c.id AS course_id,
		ms.mentor_id
	FROM public.users u
	CROSS JOIN public.courses c
	LEFT JOIN public.mentor_students ms
		ON ms.student_id = u.id
	 AND ms.course_id = c.id
	WHERE u.role = 'student'
		AND u.is_private = false
)
SELECT
	scr.id,
	scr.name,
	scr.avatar_id,
	scr.course_id,
	scr.mentor_id,
	COALESCE(cp.total_points, 0) AS total_points,
	ROW_NUMBER() OVER (
		PARTITION BY scr.course_id
		ORDER BY COALESCE(cp.total_points, 0) DESC, scr.id ASC
	) AS rank
FROM student_course_rows scr
LEFT JOIN course_points cp
	ON cp.user_id = scr.id
 AND cp.course_id = scr.course_id;

COMMENT ON VIEW public.leaderboard_course IS
	'Course-specific leaderboard with optional mentor filtering. Aggregates points by (user, course). Include mentor_id filter for mentor-scoped rankings within a course. When mentor_id is NULL, shows course-wide rankings.';

-- ============================================================
-- 3. CREATE leaderboard_course_mentor VIEW (convenience view)
-- Same as leaderboard_course but explicitly for mentor-filtered queries
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
	'Mentor-filtered course leaderboard. Shows only students assigned to a mentor in the specified course. Always include (mentor_id, course_id) filter when querying.';

-- ============================================================
-- 4. INDEXES (on base tables to support view performance)
-- ============================================================
CREATE INDEX IF NOT EXISTS idx_submissions_challenge_user
	ON public.submissions(challenge_id, user_id);

CREATE INDEX IF NOT EXISTS idx_challenges_course_id
	ON public.challenges(course_id);

CREATE INDEX IF NOT EXISTS idx_mentor_students_student_course
	ON public.mentor_students(student_id, course_id);

CREATE INDEX IF NOT EXISTS idx_users_private_role
	ON public.users(is_private, role);

-- ============================================================
-- 5. VIEW ACCESS
-- ============================================================
ALTER VIEW public.leaderboard_course SET (security_invoker = true);
ALTER VIEW public.leaderboard_course_mentor SET (security_invoker = true);

-- RLS cannot be enabled on views. Grant read access instead.
GRANT SELECT ON public.leaderboard_course TO authenticated;
GRANT SELECT ON public.leaderboard_course_mentor TO authenticated;

-- ============================================================
-- END MIGRATION 021
-- ============================================================

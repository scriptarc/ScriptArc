-- ============================================================
-- ScriptArc — Migration 023: Drop users.level column
-- Date: 2026-03-12
-- The level column was never updated (always stayed at default 1)
-- and had no computation logic. Removed from UI and DB.
-- ============================================================

-- Must DROP dependent views first (CREATE OR REPLACE cannot remove columns)
DROP VIEW IF EXISTS public.leaderboard CASCADE;
DROP VIEW IF EXISTS public.admin_student_stats CASCADE;

-- Drop the column
ALTER TABLE public.users DROP COLUMN IF EXISTS level;

-- Recreate leaderboard view without level
CREATE VIEW public.leaderboard
  WITH (security_invoker = on) AS
  SELECT
    ROW_NUMBER() OVER (ORDER BY total_stars DESC) AS rank,
    id,
    name,
    total_stars,
    avatar_id
  FROM public.users
  WHERE is_private = false
  ORDER BY total_stars DESC;

-- Recreate admin_student_stats view without level
CREATE VIEW public.admin_student_stats
WITH (security_invoker = on) AS
SELECT
    u.id,
    u.name,
    u.total_stars,
    u.created_at,
    u.updated_at,
    count(ms.mentor_id) as mentor_count,
    array_agg(mp.mentor_code) filter (where mp.mentor_code is not null) as mentor_codes
FROM
    public.users u
LEFT JOIN
    public.mentor_students ms ON u.id = ms.student_id
LEFT JOIN
    public.mentor_profiles mp ON ms.mentor_id = mp.user_id
WHERE
    u.role = 'student'
GROUP BY
    u.id;

GRANT SELECT ON public.leaderboard TO authenticated;
GRANT SELECT ON public.admin_student_stats TO authenticated;

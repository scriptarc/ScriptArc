-- ============================================================
-- ScriptArc — Migration 018: Admin Student Filtering View
-- Date: 2026-03-10
-- Creates a view for administrators to easily filter students by
-- mentor assignment and activity status.
-- ============================================================

CREATE OR REPLACE VIEW public.admin_student_stats 
WITH (security_invoker = on) AS
SELECT 
    u.id,
    u.name,
    u.total_stars,
    u.level,
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

COMMENT ON VIEW public.admin_student_stats IS 
    'Provides student details along with mentor assignment counts and codes for admin filtering.';

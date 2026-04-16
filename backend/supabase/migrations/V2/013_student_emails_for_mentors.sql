-- ============================================================
-- ScriptArc — Supabase PostgreSQL Schema (V2)
-- Migration 013: Expose student emails to mentors
-- ============================================================
-- Adds a SECURITY DEFINER function so mentors can look up
-- the emails of students assigned to them (for Excel reports).
-- auth.users is not directly accessible from the client SDK.
-- ============================================================

CREATE OR REPLACE FUNCTION public.get_student_emails(p_student_ids uuid[])
RETURNS TABLE(id uuid, email text)
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = public, auth
AS $$
BEGIN
  -- Only return emails for students actually assigned to the calling mentor
  RETURN QUERY
    SELECT au.id, au.email::text
      FROM auth.users au
     WHERE au.id = ANY(p_student_ids)
       AND EXISTS (
         SELECT 1 FROM public.mentor_students ms
          WHERE ms.mentor_id = auth.uid()
            AND ms.student_id = au.id
       );
END;
$$;

GRANT EXECUTE ON FUNCTION public.get_student_emails(uuid[]) TO authenticated;

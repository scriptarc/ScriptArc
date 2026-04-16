-- ============================================================
-- ScriptArc — Migration 025: Fix mentor_students DELETE policies
-- Date: 2026-03-17
-- ============================================================
-- PROBLEM: No RLS DELETE policy exists for students on mentor_students.
-- The existing ms_admin_delete policy (migration 005) covers admin and
-- mentor, but students cannot delete their own assignment. Supabase
-- returns 0 affected rows (no error) on RLS denial, so handleRemoveMentor
-- in CourseSingle.jsx silently fails.
--
-- FIX: Split the combined admin+mentor policy into three discrete
-- policies — one per actor — and add the missing student policy.
-- All statements are idempotent (safe to re-run).
-- ============================================================

-- ── Drop the old combined policy ─────────────────────────────
DROP POLICY IF EXISTS "ms_admin_delete"    ON public.mentor_students;
DROP POLICY IF EXISTS "ms_student_delete_own" ON public.mentor_students;
DROP POLICY IF EXISTS "ms_mentor_delete_own"  ON public.mentor_students;

-- ── Student can remove their own mentor assignment ────────────
CREATE POLICY "ms_student_delete_own"
  ON public.mentor_students FOR DELETE TO authenticated
  USING (auth.uid() = student_id);

COMMENT ON POLICY "ms_student_delete_own" ON public.mentor_students IS
  'Students can remove their own mentor assignment for any course.';

-- ── Mentor can remove students assigned to them ───────────────
CREATE POLICY "ms_mentor_delete_own"
  ON public.mentor_students FOR DELETE TO authenticated
  USING (auth.uid() = mentor_id);

COMMENT ON POLICY "ms_mentor_delete_own" ON public.mentor_students IS
  'Mentors can remove students from their own mentorship.';

-- ── Admin can delete any assignment ───────────────────────────
CREATE POLICY "ms_admin_delete"
  ON public.mentor_students FOR DELETE TO authenticated
  USING (public.is_admin());

COMMENT ON POLICY "ms_admin_delete" ON public.mentor_students IS
  'Admins have full delete access on mentor_students.';

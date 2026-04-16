-- ============================================================
-- ScriptArc — Migration 017: Admin Visibility Fixes
-- Date: 2026-03-10
-- Fixes visibility issues where Admins cannot see private students
-- or data for students with is_private = true.
-- ============================================================

-- 1. Update users_select_policy
DROP POLICY IF EXISTS "users_select_policy" ON public.users;
CREATE POLICY "users_select_policy"
  ON public.users FOR SELECT
  TO authenticated
  USING (
    auth.uid() = id
    OR NOT is_private
    OR public.is_mentor()
    OR public.is_admin()
  );

-- 2. Update submissions_select_policy
DROP POLICY IF EXISTS "submissions_select_policy" ON public.submissions;
CREATE POLICY "submissions_select_policy"
  ON public.submissions FOR SELECT
  TO authenticated
  USING (
    auth.uid() = user_id
    OR public.is_mentor()
    OR public.is_admin()
  );

-- 3. Update user_progress_select_policy
DROP POLICY IF EXISTS "user_progress_select_policy" ON public.user_progress;
CREATE POLICY "user_progress_select_policy"
  ON public.user_progress FOR SELECT
  TO authenticated
  USING (
    auth.uid() = user_id
    OR public.is_mentor()
    OR public.is_admin()
  );

COMMENT ON POLICY "users_select_policy" ON public.users IS
  'Admins (identified by scriptarc.dev@gmail.com) can see all user profiles, including private ones.';

COMMENT ON POLICY "submissions_select_policy" ON public.submissions IS
  'Admins can see all submissions for audit/support purposes.';

COMMENT ON POLICY "user_progress_select_policy" ON public.user_progress IS
  'Admins can see all user progress records.';

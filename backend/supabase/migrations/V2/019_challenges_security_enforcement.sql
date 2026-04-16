-- ============================================================
-- ScriptArc — Migration 019: Challenges Security Enforcement
-- Date: 2026-03-11
-- Enforces that clients read from challenges_public view by
-- restricting base table select access to admins/service role.
-- ============================================================

-- Drop the permissive policy introduced in migration 016
DROP POLICY IF EXISTS "challenges_select_authenticated" ON public.challenges;
DROP POLICY IF EXISTS "challenges_select_all" ON public.challenges;

-- Restrict base table select to admins only.
-- Regular authenticated users MUST use the challenges_public view 
-- (which excludes correct_option) and submit answers via the RPC.
CREATE POLICY "challenges_select_admin"
  ON public.challenges FOR SELECT
  TO authenticated
  USING (public.is_admin());

COMMENT ON POLICY "challenges_select_admin" ON public.challenges IS
  'Base table select restricted to admins. Clients verify answers via RPC and read data via challenges_public view.';

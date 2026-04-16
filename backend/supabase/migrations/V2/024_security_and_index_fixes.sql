-- ============================================================
-- ScriptArc — Migration 024: Security & Index Fixes
-- Date: 2026-03-12
-- Fixes from full audit:
--   1. handle_new_user trigger: block role escalation on signup
--   2. Partial index for leaderboard query
--   3. Unique constraint on mentor_students(mentor_id, student_id, course_id)
-- ============================================================


-- ============================================================
-- 1. SECURITY: Block role escalation via signup metadata
-- ──────────────────────────────────────────────────────────────
-- RISK: Any user can pass role:'mentor' or role:'admin' in auth
--   metadata during signup and the trigger would assign it.
-- FIX: Always assign 'student' on self-registration. Mentor/admin
--   roles must be set by service_role only.
-- ============================================================
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER SET search_path = ''
AS $$
BEGIN
  INSERT INTO public.users (id, name, role)
  VALUES (
    NEW.id,
    COALESCE(
      NULLIF(TRIM(NEW.raw_user_meta_data->>'full_name'), ''),
      SPLIT_PART(NEW.email, '@', 1)
    ),
    'student'  -- always student on self-registration; role changes require service_role
  )
  ON CONFLICT (id) DO NOTHING;
  RETURN NEW;
END;
$$;

COMMENT ON FUNCTION public.handle_new_user IS
  'Creates a users row on auth signup. Always assigns student role — '
  'mentor/admin roles must be set by service_role to prevent escalation.';


-- ============================================================
-- 2. PERFORMANCE: Partial index for leaderboard query
-- ──────────────────────────────────────────────────────────────
-- Speeds up: SELECT ... FROM users WHERE is_private = false ORDER BY total_stars DESC
-- ============================================================
CREATE INDEX IF NOT EXISTS idx_users_leaderboard
  ON public.users(total_stars DESC)
  WHERE is_private = false;


-- ============================================================
-- 3. INTEGRITY: Unique constraint on mentor_students
-- ──────────────────────────────────────────────────────────────
-- Prevents a student being assigned to the same mentor+course twice.
-- ============================================================
DO $$ BEGIN
  ALTER TABLE public.mentor_students
    ADD CONSTRAINT uq_mentor_student_course
    UNIQUE (mentor_id, student_id, course_id);
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

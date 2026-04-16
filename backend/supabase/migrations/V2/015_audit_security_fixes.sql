-- ============================================================
-- ScriptArc — Migration 015: Security Audit Fixes
-- Date: 2026-03-09
-- ============================================================
-- Run this after all prior migrations.
-- All statements use IF NOT EXISTS / OR REPLACE — safe to re-run.
-- ============================================================


-- ============================================================
-- 1. SERVER-SIDE STARS_AWARDED ENFORCEMENT  [CRITICAL]
-- ──────────────────────────────────────────────────────────────
-- RISK FIXED: The client calculates stars_awarded (2 for MCQ, 4 for coding)
--   and inserts it directly. A user intercepting the API call could send
--   stars_awarded: 9999 and the DB would accept and sum it into total_stars.
--
-- FIX: A BEFORE INSERT trigger overwrites whatever the client sent with the
--   value computed server-side from calculate_marks(), using the challenge_type
--   fetched directly from the challenges table — the client cannot influence this.
-- ============================================================

CREATE OR REPLACE FUNCTION public.enforce_stars_awarded()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER SET search_path = ''
AS $$
DECLARE
  v_challenge_type text;
BEGIN
  -- Fetch challenge type from DB — never trust the client's claimed type.
  SELECT challenge_type INTO v_challenge_type
  FROM public.challenges
  WHERE id = NEW.challenge_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'enforce_stars_awarded: unknown challenge_id %', NEW.challenge_id;
  END IF;

  -- Override the client-supplied stars_awarded with the server-calculated value.
  -- calculate_marks() is IMMUTABLE and cannot be spoofed via the network.
  NEW.stars_awarded := public.calculate_marks(
    v_challenge_type,
    COALESCE(NEW.hint_used,       false),
    COALESCE(NEW.solution_viewed, false)
  );

  RETURN NEW;
END;
$$;

COMMENT ON FUNCTION public.enforce_stars_awarded IS
  'BEFORE INSERT trigger on submissions. Overwrites client-supplied stars_awarded '
  'with the server-calculated value from calculate_marks(). '
  'Prevents score inflation via direct API manipulation.';

-- Drop any existing version of the trigger before recreating.
DROP TRIGGER IF EXISTS trg_enforce_stars ON public.submissions;

CREATE TRIGGER trg_enforce_stars
  BEFORE INSERT ON public.submissions
  FOR EACH ROW EXECUTE FUNCTION public.enforce_stars_awarded();


-- ============================================================
-- 2. GUARD: stars_awarded RANGE CONSTRAINT  [HIGH]
-- ──────────────────────────────────────────────────────────────
-- Belt-and-suspenders: even if the trigger above were somehow bypassed,
-- this constraint rejects values outside the valid range (0-4).
-- ============================================================
DO $$ BEGIN
  ALTER TABLE public.submissions
    ADD CONSTRAINT valid_stars_range CHECK (stars_awarded BETWEEN 0 AND 4);
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;


-- ============================================================
-- 3. BLOCK DIRECT SUBMISSIONS INSERT — FORCE VIA APP ONLY  [HIGH]
-- ──────────────────────────────────────────────────────────────
-- The current RLS allows any authenticated client to INSERT into submissions
-- with auth.uid() = user_id. This is still necessary for the current
-- client-side flow. The trg_enforce_stars trigger above makes it safe.
--
-- For even stronger isolation in a future refactor, replace client-side
-- supabase.from('submissions').insert() with an RPC submit_challenge() that
-- validates answers server-side before inserting. This is documented in the
-- audit report as "Requires Manual Review".
-- ============================================================


-- ============================================================
-- 4. MCQ ANSWER VALIDATION RPC  [MEDIUM — anti-cheat]
-- ──────────────────────────────────────────────────────────────
-- RISK: challenges.correct_option is returned by SELECT * and is visible
--   in the browser's React DevTools / Supabase client. A student can read
--   the correct answer without actually answering.
--
-- FIX: This RPC validates a submitted MCQ answer server-side and inserts
--   the submission in one atomic call. The client never needs to see
--   correct_option. Learn.jsx should be updated to call this instead of
--   comparing options locally + doing a raw insert.
--
-- Usage: supabase.rpc('submit_mcq_answer', {
--   p_challenge_id: '...', p_selected_index: 2,
--   p_attempts: 1, p_hint_used: false
-- })
-- Returns: { correct: bool, stars_awarded: int, already_completed: bool }
-- ============================================================

CREATE OR REPLACE FUNCTION public.submit_mcq_answer(
  p_challenge_id   uuid,
  p_selected_index int,
  p_attempts       int     DEFAULT 1,
  p_hint_used      boolean DEFAULT false
)
RETURNS jsonb
LANGUAGE plpgsql SECURITY DEFINER SET search_path = ''
AS $$
DECLARE
  v_user_id        uuid;
  v_correct_option int;
  v_is_correct     boolean;
  v_stars          int;
BEGIN
  v_user_id := auth.uid();
  IF v_user_id IS NULL THEN
    RAISE EXCEPTION 'Not authenticated';
  END IF;

  -- Check if already completed (unique_user_challenge constraint prevents double-insert)
  IF EXISTS (
    SELECT 1 FROM public.submissions
    WHERE user_id = v_user_id AND challenge_id = p_challenge_id
  ) THEN
    RETURN jsonb_build_object('correct', true, 'stars_awarded', 0, 'already_completed', true);
  END IF;

  -- Fetch the correct answer from DB — never exposed to the client
  SELECT correct_option INTO v_correct_option
  FROM public.challenges
  WHERE id = p_challenge_id AND challenge_type = 'mcq';

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Challenge not found or not an MCQ: %', p_challenge_id;
  END IF;

  v_is_correct := (p_selected_index = v_correct_option);

  IF v_is_correct THEN
    -- stars_awarded will be overwritten by trg_enforce_stars anyway,
    -- but we pass hint_used so calculate_marks() gets the right input.
    INSERT INTO public.submissions (
      user_id, challenge_id, attempts, hint_used, solution_viewed, stars_awarded
    ) VALUES (
      v_user_id, p_challenge_id, p_attempts, p_hint_used, false,
      public.calculate_marks('mcq', p_hint_used, false)
    );

    SELECT stars_awarded INTO v_stars
    FROM public.submissions
    WHERE user_id = v_user_id AND challenge_id = p_challenge_id;
  END IF;

  RETURN jsonb_build_object(
    'correct',           v_is_correct,
    'stars_awarded',     COALESCE(v_stars, 0),
    'already_completed', false
  );
END;
$$;

COMMENT ON FUNCTION public.submit_mcq_answer IS
  'Server-side MCQ answer validation. Returns {correct, stars_awarded, already_completed}. '
  'correct_option is NEVER returned to the client. '
  'Learn.jsx should call this RPC instead of comparing options client-side.';


-- ============================================================
-- 5. GRANT EXECUTE ON NEW FUNCTIONS TO authenticated ROLE
-- ============================================================
GRANT EXECUTE ON FUNCTION public.enforce_stars_awarded TO authenticated;
GRANT EXECUTE ON FUNCTION public.submit_mcq_answer     TO authenticated;

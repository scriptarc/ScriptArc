-- ============================================================
-- ScriptArc — Supabase PostgreSQL Schema (V2)
-- Migration 004: Performance & Security Improvements
-- ============================================================

-- ============================================================
-- 1. MISSING INDEXES
-- ============================================================

-- Composite index: submissions lookups by user + challenge (Dashboard, Learn)
CREATE INDEX IF NOT EXISTS idx_submissions_user_challenge
  ON public.submissions(user_id, challenge_id);

-- Covering index: lesson locking checks (lesson + completion status)
CREATE INDEX IF NOT EXISTS idx_user_progress_lesson_completed
  ON public.user_progress(lesson_id, completed);

-- Index: challenge ordering within a course by timestamp
CREATE INDEX IF NOT EXISTS idx_challenges_course_timestamp
  ON public.challenges(course_id, timestamp_seconds);


-- ============================================================
-- 2. FIX TOTAL STARS TRIGGER (O(n) → O(1) per submission)
-- Previously did a full SUM scan; now just increments.
-- ============================================================
CREATE OR REPLACE FUNCTION public.update_user_total_stars()
RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER SET search_path = '' AS $$
BEGIN
  UPDATE public.users
  SET total_stars = total_stars + NEW.stars_awarded
  WHERE id = NEW.user_id;
  RETURN NEW;
END; $$;

COMMENT ON FUNCTION public.update_user_total_stars IS
  'Increments total_stars on each new submission instead of recalculating the full SUM.';


-- ============================================================
-- 3. STORED FUNCTION: get_lesson_view
-- Combines 4 sequential Learn.jsx queries into 1 RPC call.
-- Returns lesson + challenges + next_lesson + user_progress.
-- ============================================================
CREATE OR REPLACE FUNCTION public.get_lesson_view(
  p_lesson_id uuid,
  p_user_id   uuid
)
RETURNS jsonb
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = ''
AS $$
  SELECT jsonb_build_object(
    'lesson', row_to_json(l.*),
    'challenges', (
      SELECT COALESCE(jsonb_agg(row_to_json(c.*) ORDER BY c.timestamp_seconds), '[]')
      FROM public.challenges c
      WHERE c.lesson_id = p_lesson_id
    ),
    'next_lesson', (
      SELECT row_to_json(nl.*)
      FROM public.lessons nl
      WHERE nl.course_id = l.course_id
        AND nl.order_index = l.order_index + 1
      LIMIT 1
    ),
    'user_progress', (
      SELECT row_to_json(up.*)
      FROM public.user_progress up
      WHERE up.lesson_id = p_lesson_id
        AND up.user_id = p_user_id
      LIMIT 1
    )
  )
  FROM public.lessons l
  WHERE l.id = p_lesson_id;
$$;

COMMENT ON FUNCTION public.get_lesson_view IS
  'Returns all data needed for the Learn page in a single DB round-trip.';

-- ============================================================
-- ScriptArc — Migration 020: Course Feedback
-- Date: 2026-03-11
-- Creates the course_feedback table to store user reviews.
-- ============================================================

CREATE TABLE IF NOT EXISTS public.course_feedback (
  id                 uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id          uuid        NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  user_id            uuid        NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  overall_rating     int         NOT NULL CHECK (overall_rating >= 1 AND overall_rating <= 5),
  content_quality    text        NOT NULL CHECK (content_quality IN ('Excellent', 'Good', 'Average', 'Poor')),
  difficulty_level   text        NOT NULL CHECK (difficulty_level IN ('Too Easy', 'Just Right', 'Too Hard')),
  mentor_helpfulness text        NOT NULL CHECK (mentor_helpfulness IN ('Very Helpful', 'Helpful', 'Neutral', 'Not Helpful')),
  practical_learning text        NOT NULL CHECK (practical_learning IN ('Yes, very helpful', 'Somewhat helpful', 'Not helpful')),
  liked_most         text,
  suggestions        text,
  recommend          text        NOT NULL CHECK (recommend IN ('Yes 👍', 'Maybe 🤔', 'No 👎')),
  created_at         timestamptz NOT NULL DEFAULT now(),
  UNIQUE(course_id, user_id)
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_course_feedback_course ON public.course_feedback(course_id);
CREATE INDEX IF NOT EXISTS idx_course_feedback_user   ON public.course_feedback(user_id);

-- RLS
ALTER TABLE public.course_feedback ENABLE ROW LEVEL SECURITY;

-- Users can insert their own feedback
CREATE POLICY "feedback_insert"
  ON public.course_feedback FOR INSERT TO authenticated
  WITH CHECK (auth.uid() = user_id);

-- Users can read their own feedback
CREATE POLICY "feedback_select_own"
  ON public.course_feedback FOR SELECT TO authenticated
  USING (auth.uid() = user_id);

-- Admins can read all feedback
CREATE POLICY "feedback_select_admin"
  ON public.course_feedback FOR SELECT TO authenticated
  USING (public.is_admin());

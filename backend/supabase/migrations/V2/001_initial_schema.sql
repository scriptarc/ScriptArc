-- ============================================================
-- ScriptArc — Supabase PostgreSQL Schema (V2)
-- Migration 001: Consolidated Schema (Tables & Types)
-- ============================================================

-- Custom enum for user roles
CREATE TYPE user_role AS ENUM ('student', 'mentor');

-- ============================================================
-- 1) USERS TABLE
-- ============================================================
CREATE TABLE public.users (
  id          uuid        PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  name        text,
  role        user_role   NOT NULL DEFAULT 'student'::user_role,
  total_stars int         NOT NULL DEFAULT 0,
  level       int         NOT NULL DEFAULT 1,
  is_private  boolean     NOT NULL DEFAULT false,
  avatar_id          int         DEFAULT 1,
  has_special_access boolean     NOT NULL DEFAULT false,
  created_at         timestamptz NOT NULL DEFAULT now()
);

COMMENT ON TABLE  public.users IS 'Public profile for every authenticated user';
COMMENT ON COLUMN public.users.is_private IS 'When true the user is hidden from the leaderboard';
COMMENT ON COLUMN public.users.avatar_id IS 'ID of the avatar chosen in the AvatarPicker component';
COMMENT ON COLUMN public.users.has_special_access IS 'When true, all content locks (lessons, video seek, challenges) are bypassed — used for internal testing';

-- ============================================================
-- 2) COURSES TABLE
-- ============================================================
CREATE TABLE public.courses (
  id               uuid         PRIMARY KEY DEFAULT gen_random_uuid(),
  title            text         NOT NULL,
  description      text,
  level            text         DEFAULT 'beginner',
  thumbnail_url    text,
  duration_hours   numeric(4,1) DEFAULT 0,
  total_challenges int          DEFAULT 0,
  rating           numeric(3,1) DEFAULT 0,
  enrolled_count   int          DEFAULT 0,
  tags             text[]       DEFAULT '{}',
  created_at       timestamptz  NOT NULL DEFAULT now()
);

-- ============================================================
-- 3) LESSONS TABLE
-- ============================================================
CREATE TABLE public.lessons (
  id               uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id        uuid        NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  order_index      int         NOT NULL,
  title            text        NOT NULL,
  description      text,
  video_url        text,
  duration_minutes int         NOT NULL DEFAULT 15,
  created_at       timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX idx_lessons_course ON public.lessons(course_id);

-- ============================================================
-- 4) CHALLENGES TABLE
-- ============================================================
CREATE TABLE public.challenges (
  id                uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id         uuid        NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  lesson_id         uuid        REFERENCES public.lessons(id) ON DELETE CASCADE,
  title             text        NOT NULL,
  description       text,
  difficulty        text        NOT NULL CHECK (difficulty IN ('easy', 'medium', 'hard')),
  star_value        int         NOT NULL CHECK (star_value > 0),
  timestamp_seconds numeric,
  initial_code      text,
  language_id       int,
  challenge_type    text        NOT NULL DEFAULT 'coding',
  options           jsonb       NOT NULL DEFAULT '[]'::jsonb,
  correct_option    int         DEFAULT 0,
  hints             jsonb       NOT NULL DEFAULT '[]'::jsonb,
  solution          text,
  created_at        timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX idx_challenges_course ON public.challenges(course_id);
CREATE INDEX idx_challenges_lesson ON public.challenges(lesson_id);

-- ============================================================
-- 5) SUBMISSIONS TABLE
-- ============================================================
CREATE TABLE public.submissions (
  id              uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id         uuid        NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  challenge_id    uuid        NOT NULL REFERENCES public.challenges(id) ON DELETE CASCADE,
  attempts        int         NOT NULL DEFAULT 1 CHECK (attempts >= 1),
  hint_used       boolean     NOT NULL DEFAULT false,
  solution_viewed boolean     NOT NULL DEFAULT false,
  stars_awarded   int         NOT NULL DEFAULT 0,
  created_at      timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX idx_submissions_user      ON public.submissions(user_id);
CREATE INDEX idx_submissions_challenge ON public.submissions(challenge_id);

-- ============================================================
-- 6) USER_PROGRESS TABLE
-- ============================================================
CREATE TABLE public.user_progress (
  id                      uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id                 uuid        NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  lesson_id               uuid        NOT NULL REFERENCES public.lessons(id) ON DELETE CASCADE,
  course_id               uuid        NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  completed               boolean     NOT NULL DEFAULT false,
  stars_earned            int         NOT NULL DEFAULT 0,
  completed_challenge_ids uuid[]      NOT NULL DEFAULT '{}',
  created_at              timestamptz NOT NULL DEFAULT now(),
  updated_at              timestamptz NOT NULL DEFAULT now(),
  UNIQUE(user_id, lesson_id)
);

CREATE INDEX idx_user_progress_user   ON public.user_progress(user_id);
CREATE INDEX idx_user_progress_lesson ON public.user_progress(lesson_id);
CREATE INDEX idx_user_progress_course ON public.user_progress(course_id);

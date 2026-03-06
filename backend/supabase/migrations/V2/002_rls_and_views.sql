-- ============================================================
-- ScriptArc — Supabase PostgreSQL Schema (V2)
-- Migration 002: RLS Policies, Triggers & Views
-- ============================================================

-- ============================================================
-- 1. ENABLE ROW LEVEL SECURITY
-- ============================================================
ALTER TABLE public.users         ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.courses       ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lessons       ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.challenges    ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.submissions   ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_progress ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- 2. SECURE MENTOR CHECK FUNCTION
-- Replaces inline role checks to prevent infinite RLS recursion.
-- ============================================================
CREATE OR REPLACE FUNCTION public.is_mentor()
RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = ''
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.users
    WHERE id = auth.uid() AND role = 'mentor'
  );
$$;

-- ============================================================
-- 3. USERS TABLE POLICIES & SECURITY
-- ============================================================

-- SELECT: users see their own profile, public profiles are visible to all, mentors see all.
CREATE POLICY "users_select_policy"
  ON public.users FOR SELECT
  TO authenticated
  USING (
    auth.uid() = id
    OR NOT is_private
    OR public.is_mentor()
  );

-- UPDATE: users can only update their own profile.
CREATE POLICY "users_update_own"
  ON public.users FOR UPDATE
  TO authenticated
  USING  (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- INSERT: handled by the auto-signup trigger.
CREATE POLICY "users_insert_via_trigger"
  ON public.users FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = id);

-- TRIGGER: Prevent users from escalating their privileges via UPDATE
CREATE OR REPLACE FUNCTION public.prevent_privilege_escalation()
  RETURNS TRIGGER LANGUAGE plpgsql
  SECURITY DEFINER SET search_path = ''
AS $$
BEGIN
  -- If the update is coming from a superuser or service role, allow it
  IF current_setting('request.jwt.claim.role', true) = 'service_role' OR current_user = 'postgres' THEN
    RETURN NEW;
  END IF;

  -- Prevent clients from changing their own role, stars, or special access flag
  NEW.role               := OLD.role;
  NEW.total_stars        := OLD.total_stars;
  NEW.has_special_access := OLD.has_special_access;
  RETURN NEW;
END;
$$;

CREATE TRIGGER trg_prevent_escalation
  BEFORE UPDATE ON public.users
  FOR EACH ROW EXECUTE FUNCTION public.prevent_privilege_escalation();


-- ============================================================
-- 4. COURSE, LESSON, AND CHALLENGE POLICIES
-- Anyone authenticated can read; only mentors can modify.
-- ============================================================

-- COURSES
CREATE POLICY "courses_select_all"    ON public.courses FOR SELECT TO authenticated USING (true);
CREATE POLICY "courses_mentor_insert" ON public.courses FOR INSERT TO authenticated WITH CHECK (public.is_mentor());
CREATE POLICY "courses_mentor_update" ON public.courses FOR UPDATE TO authenticated USING (public.is_mentor());
CREATE POLICY "courses_mentor_delete" ON public.courses FOR DELETE TO authenticated USING (public.is_mentor());

-- LESSONS
CREATE POLICY "lessons_select_all"    ON public.lessons FOR SELECT TO authenticated USING (true);
CREATE POLICY "lessons_mentor_insert" ON public.lessons FOR INSERT TO authenticated WITH CHECK (public.is_mentor());
CREATE POLICY "lessons_mentor_update" ON public.lessons FOR UPDATE TO authenticated USING (public.is_mentor());
CREATE POLICY "lessons_mentor_delete" ON public.lessons FOR DELETE TO authenticated USING (public.is_mentor());

-- CHALLENGES
CREATE POLICY "challenges_select_all"    ON public.challenges FOR SELECT TO authenticated USING (true);
CREATE POLICY "challenges_mentor_insert" ON public.challenges FOR INSERT TO authenticated WITH CHECK (public.is_mentor());
CREATE POLICY "challenges_mentor_update" ON public.challenges FOR UPDATE TO authenticated USING (public.is_mentor());
CREATE POLICY "challenges_mentor_delete" ON public.challenges FOR DELETE TO authenticated USING (public.is_mentor());


-- ============================================================
-- 5. SUBMISSIONS POLICIES & POINT CALCULATION
-- ============================================================

-- SELECT: students see their own submissions, mentors see all.
CREATE POLICY "submissions_select_policy"
  ON public.submissions FOR SELECT
  TO authenticated
  USING (
    auth.uid() = user_id
    OR public.is_mentor()
  );

-- INSERT: students can only insert their own submissions.
CREATE POLICY "submissions_insert_own"
  ON public.submissions FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

-- Explicit Deny UPDATE/DELETE on Submissions
CREATE POLICY "submissions_no_update" ON public.submissions FOR UPDATE TO authenticated USING (false);
CREATE POLICY "submissions_no_delete" ON public.submissions FOR DELETE TO authenticated USING (false);

-- POINTS SYSTEM: Calculates points based on challenge type and hint/solution usage
CREATE OR REPLACE FUNCTION public.calculate_marks(
  p_challenge_type text,
  p_hint_used boolean,
  p_solution_viewed boolean
) RETURNS int LANGUAGE plpgsql IMMUTABLE SET search_path = '' AS $$
BEGIN
  IF p_solution_viewed THEN RETURN 0; END IF;
  IF p_hint_used THEN
    IF p_challenge_type = 'coding' THEN RETURN 2;
    ELSE RETURN 1;
    END IF;
  END IF;
  IF p_challenge_type = 'coding' THEN RETURN 4;
  ELSE RETURN 2;
  END IF;
END; $$;

COMMENT ON FUNCTION public.calculate_marks IS 'Returns points to award for a submission. Coding: 4=max, 2=hint. MCQ: 2=max, 1=hint. 0 for solution.';

-- TRIGGER: Auto-sum total user points (total_stars column) upon submission
CREATE OR REPLACE FUNCTION public.update_user_total_stars()
RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER SET search_path = '' AS $$
BEGIN
  UPDATE public.users
  SET total_stars = (
    SELECT COALESCE(SUM(stars_awarded), 0)
    FROM public.submissions
    WHERE user_id = NEW.user_id
  )
  WHERE id = NEW.user_id;
  RETURN NEW;
END; $$;

CREATE TRIGGER on_submission_inserted
  AFTER INSERT ON public.submissions
  FOR EACH ROW EXECUTE FUNCTION public.update_user_total_stars();


-- ============================================================
-- 6. USER PROGRESS POLICIES
-- ============================================================

-- SELECT: users see their own progress, mentors see all.
CREATE POLICY "user_progress_select_policy"
  ON public.user_progress FOR SELECT
  TO authenticated
  USING (
    auth.uid() = user_id
    OR public.is_mentor()
  );

-- INSERT/UPDATE: users can only insert or update their own tracking rows.
CREATE POLICY "user_progress_insert_own"
  ON public.user_progress FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "user_progress_update_own"
  ON public.user_progress FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);


-- ============================================================
-- 7. AUTO-SIGNUP TRIGGER
-- Creates a public profile entry when a user signs up via OAuth/Email.
-- ============================================================
CREATE OR REPLACE FUNCTION public.handle_new_user()
  RETURNS TRIGGER LANGUAGE plpgsql
  SECURITY DEFINER SET search_path = ''
AS $$
BEGIN
  INSERT INTO public.users (id, name, role)
  VALUES (
    NEW.id,
    COALESCE(
      NEW.raw_user_meta_data->>'full_name',
      NEW.raw_user_meta_data->>'name',
      NEW.email
    ),
    COALESCE(
      (NEW.raw_user_meta_data->>'role')::user_role,
      'student'
    )
  )
  ON CONFLICT (id) DO UPDATE
    SET name = COALESCE(EXCLUDED.name, public.users.name),
        role = CASE
          WHEN public.users.role = 'student'
            AND EXCLUDED.role IS NOT NULL
          THEN EXCLUDED.role
          ELSE public.users.role
        END;
  RETURN NEW;
END;
$$;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();


-- ============================================================
-- 8. LEADERBOARD VIEW
-- Returns ranked users who have NOT opted into privacy.
-- ============================================================
CREATE OR REPLACE VIEW public.leaderboard
  WITH (security_invoker = on) AS
  SELECT
    ROW_NUMBER() OVER (ORDER BY total_stars DESC) AS rank,
    id,
    name,
    total_stars,
    level,
    avatar_id
  FROM public.users
  WHERE is_private = false
  ORDER BY total_stars DESC;

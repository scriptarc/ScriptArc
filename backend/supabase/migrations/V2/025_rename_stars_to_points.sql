-- ============================================================
-- ScriptArc — Migration 025: Rename "stars" → "points"
-- Date: 2026-03-16
-- ──────────────────────────────────────────────────────────────
-- Stars (1-5) are ONLY for certificates. Everything else
-- (per-challenge awards, per-lesson totals, global totals,
-- leaderboard rankings) uses "points".
--
-- Column renames:
--   users.total_stars          → users.total_points
--   submissions.stars_awarded  → submissions.points_awarded
--   user_progress.stars_earned → user_progress.points_earned
-- ============================================================


-- ============================================================
-- 1. RENAME COLUMNS
-- ============================================================

ALTER TABLE public.users
  RENAME COLUMN total_stars TO total_points;

ALTER TABLE public.submissions
  RENAME COLUMN stars_awarded TO points_awarded;

ALTER TABLE public.user_progress
  RENAME COLUMN stars_earned TO points_earned;


-- ============================================================
-- 2. UPDATE valid_stars_range CONSTRAINT → valid_points_range
-- ============================================================

ALTER TABLE public.submissions
  DROP CONSTRAINT IF EXISTS valid_stars_range;

ALTER TABLE public.submissions
  ADD CONSTRAINT valid_points_range CHECK (points_awarded BETWEEN 0 AND 4);


-- ============================================================
-- 3. UPDATE prevent_privilege_escalation TRIGGER FUNCTION
-- References total_stars → total_points
-- ============================================================

CREATE OR REPLACE FUNCTION public.prevent_privilege_escalation()
  RETURNS TRIGGER LANGUAGE plpgsql
  SECURITY DEFINER SET search_path = ''
AS $$
BEGIN
  -- If the update is coming from a superuser or service role, allow it
  IF current_setting('request.jwt.claim.role', true) = 'service_role' OR current_user = 'postgres' THEN
    RETURN NEW;
  END IF;

  -- Prevent clients from changing their own role, points, or special access flag
  NEW.role               := OLD.role;
  NEW.total_points       := OLD.total_points;
  NEW.has_special_access := OLD.has_special_access;
  RETURN NEW;
END;
$$;


-- ============================================================
-- 4. UPDATE enforce_points_awarded TRIGGER FUNCTION
-- (was enforce_stars_awarded — references stars_awarded → points_awarded)
-- ============================================================

DROP TRIGGER IF EXISTS trg_enforce_stars ON public.submissions;

CREATE OR REPLACE FUNCTION public.enforce_points_awarded()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER SET search_path = ''
AS $$
DECLARE
  v_challenge_type text;
BEGIN
  SELECT challenge_type INTO v_challenge_type
  FROM public.challenges
  WHERE id = NEW.challenge_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'enforce_points_awarded: unknown challenge_id %', NEW.challenge_id;
  END IF;

  NEW.points_awarded := public.calculate_marks(
    v_challenge_type,
    COALESCE(NEW.hint_used,       false),
    COALESCE(NEW.solution_viewed, false)
  );

  RETURN NEW;
END;
$$;

COMMENT ON FUNCTION public.enforce_points_awarded IS
  'BEFORE INSERT trigger on submissions. Overwrites client-supplied points_awarded '
  'with the server-calculated value from calculate_marks(). '
  'Prevents score inflation via direct API manipulation.';

DROP TRIGGER IF EXISTS trg_enforce_points ON public.submissions;

CREATE TRIGGER trg_enforce_points
  BEFORE INSERT ON public.submissions
  FOR EACH ROW EXECUTE FUNCTION public.enforce_points_awarded();

-- Drop the old function (renamed above)
DROP FUNCTION IF EXISTS public.enforce_stars_awarded();


-- ============================================================
-- 5. UPDATE update_user_total_points TRIGGER FUNCTION
-- (was update_user_total_stars — references total_stars + stars_awarded)
-- ============================================================

DROP TRIGGER IF EXISTS on_submission_inserted ON public.submissions;
DROP FUNCTION IF EXISTS public.update_user_total_stars();

CREATE OR REPLACE FUNCTION public.update_user_total_points()
RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER SET search_path = '' AS $$
BEGIN
  UPDATE public.users
  SET total_points = total_points + NEW.points_awarded
  WHERE id = NEW.user_id;
  RETURN NEW;
END; $$;

COMMENT ON FUNCTION public.update_user_total_points IS
  'Increments total_points on each new submission instead of recalculating the full SUM.';

CREATE TRIGGER on_submission_inserted
  AFTER INSERT ON public.submissions
  FOR EACH ROW EXECUTE FUNCTION public.update_user_total_points();


-- ============================================================
-- 6. UPDATE submit_mcq_answer RPC
-- References stars_awarded column + returns JSON key stars_awarded
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
  v_points         int;
BEGIN
  v_user_id := auth.uid();
  IF v_user_id IS NULL THEN
    RAISE EXCEPTION 'Not authenticated';
  END IF;

  -- Check if already completed
  IF EXISTS (
    SELECT 1 FROM public.submissions
    WHERE user_id = v_user_id AND challenge_id = p_challenge_id
  ) THEN
    RETURN jsonb_build_object('correct', true, 'points_awarded', 0, 'already_completed', true);
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
    INSERT INTO public.submissions (
      user_id, challenge_id, attempts, hint_used, solution_viewed, points_awarded
    ) VALUES (
      v_user_id, p_challenge_id, p_attempts, p_hint_used, false,
      public.calculate_marks('mcq', p_hint_used, false)
    );

    SELECT points_awarded INTO v_points
    FROM public.submissions
    WHERE user_id = v_user_id AND challenge_id = p_challenge_id;
  END IF;

  RETURN jsonb_build_object(
    'correct',           v_is_correct,
    'points_awarded',    COALESCE(v_points, 0),
    'already_completed', false
  );
END;
$$;

COMMENT ON FUNCTION public.submit_mcq_answer IS
  'Server-side MCQ answer validation. Returns {correct, points_awarded, already_completed}. '
  'correct_option is NEVER returned to the client.';

GRANT EXECUTE ON FUNCTION public.submit_mcq_answer(uuid, int, int, boolean) TO authenticated;


-- ============================================================
-- 7. UPDATE generate_certificate FUNCTION
-- References stars_awarded → points_awarded in SUM
-- ============================================================

CREATE OR REPLACE FUNCTION public.generate_certificate(p_course_id uuid)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = ''
AS $$
DECLARE
  v_user_id      uuid;
  v_student_name text;
  v_course_name  text;
  v_mentor_name  text := 'ScriptArc';
  v_score        int  := 0;
  v_max_score    int  := 1;
  v_pct          numeric;
  v_star_rating  int  := 1;
  v_cert_id      text;
  v_hash_input   text;
  v_hash         text;
  v_cert         public.certificates%ROWTYPE;
BEGIN
  v_user_id := auth.uid();
  IF v_user_id IS NULL THEN
    RAISE EXCEPTION 'Not authenticated';
  END IF;

  -- Return existing certificate (idempotent)
  SELECT * INTO v_cert
    FROM public.certificates
   WHERE user_id = v_user_id AND course_id = p_course_id;

  IF FOUND THEN
    RETURN to_jsonb(v_cert);
  END IF;

  -- Completion check
  IF EXISTS (
    SELECT 1
      FROM public.lessons l
     WHERE l.course_id = p_course_id
       AND EXISTS (SELECT 1 FROM public.challenges c WHERE c.lesson_id = l.id)
       AND NOT EXISTS (
             SELECT 1
               FROM public.user_progress up
              WHERE up.lesson_id = l.id
                AND up.user_id   = v_user_id
                AND up.completed = true
           )
  ) THEN
    RAISE EXCEPTION 'Course not yet fully completed';
  END IF;

  SELECT name  INTO v_student_name FROM public.users   WHERE id = v_user_id;
  SELECT title INTO v_course_name  FROM public.courses WHERE id = p_course_id;

  SELECT u.name INTO v_mentor_name
    FROM public.mentor_students ms
    JOIN public.users u ON u.id = ms.mentor_id
   WHERE ms.student_id = v_user_id
     AND ms.course_id = p_course_id
   ORDER BY ms.assigned_at
   LIMIT 1;

  IF v_mentor_name IS NULL THEN v_mentor_name := 'ScriptArc'; END IF;

  -- Score: sum of points_awarded for this course's challenges
  SELECT
    COALESCE(SUM(s.points_awarded), 0),
    COALESCE(SUM(CASE WHEN c.challenge_type = 'coding' THEN 4 ELSE 2 END), 1)
  INTO v_score, v_max_score
  FROM public.challenges c
  JOIN public.lessons l ON l.id = c.lesson_id
  LEFT JOIN public.submissions s ON s.challenge_id = c.id AND s.user_id = v_user_id
  WHERE l.course_id = p_course_id;

  IF v_max_score < 1 THEN v_max_score := 1; END IF;

  -- Star rating (1-5) — ONLY used for the certificate
  v_pct := (v_score::numeric / v_max_score::numeric) * 100;
  v_star_rating := CASE
    WHEN v_pct >= 90 THEN 5
    WHEN v_pct >= 75 THEN 4
    WHEN v_pct >= 60 THEN 3
    WHEN v_pct >= 45 THEN 2
    ELSE 1
  END;

  v_cert_id := 'SCR-' || EXTRACT(YEAR FROM now())::text
    || '-' || LPAD(nextval('public.certificate_seq')::text, 6, '0');

  v_hash_input :=
    v_student_name || '|' ||
    v_course_name  || '|' ||
    v_mentor_name  || '|' ||
    v_score::text  || '|' ||
    v_max_score::text || '|' ||
    CURRENT_DATE::text || '|' ||
    v_cert_id;

  v_hash := encode(digest(v_hash_input, 'sha256'), 'hex');

  INSERT INTO public.certificates (
    certificate_id, user_id,    course_id,
    student_name,   course_name, mentor_name,
    score,          max_score,   star_rating,
    completion_date, certificate_hash
  ) VALUES (
    v_cert_id,      v_user_id,  p_course_id,
    v_student_name, v_course_name, v_mentor_name,
    v_score,        v_max_score, v_star_rating,
    CURRENT_DATE,   v_hash
  )
  RETURNING * INTO v_cert;

  RETURN to_jsonb(v_cert);
END;
$$;

COMMENT ON FUNCTION public.generate_certificate IS
  'Idempotent: generates and stores a certificate when a course is fully completed. '
  'score/max_score are in points. star_rating (1-5) is ONLY for the certificate itself.';

GRANT EXECUTE ON FUNCTION public.generate_certificate(uuid) TO authenticated;


-- ============================================================
-- 8. RECREATE LEADERBOARD VIEW (total_stars → total_points)
-- Must drop dependent views first.
-- ============================================================

DROP VIEW IF EXISTS public.leaderboard CASCADE;
DROP VIEW IF EXISTS public.admin_student_stats CASCADE;

CREATE VIEW public.leaderboard
  WITH (security_invoker = on) AS
  SELECT
    ROW_NUMBER() OVER (ORDER BY total_points DESC) AS rank,
    id,
    name,
    total_points,
    avatar_id
  FROM public.users
  WHERE is_private = false
  ORDER BY total_points DESC;

GRANT SELECT ON public.leaderboard TO authenticated;


-- ============================================================
-- 9. RECREATE admin_student_stats VIEW (total_stars → total_points)
-- ============================================================

CREATE VIEW public.admin_student_stats
WITH (security_invoker = on) AS
SELECT
    u.id,
    u.name,
    u.total_points,
    u.created_at,
    u.updated_at,
    count(ms.mentor_id) as mentor_count,
    array_agg(mp.mentor_code) filter (where mp.mentor_code is not null) as mentor_codes
FROM
    public.users u
LEFT JOIN
    public.mentor_students ms ON u.id = ms.student_id
LEFT JOIN
    public.mentor_profiles mp ON ms.mentor_id = mp.user_id
WHERE
    u.role = 'student'
GROUP BY
    u.id;

GRANT SELECT ON public.admin_student_stats TO authenticated;


-- ============================================================
-- 10. RECREATE leaderboard_course + leaderboard_course_mentor
-- (stars_awarded → points_awarded in the CTE SUM)
-- ============================================================

DROP VIEW IF EXISTS public.leaderboard_course_mentor CASCADE;
DROP VIEW IF EXISTS public.leaderboard_course CASCADE;

CREATE OR REPLACE VIEW public.leaderboard_course
WITH (security_invoker = true)
AS
WITH course_points AS (
  SELECT
    s.user_id,
    ch.course_id,
    SUM(s.points_awarded)::int AS total_points
  FROM public.submissions s
  INNER JOIN public.challenges ch ON ch.id = s.challenge_id
  GROUP BY s.user_id, ch.course_id
),
student_course_rows AS (
  SELECT
    u.id,
    u.name,
    u.avatar_id,
    c.id AS course_id,
    ms.mentor_id
  FROM public.users u
  CROSS JOIN public.courses c
  LEFT JOIN public.mentor_students ms
    ON ms.student_id = u.id
   AND ms.course_id = c.id
  WHERE u.role = 'student'
    AND u.is_private = false
)
SELECT
  scr.id,
  scr.name,
  scr.avatar_id,
  scr.course_id,
  scr.mentor_id,
  COALESCE(cp.total_points, 0) AS total_points,
  ROW_NUMBER() OVER (
    PARTITION BY scr.course_id
    ORDER BY COALESCE(cp.total_points, 0) DESC, scr.id ASC
  ) AS rank
FROM student_course_rows scr
LEFT JOIN course_points cp
  ON cp.user_id = scr.id
 AND cp.course_id = scr.course_id;

COMMENT ON VIEW public.leaderboard_course IS
  'Course-specific leaderboard. Aggregates points_awarded by (user, course).';

CREATE OR REPLACE VIEW public.leaderboard_course_mentor
WITH (security_invoker = true)
AS
SELECT
  lc.id,
  lc.name,
  lc.avatar_id,
  lc.course_id,
  lc.mentor_id,
  lc.total_points,
  ROW_NUMBER() OVER (
    PARTITION BY lc.course_id, lc.mentor_id
    ORDER BY lc.total_points DESC, lc.id ASC
  ) AS rank
FROM public.leaderboard_course lc
WHERE lc.mentor_id IS NOT NULL;

COMMENT ON VIEW public.leaderboard_course_mentor IS
  'Mentor-filtered course leaderboard. Always include (mentor_id, course_id) filter when querying.';

GRANT SELECT ON public.leaderboard_course         TO authenticated;
GRANT SELECT ON public.leaderboard_course_mentor  TO authenticated;


-- ============================================================
-- 11. UPDATE LEADERBOARD PERFORMANCE INDEX
-- (total_stars DESC → total_points DESC)
-- ============================================================

DROP INDEX IF EXISTS public.idx_users_leaderboard;

CREATE INDEX idx_users_leaderboard
  ON public.users(total_points DESC)
  WHERE is_private = false;

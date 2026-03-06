# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

ScriptArc is a gamified coding education platform. Users enroll in courses, watch video lessons, and complete timed challenges (MCQ and coding) that appear at specific timestamps during playback.

## Tech Stack

- **Frontend**: React 19 (Create React App + CRACO) with Tailwind CSS, Radix UI primitives, Framer Motion
- **Backend**: Supabase (Postgres + Auth + RLS + Storage)
- **Code Execution**: Judge0 CE for normal challenges, custom Python Runner microservice (FastAPI/Docker) for data science challenges
- **Package Manager**: Yarn 1.x

## Commands

```bash
# Frontend dev server (from frontend/)
cd frontend && yarn start        # runs on localhost:3000

# Frontend build
cd frontend && yarn build

# Frontend tests
cd frontend && yarn test

# Python Runner (from backend/python-runner/)
docker build -t scriptarc-python-runner . && docker run -p 8000:8000 scriptarc-python-runner
# or without Docker:
pip install -r requirements.txt && uvicorn server:app --reload --port 8000
```

## Architecture

### Frontend (`frontend/src/`)

- **Routing**: `App.js` — React Router v7 with lazy-loaded pages, `ProtectedRoute`/`PublicRoute` wrappers, `AuthProvider` + `ThemeProvider` context
- **Path alias**: `@/` maps to `src/` (configured in `craco.config.js`)
- **Pages**: Landing, Auth, Dashboard, Courses, CourseSingle (course detail + lecture list), Learn (video player + challenge dialogs), Leaderboard, Profile
- **UI components**: `components/ui/` — shadcn/ui-style Radix primitives; `components/Navbar.jsx`
- **State/Auth**: `context/AuthContext.jsx` provides `useAuth()` (wraps Supabase auth). Always call `supabase.auth.getUser()` inside async handlers, not from stale context.
- **Supabase client**: `lib/supabase.js` — uses `REACT_APP_SUPABASE_URL` and `REACT_APP_SUPABASE_ANON_KEY` env vars

### Learn Page Flow (`pages/Learn.jsx`)

This is the most complex page. It fetches a lesson and its challenges, plays a video, and auto-opens challenge dialogs when `currentTime ≈ challenge.timestamp_seconds (±1s)`. MCQ and coding challenges are handled in separate dialog components. Progress is saved via UPSERT to `user_progress`.

### Course Page Flow (`pages/CourseSingle.jsx`)

Displays course detail with a lecture list. Lessons are locked until the previous lesson's `user_progress.completed = true`.

### Database (`backend/supabase/migrations/`)

Migrations are numbered 001–013 and run in order in the Supabase SQL Editor. Key tables: `users`, `courses`, `lessons`, `challenges`, `submissions`, `user_progress`. A `leaderboard_view` aggregates rankings.

### Points System (migration 013)

- **Points** = platform progress. **Stars** = certificate rating only.
- MCQ: max 2 pts (2=independent, 1=hint used, 0=solution viewed). Hint auto-shows after 2 wrong attempts.
- Coding: max 4 pts (4=independent, 2=hint used, 0=solution viewed).
- `submissions.stars_awarded` stores points. `users.total_stars` = SUM of all points.
- Certificate thresholds: 90%→5★, 75%→4★, 60%→3★, 45%→2★, <45%→1★

### Python Runner (`backend/python-runner/`)

FastAPI microservice with Docker. Executes user Python code with data science stack (NumPy, Pandas, etc). 10s timeout, blocked dangerous operations, 50KB output cap.

## Design System

Defined in `design_guidelines.json` at project root. Key rules:
- Dark mode cyber-tech theme (background `#05050F`)
- Fonts: Outfit (primary), Manrope (secondary), JetBrains Mono (code)
- Colors use CSS custom properties via `hsl(var(--...))` pattern in Tailwind config
- Keep corners sharp: `rounded-md` or `rounded-sm`, never `rounded-xl` or higher
- No gradient text (accessibility)
- Use `lucide-react` for all icons (no emoji icons)
- Use `sonner` for toast notifications
- Add `data-testid` to interactive elements
- Prefer `grid` layouts over `flex` for main page structures

## Conventions

- JavaScript only (`.jsx` files, no TypeScript)
- Use named UUIDs for seed data so migrations are idempotent (`ON CONFLICT DO NOTHING`)
- Env vars are in `frontend/.env` (not committed) — prefixed with `REACT_APP_`

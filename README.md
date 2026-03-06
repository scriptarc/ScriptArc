# ScriptArc

**Gamified coding education platform** — video lessons pause at key timestamps for interactive coding challenges, earning points toward skill certificates.

> Start. Solve. Succeed.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Frontend | React 19, Tailwind CSS, Radix UI, Framer Motion |
| Backend | Supabase (Postgres + Auth + RLS + Storage) |
| Code Execution | Judge0 CE (general) + Custom Python Runner (data science) |
| Video Streaming | HLS.js adaptive bitrate, Backblaze B2 storage |
| Package Manager | Yarn 1.x |

---

## Features

- **Checkpoint Challenges** — Video pauses automatically at timestamps for MCQ or coding challenges
- **Points System** — MCQ: 2 pts, Coding: 4 pts; reduced for hints, 0 for viewing solution
- **Adaptive Video** — HLS adaptive bitrate streaming with MP4 fallback
- **Dual Code Engine** — Judge0 CE for general languages; isolated Python Runner for data science (NumPy, Pandas)
- **Leaderboard** — Global ranking by total points, opt-in privacy
- **Lecture Lock** — Lessons unlock sequentially as you complete each one
- **Google OAuth** — Sign in with Google, role selection (Student / Mentor)
- **Certificates** — Performance-based star rating on course completion

---

## Project Structure

```
ScriptArc_V1/
├── frontend/                        # React app (CRA + CRACO)
│   ├── src/
│   │   ├── pages/                   # Landing, Auth, Dashboard, Courses,
│   │   │                            # CourseSingle, Learn, Leaderboard, Profile
│   │   ├── components/              # Navbar, UI primitives (shadcn/ui style)
│   │   ├── context/                 # AuthContext, ThemeContext
│   │   ├── hooks/                   # useHlsPlayer
│   │   └── lib/                     # supabase.js client
│   └── .env                         # Environment variables (not committed)
├── backend/
│   ├── python-runner/               # FastAPI microservice for Python execution
│   │   └── server.py
│   └── supabase/
│       ├── functions/
│       │   └── execute-code/        # Edge Function: dual-engine code executor
│       └── migrations/
│           └── V2/                  # Current schema (3 consolidated migrations)
├── design_guidelines.json           # Design system spec
└── CLAUDE.md                        # AI assistant instructions
```

---

## Getting Started

### Prerequisites
- Node.js 18+, Yarn 1.x
- Python 3.10+ (for Python Runner without Docker)
- Docker (optional)
- Supabase project

### 1. Frontend

```bash
cd frontend
yarn install
yarn start           # http://localhost:3000
```

**Required `frontend/.env`:**

```env
REACT_APP_SUPABASE_URL=https://<your-project>.supabase.co
REACT_APP_SUPABASE_ANON_KEY=<your-anon-key>
REACT_APP_B2_URL=https://f003.backblazeb2.com/file/<your-bucket>
```

### 2. Database

Run migrations in order in the Supabase SQL Editor:

```
backend/supabase/migrations/V2/001_initial_schema.sql
backend/supabase/migrations/V2/002_rls_and_views.sql
backend/supabase/migrations/V2/003_seed_data.sql
```

### 3. Python Runner

**Docker (recommended for production):**
```bash
cd backend/python-runner
docker build -t scriptarc-python-runner .
docker run -p 8000:8000 \
  -e ALLOWED_ORIGINS=https://your-supabase-project.supabase.co \
  scriptarc-python-runner
```

**Without Docker:**
```bash
cd backend/python-runner
pip install -r requirements.txt
uvicorn server:app --reload --port 8000
```

### 4. Edge Function

```bash
npx supabase functions deploy execute-code --no-verify-jwt
```

Set secrets in Supabase dashboard → Edge Functions → Secrets:
```
PYTHON_RUNNER_URL=https://your-python-runner-url
ALLOWED_ORIGINS=https://your-frontend-domain.com
```

---

## Points System

| Challenge | Independent | Hint Used | Solution Viewed |
|---|---|---|---|
| MCQ | 2 pts | 1 pt | 0 pts |
| Coding | 4 pts | 2 pts | 0 pts |

**Certificate Stars** (based on % of max possible points):
`90%→5★` · `75%→4★` · `60%→3★` · `45%→2★` · `<45%→1★`

---

## Security

- Row Level Security on all tables
- `prevent_privilege_escalation` DB trigger — users cannot self-elevate `role`, `total_stars`, or `has_special_access`
- Submissions are INSERT-only (no UPDATE/DELETE) — points are immutable once recorded
- Python Runner blocks: `import os/sys/socket/subprocess`, `exec`, `eval`, `__import__`, `from os import`, etc.
- Edge Function restricts CORS to known origins

---

## Commands

```bash
# Frontend dev server
cd frontend && yarn start

# Frontend production build
cd frontend && yarn build

# Python Runner (dev, no Docker)
cd backend/python-runner && uvicorn server:app --reload --port 8000
```

---

## Deployment Checklist

- [ ] Set all `REACT_APP_*` env vars in hosting platform (Vercel / Netlify)
- [ ] Set Supabase Edge Function secrets (`PYTHON_RUNNER_URL`, `ALLOWED_ORIGINS`)
- [ ] Set Python Runner `ALLOWED_ORIGINS` to Supabase function origin
- [ ] Run V2 migrations on production Supabase project
- [ ] Enable Google OAuth in Supabase Auth → Providers
- [ ] Verify Backblaze B2 bucket CORS allows your domain
- [ ] Test HLS video playback and MP4 fallback
- [ ] Test Judge0 and Python Runner execution end-to-end
- [ ] Confirm RLS policies active on all tables

---

## Author

**Aswin M** · © 2026 ScriptArc · All rights reserved.

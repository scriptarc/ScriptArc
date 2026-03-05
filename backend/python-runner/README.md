# ScriptArc Python Runner

A lightweight microservice that executes Python code with the full data science stack (NumPy, Pandas, Matplotlib, SciPy, scikit-learn).

## Architecture

```
User Code → ScriptArc Frontend → Supabase Edge Function
                                        │
                    ┌───────────────────┤
                    ↓                    ↓
              Judge0 CE             Python Runner
           (normal challenges)    (data science)
```

## API

### `POST /execute`

```json
{
  "code": "import numpy as np\nprint(np.sum([1,2,3]))",
  "stdin": ""
}
```

**Response:**

```json
{
  "stdout": "6\n",
  "stderr": "",
  "success": true,
  "time": 0.123
}
```

### `GET /health`

Returns `{"status": "ok"}`

## Run Locally

```bash
# With Docker
docker build -t scriptarc-python-runner .
docker run -p 8000:8000 scriptarc-python-runner

# Without Docker (dev mode)
pip install -r requirements.txt
uvicorn server:app --reload --port 8000
```

## Deploy to Railway

1. Push this folder to a GitHub repo (or use the monorepo)
2. Go to [Railway](https://railway.app) → New Project → Deploy from GitHub
3. Set the **Root Directory** to `backend/python-runner`
4. Railway auto-detects the Dockerfile and deploys
5. Copy the generated URL (e.g., `https://your-app.up.railway.app`)
6. Update the `PYTHON_RUNNER_URL` in the Supabase Edge Function

## Deploy to Render

1. Go to [Render](https://render.com) → New Web Service
2. Connect your repo, set **Root Directory** to `backend/python-runner`
3. Set **Docker** as the environment
4. Deploy — copy the URL
5. Update `PYTHON_RUNNER_URL` in the Edge Function

## Security

- **10s timeout** on all executions
- **Blocked operations**: `os.system`, `subprocess`, `shutil.rmtree`, `__import__`, `exec()`, `eval()`
- **Non-root user** inside Docker
- **50 KB output cap** to prevent memory abuse
- **Headless matplotlib** via `MPLBACKEND=Agg`

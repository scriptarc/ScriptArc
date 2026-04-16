from fastapi import FastAPI, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import subprocess
import sys
import tempfile
import os
import time
import secrets

app = FastAPI(title="ScriptArc Python Runner", version="1.0.0")

# CORS — restrict to Supabase Edge Function and local dev only.
# The Python Runner is called server-to-server by the Edge Function,
# but this limits browser-direct calls as a defence-in-depth measure.
_ALLOWED_ORIGINS = [
    o.strip() for o in os.environ.get(
        "ALLOWED_ORIGINS",
        "http://localhost:3000,http://localhost:54321"
    ).split(",") if o.strip()
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=_ALLOWED_ORIGINS,
    allow_methods=["POST"],
    allow_headers=["Content-Type", "Authorization"],
)

TIMEOUT_SECONDS = 10   # max execution time per request
MAX_OUTPUT_BYTES = 50_000  # cap output to ~50 KB
MAX_CODE_BYTES   = 10_000  # reject code payloads over 10 KB
MAX_STDIN_BYTES  = 5_000   # reject stdin payloads over 5 KB

# Shared secret: the Edge Function must send X-Runner-Secret matching this value.
# Must be set in production — the server will refuse to start without it.
_RUNNER_SECRET = os.environ.get("RUNNER_SECRET", "")
_IS_PRODUCTION = os.environ.get("ENVIRONMENT", "development").lower() == "production"
if _IS_PRODUCTION and not _RUNNER_SECRET:
    raise RuntimeError("RUNNER_SECRET must be set in production. Refusing to start.")


class ExecuteRequest(BaseModel):
    code: str
    stdin: str = ""


class ExecuteResponse(BaseModel):
    stdout: str
    stderr: str
    success: bool
    time: float | None = None
    output_truncated: bool = False


@app.get("/")
def health():
    return {"status": "ok", "service": "scriptarc-python-runner"}


@app.get("/health")
def health_check():
    return {"status": "ok"}


@app.post("/execute", response_model=ExecuteResponse)
def execute_code(req: ExecuteRequest, request: Request):
    # ── Shared-secret authentication ──────────────────────────
    # Reject requests that don't carry the correct X-Runner-Secret header.
    # Enforced when RUNNER_SECRET env var is set (always true in production).
    if _RUNNER_SECRET:
        provided = request.headers.get("x-runner-secret", "")
        if not secrets.compare_digest(provided, _RUNNER_SECRET):
            raise HTTPException(status_code=401, detail="Unauthorized.")

    # ── Input size limits ─────────────────────────────────────
    if len(req.code.encode()) > MAX_CODE_BYTES:
        raise HTTPException(status_code=400, detail=f"Code exceeds {MAX_CODE_BYTES // 1000} KB limit.")
    if len((req.stdin or "").encode()) > MAX_STDIN_BYTES:
        raise HTTPException(status_code=400, detail=f"Stdin exceeds {MAX_STDIN_BYTES // 1000} KB limit.")

    if not req.code.strip():
        raise HTTPException(status_code=400, detail="Code cannot be empty.")

    # ---------- Security: block dangerous operations ----------
    blocked = [
        "os.system", "subprocess", "shutil.rmtree", "__import__",
        "exec(", "eval(", "compile(", "exit(", "quit(",
        "import os", "import sys", "import socket", "import subprocess",
        "from os import", "from sys import", "from socket import",
        "from subprocess import", "from shutil import",
    ]
    code_lower = req.code.lower()
    for b in blocked:
        if b.lower() in code_lower:
            return ExecuteResponse(
                stdout="",
                stderr=f"SecurityError: '{b}' is not allowed in this environment.",
                success=False,
                time=0,
            )

    # ---------- Write code to a temp file and execute ----------
    with tempfile.TemporaryDirectory() as tmpdir:
        script_path = os.path.join(tmpdir, "script.py")
        with open(script_path, "w", encoding="utf-8") as f:
            f.write(req.code)

        start = time.monotonic()
        try:
            # Use ulimit to restrict memory in a shell before running python
            # This avoids using preexec_fn, which can cause deadlocks in multi-threaded environments like FastAPI workers.
            cmd = f"ulimit -v 524288 && {sys.executable} script.py"
            
            # Pass ONLY the minimal env vars needed for safe execution.
            # Never pass os.environ — it would expose host secrets (RUNNER_SECRET,
            # database credentials, etc.) to untrusted user code via os.environ reads.
            safe_env = {
                "PATH": "/usr/local/bin:/usr/bin:/bin",
                "HOME": tmpdir,               # isolate from real home dir
                "MPLBACKEND": "Agg",          # prevent matplotlib GUI popups
                "OPENBLAS_NUM_THREADS": "1",
                "OMP_NUM_THREADS": "1",
                "MKL_NUM_THREADS": "1",
                "NUMBA_DISABLE_JIT": "1",     # faster cold start in sandbox
                "PYTHONDONTWRITEBYTECODE": "1",
            }

            process = subprocess.Popen(
                ["sh", "-c", cmd],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True,
                cwd=tmpdir,
                stdin=subprocess.PIPE,
                env=safe_env,
            )
            
            stdout, stderr = process.communicate(input=req.stdin or None, timeout=TIMEOUT_SECONDS)
            elapsed = round(time.monotonic() - start, 3)

            stdout_truncated = len(stdout) > MAX_OUTPUT_BYTES
            stderr_truncated = len(stderr) > MAX_OUTPUT_BYTES
            return ExecuteResponse(
                stdout=stdout[:MAX_OUTPUT_BYTES],
                stderr=stderr[:MAX_OUTPUT_BYTES],
                success=process.returncode == 0,
                time=elapsed,
                output_truncated=stdout_truncated or stderr_truncated,
            )

        except subprocess.TimeoutExpired:
            process.kill()
            process.communicate()  # drain pipes to avoid deadlock
            elapsed = round(time.monotonic() - start, 3)
            return ExecuteResponse(
                stdout="",
                stderr=f"TimeoutError: Code execution exceeded {TIMEOUT_SECONDS}s limit.",
                success=False,
                time=elapsed,
            )
        except Exception as e:
            return ExecuteResponse(
                stdout="",
                stderr=f"InternalError: {str(e)}",
                success=False,
                time=0,
            )

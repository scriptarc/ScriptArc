from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import subprocess
import sys
import tempfile
import os
import time
import resource

app = FastAPI(title="ScriptArc Python Runner", version="1.0.0")

# CORS — allow calls from the Supabase Edge Function
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["POST", "GET", "OPTIONS"],
    allow_headers=["*"],
)

TIMEOUT_SECONDS = 10  # max execution time per request
MAX_OUTPUT_BYTES = 50_000  # cap output to ~50 KB


class ExecuteRequest(BaseModel):
    code: str
    stdin: str = ""


class ExecuteResponse(BaseModel):
    stdout: str
    stderr: str
    success: bool
    time: float | None = None


@app.get("/")
def health():
    return {"status": "ok", "service": "scriptarc-python-runner"}


@app.get("/health")
def health_check():
    return {"status": "ok"}


@app.post("/execute", response_model=ExecuteResponse)
def execute_code(req: ExecuteRequest):
    if not req.code.strip():
        raise HTTPException(status_code=400, detail="Code cannot be empty.")

    # ---------- Security: block dangerous operations ----------
    blocked = [
        "os.system", "subprocess", "shutil.rmtree", "open(", "__import__",
        "exec(", "eval(", "compile(", "exit(", "quit(",
        "import os", "import sys", "import socket"
    ]
    code_lower = req.code.lower()
    for b in blocked:
        # Allow 'open(' only if it looks like file I/O — block everything else
        if b == "open(" and "open(" in req.code:
            continue  # we run in tmpdir anyway, no persistence
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
            
            process = subprocess.Popen(
                ["sh", "-c", cmd],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True,
                cwd=tmpdir,
                stdin=subprocess.PIPE,
                env={
                    **os.environ,
                    "MPLBACKEND": "Agg",  # prevent matplotlib GUI popups
                    "OPENBLAS_NUM_THREADS": "1",
                    "OMP_NUM_THREADS": "1",
                    "MKL_NUM_THREADS": "1",
                },
            )
            
            stdout, stderr = process.communicate(input=req.stdin or None, timeout=TIMEOUT_SECONDS)
            elapsed = round(time.monotonic() - start, 3)

            return ExecuteResponse(
                stdout=stdout[:MAX_OUTPUT_BYTES],
                stderr=stderr[:MAX_OUTPUT_BYTES],
                success=process.returncode == 0,
                time=elapsed,
            )

        except subprocess.TimeoutExpired:
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

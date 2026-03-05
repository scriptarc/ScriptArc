# ── Stage 1: Build dependencies ──────────────────────
FROM python:3.11-slim AS builder

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# ── Stage 2: Runtime ─────────────────────────────────
FROM python:3.11-slim

WORKDIR /app

ENV MPLBACKEND=Agg

# Copy installed packages from builder
COPY --from=builder /install /usr/local

# Copy server code
COPY server.py .

# Non-root user for security
RUN useradd -m runner
USER runner

# Expose port (Railway/Render will set PORT env var)
EXPOSE 8000

# Run the server — $PORT is set by Railway/Render automatically
CMD ["sh", "-c", "uvicorn server:app --host 0.0.0.0 --port ${PORT:-8000}"]

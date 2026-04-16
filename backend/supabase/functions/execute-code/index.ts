// Supabase Edge Function: execute-code
// Dual-engine architecture:
//   1. Python Runner (for data science — NumPy, Pandas, etc.)
//   2. Judge0 CE  (general coding challenges)
//
// Deploy with: npx supabase functions deploy execute-code --no-verify-jwt
// JWT verification is performed manually inside the handler (see auth check below).

// @ts-nocheck
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const JUDGE0_URL = 'https://ce.judge0.com/submissions';
const PYTHON_RUNNER_URL = Deno.env.get('PYTHON_RUNNER_URL') ?? '';
const RUNNER_SECRET = Deno.env.get('RUNNER_SECRET') ?? '';

// Restrict CORS to known origins. Add production domain to ALLOWED_ORIGINS env var.
const ALLOWED_ORIGINS = (Deno.env.get('ALLOWED_ORIGINS') ?? 'http://localhost:3000').split(',').map(o => o.trim());

function getCorsHeaders(origin: string) {
    const allowed = ALLOWED_ORIGINS.includes(origin) ? origin : ALLOWED_ORIGINS[0];
    return {
        'Access-Control-Allow-Origin': allowed,
        'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
        'Access-Control-Allow-Methods': 'POST, OPTIONS',
        'X-Content-Type-Options': 'nosniff',
        'X-Frame-Options': 'DENY',
        'Referrer-Policy': 'strict-origin-when-cross-origin',
    };
}

// ── Helper: execute via Python Runner (data science) ──────────
async function executePythonRunner(code: string, stdin: string) {
    if (!PYTHON_RUNNER_URL) throw new Error('PYTHON_RUNNER_URL not configured');

    const headers: Record<string, string> = { 'Content-Type': 'application/json' };
    if (RUNNER_SECRET) headers['X-Runner-Secret'] = RUNNER_SECRET;

    const res = await fetch(`${PYTHON_RUNNER_URL}/execute`, {
        method: 'POST',
        headers,
        body: JSON.stringify({ code, stdin }),
    });

    if (!res.ok) throw new Error(`Python Runner HTTP ${res.status}`);

    const result = await res.json();

    return {
        engine: 'python-runner',
        stdout: result.stdout ?? '',
        stderr: result.stderr ?? '',
        compile_output: '',
        message: '',
        status: result.success ? 'Accepted' : 'Runtime Error',
        status_id: result.success ? 3 : 6,
        time: result.time ?? null,
        memory: null,
    };
}

// ── Helper: execute via Judge0 ────────────────────────────────
async function executeJudge0(code: string, languageId: number, stdin: string) {
    const controller = new AbortController();
    const timeout = setTimeout(() => controller.abort(), 10000);

    try {
        const res = await fetch(`${JUDGE0_URL}?base64_encoded=false&wait=true`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            signal: controller.signal,
            body: JSON.stringify({
                source_code: code,
                language_id: languageId,
                stdin,
                cpu_time_limit: 5,
                memory_limit: 128000,
            }),
        });

        if (!res.ok) throw new Error(`Judge0 HTTP ${res.status}`);
        const result = await res.json();
        if (!result.status?.id) throw new Error('Judge0 returned empty status');

        return {
            engine: 'judge0',
            stdout: result.stdout ?? '',
            stderr: result.stderr ?? '',
            compile_output: result.compile_output ?? '',
            message: result.message ?? '',
            status: result.status?.description ?? 'Unknown',
            status_id: result.status?.id ?? 0,
            time: result.time ?? null,
            memory: result.memory ?? null,
        };
    } finally {
        clearTimeout(timeout);
    }
}



// ── Main handler ──────────────────────────────────────────────
Deno.serve(async (req) => {
    const origin = req.headers.get('origin') ?? '';
    const corsHeaders = getCorsHeaders(origin);

    if (req.method === 'OPTIONS') {
        return new Response('ok', { headers: corsHeaders });
    }

    // ── Auth: verify the caller holds a valid Supabase session ──
    // The function is deployed with --no-verify-jwt so we do this manually.
    // supabase.functions.invoke() from the client automatically includes the JWT.
    const authHeader = req.headers.get('authorization') ?? '';
    const jwt = authHeader.replace(/^Bearer\s+/i, '').trim();
    if (!jwt) {
        return new Response(
            JSON.stringify({ error: 'Authentication required.' }),
            { status: 401, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        );
    }
    // Validate the JWT against Supabase Auth — rejects expired/forged tokens.
    const supabaseClient = createClient(
        Deno.env.get('SUPABASE_URL') ?? '',
        Deno.env.get('SUPABASE_ANON_KEY') ?? '',
        { auth: { persistSession: false } }
    );
    const { data: { user }, error: authError } = await supabaseClient.auth.getUser(jwt);
    if (authError || !user) {
        return new Response(
            JSON.stringify({ error: 'Invalid or expired session.' }),
            { status: 401, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        );
    }

    try {
        const { code, language_id, stdin = '', use_python_runner = false } = await req.json();

        if (!code || !language_id) {
            return new Response(
                JSON.stringify({ error: 'code and language_id are required.' }),
                { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
            );
        }

        const langId = Number(language_id);
        let result;

        // ── Route 1: Python Runner (data science courses) ──
        if (use_python_runner && PYTHON_RUNNER_URL) {
            try {
                result = await executePythonRunner(code, stdin);
            } catch (pyErr) {
                console.warn(`[execute-code] Python Runner failed: ${pyErr}. Falling back to Judge0.`);
                try {
                    result = await executeJudge0(code, langId, stdin);
                } catch (j0Err) {
                    console.error('[execute-code] Both engines failed:', pyErr, j0Err);
                    return new Response(
                        JSON.stringify({ error: 'Code execution service is temporarily unavailable. Please try again.' }),
                        { status: 502, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
                    );
                }
            }
        } else {
            // ── Route 2: Judge0 ──
            try {
                result = await executeJudge0(code, langId, stdin);
            } catch (judge0Err) {
                console.error('[execute-code] Judge0 failed:', judge0Err);
                return new Response(
                    JSON.stringify({ error: 'Code execution service is temporarily unavailable. Please try again.' }),
                    { status: 502, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
                );
            }
        }

        return new Response(JSON.stringify(result), {
            status: 200,
            headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        });

    } catch (err) {
        console.error('[execute-code] Unhandled error:', err);
        return new Response(
            JSON.stringify({ error: 'An unexpected error occurred. Please try again.' }),
            { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        );
    }
});

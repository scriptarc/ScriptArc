// Supabase Edge Function: execute-code
// Dual-engine architecture:
//   1. Python Runner (for data science — NumPy, Pandas, etc.)
//   2. Judge0 CE  (general coding challenges)
//
// Deploy with: npx supabase functions deploy execute-code --no-verify-jwt

// @ts-nocheck

const JUDGE0_URL = 'https://ce.judge0.com/submissions';
const PYTHON_RUNNER_URL = Deno.env.get('PYTHON_RUNNER_URL') ?? '';


const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

// ── Helper: execute via Python Runner (data science) ──────────
async function executePythonRunner(code: string, stdin: string) {
    if (!PYTHON_RUNNER_URL) throw new Error('PYTHON_RUNNER_URL not configured');

    const res = await fetch(`${PYTHON_RUNNER_URL}/execute`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
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
    if (req.method === 'OPTIONS') {
        return new Response('ok', { headers: corsHeaders });
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
                // Fall through to Judge0
                try {
                    result = await executeJudge0(code, langId, stdin);
                } catch (j0Err) {
                    return new Response(
                        JSON.stringify({ error: `Python Runner: ${pyErr}. Judge0: ${j0Err}.` }),
                        { status: 502, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
                    );
                }
            }
        } else {
            // ── Route 2: Judge0 ──
            try {
                result = await executeJudge0(code, langId, stdin);
            } catch (judge0Err) {
                return new Response(
                    JSON.stringify({ error: `Judge0: ${judge0Err}.` }),
                    { status: 502, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
                );
            }
        }

        return new Response(JSON.stringify(result), {
            status: 200,
            headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        });

    } catch (err) {
        const message = err instanceof Error ? err.message : String(err);
        return new Response(
            JSON.stringify({ error: `Internal error: ${message}` }),
            { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        );
    }
});

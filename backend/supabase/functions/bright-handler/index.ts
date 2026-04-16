// Supabase Edge Function: bright-handler
// Legacy Judge0 CE proxy via RapidAPI with server-side API key.
// NOTE: Prefer execute-code/index.ts which has dual-engine support.
// Deploy with: npx supabase functions deploy bright-handler --no-verify-jwt
// JWT verification is performed manually inside the handler (see auth check below).

// @ts-nocheck  (Deno globals are resolved at deploy time, not by local TS server)
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const JUDGE0_URL = 'https://judge0-ce.p.rapidapi.com/submissions';

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
    };
}

Deno.serve(async (req) => {
    const origin = req.headers.get('origin') ?? '';
    const corsHeaders = getCorsHeaders(origin);

    // Handle CORS preflight
    if (req.method === 'OPTIONS') {
        return new Response('ok', { headers: corsHeaders });
    }

    // ── Auth: verify the caller holds a valid Supabase session ──
    const authHeader = req.headers.get('authorization') ?? '';
    const jwt = authHeader.replace(/^Bearer\s+/i, '').trim();
    if (!jwt) {
        return new Response(
            JSON.stringify({ error: 'Authentication required.' }),
            { status: 401, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        );
    }
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
        const { code, language_id, stdin = '' } = await req.json();

        if (!code || !language_id) {
            return new Response(
                JSON.stringify({ error: 'code and language_id are required.' }),
                { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
            );
        }

        // Prefer JUDGE0_API_KEY; fall back to legacy JUDGEO_API_KEY (typo kept for backwards-compat)
        const apiKey = Deno.env.get('JUDGE0_API_KEY') || Deno.env.get('JUDGEO_API_KEY');
        if (!apiKey) {
            return new Response(
                JSON.stringify({ error: 'Judge0 API key not configured on server.' }),
                { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
            );
        }

        // 10s timeout on Judge0 call
        const controller = new AbortController();
        const timeout = setTimeout(() => controller.abort(), 10000);

        let result;
        try {
            const judgeRes = await fetch(`${JUDGE0_URL}?base64_encoded=false&wait=true`, {
                method: 'POST',
                signal: controller.signal,
                headers: {
                    'Content-Type': 'application/json',
                    'X-RapidAPI-Key': apiKey,
                    'X-RapidAPI-Host': 'judge0-ce.p.rapidapi.com',
                },
                body: JSON.stringify({
                    source_code: code,
                    language_id: Number(language_id),
                    stdin,
                    cpu_time_limit: 5,
                    memory_limit: 128000,
                }),
            });

            if (!judgeRes.ok) {
                const errText = await judgeRes.text();
                return new Response(
                    JSON.stringify({ error: `Judge0 API error: ${judgeRes.status} ${errText}` }),
                    { status: 502, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
                );
            }

            result = await judgeRes.json();
        } finally {
            clearTimeout(timeout);
        }

        return new Response(
            JSON.stringify({
                stdout: result.stdout ?? '',
                stderr: result.stderr ?? '',
                compile_output: result.compile_output ?? '',
                message: result.message ?? '',
                status: result.status?.description ?? 'Unknown',
                status_id: result.status?.id ?? 0,
                time: result.time ?? null,
                memory: result.memory ?? null,
            }),
            {
                status: 200,
                headers: { ...corsHeaders, 'Content-Type': 'application/json' },
            }
        );
    } catch (err) {
        const message = err instanceof Error ? err.message : String(err);
        if ((err as any).name === 'AbortError') {
            return new Response(
                JSON.stringify({ error: 'Code execution timed out. Please try again.' }),
                { status: 504, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
            );
        }
        return new Response(
            JSON.stringify({ error: `Internal error: ${message}` }),
            { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        );
    }
});

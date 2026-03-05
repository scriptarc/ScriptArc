// Supabase Edge Function: execute-code
// Proxies to Judge0 CE API (RapidAPI) with server-side API key
// Deploy with: npx supabase functions deploy execute-code

// @ts-nocheck  (Deno globals are resolved at deploy time, not by local TS server)

const JUDGE0_URL = 'https://judge0-ce.p.rapidapi.com/submissions';

const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

Deno.serve(async (req) => {
    // Handle CORS preflight
    if (req.method === 'OPTIONS') {
        return new Response('ok', { headers: corsHeaders });
    }

    try {
        const { code, language_id, stdin = '' } = await req.json();

        if (!code || !language_id) {
            return new Response(
                JSON.stringify({ error: 'code and language_id are required.' }),
                { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
            );
        }

        const apiKey = Deno.env.get('JUDGEO_API_KEY') || Deno.env.get('JUDGE0_API_KEY');
        if (!apiKey) {
            return new Response(
                JSON.stringify({ error: 'Judge0 API key not configured on server (JUDGEO_API_KEY).' }),
                { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
            );
        }

        // Submit to Judge0 with wait=true so we get an immediate result
        const judgeRes = await fetch(`${JUDGE0_URL}?base64_encoded=false&wait=true`, {
            method: 'POST',
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

        const result = await judgeRes.json();

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
        return new Response(
            JSON.stringify({ error: `Internal error: ${message}` }),
            { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        );
    }
});

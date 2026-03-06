import subprocess
import json
import sys

b2_path = r"C:\Users\Aswin\AppData\Local\Python\pythoncore-3.14-64\Scripts\b2.exe"
cors_rules = [
    {
        "corsRuleName": "allowAny",
        "allowedOrigins": [
            "http://localhost:3000",
            "https://scriptarc-dev.vercel.app"
        ],
        "allowedOperations": [
            "b2_download_file_by_id",
            "b2_download_file_by_name"
        ],
        "allowedHeaders": ["*"],
        "exposeHeaders": ["x-bz-content-sha1"],
        "maxAgeSeconds": 3600
    }
]

cors_json = json.dumps(cors_rules)
print(f"Applying CORS rules: {cors_json}")

try:
    result = subprocess.run([b2_path, "bucket", "update", "ScripArc", "allPublic", "--cors-rules", cors_json], capture_output=True, text=True)
    print("Return code:", result.returncode)
    print("Stdout:", result.stdout)
    if result.stderr:
        print("Stderr:", result.stderr)
    if result.returncode != 0:
        sys.exit(result.returncode)
except Exception as e:
    print(f"Error: {e}")
    sys.exit(1)

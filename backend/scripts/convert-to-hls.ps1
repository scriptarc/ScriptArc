param (
    [Parameter(Mandatory=$false, Position=0)]
    [string]$InputFile,
    
    [Parameter(Mandatory=$false, Position=1)]
    [string]$OutputDir
)

if (-not $InputFile -or -not $OutputDir) {
    Write-Host "Usage: .\convert-to-hls.ps1 <input.mp4> <output_directory>"
    exit 1
}

if (-not (Test-Path $InputFile -PathType Leaf)) {
    Write-Host "Error: Input file '$InputFile' not found."
    exit 1
}

# Ensure output directory exists
New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null

Write-Host "Converting '$InputFile' to HLS in directory '$OutputDir'..."

# FFmpeg command to create 360p and 720p HLS streams with a master playlist
ffmpeg -nostdin -i "$InputFile" `
  -filter_complex "[0:v]split=2[v1][v2]; [v1]scale=w=640:h=360[v1out]; [v2]scale=w=1280:h=720[v2out]" `
  -map "[v1out]" -c:v:0 libx264 -x264-params "nal-hrd=cbr:force-cfr=1" -b:v:0 800k -maxrate:v:0 856k -minrate:v:0 800k -bufsize:v:0 1200k `
  -map "[v2out]" -c:v:1 libx264 -x264-params "nal-hrd=cbr:force-cfr=1" -b:v:1 2500k -maxrate:v:1 2675k -minrate:v:1 2500k -bufsize:v:1 3750k `
  -map a -c:a:0 aac -b:a:0 96k `
  -map a -c:a:1 aac -b:a:1 128k `
  -f hls `
  -hls_time 6 `
  -hls_playlist_type vod `
  -hls_flags independent_segments `
  -master_pl_name "playlist.m3u8" `
  -var_stream_map "v:0,a:0 v:1,a:1" `
  "$OutputDir/stream_%v.m3u8"

Write-Host "Conversion complete!"
Write-Host "Files created in '$OutputDir':"
Get-ChildItem -Path $OutputDir

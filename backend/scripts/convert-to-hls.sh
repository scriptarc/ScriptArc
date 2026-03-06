#!/bin/bash

# convert-to-hls.sh
# Converts an MP4 video file into an HLS playlist with multiple quality tiers.
# Usage: ./convert-to-hls.sh <input.mp4> <output_directory>

INPUT_FILE=$1
OUTPUT_DIR=$2

if [ -z "$INPUT_FILE" ] || [ -z "$OUTPUT_DIR" ]; then
    echo "Usage: $0 <input.mp4> <output_directory>"
    exit 1
fi

if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file '$INPUT_FILE' not found."
    exit 1
fi

# Ensure output directory exists
mkdir -p "$OUTPUT_DIR"

echo "Converting '$INPUT_FILE' to HLS in directory '$OUTPUT_DIR'..."

# FFmpeg command to create 360p and 720p HLS streams with a master playlist
ffmpeg -i "$INPUT_FILE" \
  -filter_complex \
  "[0:v]split=2[v1][v2]; \
   [v1]scale=w=640:h=360[v1out]; \
   [v2]scale=w=1280:h=720[v2out]" \
  -map "[v1out]" -c:v:0 libx264 -x264-params "nal-hrd=cbr:force-cfr=1" -b:v:0 800k -maxrate:v:0 856k -minrate:v:0 800k -bufsize:v:0 1200k \
  -map "[v2out]" -c:v:1 libx264 -x264-params "nal-hrd=cbr:force-cfr=1" -b:v:1 2500k -maxrate:v:1 2675k -minrate:v:1 2500k -bufsize:v:1 3750k \
  -map a -c:a:0 aac -b:a:0 96k \
  -map a -c:a:1 aac -b:a:1 128k \
  -f hls \
  -hls_time 6 \
  -hls_playlist_type vod \
  -hls_flags independent_segments \
  -master_pl_name "playlist.m3u8" \
  -var_stream_map "v:0,a:0 v:1,a:1" \
  "$OUTPUT_DIR/stream_%v.m3u8"

echo "Conversion complete!"
echo "Files created in '$OUTPUT_DIR':"
ls -la "$OUTPUT_DIR"

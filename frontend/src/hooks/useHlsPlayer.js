import { useEffect, useRef, useCallback } from 'react';
import Hls from 'hls.js';

/**
 * useHlsPlayer — Attaches HLS.js to an external <video> ref for adaptive streaming.
 *
 * Accepts { hlsUrl, mp4Url } so it can try HLS first and fall back to MP4 internally,
 * eliminating the need for a separate HEAD probe request.
 *
 * Also accepts a plain string URL for backwards compatibility.
 *
 * Supports three tiers:
 *   1. .m3u8 URL + browser lacks native HLS → use hls.js (Chrome/Firefox/Edge)
 *   2. .m3u8 URL + native HLS supported → set src directly (Safari/iOS)
 *   3. .mp4 URL → plain HTML5 video fallback
 */
export default function useHlsPlayer(videoRef, src) {
  const hlsRef = useRef(null);

  const destroyHls = useCallback(() => {
    if (hlsRef.current) {
      hlsRef.current.destroy();
      hlsRef.current = null;
    }
  }, []);

  useEffect(() => {
    const video = videoRef.current;
    if (!video || !src) return;

    destroyHls();

    // Normalize: accept { hlsUrl, mp4Url } object or plain string
    const hlsUrl = typeof src === 'object' ? src.hlsUrl : (src.endsWith('.m3u8') ? src : null);
    const mp4Url = typeof src === 'object' ? src.mp4Url : src;

    // Cancelled flag prevents stale callbacks from firing after cleanup
    let cancelled = false;
    let segmentRetryCount = 0;
    let retryTimer = null;

    const loadMp4 = () => {
      if (!cancelled) video.src = mp4Url;
    };

    if (hlsUrl && Hls.isSupported()) {
      // Tier 1: Use hls.js for adaptive bitrate streaming
      const hls = new Hls({
        startLevel: -1,                    // Auto-select quality for fast first load
        capLevelToPlayerSize: true,        // Don't load 4k if player is small
        maxBufferLength: 30,               // 30s forward buffer (lean for fast start)
        maxMaxBufferLength: 120,           // Allow up to 120s when idle
        maxBufferSize: 60 * 1000 * 1000,   // ~60 MB max buffer
        backBufferLength: 30,              // Free memory for segments >30s behind playhead
        abrEwmaDefaultEstimate: 1_000_000, // 1 Mbps initial estimate (faster quality ramp)
        abrBandWidthFactor: 0.9,           // Use 90% of measured bandwidth (less conservative)
        abrBandWidthUpFactor: 0.7,         // Upgrade quality faster
        enableWorker: true,                // Offload demuxing to web worker
        startFragPrefetch: true,           // Prefetch next fragment during current download
        progressive: true,                 // Start playback before full segment downloaded
        testBandwidth: true,               // Measure bandwidth on start
      });

      hls.loadSource(hlsUrl);
      hls.attachMedia(video);

      hls.on(Hls.Events.ERROR, (_event, data) => {
        if (cancelled) return;
        if (data.fatal) {
          switch (data.type) {
            case Hls.ErrorTypes.NETWORK_ERROR:
              // Manifest errors → fall back to MP4 immediately
              if (data.details === Hls.ErrorDetails.MANIFEST_LOAD_ERROR ||
                  data.details === Hls.ErrorDetails.MANIFEST_LOAD_TIMEOUT ||
                  data.details === Hls.ErrorDetails.MANIFEST_PARSING_ERROR) {
                hls.destroy();
                hlsRef.current = null;
                loadMp4();
              } else {
                // Segment-level network error — retry with exponential backoff (max 10s)
                const delay = Math.min(500 * Math.pow(2, segmentRetryCount), 10_000);
                segmentRetryCount++;
                retryTimer = setTimeout(() => {
                  if (!cancelled) hls.startLoad();
                }, delay);
              }
              break;
            case Hls.ErrorTypes.MEDIA_ERROR:
              hls.recoverMediaError();
              break;
            default:
              hls.destroy();
              hlsRef.current = null;
              loadMp4();
              break;
          }
        }
      });

      hlsRef.current = hls;
    } else if (hlsUrl && video.canPlayType('application/vnd.apple.mpegurl')) {
      // Tier 2: Native HLS (Safari / iOS) — try HLS, fall back on error
      video.src = hlsUrl;
      video.addEventListener('error', loadMp4, { once: true });
    } else {
      // Tier 3: Plain MP4
      loadMp4();
    }

    return () => {
      cancelled = true;
      clearTimeout(retryTimer);
      destroyHls();
    };
  }, [videoRef, src, destroyHls]);

  return hlsRef;
}

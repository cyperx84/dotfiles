// Hardware video decode on the MacBookPro15,3 (linked into each Zen profile
// as user.js by install-t2-mac.sh).
//
// The display runs on the AMD Vega 20, whose VA-API decodes H.264 and HEVC
// but not VP9 or AV1, and YouTube prefers AV1 then VP9. Either one decodes in
// software and pins the CPU, so turn both off: YouTube falls back to H.264
// (up to 1080p), which the GPU decodes.
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("media.hardware-video-decoding.force-enabled", true);
user_pref("media.av1.enabled", false);
user_pref("media.mediasource.vp9.enabled", false);

#!/usr/bin/env bash
# Seed OBS Studio profile + scene collection from dotfiles.
#
# Not stow-managed: OBS saves config with write-temp + rename, which replaces a
# stow symlink with a plain file on first save. So we COPY in both directions.
#
# Tracked (mac/obs/config/basic/):
#   profiles/WoW-Forever/basic.ini          video/output/audio settings
#   profiles/WoW-Forever/streamEncoder.json Apple VT HEVC (YouTube): CBR 12000, 2s keyint
#   scenes/WoW-Forever.json                 WoW app capture + app audio + mic
#
# Never tracked: profiles/*/service.json (stream key / service), and any
# [Twitch]/[YouTube]/[Restream]/[Auth*] sections in basic.ini (OAuth state).
# This repo is PUBLIC. Connect your account in OBS after installing.
#
# Usage:
#   mac/obs/install.sh            # repo -> OBS (backs up existing first)
#   mac/obs/install.sh --pull     # OBS -> repo (strips secrets), then git diff
#   DRY_RUN=1 mac/obs/install.sh  # show actions without touching anything
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")/config/basic" && pwd)"
OBS_ROOT="$HOME/Library/Application Support/obs-studio"
DST="$OBS_ROOT/basic"
NAME="WoW-Forever"
DRY_RUN="${DRY_RUN:-0}"
MODE="${1:-install}"

run() { if [[ "$DRY_RUN" == 1 ]]; then echo "  [dry-run] $*"; else "$@"; fi; }

# OBS rewrites its config on exit; installing under a running OBS gets clobbered.
if [[ "$DRY_RUN" != 1 ]] && pgrep -x OBS >/dev/null 2>&1; then
  echo "⚠ OBS is running. Quit it first, then re-run."
  exit 1
fi

# Main display UUID. App capture is scoped to one display and the UUID is per
# machine, so the tracked scene carries __DISPLAY_UUID__ instead.
display_uuid() {
  /usr/bin/python3 -I -c '
import ctypes, ctypes.util
cg = ctypes.CDLL("/System/Library/Frameworks/ApplicationServices.framework/ApplicationServices")
cf = ctypes.CDLL(ctypes.util.find_library("CoreFoundation"))
cg.CGMainDisplayID.restype = ctypes.c_uint32
cg.CGDisplayCreateUUIDFromDisplayID.restype = ctypes.c_void_p
cg.CGDisplayCreateUUIDFromDisplayID.argtypes = [ctypes.c_uint32]
cf.CFUUIDCreateString.restype = ctypes.c_void_p
cf.CFUUIDCreateString.argtypes = [ctypes.c_void_p, ctypes.c_void_p]
cf.CFStringGetCString.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_long, ctypes.c_uint32]
s = cf.CFUUIDCreateString(None, cg.CGDisplayCreateUUIDFromDisplayID(cg.CGMainDisplayID()))
buf = ctypes.create_string_buffer(64); cf.CFStringGetCString(s, buf, 64, 0x08000100)
print(buf.value.decode())
'
}
DISPLAY_UUID="$(display_uuid)"
[[ -n "$DISPLAY_UUID" ]] || { echo "✗ Could not read main display UUID"; exit 1; }

# Drop OAuth sections from an OBS ini on stdin.
strip_auth() {
  awk '
    /^\[/ { skip = ($0 ~ /^\[(Twitch|YouTube|Restream|Auth)/) }
    !skip { print }
  '
}

if [[ "$MODE" == "--pull" ]]; then
  echo "→ Pulling live OBS config into repo"
  run cp "$DST/profiles/$NAME/streamEncoder.json" "$SRC/profiles/$NAME/streamEncoder.json"
  if [[ "$DRY_RUN" == 1 ]]; then
    echo "  [dry-run] template display UUID: $NAME.json"
  else
    sed "s|$DISPLAY_UUID|__DISPLAY_UUID__|g" "$DST/scenes/$NAME.json" > "$SRC/scenes/$NAME.json"
  fi
  if [[ "$DRY_RUN" == 1 ]]; then
    echo "  [dry-run] strip auth + template \$HOME: basic.ini"
  else
    strip_auth < "$DST/profiles/$NAME/basic.ini" \
      | sed "s|$HOME|__HOME__|g" > "$SRC/profiles/$NAME/basic.ini"
  fi
  echo "✓ Pulled. Review: git -C \"$(git -C "$SRC" rev-parse --show-toplevel)\" diff -- mac/obs"
  exit 0
fi

[[ -d "$OBS_ROOT" ]] || { echo "✗ No $OBS_ROOT — launch OBS once, quit it, re-run."; exit 1; }

# Back up anything we'd overwrite.
BACKUP="$OBS_ROOT/.dotfiles-obs-backup-$(date +%Y%m%d-%H%M%S)"
for t in "$DST/profiles/$NAME" "$DST/scenes/$NAME.json" "$OBS_ROOT/user.ini"; do
  [[ -e "$t" ]] || continue
  run mkdir -p "$BACKUP"
  run cp -R "$t" "$BACKUP/"
done

echo "→ Installing profile $NAME"
run mkdir -p "$DST/profiles/$NAME" "$DST/scenes"
run cp "$SRC/profiles/$NAME/streamEncoder.json" "$DST/profiles/$NAME/streamEncoder.json"
if [[ "$DRY_RUN" == 1 ]]; then
  echo "  [dry-run] render basic.ini with \$HOME=$HOME"
else
  # Keep the live service.json (stream key / OAuth) and auth sections untouched:
  # carry existing auth sections over into the freshly rendered basic.ini.
  live="$DST/profiles/$NAME/basic.ini"
  auth=""
  [[ -f "$live" ]] && auth="$(awk '/^\[/{keep=($0 ~ /^\[(Twitch|YouTube|Restream|Auth)/)} keep' "$live")"
  { sed "s|__HOME__|$HOME|g" "$SRC/profiles/$NAME/basic.ini"
    if [[ -n "$auth" ]]; then printf '\n%s\n' "$auth"; fi
  } > "$live"
fi

# Seed the service so OBS starts on YouTube, never its Twitch default: Twitch is
# H.264-only, and OBS silently swaps an incompatible encoder (our HEVC) for
# x264 the first time Settings opens. Only when missing: the live file holds
# the stream key and is never overwritten.
SERVICE="$DST/profiles/$NAME/service.json"
if [[ ! -f "$SERVICE" ]]; then
  echo "→ Seeding service.json (YouTube - RTMPS, no key)"
  if [[ "$DRY_RUN" != 1 ]]; then
    cat > "$SERVICE" <<'JSON'
{
    "type": "rtmp_common",
    "settings": {
        "service": "YouTube - RTMPS",
        "protocol": "RTMPS",
        "server": "rtmps://a.rtmps.youtube.com:443/live2"
    }
}
JSON
  fi
fi

echo "→ Installing scene collection $NAME (display $DISPLAY_UUID)"
if [[ "$DRY_RUN" == 1 ]]; then
  echo "  [dry-run] render $NAME.json with display UUID"
else
  sed "s|__DISPLAY_UUID__|$DISPLAY_UUID|g" "$SRC/scenes/$NAME.json" > "$DST/scenes/$NAME.json"
fi

# Make OBS open on this profile + collection.
if [[ -f "$OBS_ROOT/user.ini" ]]; then
  echo "→ Selecting $NAME in user.ini"
  run sed -i '' \
    -e "s|^Profile=.*|Profile=$NAME|" \
    -e "s|^ProfileDir=.*|ProfileDir=$NAME|" \
    -e "s|^SceneCollection=.*|SceneCollection=$NAME|" \
    -e "s|^SceneCollectionFile=.*|SceneCollectionFile=$NAME.json|" \
    "$OBS_ROOT/user.ini"
fi

echo
if [[ "$DRY_RUN" == 1 ]]; then
  echo "Dry run complete — nothing changed."
else
  echo "✓ OBS config installed ($NAME)"
  [[ -d "$BACKUP" ]] && echo "  Previous files backed up to: ${BACKUP/#$HOME/~}"
  echo "  Open OBS → Settings → Stream → Use Stream Key (YouTube Studio → Go live → Stream)."
fi

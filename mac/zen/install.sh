#!/usr/bin/env bash
# Seed Zen Browser config from dotfiles into the active profile.
#
# Zen (a Firefox fork) names its profile dir randomly per machine, so plain
# `stow` can't target it. This script resolves the active profile from
# profiles.ini and installs the tracked, declarative config:
#   - user.js         -> SYMLINKED (Zen only reads it; edits in git propagate)
#   - everything else -> COPIED    (Zen rewrites these in place; a symlink would
#                                   be clobbered by its atomic write+rename)
#
# What Zen carries itself (don't expect this script to): bookmarks, history,
# passwords, open tabs, and extensions all sync via your Mozilla account
# (Settings -> Sync). This script covers the declarative bits Sync doesn't.
#
# Usage:
#   mac/zen/install.sh                 # resolve active profile automatically
#   ZEN_PROFILE="joojycad.Default (release)" mac/zen/install.sh   # force one
#   DRY_RUN=1 mac/zen/install.sh       # show actions without touching anything
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")/config" && pwd)"
ZEN_ROOT="$HOME/Library/Application Support/zen"
INI="$ZEN_ROOT/profiles.ini"
DRY_RUN="${DRY_RUN:-0}"

run() { if [[ "$DRY_RUN" == 1 ]]; then echo "  [dry-run] $*"; else "$@"; fi; }

[[ -f "$INI" ]] || { echo "✗ No Zen profiles.ini at $INI — is Zen installed and run once?"; exit 1; }

# --- Resolve the active profile directory -----------------------------------
# Precedence: explicit ZEN_PROFILE > [Install*] Default (what Zen actually uses)
# > [Profile*] with Default=1 (legacy default).
resolve_profile() {
  if [[ -n "${ZEN_PROFILE:-}" ]]; then echo "Profiles/$ZEN_PROFILE"; return; fi
  # [Install*] Default= wins on modern Firefox/Zen
  local install_default
  install_default="$(awk -F= '/^\[Install/{ins=1} ins&&/^Default=/{print $2; exit}' "$INI")"
  if [[ -n "$install_default" ]]; then echo "$install_default"; return; fi
  # Fall back to the [Profile*] block flagged Default=1
  awk -F= '
    /^\[Profile/{p=1; path=""; def=0; next}
    p&&/^Path=/{path=$2}
    p&&/^Default=1/{def=1}
    p&&/^$/{if(def){print path; exit} p=0}
    END{if(def&&path)print path}
  ' "$INI"
}

REL="$(resolve_profile)"
[[ -n "$REL" ]] || { echo "✗ Could not resolve active profile from $INI"; exit 1; }
PROFILE="$ZEN_ROOT/$REL"
[[ -d "$PROFILE" ]] || { echo "✗ Resolved profile dir does not exist: $PROFILE"; exit 1; }

echo "→ Target profile: $REL"

# --- Guard: Zen should be closed so it doesn't overwrite what we install -----
if [[ "$DRY_RUN" != 1 ]] && pgrep -x "zen" >/dev/null 2>&1; then
  echo "⚠ Zen is running. Quit it first (it rewrites these files on exit)."
  echo "  Re-run once Zen is closed."
  exit 1
fi

BACKUP="$PROFILE/.dotfiles-zen-backup-$(date +%Y%m%d-%H%M%S)"
backup() {  # backup $target if it exists and isn't already our symlink
  local t="$1"
  [[ -e "$t" || -L "$t" ]] || return 0
  run mkdir -p "$BACKUP"
  run cp -R "$t" "$BACKUP/"
}

# --- 1. user.js: symlink -----------------------------------------------------
echo "→ Linking user.js"
backup "$PROFILE/user.js"
run rm -rf "$PROFILE/user.js"
run ln -s "$SRC/user.js" "$PROFILE/user.js"

# --- 2. Copied config --------------------------------------------------------
COPY_ITEMS=(
  chrome
  zen-keyboard-shortcuts.json
  zen-themes.json
  containers.json
  handlers.json
  search.json.mozlz4
)
for item in "${COPY_ITEMS[@]}"; do
  [[ -e "$SRC/$item" ]] || continue
  echo "→ Copying $item"
  backup "$PROFILE/$item"
  run rm -rf "$PROFILE/$item"
  run cp -R "$SRC/$item" "$PROFILE/$item"
done

echo
if [[ "$DRY_RUN" == 1 ]]; then
  echo "Dry run complete — nothing changed."
else
  echo "✓ Zen config installed into $REL"
  [[ -d "$BACKUP" ]] && echo "  Previous files backed up to: ${BACKUP/#$HOME/~}"
  echo "  Launch Zen, then sign in to Sync for bookmarks/passwords/tabs/extensions."
fi

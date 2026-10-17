#!/usr/bin/env bash
# Keep WoW account-wide keybinds + UI settings in dotfiles.
#
# Tracked (mac/wow/account/), all account-wide, no character data:
#   bindings-cache.wtf           keybinds
#   config-cache.wtf             account UI CVars (nameplates etc.)
#   edit-mode-cache-account.txt  Edit Mode frame layout
#   macros-cache.txt             account macros (once you have any)
#
# Not tracked: Config.wtf (graphics — per machine), addons + SavedVariables,
# per-character folders (names/realms). The Account/<id>#1 dir name is your
# Battle.net account id; it is resolved at run time, never stored.
#
# Copy, not stow: WoW rewrites these on logout. Blizzard also syncs them
# server-side per game flavour, and the server copy can win on login — if a
# fresh client ignores what you installed, set the binds once in-game.
#
# Usage:
#   mac/wow/sync.sh                  # repo -> game (backs up existing first)
#   mac/wow/sync.sh --pull           # game -> repo, then git diff
#   WOW_FLAVOR=_classic_ mac/wow/sync.sh   # target another install (default _classic_beta_)
#   DRY_RUN=1 mac/wow/sync.sh
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")/account" && pwd)"
WOW_ROOT="/Applications/World of Warcraft"
FLAVOR="${WOW_FLAVOR:-_classic_beta_}"
DRY_RUN="${DRY_RUN:-0}"
MODE="${1:-install}"
FILES=(bindings-cache.wtf config-cache.wtf edit-mode-cache-account.txt macros-cache.txt)

run() { if [[ "$DRY_RUN" == 1 ]]; then echo "  [dry-run] $*"; else "$@"; fi; }

# WoW writes these on logout/exit; syncing under a running client gets clobbered.
if [[ "$DRY_RUN" != 1 ]] && pgrep -f "/Contents/MacOS/World of Warcraft$" >/dev/null 2>&1; then
  echo "⚠ WoW is running. Exit the game first, then re-run."
  exit 1
fi

ACCOUNT_ROOT="$WOW_ROOT/$FLAVOR/WTF/Account"
[[ -d "$ACCOUNT_ROOT" ]] || { echo "✗ No $ACCOUNT_ROOT — log in once on $FLAVOR, exit, re-run."; exit 1; }

# Exactly one Battle.net account dir (e.g. 123456789#1) expected.
ACCOUNTS=()
for d in "$ACCOUNT_ROOT"/*\#*; do [[ -d "$d" ]] && ACCOUNTS+=("$d"); done
if (( ${#ACCOUNTS[@]} != 1 )); then
  echo "✗ Expected one account dir under $ACCOUNT_ROOT, found ${#ACCOUNTS[@]}."
  exit 1
fi
DST="${ACCOUNTS[0]}"

if [[ "$MODE" == "--pull" ]]; then
  echo "→ Pulling account settings from $FLAVOR"
  for f in "${FILES[@]}"; do
    [[ -s "$DST/$f" ]] || continue   # skip missing/empty (e.g. no macros yet)
    run cp "$DST/$f" "$SRC/$f"
    echo "  $f"
  done
  echo "✓ Pulled. Review: git -C \"$(git -C "$SRC" rev-parse --show-toplevel)\" diff -- mac/wow"
  exit 0
fi

BACKUP="$DST/.dotfiles-wow-backup-$(date +%Y%m%d-%H%M%S)"
echo "→ Installing account settings into $FLAVOR"
for f in "${FILES[@]}"; do
  [[ -f "$SRC/$f" ]] || continue
  if [[ -e "$DST/$f" ]]; then
    run mkdir -p "$BACKUP"
    run cp "$DST/$f" "$BACKUP/"
  fi
  run cp "$SRC/$f" "$DST/$f"
  echo "  $f"
done

echo
if [[ "$DRY_RUN" == 1 ]]; then
  echo "Dry run complete — nothing changed."
else
  echo "✓ WoW keybinds + UI installed ($FLAVOR)"
  [[ -d "$BACKUP" ]] && echo "  Previous files backed up to: $BACKUP"
fi

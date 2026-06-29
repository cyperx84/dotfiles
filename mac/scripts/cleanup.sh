#!/usr/bin/env bash
# Mac cleanup script — safe caches and build artifacts only.
# Run manually or via launchd (com.user.monthly-cleanup.plist).
# Logs to /tmp/cleanup.log

set -uo pipefail

LOG=/tmp/cleanup.log
exec > >(tee -a "$LOG") 2>&1

echo "=== cleanup started $(date) ==="

# Bail if somehow HOME is unset or empty — prevents rm -rf expanding to bare paths
if [[ -z "${HOME:-}" ]]; then
  echo "ERROR: HOME is not set, aborting"
  exit 1
fi

free_before=$(df / | awk 'NR==2 {print $4}')

# Only delete paths that are strictly inside HOME or /tmp — never follow symlinks
_rm() {
  local path="$1"
  # Require path to be under HOME or /tmp
  case "$path" in
    "$HOME"/*|/tmp/*) ;;
    *) echo "  SKIP (outside HOME): $path"; return ;;
  esac
  # Refuse to delete if path is a symlink (stow symlinks live here)
  if [[ -L "$path" ]]; then
    echo "  SKIP (symlink): $path"
    return
  fi
  if [[ -e "$path" ]]; then
    rm -rf "$path" && echo "  cleared: $path"
  fi
}

echo "--- package manager caches ---"
command -v brew &>/dev/null && brew cleanup --prune=30 -q && echo "  brew: done"
command -v npm  &>/dev/null && npm cache clean --force -q  && echo "  npm: done"
command -v uv   &>/dev/null && uv cache clean              && echo "  uv: done"
command -v go   &>/dev/null && go clean -cache             && echo "  go: done"
command -v pip  &>/dev/null && pip cache purge 2>/dev/null && echo "  pip: done"
_rm "$HOME/Library/Caches/node-gyp"
_rm "$HOME/Library/Caches/pip"

echo "--- app caches ---"
_rm "$HOME/Library/Application Support/Claude/Cache"
_rm "$HOME/Library/Application Support/Claude/Code Cache"
_rm "$HOME/Library/Application Support/Claude/GPUCache"
_rm "$HOME/Library/Caches/electron"
_rm "$HOME/Library/Caches/Homebrew"

echo "--- openclaw ---"
_rm "$HOME/.openclaw/tmp"

echo "--- docker (only if colima is running) ---"
if command -v colima &>/dev/null && colima status 2>/dev/null | grep -q "Running"; then
  # Only dangling images (unreferenced layers) — not all unused images
  docker image prune -f    && echo "  docker: dangling images removed"
  # Only stopped containers that exited more than 1 day ago
  docker container prune -f --filter "until=24h" && echo "  docker: old stopped containers removed"
else
  echo "  colima not running, skipping docker"
fi

echo "--- zsh compdump ---"
# Remove stale host-named compdumps, keep the plain .zcompdump
find "$HOME" -maxdepth 1 -name ".zcompdump.*" -delete 2>/dev/null && echo "  stale compdumps removed"

free_after=$(df / | awk 'NR==2 {print $4}')
freed=$(( (free_after - free_before) * 512 / 1024 / 1024 ))
[[ $freed -lt 0 ]] && freed=0
echo "--- done: freed ~${freed} MB ($(date)) ---"

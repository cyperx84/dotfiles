#!/usr/bin/env bash
# Mac cleanup script — safe caches and build artifacts only.
# Run manually or via launchd (com.user.monthly-cleanup.plist).
# Logs to /tmp/cleanup.log

set -uo pipefail

LOG=/tmp/cleanup.log
exec > >(tee -a "$LOG") 2>&1

echo "=== cleanup started $(date) ==="

free_before=$(df / | awk 'NR==2 {print $4}')

_rm() {
  local path="$1"
  if [[ -e "$path" ]]; then
    rm -rf "$path" && echo "  cleared: $path"
  fi
}

echo "--- package manager caches ---"
command -v brew  &>/dev/null && brew cleanup --prune=30 -q && echo "  brew: done"
command -v npm   &>/dev/null && npm cache clean --force -q  && echo "  npm: done"
command -v uv    &>/dev/null && uv cache clean              && echo "  uv: done"
command -v go    &>/dev/null && go clean -cache             && echo "  go: done"
pip cache purge 2>/dev/null                                 && echo "  pip: done"
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
# logs older than 7 days
find "$HOME/.openclaw/logs" -type f -mtime +7 -delete 2>/dev/null && echo "  openclaw logs: pruned (>7d)"

echo "--- hermes ---"
find "$HOME/.hermes/logs" -type f -mtime +7 -delete 2>/dev/null  && echo "  hermes logs: pruned (>7d)"

echo "--- docker (only if colima is running) ---"
if colima status 2>/dev/null | grep -q "Running"; then
  docker image prune -f   && echo "  docker: dangling images removed"
  docker container prune -f && echo "  docker: stopped containers removed"
else
  echo "  colima not running, skipping"
fi

echo "--- zsh compdump ---"
# Keep only the current compdump, remove stale named ones
find "$HOME" -maxdepth 1 -name ".zcompdump.*" -delete 2>/dev/null && echo "  stale compdumps removed"

free_after=$(df / | awk 'NR==2 {print $4}')
freed=$(( (free_after - free_before) * 512 / 1024 / 1024 ))
echo "--- done: freed ~${freed} MB ($(date)) ---"

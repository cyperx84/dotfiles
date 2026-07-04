#!/usr/bin/env bash
################################################################################
# codex-status-start.sh - SessionStart hook for Codex CLI
################################################################################
# Creates a status file when a Codex session starts, mirroring the Claude Code
# status hooks so the SketchyBar agent cluster and agent_jump.sh can treat all
# agents uniformly. Wired via ~/.codex/config.toml [[hooks.SessionStart]].
#
# INPUT:  JSON on stdin (session_id, cwd, hook_event_name, ...)
# OUTPUT: ~/.cache/codex-sessions/codex-{session_id}.json
################################################################################
set -euo pipefail

# Codex may invoke hooks with a minimal PATH; ensure jq/date resolve.
export PATH="/opt/homebrew/bin:/usr/bin:/bin:$PATH"

STATUS_DIR="${HOME}/.cache/codex-sessions"
mkdir -p "$STATUS_DIR"

input=$(cat)
session_id=$(printf '%s' "$input" | jq -r '.session_id // empty')
cwd=$(printf '%s' "$input" | jq -r '.cwd // empty')
[ -z "$session_id" ] && exit 0

# tmux_pane: the reliable pane id ($TMUX_PANE, e.g. "%5"), inherited from the
# pane Codex runs in. Used by agents_lib.sh to resolve the jump target.
tmux_pane="${TMUX_PANE:-}"
now=$(date -u +%Y-%m-%dT%H:%M:%SZ)

cat > "$STATUS_DIR/codex-${session_id}.json" <<EOF
{
  "session_id": "${session_id}",
  "pid": ${PPID:-0},
  "tmux_pane": "${tmux_pane}",
  "state": "waiting",
  "cwd": "${cwd}",
  "last_activity": "${now}"
}
EOF
exit 0

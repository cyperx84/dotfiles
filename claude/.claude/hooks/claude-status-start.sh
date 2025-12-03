#!/usr/bin/env bash
################################################################################
# claude-status-start.sh - SessionStart Hook for Claude Code
################################################################################
#
# DESCRIPTION:
#   Creates a status file when a Claude Code session starts.
#   Tracks tmux session/pane information for sesh integration.
#
# HOOK EVENT: SessionStart
# INPUT: JSON via stdin with session_id, cwd, timestamp
# OUTPUT: Status file at ~/.cache/claude-sessions/claude-{session_id}.json
#
################################################################################

set -euo pipefail

# Configuration
STATUS_DIR="${HOME}/.cache/claude-sessions"
mkdir -p "$STATUS_DIR"

# Read JSON input from stdin
input=$(cat)

# Parse input fields
session_id=$(echo "$input" | jq -r '.session_id // empty')
cwd=$(echo "$input" | jq -r '.cwd // empty')
timestamp=$(echo "$input" | jq -r '.timestamp // empty')

# Exit if no session_id
if [ -z "$session_id" ]; then
    exit 0
fi

# Detect tmux session and pane (if running inside tmux)
tmux_session=""
tmux_pane=""
if [ -n "${TMUX:-}" ]; then
    # Extract tmux socket path and session info
    tmux_session=$(tmux display-message -p '#{session_name}' 2>/dev/null || echo "")
    tmux_pane=$(tmux display-message -p '#{window_index}.#{pane_index}' 2>/dev/null || echo "")
fi

# Get current PID (Claude's process)
claude_pid=$$

# Try to get the actual Claude process PID from parent
if [ -n "${PPID:-}" ]; then
    claude_pid=$PPID
fi

# Status file path
status_file="$STATUS_DIR/claude-${session_id}.json"

# Write initial status
cat > "$status_file" << EOF
{
  "session_id": "${session_id}",
  "pid": ${claude_pid},
  "tmux_session": "${tmux_session}",
  "tmux_pane": "${tmux_pane}",
  "state": "waiting",
  "cwd": "${cwd}",
  "started_at": "${timestamp:-$(date -u +%Y-%m-%dT%H:%M:%SZ)}",
  "last_activity": "${timestamp:-$(date -u +%Y-%m-%dT%H:%M:%SZ)}",
  "prompt_count": 0,
  "response_count": 0
}
EOF

exit 0

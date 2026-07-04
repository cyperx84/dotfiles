#!/usr/bin/env bash
################################################################################
# codex-status-input.sh - UserPromptSubmit hook for Codex CLI
################################################################################
# Marks the session "thinking" when you submit a prompt.
# Wired via ~/.codex/config.toml [[hooks.UserPromptSubmit]].
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

status_file="$STATUS_DIR/codex-${session_id}.json"
now=$(date -u +%Y-%m-%dT%H:%M:%SZ)
tmux_pane="${TMUX_PANE:-}"

if [ -f "$status_file" ]; then
  jq --arg state "thinking" --arg now "$now" --arg pane "$tmux_pane" \
     '.state=$state | .last_activity=$now | (.tmux_pane = (if $pane=="" then .tmux_pane else $pane end))' \
     "$status_file" > "$status_file.tmp" && mv "$status_file.tmp" "$status_file"
else
  cat > "$status_file" <<EOF
{
  "session_id": "${session_id}",
  "pid": ${PPID:-0},
  "tmux_pane": "${tmux_pane}",
  "state": "thinking",
  "cwd": "${cwd}",
  "last_activity": "${now}"
}
EOF
fi
exit 0

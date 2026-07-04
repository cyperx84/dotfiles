#!/usr/bin/env bash
################################################################################
# codex-status-stop.sh - Stop hook for Codex CLI
################################################################################
# Marks the session "waiting" (needs your input) when Codex finishes a turn.
# Wired via ~/.codex/config.toml [[hooks.Stop]].
################################################################################
set -euo pipefail

# Codex may invoke hooks with a minimal PATH; ensure jq/date resolve.
export PATH="/opt/homebrew/bin:/usr/bin:/bin:$PATH"

STATUS_DIR="${HOME}/.cache/codex-sessions"
mkdir -p "$STATUS_DIR"

input=$(cat)
session_id=$(printf '%s' "$input" | jq -r '.session_id // empty')
[ -z "$session_id" ] && exit 0

status_file="$STATUS_DIR/codex-${session_id}.json"
now=$(date -u +%Y-%m-%dT%H:%M:%SZ)
tmux_pane="${TMUX_PANE:-}"

if [ -f "$status_file" ]; then
  jq --arg state "waiting" --arg now "$now" --arg pane "$tmux_pane" \
     '.state=$state | .last_activity=$now | (.tmux_pane = (if $pane=="" then .tmux_pane else $pane end))' \
     "$status_file" > "$status_file.tmp" && mv "$status_file.tmp" "$status_file"
fi
exit 0

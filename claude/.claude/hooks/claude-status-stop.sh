#!/usr/bin/env bash
################################################################################
# claude-status-stop.sh - Stop Hook for Claude Code
################################################################################
#
# DESCRIPTION:
#   Updates status file when Claude finishes responding.
#   Changes state to "waiting" to indicate Claude is ready for input.
#
# HOOK EVENT: Stop
# INPUT: JSON via stdin with session_id
# OUTPUT: Updates status file state to "waiting"
#
################################################################################

set -euo pipefail

# Configuration
STATUS_DIR="${HOME}/.cache/claude-sessions"

# Read JSON input from stdin
input=$(cat)

# Parse session_id
session_id=$(echo "$input" | jq -r '.session_id // empty')

# Exit if no session_id
if [ -z "$session_id" ]; then
    exit 0
fi

# Status file path
status_file="$STATUS_DIR/claude-${session_id}.json"

# Update status if file exists
if [ -f "$status_file" ]; then
    now=$(date -u +%Y-%m-%dT%H:%M:%SZ)

    # Atomic update with jq
    jq --arg state "waiting" \
       --arg now "$now" \
       '.state = $state | .last_activity = $now | .response_count += 1' \
       "$status_file" > "$status_file.tmp" && mv "$status_file.tmp" "$status_file"
fi

exit 0

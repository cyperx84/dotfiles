#!/usr/bin/env bash
################################################################################
# claude-status-input.sh - UserPromptSubmit Hook for Claude Code
################################################################################
#
# DESCRIPTION:
#   Updates status file when user submits a prompt.
#   Changes state to "thinking" to indicate Claude is processing.
#
# HOOK EVENT: UserPromptSubmit
# INPUT: JSON via stdin with session_id, prompt
# OUTPUT: Updates status file state to "thinking"
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
    jq --arg state "thinking" \
       --arg now "$now" \
       '.state = $state | .last_activity = $now | .prompt_count += 1' \
       "$status_file" > "$status_file.tmp" && mv "$status_file.tmp" "$status_file"
fi

exit 0

#!/usr/bin/env bash
################################################################################
# claude-status-end.sh - SessionEnd Hook for Claude Code
################################################################################
#
# DESCRIPTION:
#   Cleans up status file when Claude Code session ends.
#   Removes the tracking file to keep cache clean.
#
# HOOK EVENT: SessionEnd
# INPUT: JSON via stdin with session_id
# OUTPUT: Removes status file
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

# Remove status file if it exists
if [ -f "$status_file" ]; then
    rm -f "$status_file"
fi

exit 0

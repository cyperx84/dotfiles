#!/usr/bin/env bash

# Sesh create new session - prompts for name and creates/connects
# Called from fzf keybind (Ctrl-n)

# Source common utilities
SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
SESH_SCRIPTS_LIB="${SCRIPT_DIR}/../lib"
source "${SESH_SCRIPTS_LIB}/sesh_common.sh"

# Get session name from user
read -p "New session name: " session_name

# Clean session name (remove whitespace, ANSI codes, etc.)
session_name=$(clean_session_name "$session_name")

# Check if name is empty
if [ -z "$session_name" ]; then
    echo "Error: Session name cannot be empty"
    read -p "Press Enter to continue..."
    exit 1
fi

# Check if session already exists (using detect_session_type from common)
if tmux has-session -t "$session_name" 2>/dev/null; then
    echo "Session '$session_name' already exists. Connecting..."
    sesh connect "$session_name"
else
    # Create and connect to new session
    echo "Creating session '$session_name'..."
    CURRENT_DIR=$(pwd)
    tmux new-session -d -s "$session_name" "cd '$CURRENT_DIR' && bash ~/.config/sesh/scripts/sesh_smart_start.sh '$CURRENT_DIR' '$session_name'"
    sleep 1
    sesh connect "$session_name"
fi

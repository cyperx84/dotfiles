#!/usr/bin/env bash

# Sesh create new session - prompts for name and creates/connects
# Called from fzf keybind (Ctrl-n)

# Get session name from user
read -p "New session name: " session_name

# Trim whitespace
session_name=$(echo "$session_name" | xargs)

# Check if name is empty
if [ -z "$session_name" ]; then
    echo "Error: Session name cannot be empty"
    read -p "Press Enter to continue..."
    exit 1
fi

# Check if session already exists
if tmux has-session -t "$session_name" 2>/dev/null; then
    echo "Session '$session_name' already exists. Connecting..."
    sleep 1
    sesh connect "$session_name"
else
    # Create and connect to new session in home directory
    echo "Creating session '$session_name'..."
    sleep 0.5
    # Create tmux session in home directory with a simple shell
    tmux new-session -d -s "$session_name" -c "$HOME"
    sleep 0.5
    sesh connect "$session_name"
fi

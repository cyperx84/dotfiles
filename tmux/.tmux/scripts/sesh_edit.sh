#!/usr/bin/env bash

# Sesh Edit - Smart editing based on session type
# Opens directories in nvim, or tmuxinator configs for editing

SESSION_INPUT="$1"

# Clean input
SESSION_CLEAN=$(echo "$SESSION_INPUT" | sed 's/\x1b\[[0-9;]*m//g' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
SESSION_CLEAN=$(echo "$SESSION_CLEAN" | sed 's/^[◆▣📁📂🔷🔶⬢●◉○] *//')
SESSION_CLEAN="${SESSION_CLEAN/#\~/$HOME}"

# Detect what to edit
if [ -f "$HOME/.config/tmuxinator/${SESSION_CLEAN}.yml" ]; then
    # Edit tmuxinator config
    tmux new-window "nvim $HOME/.config/tmuxinator/${SESSION_CLEAN}.yml"
elif [ -d "$SESSION_CLEAN" ]; then
    # Open directory in nvim
    tmux new-window -c "$SESSION_CLEAN" "nvim ."
else
    # Try to find the session's directory
    if tmux has-session -t "$SESSION_CLEAN" 2>/dev/null; then
        SESSION_PATH=$(tmux display-message -p -t "$SESSION_CLEAN" '#{pane_current_path}')
        if [ -n "$SESSION_PATH" ] && [ -d "$SESSION_PATH" ]; then
            tmux new-window -c "$SESSION_PATH" "nvim ."
        fi
    fi
fi

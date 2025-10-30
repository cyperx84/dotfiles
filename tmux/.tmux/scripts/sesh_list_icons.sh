#!/usr/bin/env bash

# Sesh list wrapper - adds type icons to distinguish session types
# Usage: sesh_list_icons.sh [sesh-list-args]

# Pass through any arguments to sesh list (e.g., -t, -c, -z)
sesh list "$@" | while IFS= read -r session; do
    # Strip any existing icons/prefixes
    clean_session=$(echo "$session" | sed 's/^[●◆📁🔷▣] *//')

    # Determine session type and add icon
    if tmux has-session -t "$clean_session" 2>/dev/null; then
        # Active tmux session
        echo "● $clean_session"
    elif [ -f "$HOME/.config/tmuxinator/${clean_session}.yml" ]; then
        # Tmuxinator project config
        echo "◆ $clean_session"
    elif [ -d "${clean_session/#\~/$HOME}" ] || [[ "$clean_session" =~ ^~/ ]] || [[ "$clean_session" =~ ^/ ]]; then
        # Directory path (zoxide result)
        echo "📁 $clean_session"
    else
        # Unknown type, show as-is
        echo "$clean_session"
    fi
done

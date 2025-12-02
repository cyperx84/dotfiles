#!/usr/bin/env bash
# Sesh Edit - Smart editing based on session type

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../lib/sesh_common.sh"

SESSION_INPUT="$1"
SESSION_CLEAN=$(clean_session_name "$SESSION_INPUT")
SESSION_TYPE=$(detect_session_type "$SESSION_CLEAN")

case "$SESSION_TYPE" in
    tmuxinator)
        tmux new-window "nvim ${TMUXINATOR_CONFIG_DIR}/${SESSION_CLEAN}.yml" ;;
    directory|sesh_custom)
        tmux new-window -c "$SESSION_CLEAN" "nvim ." ;;
    tmux)
        SESSION_PATH=$(tmux display-message -p -t "$SESSION_CLEAN" '#{pane_current_path}')
        [ -n "$SESSION_PATH" ] && [ -d "$SESSION_PATH" ] && tmux new-window -c "$SESSION_PATH" "nvim ." ;;
esac

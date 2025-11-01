#!/usr/bin/env bash

# Sesh session switcher - works inside and outside tmux
# Called from skhd system hotkey (cmd + shift + j)

# Check if we're inside tmux
if [ -n "$TMUX" ]; then
    # Inside tmux - run sesh connect directly with enhanced list
    sesh connect "$(
        ~/.tmux/scripts/sesh_list_enhanced.sh -id | fzf-tmux -p 90%,80% \
            --ansi \
            --no-sort --border-label ' sesh ' --prompt '⚡  ' \
            --header '  ^a all ^t tmux ^x zoxide ^g config ^/ new | ^k kill' \
            --preview '~/.tmux/scripts/sesh_preview.sh {}' \
            --preview-window 'right:70%' \
            --bind 'ctrl-d:preview-page-down,ctrl-u:preview-page-up' \
            --bind 'ctrl-a:change-prompt(⚡  )+reload(~/.tmux/scripts/sesh_list_enhanced.sh -id)' \
            --bind 'ctrl-t:change-prompt(🪟  )+reload(~/.tmux/scripts/sesh_list_enhanced.sh -idt)' \
            --bind 'ctrl-g:change-prompt(⚙️  )+reload(~/.tmux/scripts/sesh_list_enhanced.sh -idc)' \
            --bind 'ctrl-x:change-prompt(📁  )+reload(~/.tmux/scripts/sesh_list_enhanced.sh -idz)' \
            --bind 'ctrl-/:execute(~/.tmux/scripts/sesh_create_new.sh)+abort' \
            --bind 'ctrl-k:execute(~/.tmux/scripts/kill_sesh_session.sh {})+reload(~/.tmux/scripts/sesh_list_enhanced.sh -id)'
    )"
else
    # Outside tmux - launch in a popup terminal or attach to existing tmux
    # First check if any tmux sessions exist
    if tmux list-sessions &>/dev/null; then
        # Sessions exist - show selector in a floating Ghostty window
        ghostty \
            --title="Session Switcher" \
            --window-width=120 \
            --window-height=30 \
            -e bash -c "
                selected=\$(~/.tmux/scripts/sesh_list_enhanced.sh -id | fzf \
                    --ansi \
                    --no-sort --border-label ' sesh ' --prompt '⚡  ' \
                    --header '  ^a all ^t tmux ^x zoxide ^g config ^/ new | ^k kill' \
                    --preview '~/.tmux/scripts/sesh_preview.sh {}' \
                    --preview-window 'right:70%' \
                    --bind 'ctrl-d:preview-page-down,ctrl-u:preview-page-up' \
                    --bind 'ctrl-a:change-prompt(⚡  )+reload(~/.tmux/scripts/sesh_list_enhanced.sh -id)' \
                    --bind 'ctrl-t:change-prompt(🪟  )+reload(~/.tmux/scripts/sesh_list_enhanced.sh -idt)' \
                    --bind 'ctrl-g:change-prompt(⚙️  )+reload(~/.tmux/scripts/sesh_list_enhanced.sh -idc)' \
                    --bind 'ctrl-x:change-prompt(📁  )+reload(~/.tmux/scripts/sesh_list_enhanced.sh -idz)' \
                    --bind 'ctrl-/:execute(~/.tmux/scripts/sesh_create_new.sh)+abort' \
                    --bind 'ctrl-k:execute(~/.tmux/scripts/kill_sesh_session.sh {})+reload(~/.tmux/scripts/sesh_list_enhanced.sh -id)')
                if [ -n \"\$selected\" ]; then
                    sesh connect \"\$selected\"
                fi
            " &
    else
        # No sessions - create first session
        ghostty -e tmux new-session &
    fi
fi

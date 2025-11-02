#!/usr/bin/env bash

# Sesh session switcher - works inside and outside tmux
# Called from skhd system hotkey (cmd + shift + j)

# Check if we're inside tmux
if [ -n "$TMUX" ]; then
    # Inside tmux - run sesh connect directly with enhanced list
    selected=$(
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
    )

    # Clean the selected session name before connecting
    # Remove ANSI color codes
    selected=$(echo "$selected" | sed -E 's/\[38;2;[0-9;]+m//g' | sed -E 's/\[[0-9]+m//g' | sed 's/\[0m//g')
    # Remove leading/trailing whitespace
    selected=$(echo "$selected" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    # Remove status icon prefixes (◆, ●, ◉, 📁, ▣)
    selected=$(echo "$selected" | sed -e 's/^◆[[:space:]]*//' -e 's/^●[[:space:]]*//' -e 's/^◉[[:space:]]*//' -e 's/^📁[[:space:]]*//' -e 's/^▣[[:space:]]*//')
    # Remove ANY leading emoji characters (multi-byte UTF-8) followed by optional space
    selected=$(echo "$selected" | sed -E 's/^[^[:alnum:]~\/\._-]+[[:space:]]*//')
    # Extract first word (session name) - everything else is metadata (git branch, icons, etc.)
    selected=$(echo "$selected" | awk '{print $1}')

    [ -n "$selected" ] && sesh connect "$selected"
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
                    # Clean the selected session name before connecting
                    # Remove ANSI color codes
                    selected=\$(echo \"\$selected\" | sed -E 's/\[38;2;[0-9;]+m//g' | sed -E 's/\[[0-9]+m//g' | sed 's/\[0m//g')
                    # Remove leading/trailing whitespace
                    selected=\$(echo \"\$selected\" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
                    # Remove status icon prefixes (◆, ●, ◉, 📁, ▣)
                    selected=\$(echo \"\$selected\" | sed -e 's/^◆[[:space:]]*//' -e 's/^●[[:space:]]*//' -e 's/^◉[[:space:]]*//' -e 's/^📁[[:space:]]*//' -e 's/^▣[[:space:]]*//')
                    # Remove ANY leading emoji characters (multi-byte UTF-8) followed by optional space
                    selected=\$(echo \"\$selected\" | sed -E 's/^[^[:alnum:]~\/\._-]+[[:space:]]*//')
                    # Extract first word (session name) - everything else is metadata (git branch, icons, etc.)
                    selected=\$(echo \"\$selected\" | awk '{print \$1}')

                    sesh connect \"\$selected\"
                fi
            " &
    else
        # No sessions - create first session
        ghostty -e tmux new-session &
    fi
fi

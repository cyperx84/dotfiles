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
            --bind 'ctrl-k:execute-silent(~/.tmux/scripts/kill_sesh_session.sh {})+reload(~/.tmux/scripts/sesh_list_enhanced.sh -id)'
    )

    # Clean the selected session name before connecting
    # IMPORTANT: Session names can contain emojis (e.g., "⚙️dotfiles", "💻 code")
    # Remove ANSI color codes (handle both with and without ESC character)
    selected=$(echo "$selected" | sed 's/\x1b\[[0-9;]*m//g' | sed 's/\[[0-9;]*m//g')
    # Remove status icon prefixes - try each icon separately
    selected=$(echo "$selected" | sed 's/^◆//' | sed 's/^●//' | sed 's/^◉//' | sed 's/^📁//' | sed 's/^▣//')
    # Remove control characters (backspace, etc.)
    selected=$(echo "$selected" | tr -d '[:cntrl:]')
    # Remove leading/trailing whitespace
    selected=$(echo "$selected" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    # Extract everything BEFORE metadata pattern "(Xw Yp)" - preserves emojis in session names
    selected=$(echo "$selected" | sed -E 's/[[:space:]]+\([0-9].*//')
    # Remove trailing activity indicators (🔥 ⚡ 💤 📊 🗄️ ⏱) and time strings
    selected=$(echo "$selected" | sed -E 's/[[:space:]]+(🔥|⚡|💤|📊|🗄️|⏱)[[:space:]].*//' | sed -E 's/[[:space:]]+(🔥|⚡|💤|📊|🗄️|⏱)$//')
    selected=$(echo "$selected" | sed -E 's/[[:space:]]+[0-9]+(m|h|d|w|mo)[[:space:]]+ago$//')
    # Remove git branch info and status indicators
    selected=$(echo "$selected" | sed -E 's/[[:space:]]+\[.*\]$//' | sed -E 's/[[:space:]]+(↑|↓|✗|✓|●|±)[0-9].*$//')
    # Final trim
    selected=$(echo "$selected" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

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
                    --bind 'ctrl-k:execute-silent(~/.tmux/scripts/kill_sesh_session.sh {})+reload(~/.tmux/scripts/sesh_list_enhanced.sh -id)')
                if [ -n \"\$selected\" ]; then
                    # Clean the selected session name before connecting
                    # IMPORTANT: Session names can contain emojis (e.g., \"⚙️dotfiles\", \"💻 code\")
                    # Remove ANSI color codes (handle both with and without ESC character)
                    selected=\$(echo \"\$selected\" | sed 's/\\x1b\[[0-9;]*m//g' | sed 's/\[[0-9;]*m//g')
                    # Remove status icon prefixes - try each icon separately
                    selected=\$(echo \"\$selected\" | sed 's/^◆//' | sed 's/^●//' | sed 's/^◉//' | sed 's/^📁//' | sed 's/^▣//')
                    # Remove control characters (backspace, etc.)
                    selected=\$(echo \"\$selected\" | tr -d '[:cntrl:]')
                    # Remove leading/trailing whitespace
                    selected=\$(echo \"\$selected\" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
                    # Extract everything BEFORE metadata pattern \"(Xw Yp)\" - preserves emojis in session names
                    selected=\$(echo \"\$selected\" | sed -E 's/[[:space:]]+\([0-9].*//')
                    # Remove trailing activity indicators (🔥 ⚡ 💤 📊 🗄️ ⏱) and time strings
                    selected=\$(echo \"\$selected\" | sed -E 's/[[:space:]]+(🔥|⚡|💤|📊|🗄️|⏱)[[:space:]].*//' | sed -E 's/[[:space:]]+(🔥|⚡|💤|📊|🗄️|⏱)$//')
                    selected=\$(echo \"\$selected\" | sed -E 's/[[:space:]]+[0-9]+(m|h|d|w|mo)[[:space:]]+ago$//')
                    # Remove git branch info and status indicators
                    selected=\$(echo \"\$selected\" | sed -E 's/[[:space:]]+\[.*\]$//' | sed -E 's/[[:space:]]+(↑|↓|✗|✓|●|±)[0-9].*$//')
                    # Final trim
                    selected=\$(echo \"\$selected\" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

                    sesh connect \"\$selected\"
                fi
            " &
    else
        # No sessions - create first session
        ghostty -e tmux new-session &
    fi
fi

#!/usr/bin/env bash

# Enhanced Sesh Aliases for Session Status Management
# Auto-sourced via stow in ~/.config/sesh/scripts/sesh_aliases.sh

# Quick session commands (integrated with existing .zshrc sesh function)
alias sl='sesh list -t -c'                                         # List sessions (compact)
alias slj='sesh list -t -c -J'                                     # List sessions as JSON
alias sc='sesh connect'                                            # Connect to session
alias sd='sesh connect $(sesh list -t -c | fzf --prompt "📱 ")'    # Fuzzy connect to session

# Session status and monitoring
alias sesh-active='tmux list-sessions 2>/dev/null || echo "No active sessions"'  # Show active sessions
alias sesh-windows='tmux list-windows 2>/dev/null'                 # Show windows in current session
alias sesh-panes='tmux list-panes -a 2>/dev/null'                  # Show all panes

# Session management with tmuxinator integration
alias sesh-tmux='tmuxinator list'                                  # List tmuxinator sessions
alias sesh-start='tmuxinator start'                                # Start tmuxinator session
alias sesh-kill='tmux kill-session -t'                             # Kill specific session
alias sesh-kill-all='tmux kill-server'                             # Kill all sessions

# File management integration
alias sesh-files='yazi'                                            # Open file manager in session
alias sesh-tree='eza --tree --level=2 --icons'                     # Show directory tree

# Enhanced session info and navigation
sesh-info() {
    local session="${1:-$(tmux display-message -p '#S' 2>/dev/null)}"
    if [[ -z "$session" ]]; then
        echo "❌ No session specified and not in tmux session"
        echo "Usage: sesh-info [session_name]"
        return 1
    fi

    echo "📋 Session: $session"
    if tmux has-session -t "$session" 2>/dev/null; then
        echo "🟢 Status: Active"
        tmux list-windows -t "$session" 2>/dev/null | head -5
    else
        echo "🔴 Status: Not running"
        # Show configured session info if available
        sesh list | grep -q "$session" && echo "📋 Available in sesh config"
    fi
}

# Show current session details
sesh-current() {
    if [[ -n "$TMUX" ]]; then
        local current_session=$(tmux display-message -p '#S')
        local current_window=$(tmux display-message -p '#W')
        local current_pane=$(tmux display-message -p '#P')
        echo "📍 Current: $current_session:$current_window.$current_pane"
        echo "📂 Path: $(pwd)"
        tmux list-windows -t "$current_session" | grep '\*' | cut -d' ' -f2-
    else
        echo "❌ Not in a tmux session"
        echo "💡 Use 'sd' for fuzzy session selection or 'sl' to list sessions"
    fi
}

# Comprehensive dashboard with dotfiles integration
sesh-dashboard() {
    echo "🚀 Sesh Dashboard - $(date '+%Y-%m-%d %H:%M')"
    echo "================================================"
    echo ""

    # Show current session if in tmux
    if [[ -n "$TMUX" ]]; then
        sesh-current
        echo ""
    fi

    # Show active sessions
    echo "🎯 Active Sessions:"
    if tmux list-sessions 2>/dev/null; then
        tmux list-sessions 2>/dev/null | while IFS= read -r line; do
            session_name=$(echo "$line" | cut -d: -f1)
            if echo "$line" | grep -q "attached"; then
                echo "  🔗 $session_name (attached)"
            else
                echo "  💤 $session_name (detached)"
            fi
        done
    else
        echo "  💤 No active sessions"
    fi
    echo ""

    # Show available sesh configurations
    echo "⚙️  Configured Sessions:"
    sesh list | head -8 | while read -r session; do
        echo "  📋 $session"
    done
    echo ""

    # Show tmuxinator sessions if available
    if command -v tmuxinator >/dev/null 2>&1; then
        echo "🎭 Tmuxinator Layouts:"
        tmuxinator list 2>/dev/null | grep -v "tmuxinator projects:" | head -5 | while read -r layout; do
            [[ -n "$layout" ]] && echo "  🎪 $layout"
        done
        echo ""
    fi

    echo "💡 Quick actions: 'sd' (fuzzy connect) | 'sl' (list) | 'sesh-tmux' (layouts)"
}
#!/usr/bin/env bash

# Enhanced Sesh Aliases for Session Status Management
# Source this file in your ~/.zshrc with: source ~/dotfiles/sesh_aliases.sh

# Enhanced sesh commands with status indicators
alias ss='~/.config/sesh/scripts/sesh_with_status.sh list'          # Show sessions with status
alias ssp='~/.config/sesh/scripts/sesh_with_status.sh pick'         # Pick session with status
alias ssq='~/.config/sesh/scripts/sesh_with_status.sh quick'        # Quick status summary

# Session status utilities
alias sesh-status='~/.config/sesh/scripts/session_status.sh'        # Get session status
alias sesh-active='tmux list-sessions 2>/dev/null || echo "No active sessions"'  # Show active sessions

# Quick session management
alias sesh-kill='tmux kill-session -t'                             # Kill specific session
alias sesh-kill-all='tmux kill-server'                             # Kill all sessions

# Enhanced session connection with status check
sesh-connect() {
    local session="$1"
    if [[ -z "$session" ]]; then
        echo "Usage: sesh-connect <session_name>"
        return 1
    fi
    
    # Show status before connecting
    echo "Session status: $($HOME/.config/sesh/scripts/session_status.sh status "$session")"
    sesh connect "$session"
}

# Show status for current tmux session
sesh-current() {
    if [[ -n "$TMUX" ]]; then
        local current_session=$(tmux display-message -p '#S')
        echo "Current session: $current_session"
        $HOME/.config/sesh/scripts/session_status.sh status "$current_session"
    else
        echo "Not in a tmux session"
    fi
}

# Quick dashboard
sesh-dashboard() {
    echo "📊 Sesh Session Dashboard"
    echo "========================"
    echo ""
    $HOME/.config/sesh/scripts/sesh_with_status.sh quick
    echo ""
    echo "Active Sessions:"
    tmux list-sessions 2>/dev/null | while IFS= read -r line; do
        session_name=$(echo "$line" | cut -d: -f1)
        if echo "$line" | grep -q "attached"; then
            echo "  🔴 $session_name (attached)"
        else
            echo "  🟡 $session_name (detached)"
        fi
    done
    echo ""
    echo "Use 'ss' to see all sessions or 'ssp' to pick with status"
}
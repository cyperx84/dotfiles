#!/bin/bash

# Enhanced session helper functions for tmux
# Provides better session previews, management, and utilities

SESSION_HELPER_DIR="$(dirname "${BASH_SOURCE[0]}")"

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Enhanced session preview function
session_preview() {
    local session_name="$1"
    local session_type="$2"
    
    case "$session_type" in
        "tmux:")
            # Tmux session preview
            echo -e "${BLUE}📟 Tmux Session: ${session_name}${NC}"
            echo -e "${CYAN}Windows:${NC} $(tmux list-windows -t "$session_name" 2>/dev/null | wc -l)"
            echo -e "${CYAN}Path:${NC} $(tmux display-message -p -t "$session_name" '#{pane_current_path}' 2>/dev/null || echo "Unknown")"
            ;;
        "sesh:")
            # Sesh session preview
            local sesh_info="$(sesh info "$session_name" 2>/dev/null)"
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}🧩 Sesh Session: ${session_name}${NC}"
                echo "$sesh_info" | head -10
            else
                echo -e "${YELLOW}📁 Directory Session${NC}"
                echo -e "${CYAN}Name:${NC} ${session_name}"
            fi
            ;;
        "tmuxinator:")
            # Tmuxinator project preview
            local project_name="${session_name#tmuxinator:}"
            local config_file="$HOME/.config/tmuxinator/${project_name}.yml"
            
            if [ -f "$config_file" ]; then
                echo -e "${MAGENTA}🎛️ Tmuxinator Project: ${project_name}${NC}"
                echo -e "${CYAN}Config:${NC} $config_file"
                
                # Show basic project info
                grep -E "^(name|root|windows):" "$config_file" | head -5 | while read line; do
                    echo "  $line"
                done
            else
                echo -e "${RED}❌ Config not found${NC}"
            fi
            ;;
        *)
            # Generic directory preview
            if [ -d "$session_name" ]; then
                echo -e "${YELLOW}📁 Directory: ${session_name}${NC}"
                echo -e "${CYAN}Contents:${NC}"
                ls -la "$session_name" | head -6
            else
                echo -e "${RED}❌ Invalid session${NC}"
            fi
            ;;
    esac
}

# Session status checker
check_session_status() {
    local session_name="$1"
    
    if tmux has-session -t "$session_name" 2>/dev/null; then
        echo -e "${GREEN}✅ Active${NC}"
    else
        echo -e "${YELLOW}💤 Inactive${NC}"
    fi
}

# Kill session with confirmation
safe_kill_session() {
    local session_name="$1"
    
    if tmux has-session -t "$session_name" 2>/dev/null; then
        read -p "Kill session '$session_name'? (y/N): " confirm
        if [[ $confirm =~ ^[Yy]$ ]]; then
            tmux kill-session -t "$session_name"
            echo -e "${GREEN}Session '$session_name' killed${NC}"
        else
            echo -e "${YELLOW}Cancelled${NC}"
        fi
    else
        echo -e "${RED}Session '$session_name' not found${NC}"
    fi
}

# Session statistics
session_stats() {
    echo -e "${BLUE}📊 Session Statistics${NC}"
    echo -e "${CYAN}Total sessions:${NC} $(tmux list-sessions 2>/dev/null | wc -l)"
    echo -e "${CYAN}Total windows:${NC} $(tmux list-windows 2>/dev/null | wc -l)"
    echo -e "${CYAN}Total panes:${NC} $(tmux list-panes 2>/dev/null | wc -l)"
    
    # Show top 5 largest sessions
    echo -e "\\n${CYAN}Top sessions by window count:${NC}"
    tmux list-sessions -F '#{session_name} #{session_windows}' 2>/dev/null | \
        sort -k2 -nr | head -5 | while read session windows; do
        echo -e "  ${GREEN}$session${NC}: $windows windows"
    done
}

# Clean up dead sessions
cleanup_sessions() {
    local dead_sessions=0
    
    tmux list-sessions -F '#{session_name}' 2>/dev/null | while read session; do
        if ! tmux has-session -t "$session" 2>/dev/null; then
            echo -e "${YELLOW}Removing dead session: $session${NC}"
            tmux kill-session -t "$session" 2>/dev/null
            ((dead_sessions++))
        fi
    done
    
    echo -e "${GREEN}Cleaned up $dead_sessions dead sessions${NC}"
}

# Main function for external use
case "${1:-}" in
    "preview")
        session_preview "$2" "$3"
        ;;
    "status")
        check_session_status "$2"
        ;;
    "kill")
        safe_kill_session "$2"
        ;;
    "stats")
        session_stats
        ;;
    "cleanup")
        cleanup_sessions
        ;;
    *)
        echo "Usage: $0 {preview|status|kill} [session_name] [session_type]"
        echo "Enhanced session management utilities for tmux"
        ;;
esac
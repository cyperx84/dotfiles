#!/usr/bin/env bash

# Session Status Script for Sesh Integration
# Provides status information for different session types

set -euo pipefail

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Main function
case "${1:-}" in
    "status")
        session_name="${2:-}"
        if [[ -z "$session_name" ]]; then
            echo "❌ No session name provided"
            exit 1
        fi

        # Check if session is currently active in tmux
        if tmux has-session -t "$session_name" 2>/dev/null; then
            echo -e "${GREEN}✅ Active Session: $session_name${NC}"
            windows=$(tmux list-windows -t "$session_name" 2>/dev/null | wc -l)
            echo -e "${CYAN}📊 Windows: $windows${NC}"

            # Show current directory if session exists
            current_path=$(tmux display-message -p -t "$session_name" '#{pane_current_path}' 2>/dev/null || echo "Unknown")
            echo -e "${CYAN}📂 Path: $current_path${NC}"
        else
            echo -e "${YELLOW}💤 Inactive: $session_name${NC}"
            echo -e "${CYAN}📋 Available in sesh config${NC}"
        fi
        ;;

    "info")
        session_name="${2:-}"
        if [[ -z "$session_name" ]]; then
            echo "❌ No session name provided"
            exit 1
        fi

        echo -e "${BLUE}ℹ️  Session Information: $session_name${NC}"

        # Try to get sesh-specific info
        if command -v sesh >/dev/null 2>&1; then
            if sesh list | grep -q "$session_name"; then
                echo -e "${GREEN}📋 Configured in sesh${NC}"
            fi
        fi

        # Check tmux status
        if tmux has-session -t "$session_name" 2>/dev/null; then
            echo -e "${GREEN}🟢 Active in tmux${NC}"
            tmux list-windows -t "$session_name" 2>/dev/null | head -3
        else
            echo -e "${YELLOW}🟡 Not currently running${NC}"
        fi
        ;;

    "list")
        echo -e "${BLUE}📋 Session Status Overview${NC}"
        echo "=========================="

        # Show active tmux sessions
        echo -e "${CYAN}Active Sessions:${NC}"
        if tmux list-sessions 2>/dev/null; then
            tmux list-sessions 2>/dev/null | while IFS= read -r line; do
                session_name=$(echo "$line" | cut -d: -f1)
                if echo "$line" | grep -q "attached"; then
                    echo -e "  🔗 $session_name (attached)"
                else
                    echo -e "  💤 $session_name (detached)"
                fi
            done
        else
            echo "  💤 No active sessions"
        fi

        echo ""

        # Show sesh configured sessions
        echo -e "${CYAN}Configured Sessions:${NC}"
        if command -v sesh >/dev/null 2>&1; then
            sesh list | head -8 | while read -r session; do
                echo -e "  📋 $session"
            done
        else
            echo "  ❌ Sesh not available"
        fi
        ;;

    *)
        echo "Usage: $0 {status|info|list} [session_name]"
        echo "Session status and information utilities for sesh integration"
        echo ""
        echo "Commands:"
        echo "  status <name>  - Show current status of a session"
        echo "  info <name>    - Show detailed information about a session"
        echo "  list           - List all sessions with status"
        exit 1
        ;;
esac
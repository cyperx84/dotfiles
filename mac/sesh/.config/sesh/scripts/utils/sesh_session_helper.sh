#!/usr/bin/env bash
################################################################################
# sesh_session_helper.sh - Session Management Utilities
################################################################################
#
# DESCRIPTION:
#   Session management helper functions for tmux sessions. Provides utilities
#   for checking status, killing sessions, gathering statistics, and cleanup.
#
# FEATURES:
#   - Session status checking
#   - Safe session termination with confirmation
#   - Session statistics and reporting
#   - Dead session cleanup
#
# USAGE:
#   # As a library
#   source "${SESH_SCRIPTS_DIR}/utils/sesh_session_helper.sh"
#   check_session_status "my-session"
#
#   # As a command
#   ./sesh_session_helper.sh status my-session
#   ./sesh_session_helper.sh kill my-session
#   ./sesh_session_helper.sh stats
#   ./sesh_session_helper.sh cleanup
#
# VERSION: 2.0.0
# LAST MODIFIED: 2025-12-02
#
################################################################################

# ============================================================================
# DEPENDENCY LOADING
# ============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SESH_SCRIPTS_LIB="${SESH_SCRIPTS_LIB:-$(dirname "$SCRIPT_DIR")/lib}"

# Source common utilities (provides colors, icons, and common functions)
# shellcheck source=../lib/sesh_common.sh
source "${SESH_SCRIPTS_LIB}/sesh_common.sh"

# ============================================================================
# SESSION STATUS FUNCTIONS
# ============================================================================

# Check if a session is active
# Usage: check_session_status <session_name>
# Returns: Prints status with color formatting
check_session_status() {
    local session_name="$1"

    if [ -z "$session_name" ]; then
        echo -e "${RED}Error: Session name required${NC}"
        return 1
    fi

    if tmux has-session -t "$session_name" 2>/dev/null; then
        echo -e "${GREEN}✅ Active${NC}"
        return 0
    else
        echo -e "${YELLOW}💤 Inactive${NC}"
        return 1
    fi
}

# ============================================================================
# SESSION MANAGEMENT FUNCTIONS
# ============================================================================

# Kill session with confirmation prompt
# Usage: safe_kill_session <session_name>
# Returns: 0 on success, 1 on cancel or error
safe_kill_session() {
    local session_name="$1"

    if [ -z "$session_name" ]; then
        echo -e "${RED}Error: Session name required${NC}"
        return 1
    fi

    if tmux has-session -t "$session_name" 2>/dev/null; then
        read -p "Kill session '$session_name'? (y/N): " confirm
        if [[ $confirm =~ ^[Yy]$ ]]; then
            tmux kill-session -t "$session_name"
            echo -e "${GREEN}Session '$session_name' killed${NC}"
            return 0
        else
            echo -e "${YELLOW}Cancelled${NC}"
            return 1
        fi
    else
        echo -e "${RED}Session '$session_name' not found${NC}"
        return 1
    fi
}

# Display session statistics
# Usage: session_stats
# Returns: Prints formatted statistics about all sessions
session_stats() {
    echo -e "${BLUE}📊 Session Statistics${NC}"
    echo -e "${CYAN}Total sessions:${NC} $(tmux list-sessions 2>/dev/null | wc -l)"
    echo -e "${CYAN}Total windows:${NC} $(tmux list-windows -a 2>/dev/null | wc -l)"
    echo -e "${CYAN}Total panes:${NC} $(tmux list-panes -a 2>/dev/null | wc -l)"

    # Show top 5 largest sessions by window count
    echo -e "\\n${CYAN}Top sessions by window count:${NC}"
    tmux list-sessions -F '#{session_name} #{session_windows}' 2>/dev/null | \
        sort -k2 -nr | head -5 | while read session windows; do
        echo -e "  ${GREEN}$session${NC}: $windows windows"
    done
}

# Clean up dead or orphaned sessions
# Usage: cleanup_sessions
# Returns: 0 on success, prints count of cleaned sessions
cleanup_sessions() {
    local dead_sessions=0

    echo -e "${BLUE}Scanning for dead sessions...${NC}"

    tmux list-sessions -F '#{session_name}' 2>/dev/null | while read session; do
        # Double-check if session truly exists (redundant but safe)
        if ! tmux has-session -t "$session" 2>/dev/null; then
            echo -e "${YELLOW}Removing dead session: $session${NC}"
            tmux kill-session -t "$session" 2>/dev/null
            ((dead_sessions++))
        fi
    done

    if [ "$dead_sessions" -eq 0 ]; then
        echo -e "${GREEN}No dead sessions found${NC}"
    else
        echo -e "${GREEN}Cleaned up $dead_sessions dead session(s)${NC}"
    fi
}

# ============================================================================
# COMMAND-LINE INTERFACE
# ============================================================================

# Main function for external CLI use
case "${1:-}" in
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
        echo "Usage: $0 {status|kill|stats|cleanup} [session_name]"
        echo ""
        echo "Commands:"
        echo "  status <session>  - Check if session is active"
        echo "  kill <session>    - Kill session with confirmation"
        echo "  stats             - Show session statistics"
        echo "  cleanup           - Remove dead sessions"
        echo ""
        echo "Enhanced session management utilities for tmux"
        exit 1
        ;;
esac

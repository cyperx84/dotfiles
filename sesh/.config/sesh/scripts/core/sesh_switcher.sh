#!/usr/bin/env bash
################################################################################
# sesh_switcher.sh - Enhanced Session Switcher with Error Handling
################################################################################
#
# DESCRIPTION:
#   Intelligent tmux session switcher integrating sesh, fzf, and custom scripts.
#   Provides multi-source session listing, live previews, and dynamic mode
#   switching with full error handling and dependency validation.
#
# FEATURES:
#   - Multi-source session listing with icons and status indicators
#   - Live preview window with keybindings reference
#   - Dynamic mode switching (tmux sessions, directories, containers, etc.)
#   - Session creation and deletion from switcher
#   - Sort functionality for better organization
#   - Comprehensive error handling and dependency validation
#   - Graceful degradation for optional features
#
# KEYBINDINGS (within FZF):
#   Esc             - Close switcher
#   Ctrl+D/U        - Scroll preview window down/up
#   Alt+C           - Create new session
#   Alt+K           - Kill selected session
#   Ctrl+T          - Toggle tmux-only view
#   Ctrl+B          - Browse all sessions (requires zoxide)
#   Ctrl+/          - Browse directories (requires zoxide)
#   Ctrl+R          - Reload session list
#   Ctrl+S          - Sort sessions alphabetically
#
# DEPENDENCIES:
#   Required:
#     - sesh (session manager)
#     - fzf-tmux (fuzzy finder with tmux popup support)
#     - tmux (terminal multiplexer)
#   Optional:
#     - zoxide (directory navigation - affects Ctrl+B and Ctrl+/)
#
# CALLED BY:
#   - tmux keybinding: Prefix + e
#   - Manual invocation: ~/.tmux/scripts/sesh_switcher.sh
#
# CALLS:
#   - sesh connect/list
#   - fzf-tmux (fuzzy selection)
#   - sesh_list.sh (session enumeration)
#   - sesh_preview.sh (preview rendering)
#   - sesh_clean_selection.sh (output sanitization)
#   - sesh_create_new.sh (new session creation)
#   - sesh_kill.sh (session termination)
#
# USAGE:
#   ~/.tmux/scripts/sesh_switcher.sh
#
# EXIT CODES:
#   0 - Successfully connected to session or user aborted gracefully
#   1 - Dependency check failed
#   2 - Script execution error (trapped by error handler)
#   3 - User aborted in FZF (suppressed by || true)
#
# ENVIRONMENT:
#   SESH_SCRIPTS_DIR     - Override default scripts directory
#   FZF_PREVIEW_COLUMNS  - Customize preview width
#
# NOTES:
#   - All variables are quoted to prevent word splitting
#   - Readonly variables prevent accidental modification
#   - Error handler captures line numbers for debugging
#   - Dependency validation occurs before execution
#   - Optional features gracefully degrade if unavailable
#   - Zoxide enables directory browsing modes (Ctrl+B, Ctrl+/)
#
# VERSION: 2.0.0
# AUTHOR: CyperX
# LAST MODIFIED: 2025-11-12
#
################################################################################

# ===== ERROR HANDLING & SAFETY =====
# Exit immediately on error, error on unset variables, fail on pipe errors
set -euo pipefail

# Error handler: logs line number and failed command
error_handler() {
    local line_num="$1"
    local exit_code="$2"
    echo "ERROR: Script failed at line ${line_num} with exit code ${exit_code}" >&2
    echo "Failed command: ${BASH_COMMAND}" >&2
    exit 2
}

# Cleanup handler: placeholder for future cleanup operations
cleanup_handler() {
    :  # No cleanup needed currently
}

# Register error and cleanup traps
trap 'error_handler ${LINENO} $?' ERR
trap 'cleanup_handler' EXIT

# ===== DEPENDENCY VALIDATION =====

# Check if required command exists
# Arguments: $1 = command name, $2 = package name (optional, defaults to $1)
check_dependency() {
    local cmd="${1}"
    local pkg="${2:-${1}}"

    if ! command -v "${cmd}" &>/dev/null; then
        echo "ERROR: Required dependency '${cmd}' not found" >&2
        echo "Install with: brew install ${pkg}" >&2
        exit 1
    fi
}

# Validate required dependencies before execution
check_dependency "sesh" "sesh"
check_dependency "fzf-tmux" "fzf"
check_dependency "tmux" "tmux"

# Warn if optional dependencies are missing
if ! command -v "zoxide" &>/dev/null; then
    echo "WARNING: Optional dependency 'zoxide' not found (Ctrl+/ and Ctrl+B modes disabled)" >&2
    echo "Install with: brew install zoxide" >&2
fi

# ===== CONFIGURATION =====

# Base directory for helper scripts (override with SESH_SCRIPTS_DIR env var)
readonly SESH_SCRIPTS_DIR="${SESH_SCRIPTS_DIR:-${HOME}/.config/sesh/scripts}"

# Source common functions and variables
source "${SESH_SCRIPTS_DIR}/lib/sesh_common.sh"

# Required helper scripts
readonly SCRIPT_LIST_LIGHTWEIGHT="${SESH_SCRIPTS_DIR}/core/sesh_list.sh"
readonly SCRIPT_PREVIEW="${SESH_SCRIPTS_DIR}/core/sesh_preview.sh"
readonly SCRIPT_CLEAN_SELECTION="${SESH_SCRIPTS_DIR}/core/sesh_clean_selection.sh"

# Optional helper scripts (used in keybindings)
readonly SCRIPT_CREATE_NEW="${SESH_SCRIPTS_DIR}/utils/sesh_create_new.sh"
readonly SCRIPT_KILL="${SESH_SCRIPTS_DIR}/utils/sesh_kill.sh"

# Validate scripts directory exists
if [[ ! -d "${SESH_SCRIPTS_DIR}" ]]; then
    echo "ERROR: Scripts directory not found: ${SESH_SCRIPTS_DIR}" >&2
    exit 1
fi

# Validate required helper scripts exist and are executable
for script in "${SCRIPT_LIST_LIGHTWEIGHT}" "${SCRIPT_PREVIEW}" "${SCRIPT_CLEAN_SELECTION}"; do
    if [[ ! -f "${script}" ]]; then
        echo "ERROR: Required script not found: ${script}" >&2
        exit 1
    fi

    if [[ ! -x "${script}" ]]; then
        echo "ERROR: Script not executable: ${script}" >&2
        echo "Fix with: chmod +x ${script}" >&2
        exit 1
    fi
done

# Warn if optional scripts are missing (but don't exit)
for script in "${SCRIPT_CREATE_NEW}" "${SCRIPT_KILL}"; do
    if [[ ! -f "${script}" ]]; then
        script_name=$(basename "${script}")
        echo "WARNING: Optional script not found: ${script} (some keybindings may not work)" >&2
    fi
done

# ===== MAIN LOGIC =====

# Execute the session switcher with FZF
selected_session=$(
    "${SCRIPT_LIST_LIGHTWEIGHT}" | fzf-tmux -p 80%,60% \
        --ansi \
        --layout=reverse \
        --no-sort --border-label ' sesh ' --prompt '⚡  ' \
        --header '' \
        --preview "${SCRIPT_PREVIEW} {}" \
        --preview-window 'right:70%' \
        --color='border:#00ff00' \
        --bind 'ctrl-d:preview-page-down,ctrl-u:preview-page-up' \
        --bind 'esc:abort' \
        --bind "alt-c:execute(${SCRIPT_CREATE_NEW})+abort" \
        --bind "alt-k:execute(${SCRIPT_KILL} {})+reload(${SCRIPT_LIST_LIGHTWEIGHT})+change-header()" \
        --bind 'ctrl-t:change-prompt(🪟  )+reload('"${SCRIPT_LIST_LIGHTWEIGHT}"')+change-header()' \
        --bind 'ctrl-b:change-prompt(📦  )+reload(zoxide query -l)+change-header()' \
        --bind 'ctrl-/:change-prompt(📁  )+reload(zoxide query -l)+change-header()' \
        --bind "ctrl-r:reload(${SCRIPT_LIST_LIGHTWEIGHT})+change-header()" \
        --bind "ctrl-s:reload(${SCRIPT_LIST_LIGHTWEIGHT} | sort)+change-header()" \
        | "${SCRIPT_CLEAN_SELECTION}"
) || true

# Connect to selected session if user didn't abort
if [[ -n "${selected_session}" ]]; then
    sesh connect "${selected_session}"
fi

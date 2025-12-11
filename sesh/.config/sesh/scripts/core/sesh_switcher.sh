#!/usr/bin/env bash
################################################################################
# Sesh Switcher - Interactive Session Selector with FZF
################################################################################
#
# DESCRIPTION:
#   Provides an interactive FZF-based session switcher for tmux/tmuxinator/zoxide.
#   Shows all available sessions (tmux, config, zoxide directories) in a unified view
#   with extensive keybindings for session management.
#
# USAGE:
#   sesh_switcher.sh
#
# KEYBINDINGS:
#   ESC/Alt+E - Abort selection (toggle close)
#   Alt+N     - Create new session
#   Alt+K     - Kill selected session
#   Ctrl+R    - Reload session list
#   Ctrl+S    - Sort session list alphabetically
#   Ctrl+D    - Preview page down
#   Ctrl+U    - Preview page up
#
# PLATFORM SUPPORT:
#   macOS (Darwin), Linux (Arch, Ubuntu, Fedora, Debian)
#
# INSTALLATION:
#   macOS:   brew install joshmedeski/sesh/sesh fzf tmux zoxide
#   Arch:    yay -S sesh-bin fzf tmux zoxide
#   Ubuntu:  sudo apt install fzf tmux zoxide && cargo install sesh
#   Fedora:  sudo dnf install fzf tmux zoxide && cargo install sesh
#
# ENVIRONMENT VARIABLES:
#   SESH_SCRIPTS_DIR        - Override scripts directory (default: ~/.config/sesh/scripts)
#   SESH_DEBUG              - Enable debug logging (default: false)
#   SESH_DEBUG_LOG          - Debug log file (default: /tmp/sesh_switcher_debug.log)
#   SESH_PLATFORM_OVERRIDE  - Override platform detection (macos/linux, for testing)
#   SESH_DISTRO_OVERRIDE    - Override distro detection (arch/ubuntu/fedora, for testing)
#   SESH_PATH_BLACKLIST     - Additional paths to blacklist (colon-separated)
#
# DEPENDENCIES:
#   Required: sesh, fzf (fzf-tmux), tmux, bash 4.0+
#   Optional: zoxide, eza, git, docker
#
# VERSION: 2.1.0
# LAST MODIFIED: 2025-12-05
#
################################################################################

# ===== ERROR HANDLING & SAFETY =====

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

# ===== CONFIGURATION =====

# Debug settings (disable by default, enable with SESH_DEBUG=true)
readonly DEBUG_ENABLED="${SESH_DEBUG:-false}"
readonly DEBUG_LOG="${SESH_DEBUG_LOG:-/tmp/sesh_switcher_debug.log}"

# Base directory for helper scripts
readonly SESH_SCRIPTS_DIR="${SESH_SCRIPTS_DIR:-${HOME}/.config/sesh/scripts}"

# FZF appearance configuration
readonly FZF_WIDTH="80%"
readonly FZF_HEIGHT="60%"
readonly FZF_BORDER_COLOR="#00ff00"
readonly FZF_BORDER_LABEL=" sesh "
readonly FZF_PREVIEW_WIDTH="70%"

# FZF prompt
readonly PROMPT_DEFAULT="⚡  "

# FZF header (empty for cleaner UI - keybinds documented in script header)
readonly FZF_HEADER=""

# Directory blacklist pattern (system directories to exclude from zoxide)
readonly ZOXIDE_BLACKLIST="^(/|/Users|/dev|/usr|/Library)$"

# ===== DEPENDENCY VALIDATION =====

# Check if required command exists
# Arguments: $1 = command name, $2 = package name (optional, defaults to $1)
check_dependency() {
    local cmd="${1}"
    local pkg="${2:-${1}}"

    if ! command -v "${cmd}" &>/dev/null; then
        echo "ERROR: Required dependency '${cmd}' not found" >&2

        # Special handling for sesh (different install methods per platform)
        if [[ "${cmd}" == "sesh" ]]; then
            case "$SESH_OS" in
                macos)
                    echo "Install with: brew install joshmedeski/sesh/sesh" >&2
                    ;;
                linux)
                    case "$SESH_LINUX_DISTRO" in
                        arch)
                            echo "Install with: yay -S sesh-bin  # or: paru -S sesh-bin" >&2
                            ;;
                        *)
                            echo "Install with: cargo install sesh  # or download from: https://github.com/joshmedeski/sesh/releases" >&2
                            ;;
                    esac
                    ;;
                *)
                    echo "Download from: https://github.com/joshmedeski/sesh/releases" >&2
                    ;;
            esac
        else
            # Use platform-aware package manager command
            echo "Install with: $(get_package_install_cmd "${pkg}")" >&2
        fi
        exit 1
    fi
}

# Validate required dependencies
check_dependency "sesh" "sesh"
check_dependency "fzf-tmux" "fzf"
check_dependency "tmux" "tmux"

# Warn if optional dependencies are missing
if ! command -v "zoxide" &>/dev/null; then
    echo "WARNING: Optional dependency 'zoxide' not found (Ctrl+/ and Ctrl+B modes disabled)" >&2
    echo "Install with: $(get_package_install_cmd zoxide)" >&2
fi

# ===== SCRIPT PATHS =====

# Source common functions and variables
source "${SESH_SCRIPTS_DIR}/lib/sesh_common.sh"

# Required helper scripts
readonly SCRIPT_LIST="${SESH_SCRIPTS_DIR}/core/sesh_list.sh"
readonly SCRIPT_PREVIEW="${SESH_SCRIPTS_DIR}/core/sesh_preview.sh"
readonly SCRIPT_CLEAN_SELECTION="${SESH_SCRIPTS_DIR}/core/sesh_clean_selection.sh"

# Optional helper scripts (used in keybindings)
readonly SCRIPT_CREATE_NEW="${SESH_SCRIPTS_DIR}/utils/sesh_create_new.sh"
readonly SCRIPT_KILL="${SESH_SCRIPTS_DIR}/utils/sesh_kill.sh"

# ===== SCRIPT VALIDATION =====

# Validate scripts directory exists
if [[ ! -d "${SESH_SCRIPTS_DIR}" ]]; then
    echo "ERROR: Scripts directory not found: ${SESH_SCRIPTS_DIR}" >&2
    exit 1
fi

# Validate required helper scripts exist and are executable
validate_script() {
    local script="$1"
    local required="${2:-true}"

    if [[ ! -f "${script}" ]]; then
        if [[ "${required}" == "true" ]]; then
            echo "ERROR: Required script not found: ${script}" >&2
            exit 1
        else
            echo "WARNING: Optional script not found: $(basename "${script}") (some keybindings may not work)" >&2
            return 1
        fi
    fi

    if [[ ! -x "${script}" ]]; then
        if [[ "${required}" == "true" ]]; then
            echo "ERROR: Script not executable: ${script}" >&2
            echo "Fix with: chmod +x ${script}" >&2
            exit 1
        fi
        return 1
    fi

    return 0
}

# Validate required scripts
validate_script "${SCRIPT_LIST}" true
validate_script "${SCRIPT_PREVIEW}" true
validate_script "${SCRIPT_CLEAN_SELECTION}" true

# Validate optional scripts
validate_script "${SCRIPT_CREATE_NEW}" false
validate_script "${SCRIPT_KILL}" false

# ===== UTILITY FUNCTIONS =====

# Log debug message if debug mode is enabled
# Arguments: $1 = message
debug_log() {
    if [[ "${DEBUG_ENABLED}" == "true" ]]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" >> "${DEBUG_LOG}"
    fi
}

# Create a new tmux session from a directory
# Arguments: $1 = directory path, $2 = session name
create_session_from_directory() {
    local directory="$1"
    local session_name="$2"

    debug_log "Creating session '${session_name}' in directory '${directory}'"

    if ! tmux has-session -t "${session_name}" 2>/dev/null; then
        if ! tmux new-session -d -s "${session_name}" -c "${directory}" 2>&1 | tee -a "${DEBUG_LOG}" >&2; then
            echo "ERROR: Failed to create session '${session_name}'" >&2
            return 1
        fi
        debug_log "Session '${session_name}' created successfully"
    else
        debug_log "Session '${session_name}' already exists"
    fi

    return 0
}

# Connect to a session (directory or existing session)
# Arguments: $1 = selected session/directory
connect_to_session() {
    local selection="$1"
    local expanded_path="${selection/#\~/$HOME}"

    debug_log "=== Session Connection Request ==="
    debug_log "Selected: '${selection}'"
    debug_log "Expanded: '${expanded_path}'"
    debug_log "Is directory: $([[ -d "${expanded_path}" ]] && echo YES || echo NO)"
    debug_log "Has session: $(tmux has-session -t "${selection}" 2>/dev/null && echo YES || echo NO)"

    # Check if selection is a directory path (not an existing session)
    if [[ -d "${expanded_path}" ]] && ! tmux has-session -t "${selection}" 2>/dev/null; then
        # Extract session name from directory path (last component)
        local session_name
        session_name=$(basename "${selection}")

        debug_log "Session name: '${session_name}'"

        # Safety check: don't allow "/" or empty session names
        if [[ "${session_name}" == "/" ]] || [[ -z "${session_name}" ]]; then
            debug_log "ERROR: Invalid session name"
            echo "WARNING: Cannot create session for root directory" >&2
            return 0  # Exit successfully to avoid tmux keybinding error
        fi

        # Create and connect to session
        if create_session_from_directory "${expanded_path}" "${session_name}"; then
            debug_log "Connecting to '${session_name}'"
            sesh connect "${session_name}"
        else
            echo "ERROR: Failed to create session from directory" >&2
            return 1
        fi
    else
        # Normal session connection
        debug_log "Normal connect to '${selection}'"
        sesh connect "${selection}"
    fi
}

# ===== MAIN LOGIC =====

# Initialize debug log
if [[ "${DEBUG_ENABLED}" == "true" ]]; then
    debug_log "======================================"
    debug_log "Sesh Switcher Started"
    debug_log "======================================"
fi

# Execute the session switcher with FZF
selected_session=$(
    "${SCRIPT_LIST}" --fast | fzf-tmux -p "${FZF_WIDTH},${FZF_HEIGHT}" \
        --ansi \
        --layout=reverse \
        --no-sort \
        --border-label "${FZF_BORDER_LABEL}" \
        --prompt "${PROMPT_DEFAULT}" \
        --header "${FZF_HEADER}" \
        --preview "${SCRIPT_PREVIEW} {}" \
        --preview-window "right:${FZF_PREVIEW_WIDTH}" \
        --color="border:${FZF_BORDER_COLOR}" \
        --bind 'ctrl-d:preview-page-down,ctrl-u:preview-page-up' \
        --bind 'esc:abort' \
        --bind 'alt-e:abort' \
        --bind "alt-n:execute(${SCRIPT_CREATE_NEW})+abort" \
        --bind "alt-k:execute(${SCRIPT_KILL} {})+reload(${SCRIPT_LIST} --fast)" \
        --bind "ctrl-r:reload(${SCRIPT_LIST} --fast)" \
        --bind "ctrl-s:reload(${SCRIPT_LIST} --fast | sort)" \
        | "${SCRIPT_CLEAN_SELECTION}"
) || true

# Connect to selected session if user didn't abort
if [[ -n "${selected_session}" ]]; then
    connect_to_session "${selected_session}"
else
    debug_log "User aborted session selection"
fi

debug_log "Sesh Switcher Finished"

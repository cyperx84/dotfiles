#!/usr/bin/env bash
################################################################################
# sesh_common.sh - Core Utilities and Configuration Module
################################################################################
#
# DESCRIPTION:
#   Central library for sesh scripts providing shared configuration constants,
#   utility functions, and error handling. Single source of truth for common
#   functionality across all sesh helper scripts.
#
# FEATURES:
#   - Configuration constants (paths, cache settings)
#   - Session detection and type identification
#   - Session name cleaning and normalization
#   - Error handling and cleanup functions
#   - Time formatting utilities
#   - Active session queries
#
# USAGE:
#   # Source at the top of any sesh script
#   SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
#   source "$SCRIPT_DIR/lib/sesh_common.sh"
#
# PROVIDED FUNCTIONS:
#   - clean_session_name()       - Normalize session names
#   - detect_session_type()      - Identify session source (tmux/tmuxinator/sesh/dir)
#   - is_sesh_toml_session()     - Check if session defined in sesh.toml
#   - get_active_sessions()      - Get currently active tmux sessions
#   - get_sesh_toml_path()       - Extract path from sesh.toml
#   - error_handler()            - Log errors with line numbers
#   - cleanup_handler()          - Cleanup on exit
#   - setup_error_handling()     - Initialize error traps
#   - human_time()               - Format seconds to human-readable
#   - has_command()              - Check if command exists
#   - list_directory()           - Get directory listing with fallback
#
# DEPENDENCIES:
#   - sesh_colors.sh (automatically sourced)
#   - sesh_icons.sh (automatically sourced)
#
# VERSION: 2.0.0
# LAST MODIFIED: 2025-12-02
#
################################################################################

# ============================================================================
# PLATFORM DETECTION - Cross-platform compatibility layer
# ============================================================================

# Detect operating system (called once on load)
# Returns: "macos" or "linux" or "unknown"
detect_os() {
    case "$(uname -s)" in
        Darwin*) echo "macos" ;;
        Linux*)  echo "linux" ;;
        *)       echo "unknown" ;;
    esac
}

# Detect Linux distribution (only called on Linux systems)
# Returns: "arch", "ubuntu", "fedora", "debian", or "unknown"
detect_linux_distro() {
    if [[ -f /etc/os-release ]]; then
        local id
        id=$(grep '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"')
        case "$id" in
            arch|manjaro|endeavouros) echo "arch" ;;
            ubuntu|pop|mint)          echo "ubuntu" ;;
            fedora|rhel|centos)       echo "fedora" ;;
            debian)                   echo "debian" ;;
            *)                        echo "unknown" ;;
        esac
    else
        echo "unknown"
    fi
}

# Get platform-appropriate package manager install command
# Usage: get_package_install_cmd <package_name>
# Returns: Installation command string for current platform
get_package_install_cmd() {
    local pkg="$1"

    case "$SESH_OS" in
        macos)
            echo "brew install $pkg"
            ;;
        linux)
            case "$SESH_LINUX_DISTRO" in
                arch)
                    # Prefer yay if available, fall back to pacman
                    if command -v yay &>/dev/null; then
                        echo "yay -S $pkg"
                    else
                        echo "sudo pacman -S $pkg"
                    fi
                    ;;
                ubuntu|debian)
                    echo "sudo apt install $pkg"
                    ;;
                fedora)
                    echo "sudo dnf install $pkg"
                    ;;
                *)
                    echo "# Install $pkg using your package manager"
                    ;;
            esac
            ;;
        *)
            echo "# Install $pkg using your package manager"
            ;;
    esac
}

# Get platform-specific directory blacklist for filtering
# Returns: Newline-separated list of paths to exclude
get_path_blacklist() {
    local blacklist=()

    # Common blacklist patterns (all platforms)
    blacklist+=(
        "/"
        ".Trash"
        "node_modules"
        ".git"
        ".cache"
        ".DS_Store"
    )

    # Platform-specific system paths
    case "$SESH_OS" in
        macos)
            blacklist+=(
                "/Users/Shared"
                "/Library/Preferences"
                "/Library/LaunchDaemons"
                "/System/Library"
                "/private/tmp"
                "/private/var"
            )
            ;;
        linux)
            blacklist+=(
                "/usr/lib"
                "/lib"
                "/lib64"
                "/etc/systemd"
                "/var/lib"
                "/var/cache"
                "/tmp"
                "/proc"
                "/sys"
                "/dev"
            )
            ;;
    esac

    # User-defined blacklist via environment variable (colon-separated)
    if [[ -n "${SESH_PATH_BLACKLIST:-}" ]]; then
        IFS=':' read -ra user_blacklist <<< "$SESH_PATH_BLACKLIST"
        blacklist+=("${user_blacklist[@]}")
    fi

    printf '%s\n' "${blacklist[@]}"
}

# Get file modification time in a platform-aware way
# Usage: get_file_mtime <file_path>
# Returns: Unix timestamp of last modification
get_file_mtime() {
    local file="$1"

    case "$SESH_OS" in
        macos)
            # macOS uses BSD stat with -f flag
            stat -f %m "$file" 2>/dev/null
            ;;
        linux|*)
            # Linux uses GNU stat with -c flag
            stat -c %Y "$file" 2>/dev/null
            ;;
    esac
}

# Initialize platform detection (called once when this file is sourced)
# Sets SESH_OS and SESH_LINUX_DISTRO environment variables
init_platform_detection() {
    # Allow user override for testing (e.g., SESH_PLATFORM_OVERRIDE=linux)
    if [[ -n "${SESH_PLATFORM_OVERRIDE:-}" ]]; then
        export SESH_OS="$SESH_PLATFORM_OVERRIDE"
    else
        export SESH_OS="${SESH_OS:-$(detect_os)}"
    fi

    # Detect Linux distribution if on Linux
    if [[ "$SESH_OS" == "linux" ]]; then
        if [[ -n "${SESH_DISTRO_OVERRIDE:-}" ]]; then
            export SESH_LINUX_DISTRO="$SESH_DISTRO_OVERRIDE"
        else
            export SESH_LINUX_DISTRO="${SESH_LINUX_DISTRO:-$(detect_linux_distro)}"
        fi
    fi
}

# Run initialization immediately when this file is sourced
init_platform_detection

# ============================================================================
# DEPENDENCY LOADING - Source color and icon definitions
# ============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Use provided SESH_SCRIPTS_DIR or default to home directory
SESH_SCRIPTS_DIR_RESOLVED="${SESH_SCRIPTS_DIR:-${HOME}/.config/sesh/scripts}"

# Source colors (if not already loaded)
# Use ${VAR+x} syntax to safely check if variable is set (works with set -u)
if [ -z "${COLOR_NEON_GREEN+x}" ]; then
    # shellcheck source=./sesh_colors.sh
    source "${SESH_SCRIPTS_DIR_RESOLVED}/lib/sesh_colors.sh" || source "$SCRIPT_DIR/sesh_colors.sh"
fi

# Source icons (if not already loaded)
# Use ${VAR+x} syntax to safely check if variable is set (works with set -u)
if [ -z "${ICON_ATTACHED+x}" ]; then
    # shellcheck source=./sesh_icons.sh
    source "${SESH_SCRIPTS_DIR_RESOLVED}/lib/sesh_icons.sh" || source "$SCRIPT_DIR/sesh_icons.sh"
fi

# Legacy color definitions for backward compatibility
# (new scripts should use COLOR_* from sesh_colors.sh)
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[1;33m'
export BLUE='\033[0;34m'
export MAGENTA='\033[0;35m'
export CYAN='\033[0;36m'
export GRAY='\033[0;90m'
export BOLD='\033[1m'
export NC='\033[0m'

# ============================================================================
# CONFIGURATION CONSTANTS
# ============================================================================

# Sesh configuration file and directories
# Note: SESH_SCRIPTS_DIR may already be readonly in parent script (sesh_switcher.sh)
# Only export if not already set
if [ -z "${SESH_CONFIG+x}" ]; then
    export SESH_CONFIG="${HOME}/.config/sesh/sesh.toml"
fi
if [ -z "${SESH_SCRIPTS_DIR+x}" ]; then
    export SESH_SCRIPTS_DIR="${HOME}/.config/sesh/scripts"
fi
if [ -z "${TMUXINATOR_CONFIG_DIR+x}" ]; then
    export TMUXINATOR_CONFIG_DIR="${HOME}/.config/tmuxinator"
fi

# Display mode and cache settings
if [ -z "${SESH_DISPLAY_MODE_FILE+x}" ]; then
    export SESH_DISPLAY_MODE_FILE="${HOME}/.sesh_display_mode"
fi
if [ -z "${SESH_CACHE_FILE+x}" ]; then
    export SESH_CACHE_FILE="/tmp/sesh_list_cache"
fi
if [ -z "${SESH_CACHE_TTL+x}" ]; then
    export SESH_CACHE_TTL="2"
fi

# ============================================================================
# ERROR HANDLING FUNCTIONS
# ============================================================================

# Error handler: logs line number and failed command
# Arguments: $1 = line number, $2 = exit code
# Called automatically via trap ERR when setup_error_handling() is used
error_handler() {
    local line_num="${1:-unknown}"
    local exit_code="${2:-1}"
    echo "ERROR: Script failed at line ${line_num} with exit code ${exit_code}" >&2
    echo "Failed command: ${BASH_COMMAND}" >&2
    return "$exit_code"
}

# Cleanup handler: placeholder for cleanup operations
# Called automatically via trap EXIT when setup_error_handling() is used
# Override this function in your script if you need custom cleanup
cleanup_handler() {
    # No default cleanup needed - override in calling script if needed
    :
}

# Setup error handling with traps
# Call this at the start of any script that needs error handling
# Sets: set -euo pipefail, trap ERR, trap EXIT
setup_error_handling() {
    set -euo pipefail
    trap 'error_handler ${LINENO} $?' ERR
    trap 'cleanup_handler' EXIT
}

# ============================================================================
# TIME FORMATTING FUNCTIONS
# ============================================================================

# Convert seconds to human-readable time format
# Usage: human_time <seconds>
# Returns: "5s", "2m", "3h 15m", "2d 5h"
human_time() {
    local seconds=$1

    if [ "$seconds" -lt 60 ]; then
        echo "${seconds}s"
    elif [ "$seconds" -lt 3600 ]; then
        echo "$((seconds / 60))m"
    elif [ "$seconds" -lt 86400 ]; then
        local hours=$((seconds / 3600))
        local mins=$((seconds % 3600 / 60))
        if [ "$mins" -gt 0 ]; then
            echo "${hours}h ${mins}m"
        else
            echo "${hours}h"
        fi
    else
        local days=$((seconds / 86400))
        local hours=$((seconds % 86400 / 3600))
        if [ "$hours" -gt 0 ]; then
            echo "${days}d ${hours}h"
        else
            echo "${days}d"
        fi
    fi
}

# Clean session input - remove ANSI codes, icons, and metadata
# Usage: clean_session_name <session_string>
# Returns: Cleaned session name
clean_session_name() {
    local input="$1"

    # Remove ANSI color codes (prefer perl for better compatibility)
    if command -v perl &> /dev/null; then
        input=$(echo "$input" | perl -pe 's/\e\[[0-9;]*m//g')
    else
        input=$(echo "$input" | LC_ALL=C sed 's/'$(printf '\033')'\[[0-9;]*m//g')
    fi

    # Remove leading/trailing whitespace
    input=$(echo "$input" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

    # Remove status icons (>, *, -, +, #, G, D, S, C)
    # Note: / is NOT removed here to preserve absolute paths
    input=$(echo "$input" | sed -e 's/^[>*-+#GDS][[:space:]]*//')

    # Remove emoji prefixes (any non-alphanumeric leading characters)
    input=$(echo "$input" | sed -E 's/^[^[:alnum:]~\/\._-]+[[:space:]]*//')

    # Remove metadata like (2w 3p), git info, resource info, Claude status
    input=$(echo "$input" | sed -E 's/[[:space:]]*\([0-9]+w[[:space:]]+[0-9]+p\).*//' | \
        sed -E 's/[[:space:]]+[!+~_-].*//' | \
        sed -E 's/[[:space:]]+\[C:[0-9*.]*\].*//' | \
        xargs)

    # Remove trailing project type indicators (emojis and short text like js, py, ts, G)
    # Match one or more sequences of: space followed by 1-3 alphanumeric chars or emoji
    input=$(echo "$input" | sed -E 's/([[:space:]]+[[:alnum:]]{1,3})+$//')

    # Remove trailing emoji characters if perl is available
    if command -v perl &> /dev/null; then
        input=$(echo "$input" | perl -pe 's/\s+[\x{1F300}-\x{1F9FF}]+$//')
    fi

    # Expand tilde to HOME
    input="${input/#\~/$HOME}"

    echo "$input"
}

# Check if command exists
# Usage: has_command <command_name>
# Returns: 0 (success) if command exists, 1 otherwise
has_command() {
    command -v "$1" &> /dev/null
}

# Get directory listing with fallback
# Usage: list_directory <path> [max_lines]
# Returns: Directory listing (uses eza if available, falls back to ls)
list_directory() {
    local dir_path="$1"
    local max_lines="${2:-8}"

    if [ ! -d "$dir_path" ]; then
        echo -e "${RED}Directory does not exist${NC}"
        return 1
    fi

    if has_command eza; then
        eza --icons --color=always --group-directories-first -a -l "$dir_path" 2>/dev/null | head -n "$max_lines"
    else
        ls -lA "$dir_path" 2>/dev/null | head -n "$max_lines"
    fi
}

# ============================================================================
# SESSION DETECTION FUNCTIONS
# ============================================================================

# Get path from sesh.toml for a custom session
# Usage: get_sesh_toml_path <session_name>
# Returns: Path configured in sesh.toml, or empty if not found
# Note: This function is duplicated in sesh_preview_common.sh for compatibility
get_sesh_toml_path() {
    local session_name="$1"
    local sesh_config="${SESH_CONFIG}"

    if [ ! -f "$sesh_config" ]; then
        return
    fi

    # Parse TOML to find matching session and extract path
    local in_session=0
    local session_path=""

    while IFS= read -r line; do
        # Check if we're starting a new session block
        if [[ "$line" == "[[session]]" ]]; then
            in_session=1
            session_path=""
            continue
        fi

        # Extract name from current session block
        if [[ "$in_session" == 1 ]]; then
            if [[ "$line" =~ ^name[[:space:]]*=[[:space:]]*\"(.*)\" ]]; then
                local name="${BASH_REMATCH[1]}"
                if [ "$name" = "$session_name" ]; then
                    # Found matching session, now look for path
                    while IFS= read -r path_line; do
                        if [[ "$path_line" =~ ^path[[:space:]]*=[[:space:]]*\"(.*)\" ]]; then
                            session_path="${BASH_REMATCH[1]}"
                            break
                        fi
                        if [[ "$path_line" == "[[session]]" ]]; then
                            break
                        fi
                    done
                    break
                fi
            fi
        fi
    done < "$sesh_config"

    if [ -n "$session_path" ]; then
        echo "${session_path/#\~/$HOME}"
    fi
}

# Check if session is defined in sesh.toml
# Usage: is_sesh_toml_session <session_name>
# Returns: 0 (true) if session is in sesh.toml, 1 (false) otherwise
is_sesh_toml_session() {
    local name="$1"
    local sesh_config="${SESH_CONFIG}"

    if [ ! -f "$sesh_config" ]; then
        return 1
    fi

    # Check exact name first
    if grep -q "^name = \"${name}\"" "$sesh_config" 2>/dev/null; then
        return 0
    fi

    # Check if there's a toml entry that matches this name (with emoji prefix)
    # Extract the base name without emoji and check for matches
    local base_name=$(echo "$name" | sed -E 's/^[[:space:]]*[^[:alnum:]~\/\._-]+[[:space:]]*//')
    if grep -E "^name = \"[^\"]*${base_name}\"" "$sesh_config" 2>/dev/null | grep -q "$base_name"; then
        return 0
    fi

    return 1
}

# Detect session type from session name
# Usage: detect_session_type <session_name>
# Returns: "tmux", "tmuxinator", "sesh_custom", "directory", or "unknown"
# Extracted from: sesh_list_enhanced.sh (lines 757-781) and sesh_preview_fast.sh
detect_session_type() {
    local session_name="$1"
    local expanded_session="${session_name/#\~/$HOME}"

    # Check if it's an active tmux session
    if tmux has-session -t "$session_name" 2>/dev/null; then
        echo "tmux"
        return
    fi

    # Check if it's a tmuxinator project
    if [ -f "${TMUXINATOR_CONFIG_DIR}/${session_name}.yml" ]; then
        echo "tmuxinator"
        return
    fi

    # Check if it's a custom sesh.toml session BEFORE checking directory
    # (because a path might both be a sesh.toml entry AND a valid directory)
    local sesh_path=$(get_sesh_toml_path "$session_name")
    if [ -n "$sesh_path" ] && [ -d "$sesh_path" ]; then
        echo "sesh_custom"
        return
    fi

    # Check if it's a directory
    if [ -d "$expanded_session" ]; then
        echo "directory"
        return
    fi

    # Unknown type
    echo "unknown"
}

# Get list of active tmux sessions
# Usage: get_active_sessions
# Returns: Array of active tmux session names (one per line)
# Extracted from: sesh_list_enhanced.sh (lines 197-206)
get_active_sessions() {
    tmux list-sessions -F '#{session_name}' 2>/dev/null || true
}

# ============================================================================
# EXPORTED FUNCTIONS SUMMARY
# ============================================================================
# This module exports the following functions for use in other sesh scripts:
#
# Time & Formatting:
#   - human_time()           - Convert seconds to human-readable format
#
# Session Name Processing:
#   - clean_session_name()   - Clean ANSI codes, icons, metadata from session names
#
# Session Detection:
#   - detect_session_type()  - Identify session type (tmux/tmuxinator/sesh/dir)
#   - is_sesh_toml_session() - Check if session is in sesh.toml
#   - get_sesh_toml_path()   - Extract path from sesh.toml
#   - get_active_sessions()  - Get list of active tmux sessions
#
# Error Handling:
#   - error_handler()        - Log errors with context
#   - cleanup_handler()      - Run cleanup on exit
#   - setup_error_handling() - Initialize error traps
#
# Utilities:
#   - has_command()          - Check if command exists
#   - list_directory()       - Get directory listing with fallback
#
# Configuration Constants:
#   - SESH_CONFIG            - Path to sesh.toml
#   - SESH_SCRIPTS_DIR       - Path to sesh scripts directory
#   - TMUXINATOR_CONFIG_DIR  - Path to tmuxinator configs
#   - SESH_DISPLAY_MODE_FILE - Display mode toggle file
#   - SESH_CACHE_FILE        - Cache file path
#   - SESH_CACHE_TTL         - Cache TTL in seconds
# ============================================================================

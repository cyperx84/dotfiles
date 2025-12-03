#!/usr/bin/env bash
################################################################################
# Unified Sesh List - Consolidated Session Listing with Multi-Mode Support
################################################################################
#
# VERSION: 5.0
# DESCRIPTION:
#   Unified session listing script consolidating 5 previous list scripts:
#   - sesh_list_enhanced.sh (detailed mode with full metadata)
#   - sesh_list_lightweight.sh (compact mode - minimal output)
#   - sesh_list_cached.sh (cache support)
#   - sesh_list_wrapper.sh (display mode toggle)
#   - sesh_list_icons.sh (icon definitions - now in lib)
#
# FEATURES:
#   - Multi-mode display: compact, detailed (default)
#   - Git integration with status indicators
#   - Resource monitoring (CPU/memory)
#   - Container detection (Docker)
#   - Dev environment detection (Python/Node/Rust/Go)
#   - Activity tracking with timeline icons
#   - Smart session deduplication
#   - Flexible filtering and sorting
#   - Cache support with TTL-based invalidation
#   - Display mode toggle from ~/.sesh_display_mode
#
# USAGE:
#   sesh_list.sh [options]
#
# OPTIONS:
#   --mode=compact       Lightweight output (minimal metadata)
#   --mode=detailed      Full metadata (default)
#   --cache              Use cached results with TTL invalidation
#   --sort=activity      Sort by most recent activity (default)
#   --sort=alpha         Sort alphabetically
#   --filter=all         Show all sessions (default)
#   --filter=git         Show only git repositories
#   --filter=containers  Show only sessions with containers
#
# DEPENDENCIES:
#   - sesh_common.sh (configuration, utilities)
#   - sesh_colors.sh (color definitions)
#   - sesh_icons.sh (icon definitions)
#
# LAST MODIFIED: 2025-12-02
#
################################################################################

# ============================================================================
# DEPENDENCY LOADING
# ============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SESH_SCRIPTS_LIB="${SCRIPT_DIR}/../lib"

# Source shared libraries
source "${SESH_SCRIPTS_LIB}/sesh_common.sh"
source "${SESH_SCRIPTS_LIB}/sesh_colors.sh"
source "${SESH_SCRIPTS_LIB}/sesh_icons.sh"

# ============================================================================
# CONFIGURATION & DISPLAY MODE
# ============================================================================

# Default modes
DISPLAY_MODE="${SESH_DISPLAY_MODE:-detailed}"
SORT_MODE="${SESH_SORT_MODE:-activity}"
FILTER_MODE="${SESH_FILTER_MODE:-all}"
USE_CACHE=false

# Display mode toggle file
DISPLAY_MODE_FILE="${SESH_DISPLAY_MODE_FILE:-${HOME}/.sesh_display_mode}"

# Load display mode from file if it exists
if [ -f "$DISPLAY_MODE_FILE" ]; then
    SAVED_MODE=$(cat "$DISPLAY_MODE_FILE" 2>/dev/null)
    if [ -n "$SAVED_MODE" ]; then
        DISPLAY_MODE="$SAVED_MODE"
    fi
fi

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --mode=*)
            DISPLAY_MODE="${1#*=}"
            shift
            ;;
        --sort=*)
            SORT_MODE="${1#*=}"
            shift
            ;;
        --filter=*)
            FILTER_MODE="${1#*=}"
            shift
            ;;
        --cache)
            USE_CACHE=true
            shift
            ;;
        # Short-form flags for interactive display
        -id)
            DISPLAY_MODE="compact"
            FILTER_MODE="all"
            shift
            ;;
        -idt)
            DISPLAY_MODE="compact"
            FILTER_MODE="tmux"
            shift
            ;;
        -idc)
            DISPLAY_MODE="compact"
            FILTER_MODE="config"
            shift
            ;;
        -idz)
            DISPLAY_MODE="compact"
            FILTER_MODE="zoxide"
            shift
            ;;
        -idtm)
            DISPLAY_MODE="compact"
            FILTER_MODE="tmuxinator_and_tmux"
            shift
            ;;
        -idnz)
            DISPLAY_MODE="compact"
            FILTER_MODE="no_zoxide"
            shift
            ;;
        *)
            # Pass through to sesh
            break
            ;;
    esac
done

# ============================================================================
# CACHE SYSTEM
# ============================================================================

CACHE_FILE="${SESH_CACHE_FILE:-/tmp/sesh_list_cache}"
CACHE_TTL="${SESH_CACHE_TTL:-2}"

# Check if cache is valid
is_cache_valid() {
    [ ! -f "$CACHE_FILE" ] && return 1

    local cache_time=$(stat -f %m "$CACHE_FILE" 2>/dev/null || stat -c %Y "$CACHE_FILE" 2>/dev/null)
    local now=$(date +%s)
    local age=$((now - cache_time))

    [ "$age" -lt "$CACHE_TTL" ]
}

# Use cache if enabled and valid
if [ "$USE_CACHE" = true ] && is_cache_valid; then
    cat "$CACHE_FILE"
    exit 0
fi

# ============================================================================
# PERFORMANCE CACHE SYSTEM
# ============================================================================

declare -A CACHE_GIT_STATUS
declare -A CACHE_GIT_BRANCH
declare -A CACHE_RESOURCES
declare -A CACHE_CONTAINERS
declare -A CACHE_DEV_ENV
CACHE_TTL_INTERNAL=3  # seconds

# Cache runtime versions globally (rarely change during session)
CACHED_PYTHON_VERSION=""
CACHED_NODE_VERSION=""
CACHED_RUST_VERSION=""
CACHED_GO_VERSION=""
DOCKER_DAEMON_AVAILABLE=0

# Check docker daemon once (expensive check ~100ms)
if command -v docker &> /dev/null && docker info &>/dev/null 2>&1; then
    DOCKER_DAEMON_AVAILABLE=1
fi

if command -v python3 &> /dev/null; then
    CACHED_PYTHON_VERSION=$(python3 --version 2>&1 | grep -oE '[0-9]+\.[0-9]+' | head -1)
fi
if command -v node &> /dev/null; then
    CACHED_NODE_VERSION=$(node --version 2>&1 | grep -oE '[0-9]+\.[0-9]+' | head -1)
fi
if command -v rustc &> /dev/null; then
    CACHED_RUST_VERSION=$(rustc --version 2>&1 | grep -oE '[0-9]+\.[0-9]+' | head -1)
fi
if command -v go &> /dev/null; then
    CACHED_GO_VERSION=$(go version 2>&1 | grep -oE '[0-9]+\.[0-9]+' | head -1)
fi

# ============================================================================
# TMUX SESSION METADATA COLLECTION
# ============================================================================

# Get current attached session
CURRENT_SESSION=""
if [ -n "$TMUX" ]; then
    CURRENT_SESSION=$(tmux display-message -p '#S' 2>/dev/null)
fi

# Cache tmux sessions and metadata
declare -A tmux_sessions
declare -A session_metadata
declare -A session_activity
declare -A session_created

while IFS='|' read -r name windows activity created; do
    if [ -n "$name" ]; then
        tmux_sessions["$name"]=1
        panes=$(tmux list-panes -s -t "$name" 2>/dev/null | wc -l | tr -d ' ')
        session_metadata["$name"]="$windows,$panes"
        session_activity["$name"]="$activity"
        session_created["$name"]="$created"
    fi
done < <(tmux list-sessions -F '#{session_name}|#{session_windows}|#{session_activity}|#{session_created}' 2>/dev/null)

# ============================================================================
# GIT INTEGRATION FUNCTIONS
# ============================================================================

get_git_info() {
    local dir="$1"
    local expanded_dir="${dir/#\~/$HOME}"

    [ ! -d "$expanded_dir" ] && return
    [ ! -d "$expanded_dir/.git" ] && return

    local cache_key="$expanded_dir"
    local cache_time="${CACHE_GIT_STATUS[$cache_key]:-0}"
    local now=$(date +%s)

    # Return cached result if fresh
    if [ $((now - cache_time)) -lt $CACHE_TTL_INTERNAL ] && [ -n "${CACHE_GIT_BRANCH[$cache_key]}" ]; then
        echo "${CACHE_GIT_BRANCH[$cache_key]}"
        return
    fi

    # Quick check: is this a git repo? (faster than cd + git command)
    [ ! -d "$expanded_dir/.git" ] && ! git -C "$expanded_dir" rev-parse --git-dir &>/dev/null && return

    cd "$expanded_dir" || return

    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    [ -z "$branch" ] && return

    # Truncate branch name if too long
    [ ${#branch} -gt 15 ] && branch="${branch:0:12}..."

    # Single git status call for efficiency
    local git_status=$(git status --porcelain 2>/dev/null)

    # Use bash parameter expansion instead of grep (faster)
    local staged=0 modified=0 untracked=0 conflicts=0
    while IFS= read -r line; do
        case "$line" in
            [MADRC]*)    ((staged++)) ;;
            ?[MD]*)      ((modified++)) ;;
            \?\?*)       ((untracked++)) ;;
            UU*)         ((conflicts++)) ;;
        esac
    done <<< "$git_status"

    # Get upstream status
    local ahead="0"
    local behind="0"
    if [[ "$DISPLAY_MODE" != "compact" ]] || git rev-parse @{u} >/dev/null 2>&1; then
        ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null || echo "0")
        behind=$(git rev-list --count HEAD..@{u} 2>/dev/null || echo "0")
    fi

    # Determine status
    local status_color="$COLOR_GIT_CLEAN"
    local status_icon="$ICON_GIT_CLEAN"
    local changes=""

    if [ "$conflicts" -gt 0 ]; then
        status_color="$COLOR_GIT_CONFLICT"
        status_icon="$ICON_GIT_CONFLICT"
    elif [ "$modified" -gt 0 ] || [ "$staged" -gt 0 ] || [ "$untracked" -gt 0 ]; then
        status_color="$COLOR_GIT_DIRTY"
        status_icon="$ICON_GIT_MODIFIED"

        # Build compact change indicator
        [ "$staged" -gt 0 ] && changes="${changes}+${staged}"
        [ "$modified" -gt 0 ] && changes="${changes}~${modified}"
        [ "$untracked" -gt 0 ] && changes="${changes}?${untracked}"
    fi

    # Build upstream indicator
    local upstream=""
    if [ "$ahead" -gt 0 ] && [ "$behind" -gt 0 ]; then
        upstream=" ${ICON_GIT_DIVERGED}"
        status_color="$COLOR_GIT_BEHIND"
    elif [ "$ahead" -gt 0 ]; then
        upstream=" ${ICON_GIT_AHEAD}${ahead}"
        status_color="$COLOR_GIT_AHEAD"
    elif [ "$behind" -gt 0 ]; then
        upstream=" ${ICON_GIT_BEHIND}${behind}"
        status_color="$COLOR_GIT_BEHIND"
    fi

    # Build output based on display mode
    local output=""
    case "$DISPLAY_MODE" in
        compact)
            output=" ${status_color}${branch}${COLOR_RESET}"
            [ -n "$upstream" ] && output="${output}${upstream}"
            ;;
        detailed)
            output=" ${status_color}${branch}${COLOR_RESET}"
            [ -n "$upstream" ] && output="${output}${upstream}"
            [ -n "$changes" ] && output="${output} ${changes}"
            ;;
    esac

    # Cache result
    CACHE_GIT_STATUS[$cache_key]=$now
    CACHE_GIT_BRANCH[$cache_key]="$output"

    echo "$output"
}

# ============================================================================
# RESOURCE MONITORING FUNCTIONS
# ============================================================================

get_session_resources() {
    local session_name="$1"

    # Check cache (longer TTL for resources - 5 seconds)
    local cache_key="$session_name"
    local cache_time="${CACHE_RESOURCES[$cache_key]:-0}"
    local now=$(date +%s)

    if [ $((now - cache_time)) -lt 5 ] && [ -n "${CACHE_RESOURCES[$cache_key]}" ]; then
        echo "${CACHE_RESOURCES[$cache_key]}"
        return
    fi

    local pids=$(tmux list-panes -s -t "$session_name" -F '#{pane_pid}' 2>/dev/null)
    [ -z "$pids" ] && return

    # Get direct pane processes
    local ps_output=$(ps -p $(echo $pids | tr ' ' ',') -o %cpu=,rss= 2>/dev/null)

    local parent_cpu=$(echo "$ps_output" | awk '{sum+=$1} END {print sum}')
    local parent_mem=$(echo "$ps_output" | awk '{sum+=$2} END {print sum}')

    local parent_cpu_int=$(printf "%.0f" "${parent_cpu:-0}" 2>/dev/null || echo "0")
    local parent_mem_mb=$((${parent_mem:-0} / 1024))

    local total_cpu=$parent_cpu
    local total_mem=$parent_mem

    # Only scan children if parent shows activity
    if [ "$parent_cpu_int" -gt 2 ] || [ "$parent_mem_mb" -gt 50 ]; then
        for pid in $pids; do
            local child_pids=$(pgrep -P "$pid" 2>/dev/null)
            if [ -n "$child_pids" ]; then
                local child_ps=$(ps -p $(echo $child_pids | tr ' ' ',') -o %cpu=,rss= 2>/dev/null)
                local child_cpu=$(echo "$child_ps" | awk '{sum+=$1} END {print sum}')
                local child_mem=$(echo "$child_ps" | awk '{sum+=$2} END {print sum}')
                total_cpu=$(echo "$total_cpu + ${child_cpu:-0}" | bc 2>/dev/null || echo "$total_cpu")
                total_mem=$((total_mem + ${child_mem:-0}))
            fi
        done
    fi

    # Convert memory to MB/GB
    local mem_mb=$((total_mem / 1024))
    local mem_display
    if [ $mem_mb -gt 1024 ]; then
        mem_display="$(echo "scale=1; $mem_mb / 1024" | bc)GB"
    else
        mem_display="${mem_mb}MB"
    fi

    local cpu_int=$(printf "%.0f" "$total_cpu" 2>/dev/null || echo "0")

    # Determine color based on thresholds
    local cpu_color="$COLOR_RESOURCE_LOW"
    if [ "$cpu_int" -ge 90 ]; then
        cpu_color="$COLOR_RESOURCE_CRIT"
    elif [ "$cpu_int" -ge 70 ]; then
        cpu_color="$COLOR_RESOURCE_HIGH"
    elif [ "$cpu_int" -ge 30 ]; then
        cpu_color="$COLOR_RESOURCE_MED"
    fi

    local mem_color="$COLOR_RESOURCE_LOW"
    if [ $mem_mb -gt 4096 ]; then
        mem_color="$COLOR_RESOURCE_CRIT"
    elif [ $mem_mb -gt 2048 ]; then
        mem_color="$COLOR_RESOURCE_HIGH"
    elif [ $mem_mb -gt 512 ]; then
        mem_color="$COLOR_RESOURCE_MED"
    fi

    # Build output based on display mode
    local output=""

    # Only show if significant resource usage
    if [ "$cpu_int" -gt 5 ] || [ $mem_mb -gt 100 ]; then
        case "$DISPLAY_MODE" in
            compact)
                output=" ${cpu_color}CPU:${cpu_int}%${COLOR_RESET}"
                ;;
            detailed)
                output=" ${cpu_color}CPU:${cpu_int}%${COLOR_RESET} ${mem_color}MEM:${mem_display}${COLOR_RESET}"
                ;;
        esac
    fi

    # Cache result
    CACHE_RESOURCES[$cache_key]="$output"

    echo "$output"
}

# ============================================================================
# CONTAINER & SERVICE DETECTION FUNCTIONS
# ============================================================================

get_container_info() {
    local session_name="$1"
    local dir="$2"

    # Check cache
    local cache_key="$session_name"
    local cache_time="${CACHE_CONTAINERS[$cache_key]:-0}"
    local now=$(date +%s)

    if [ $((now - cache_time)) -lt 10 ] && [ -n "${CACHE_CONTAINERS[$cache_key]}" ]; then
        echo "${CACHE_CONTAINERS[$cache_key]}"
        return
    fi

    local output=""

    # Use cached docker daemon status (checked once at startup)
    if [ "$DOCKER_DAEMON_AVAILABLE" -eq 1 ]; then
        local expanded_dir="${dir/#\~/$HOME}"

        if [ -f "$expanded_dir/docker-compose.yml" ] || [ -f "$expanded_dir/compose.yml" ]; then
            local compose_running=$(docker compose -f "$expanded_dir/docker-compose.yml" ps -q 2>/dev/null | wc -l | tr -d ' ')
            if [ "$compose_running" -gt 0 ]; then
                local color="$COLOR_NEON_BLUE"
                [ "$compose_running" -gt 3 ] && color="$COLOR_NEON_YELLOW"
                output=" ${color}${ICON_DOCKER}${compose_running}${COLOR_RESET}"
            fi
        fi
    fi

    # Only check dev servers if no docker containers found
    if [ -z "$output" ]; then
        local pids=$(tmux list-panes -s -t "$session_name" -F '#{pane_pid}' 2>/dev/null)
        local all_child_pids=$(pgrep -P $(echo $pids | tr ' ' ',') 2>/dev/null)
        if [ -n "$all_child_pids" ]; then
            local procs=$(ps -p $(echo $all_child_pids | tr ' ' ',') -o comm= 2>/dev/null)
            if echo "$procs" | grep -qE "(vite|next-server|webpack|parcel|trunk|cargo-watch|flask|django|uvicorn)"; then
                output=" ${COLOR_NEON_GREEN}${ICON_SERVER}${COLOR_RESET}"
            fi
        fi
    fi

    # Cache result
    CACHE_CONTAINERS[$cache_key]="$output"

    echo "$output"
}

# ============================================================================
# DEVELOPMENT ENVIRONMENT DETECTION FUNCTIONS
# ============================================================================

get_dev_env_info() {
    local dir="$1"
    local session_name="$2"
    local expanded_dir="${dir/#\~/$HOME}"

    [ ! -d "$expanded_dir" ] && return

    # Check cache
    local cache_key="$expanded_dir"
    local cache_time="${CACHE_DEV_ENV[$cache_key]:-0}"
    local now=$(date +%s)

    if [ $((now - cache_time)) -lt 10 ] && [ -n "${CACHE_DEV_ENV[$cache_key]}" ]; then
        echo "${CACHE_DEV_ENV[$cache_key]}"
        return
    fi

    local output=""

    # Python virtual environment
    if [ -d "$expanded_dir/.venv" ] || [ -d "$expanded_dir/venv" ] || [ -n "$VIRTUAL_ENV" ]; then
        if [ -n "$CACHED_PYTHON_VERSION" ]; then
            output=" ${COLOR_NEON_YELLOW}${ICON_PYTHON}${CACHED_PYTHON_VERSION}${COLOR_RESET}"
        else
            output=" ${COLOR_NEON_YELLOW}${ICON_PYTHON}venv${COLOR_RESET}"
        fi
    fi

    # Node.js environment
    if [ -f "$expanded_dir/package.json" ] && [ -z "$output" ]; then
        local node_version=""
        if [ -f "$expanded_dir/.nvmrc" ]; then
            node_version=$(cat "$expanded_dir/.nvmrc" | grep -oE '[0-9]+\.[0-9]+' | head -1)
        else
            node_version="$CACHED_NODE_VERSION"
        fi
        if [ -n "$node_version" ]; then
            output=" ${COLOR_NEON_BLUE}${ICON_NODE}${node_version}${COLOR_RESET}"
        fi
    fi

    # Rust environment
    if [ -f "$expanded_dir/Cargo.toml" ] && [ -z "$output" ]; then
        if [ -n "$CACHED_RUST_VERSION" ]; then
            output=" ${COLOR_NEON_ORANGE}${ICON_RUST}${CACHED_RUST_VERSION}${COLOR_RESET}"
        fi
    fi

    # Go environment
    if [ -f "$expanded_dir/go.mod" ] && [ -z "$output" ]; then
        if [ -n "$CACHED_GO_VERSION" ]; then
            output=" ${COLOR_NEON_GREEN}${ICON_GO}${CACHED_GO_VERSION}${COLOR_RESET}"
        fi
    fi

    # Cache result
    CACHE_DEV_ENV[$cache_key]="$output"

    echo "$output"
}

# ============================================================================
# PROJECT TYPE DETECTION
# ============================================================================

detect_project_type() {
    local dir="$1"
    local expanded_dir="${dir/#\~/$HOME}"

    [ ! -d "$expanded_dir" ] && return

    local icons=""

    # Check for project markers
    if [ -f "$expanded_dir/package.json" ]; then
        icons="${icons} ${ICON_NODE}"
    elif [ -f "$expanded_dir/Cargo.toml" ]; then
        icons="${icons} ${ICON_RUST}"
    elif [ -f "$expanded_dir/go.mod" ]; then
        icons="${icons} ${ICON_GO}"
    elif [ -f "$expanded_dir/requirements.txt" ] || [ -f "$expanded_dir/pyproject.toml" ] || [ -f "$expanded_dir/setup.py" ]; then
        icons="${icons} ${ICON_PYTHON}"
    elif [ -f "$expanded_dir/docker-compose.yml" ] || [ -f "$expanded_dir/Dockerfile" ]; then
        icons="${icons} ${ICON_DOCKER}"
    fi

    # Check if git repo
    if [ -d "$expanded_dir/.git" ]; then
        icons="${icons} ${ICON_GIT}"
    fi

    echo "$icons"
}

# ============================================================================
# ACTIVITY TRACKING
# ============================================================================

get_activity_indicator() {
    local session_name="$1"
    local last_activity="${session_activity[$session_name]}"

    [ -z "$last_activity" ] && return

    local now=$(date +%s)
    local idle_seconds=$((now - last_activity))

    local icon=""
    local time_str=""

    # Determine icon and time string
    if [ "$idle_seconds" -lt 3600 ]; then
        icon="$ICON_HOT"
        local minutes=$((idle_seconds / 60))
        time_str="${minutes}m ago"
    elif [ "$idle_seconds" -lt 86400 ]; then
        icon="$ICON_RECENT"
        local hours=$((idle_seconds / 3600))
        time_str="${hours}h ago"
    elif [ "$idle_seconds" -lt 604800 ]; then
        icon="$ICON_IDLE"
        local days=$((idle_seconds / 86400))
        time_str="${days}d ago"
    elif [ "$idle_seconds" -lt 2592000 ]; then
        icon="$ICON_SLEEPING"
        local weeks=$((idle_seconds / 604800))
        time_str="${weeks}w ago"
    else
        icon="$ICON_ARCHIVED"
        local months=$((idle_seconds / 2592000))
        time_str="${months}mo ago"
    fi

    # Only show icon for quick switching
    echo " $icon"
}

# ============================================================================
# CLAUDE CODE STATUS TRACKING
# ============================================================================

# Get Claude Code instances running in a tmux session
# Reads status files from ~/.cache/claude-sessions/ created by Claude Code hooks
# Returns compact format: [C:2*1.] = 2 thinking, 1 waiting
get_claude_info() {
    local session_name="$1"
    local status_dir="${HOME}/.cache/claude-sessions"

    # Skip if no status directory
    [ ! -d "$status_dir" ] && return

    local thinking_count=0
    local waiting_count=0

    # Read all Claude status files
    for status_file in "$status_dir"/claude-*.json; do
        [ ! -f "$status_file" ] && continue

        # Parse the status file (single jq call for efficiency)
        read -r tmux_session state pid < <(jq -r '[.tmux_session // "", .state // "", .pid // ""] | @tsv' "$status_file" 2>/dev/null)

        # Only count if this Claude instance is in the current tmux session
        if [ "$tmux_session" = "$session_name" ]; then
            # Verify the process is still running (cleanup stale files)
            if [ -n "$pid" ] && ! kill -0 "$pid" 2>/dev/null; then
                rm -f "$status_file" 2>/dev/null
                continue
            fi

            case "$state" in
                thinking) ((thinking_count++)) ;;
                waiting) ((waiting_count++)) ;;
            esac
        fi
    done

    # Build compact output: ⚡2⏸1 or ⚡2 or ⏸1
    if [ "$thinking_count" -gt 0 ] || [ "$waiting_count" -gt 0 ]; then
        local status=""
        [ "$thinking_count" -gt 0 ] && status="⚡${thinking_count}"
        [ "$waiting_count" -gt 0 ] && status="${status}⏸${waiting_count}"
        echo " ${COLOR_NEON_MAGENTA}${status}${COLOR_RESET}"
    fi
}

# ============================================================================
# SESSION METADATA FUNCTIONS
# ============================================================================

get_session_metadata() {
    local session_name="$1"
    local metadata="${session_metadata[$session_name]}"

    [ -z "$metadata" ] && return

    IFS=',' read -r windows panes <<< "$metadata"

    # Return empty string - window/pane count not needed for quick switching
    # case "$DISPLAY_MODE" in
    #     compact)
    #         echo " ${COLOR_GRAY}(${windows}w ${panes}p)${COLOR_RESET}"
    #         ;;
    #     detailed)
    #         echo " ${COLOR_GRAY}(${windows}w ${panes}p)${COLOR_RESET}"
    #         ;;
    # esac
    echo ""
}

# ============================================================================
# SORTING FUNCTIONS
# ============================================================================

sort_sessions() {
    local temp_file="$1"

    case "$SORT_MODE" in
        activity)
            # Most recently used first (default - no sorting needed)
            cat "$temp_file"
            ;;
        alpha)
            # Alphabetical A-Z
            sort "$temp_file"
            ;;
        *)
            cat "$temp_file"
            ;;
    esac
}

# ============================================================================
# MAIN SESSION PROCESSING LOOP
# ============================================================================

# Create temporary file for collecting sessions
TEMP_SESSIONS=$(mktemp)
trap "rm -f $TEMP_SESSIONS" EXIT

# Global deduplication cache
declare -A seen_sessions

# Process sesh list output
sesh list "$@" | while IFS= read -r session; do
    # Detect sesh entry type from ANSI color code
    sesh_type="unknown"
    case "$session" in
        *"[33m"*) sesh_type="tmuxinator" ;;
        *"[34m"*) sesh_type="tmux" ;;
        *"[36m"*) sesh_type="directory" ;;
        *"[90m"*) sesh_type="config" ;;
    esac

    # Strip ANSI codes and icons
    clean_session=$(echo "$session" | sed 's/\x1b\[[0-9;]*m//g' | sed 's/\[[0-9;]*m//g')
    clean_session=$(echo "$clean_session" | sed -E 's/^[◆●◉◯📁▪▣][[:space:]]*//')
    clean_session=$(echo "$clean_session" | xargs)

    [ -z "$clean_session" ] && continue

    # Create deduplication key
    dedup_key=$(echo "$clean_session" | sed -E 's/^[[:space:]]*[^[:alnum:]~\/\._-]+[[:space:]]*//' | xargs)
    dedup_normalized=$(echo "$dedup_key" | sed 's|^~/||')

    # Global deduplication
    if [[ -n "${seen_sessions[$dedup_key]}" ]] || [[ -n "${seen_sessions[$dedup_normalized]}" ]]; then
        continue
    fi

    # Blacklist filtering
    case "$clean_session" in
        "/Users"|"/"|"/dev"|"/usr/bin"|"/Library/Preferences"|"/Library/LaunchDaemons"|*.cache*|*node_modules*|*.Trash*|*.DS_Store*)
            continue
            ;;
    esac

    # Determine session type
    is_tmux_session=false
    is_tmuxinator=false
    is_directory=false
    is_custom=false

    if [[ "$sesh_type" == "tmux" ]] || [[ -n "${tmux_sessions[$clean_session]}" ]] || [[ -n "${tmux_sessions[$dedup_key]}" ]]; then
        is_tmux_session=true
    elif [[ "$sesh_type" == "tmuxinator" ]] || [ -f "$HOME/.config/tmuxinator/${clean_session}.yml" ]; then
        is_tmuxinator=true
        [[ -n "${tmux_sessions[$clean_session]}" ]] && continue
        [[ -n "${tmux_sessions[$dedup_key]}" ]] && continue
    elif [[ "$sesh_type" == "config" ]] || is_sesh_toml_session "$clean_session"; then
        is_custom=true
        [[ -n "${tmux_sessions[$clean_session]}" ]] && continue
        [[ -n "${tmux_sessions[$dedup_key]}" ]] && continue
    elif [[ "$sesh_type" == "directory" ]] || [ -d "${clean_session/#\~/$HOME}" ]; then
        is_directory=true
        is_sesh_toml_session "$dedup_normalized" && continue
        [ -f "$HOME/.config/tmuxinator/${dedup_key}.yml" ] && continue
    fi

    # Apply filtering
    case "$FILTER_MODE" in
        tmux)
            [[ "$is_tmux_session" == true ]] || continue
            ;;
        tmuxinator)
            [[ "$is_tmuxinator" == true ]] || continue
            ;;
        config)
            [[ "$is_custom" == true ]] || continue
            ;;
        zoxide)
            [[ "$is_directory" == true ]] || continue
            ;;
        tmuxinator_and_tmux)
            [[ "$is_tmux_session" == true ]] || [[ "$is_tmuxinator" == true ]] || continue
            ;;
        no_zoxide)
            [[ "$is_directory" == true ]] && continue
            ;;
        git)
            expanded_session="${clean_session/#\~/$HOME}"
            [ -d "$expanded_session/.git" ] || continue
            ;;
        containers)
            expanded_session="${clean_session/#\~/$HOME}"
            [ -f "$expanded_session/docker-compose.yml" ] || [ -f "$expanded_session/Dockerfile" ] || continue
            ;;
        all|*)
            ;;
    esac

    # Mark as seen
    seen_sessions["$dedup_key"]=1
    seen_sessions["$dedup_normalized"]=1

    # Build output
    if [[ "$is_tmux_session" == true ]]; then
        # Active tmux sessions
        activity_icon=$(get_activity_indicator "$clean_session")
        metadata=$(get_session_metadata "$clean_session")

        git_info=""
        resources=""
        containers=""
        dev_env=""
        claude_info=""

        # Always show Claude status (important to see at a glance)
        claude_info=$(get_claude_info "$clean_session")

        if [[ "$DISPLAY_MODE" == "detailed" ]]; then
            git_info=$(get_git_info "$clean_session")
            resources=$(get_session_resources "$clean_session")
            containers=$(get_container_info "$clean_session" "$clean_session")
            dev_env=$(get_dev_env_info "$clean_session" "$clean_session")
        fi

        # Check if stale
        last_activity="${session_activity[$clean_session]}"
        is_stale=false
        if [ -n "$last_activity" ]; then
            now=$(date +%s)
            idle_seconds=$((now - last_activity))
            [ "$idle_seconds" -gt 86400 ] && is_stale=true
        fi

        # Build output line
        if [[ "$clean_session" == "$CURRENT_SESSION" ]]; then
            echo -e "${COLOR_ATTACHED}${ICON_ATTACHED} ${clean_session}${COLOR_RESET}${git_info}${activity_icon}${resources}${containers}${dev_env}${claude_info}${metadata}"
        elif [ "$is_stale" = true ]; then
            echo -e "${COLOR_STALE}${ICON_ACTIVE} ${clean_session}${COLOR_RESET}${git_info}${activity_icon}${resources}${containers}${dev_env}${claude_info}${metadata}"
        else
            echo -e "${COLOR_ACTIVE}${ICON_ACTIVE} ${clean_session}${COLOR_RESET}${git_info}${activity_icon}${resources}${containers}${dev_env}${claude_info}${metadata}"
        fi

    elif [[ "$is_tmuxinator" == true ]]; then
        # Tmuxinator projects
        tmuxinator_root=$(grep "^root:" "$HOME/.config/tmuxinator/${clean_session}.yml" 2>/dev/null | sed 's/root: *//' | sed "s|~|$HOME|" | tr -d '"' | tr -d "'")
        project_icons=$(detect_project_type "$tmuxinator_root")

        echo -e "${COLOR_TMUXINATOR}${ICON_TMUXINATOR} ${clean_session}${COLOR_RESET}${project_icons}"

    elif [[ "$is_custom" == true ]]; then
        # Custom sesh sessions
        echo -e "${COLOR_NEON_BLUE}${ICON_SESH_CUSTOM} ${clean_session}${COLOR_RESET}"

    elif [[ "$is_directory" == true ]]; then
        # Zoxide directories
        project_icons=$(detect_project_type "$clean_session")

        echo -e "${COLOR_DIRECTORY}${ICON_DIRECTORY} ${clean_session}${COLOR_RESET}${project_icons}"
    else
        # Unknown type
        echo "${clean_session}"
    fi
done >> "$TEMP_SESSIONS"

# Apply sorting and output
OUTPUT=$(sort_sessions "$TEMP_SESSIONS")

# Save to cache if enabled
if [ "$USE_CACHE" = true ]; then
    echo "$OUTPUT" > "$CACHE_FILE"
fi

# Display output
echo "$OUTPUT"

#!/usr/bin/env bash

# Enhanced Sesh List - Maximum Edition
# Version: 4.0 - All-in with CyperX Neon Theme
# Features: Multi-mode display, git integration, resource monitoring, container detection,
#           dev environment detection, smart sorting, enhanced activity tracking

# ============================================================================
# CONFIGURATION & DISPLAY MODE
# ============================================================================

# Display modes: compact, detailed, rich
DISPLAY_MODE="${SESH_DISPLAY_MODE:-compact}"
SORT_MODE="${SESH_SORT_MODE:-activity}"  # activity, resources, windows, alpha
FILTER_MODE="${SESH_FILTER_MODE:-all}"   # all, git, containers, resources

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
        # Short-form flags for interactive display
        -id)
            # Interactive display, all sessions
            DISPLAY_MODE="compact"
            FILTER_MODE="all"
            shift
            ;;
        -idt)
            # Interactive display, tmux sessions only
            DISPLAY_MODE="compact"
            FILTER_MODE="tmux"
            shift
            ;;
        -idc)
            # Interactive display, config sessions only
            DISPLAY_MODE="compact"
            FILTER_MODE="config"
            shift
            ;;
        -idz)
            # Interactive display, zoxide sessions only
            DISPLAY_MODE="compact"
            FILTER_MODE="zoxide"
            shift
            ;;
        -idtm)
            # Interactive display, tmux + tmuxinator sessions (exclude zoxide)
            DISPLAY_MODE="compact"
            FILTER_MODE="tmuxinator_and_tmux"
            shift
            ;;
        -idnz)
            # Interactive display, all sessions except zoxide
            DISPLAY_MODE="compact"
            FILTER_MODE="no_zoxide"
            shift
            ;;
        *)
            break
            ;;
    esac
done

# ============================================================================
# CYPERX NEON COLOR PALETTE (Terminal ANSI Codes)
# ============================================================================

# Primary CyperX colors (converted from hex for terminal use)
COLOR_NEON_GREEN='\033[38;2;128;255;0m'     # 0xff80ff00 - Electric green
COLOR_NEON_RED='\033[38;2;255;0;31m'        # 0xffff001f - Vibrant red
COLOR_NEON_BLUE='\033[38;2;0;42;255m'       # 0xff002aff - Electric blue
COLOR_NEON_ORANGE='\033[38;2;255;107;0m'    # 0xffff6b00 - Bright orange
COLOR_NEON_YELLOW='\033[38;2;241;252;121m'  # 0xfff1fc79 - Soft yellow
COLOR_NEON_MAGENTA='\033[38;2;164;140;242m' # 0xffa48cf2 - Purple-magenta
COLOR_GRAY='\033[38;2;50;52;73m'            # 0xff323449 - Stale gray
COLOR_WHITE='\033[38;2;255;255;255m'        # 0xffffffff - White text
COLOR_RESET='\033[0m'

# Status-based colors (semantic mapping)
COLOR_ACTIVE="$COLOR_NEON_GREEN"       # Active sessions, healthy state
COLOR_ATTACHED="$COLOR_NEON_GREEN"     # Currently attached
COLOR_TMUXINATOR="$COLOR_NEON_MAGENTA" # Tmuxinator projects
COLOR_DIRECTORY="$COLOR_NEON_YELLOW"   # Directories/zoxide
COLOR_STALE="$COLOR_GRAY"              # Stale sessions

# Git status colors
COLOR_GIT_CLEAN="$COLOR_NEON_GREEN"    # Clean repository
COLOR_GIT_DIRTY="$COLOR_NEON_YELLOW"   # Uncommitted changes
COLOR_GIT_CONFLICT="$COLOR_NEON_RED"   # Merge conflicts
COLOR_GIT_AHEAD="$COLOR_NEON_BLUE"     # Ahead of upstream
COLOR_GIT_BEHIND="$COLOR_NEON_ORANGE"  # Behind upstream

# Resource threshold colors
COLOR_RESOURCE_LOW="$COLOR_NEON_GREEN"    # <30% usage
COLOR_RESOURCE_MED="$COLOR_NEON_YELLOW"   # 30-70% usage
COLOR_RESOURCE_HIGH="$COLOR_NEON_ORANGE"  # 70-90% usage
COLOR_RESOURCE_CRIT="$COLOR_NEON_RED"     # >90% usage

# ============================================================================
# ICON SYSTEM - Nerd Fonts + Strategic Emoji
# ============================================================================

# Session type icons
ICON_ATTACHED='●'       # Currently attached session
ICON_ACTIVE='◉'         # Active tmux session (not attached)
ICON_TMUXINATOR='◆'     # Tmuxinator project
ICON_DIRECTORY='📁'     # Directory/zoxide entry

# Activity timeline icons
ICON_HOT='🔥'          # Active <1h
ICON_RECENT='✓'        # Used <24h
ICON_IDLE='⏰'         # Stale 1d-7d
ICON_SLEEPING='💤'     # Sleeping >7d
ICON_ARCHIVED='📦'     # Archived >30d

# Git status icons
ICON_GIT_CLEAN='✓'     # Clean repo
ICON_GIT_AHEAD='▴'     # Ahead of upstream
ICON_GIT_BEHIND='▿'    # Behind upstream
ICON_GIT_DIVERGED='⇅'  # Diverged
ICON_GIT_STAGED='▪'    # Staged changes
ICON_GIT_MODIFIED='●'  # Modified files
ICON_GIT_CONFLICT='◪'  # Merge conflicts
ICON_GIT=''          # Generic git repo

# Project type icons
ICON_NODE='⚛️'         # Node.js/JavaScript
ICON_PYTHON='🐍'       # Python
ICON_RUST='🦀'         # Rust
ICON_GO='🐹'           # Go
ICON_DOCKER='🐳'       # Docker
ICON_SERVER='󰚌'        # Dev server running

# Resource icons
ICON_CPU='⚡'          # CPU usage
ICON_MEM='💾'          # Memory usage
ICON_NETWORK='🌐'      # Network activity

# ============================================================================
# CACHE SYSTEM FOR PERFORMANCE
# ============================================================================

declare -A CACHE_GIT_STATUS
declare -A CACHE_GIT_BRANCH
declare -A CACHE_RESOURCES
declare -A CACHE_CONTAINERS
declare -A CACHE_DEV_ENV
CACHE_TTL=3  # seconds

# OPTIMIZATION: Cache runtime versions globally (they rarely change during a session)
CACHED_PYTHON_VERSION=""
CACHED_NODE_VERSION=""
CACHED_RUST_VERSION=""
CACHED_GO_VERSION=""

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
        # Count panes for this session
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
    if [ $((now - cache_time)) -lt $CACHE_TTL ] && [ -n "${CACHE_GIT_BRANCH[$cache_key]}" ]; then
        echo "${CACHE_GIT_BRANCH[$cache_key]}"
        return
    fi

    # Get git information (optimized - single git status call instead of multiple)
    cd "$expanded_dir" || return

    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    [ -z "$branch" ] && return

    # Truncate branch name if too long
    if [ ${#branch} -gt 15 ]; then
        branch="${branch:0:12}..."
    fi

    # OPTIMIZATION: Use single git status --porcelain instead of multiple diff/ls-files calls
    local git_status=$(git status --porcelain 2>/dev/null)
    local staged=$(echo "$git_status" | grep -c '^[MADRC]' 2>/dev/null || echo "0")
    local modified=$(echo "$git_status" | grep -c '^.[MD]' 2>/dev/null || echo "0")
    local untracked=$(echo "$git_status" | grep -c '^??' 2>/dev/null || echo "0")
    local conflicts=$(echo "$git_status" | grep -c '^UU' 2>/dev/null || echo "0")

    # Get upstream status (only if needed for display)
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

    # Build final output based on display mode
    local output=""
    case "$DISPLAY_MODE" in
        compact)
            output=" ${status_color}${branch}${COLOR_RESET}"
            [ -n "$upstream" ] && output="${output}${upstream}"
            [ -n "$changes" ] && output="${output} ${changes}"
            ;;
        detailed)
            output=" ${status_color}${branch}${COLOR_RESET}"
            [ -n "$upstream" ] && output="${output}${upstream}"
            [ -n "$changes" ] && output="${output} ${changes}"
            ;;
        rich)
            output=" ${ICON_GIT} ${status_color}${branch}${COLOR_RESET}"
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

    # OPTIMIZATION: Get all PIDs for this session in one call
    local pids=$(tmux list-panes -s -t "$session_name" -F '#{pane_pid}' 2>/dev/null)
    [ -z "$pids" ] && return

    # OPTIMIZATION: Use ps with all PIDs at once instead of looping
    # Get direct pane processes first
    local ps_output=$(ps -p $(echo $pids | tr ' ' ',') -o %cpu=,rss= 2>/dev/null)

    # Quick check: if parent processes are idle, skip expensive child scanning
    local parent_cpu=$(echo "$ps_output" | awk '{sum+=$1} END {print sum}')
    local parent_mem=$(echo "$ps_output" | awk '{sum+=$2} END {print sum}')

    # If parents are very idle (<2% CPU and <50MB), skip child process scanning
    local parent_cpu_int=$(printf "%.0f" "${parent_cpu:-0}" 2>/dev/null || echo "0")
    local parent_mem_mb=$((${parent_mem:-0} / 1024))

    local total_cpu=$parent_cpu
    local total_mem=$parent_mem

    # Only scan children if parent shows activity
    if [ "$parent_cpu_int" -gt 2 ] || [ "$parent_mem_mb" -gt 50 ]; then
        # Get child processes (still expensive but only when needed)
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

    # Round CPU to integer
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
            rich)
                output=" ${ICON_CPU}${cpu_color}${cpu_int}%${COLOR_RESET} ${ICON_MEM}${mem_color}${mem_display}${COLOR_RESET}"
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

    # Check cache (longer TTL - containers don't change that frequently)
    local cache_key="$session_name"
    local cache_time="${CACHE_CONTAINERS[$cache_key]:-0}"
    local now=$(date +%s)

    if [ $((now - cache_time)) -lt 10 ] && [ -n "${CACHE_CONTAINERS[$cache_key]}" ]; then
        echo "${CACHE_CONTAINERS[$cache_key]}"
        return
    fi

    local output=""

    # OPTIMIZATION: Quick docker daemon check before expensive operations
    if command -v docker &> /dev/null && docker info &>/dev/null; then
        local expanded_dir="${dir/#\~/$HOME}"

        # Quick compose file check (cheap)
        if [ -f "$expanded_dir/docker-compose.yml" ] || [ -f "$expanded_dir/compose.yml" ]; then
            # Check if compose is running (only if files exist)
            local compose_running=$(docker compose -f "$expanded_dir/docker-compose.yml" ps -q 2>/dev/null | wc -l | tr -d ' ')
            if [ "$compose_running" -gt 0 ]; then
                local color="$COLOR_NEON_BLUE"
                [ "$compose_running" -gt 3 ] && color="$COLOR_NEON_YELLOW"
                output=" ${color}${ICON_DOCKER}×${compose_running}${COLOR_RESET}"
            fi
        fi
    fi

    # OPTIMIZATION: Only check dev servers if no docker containers found
    if [ -z "$output" ]; then
        # Get PIDs once
        local pids=$(tmux list-panes -s -t "$session_name" -F '#{pane_pid}' 2>/dev/null)

        # OPTIMIZATION: Single ps call for all pids instead of per-pid pgrep
        local all_child_pids=$(pgrep -P $(echo $pids | tr ' ' ',') 2>/dev/null)
        if [ -n "$all_child_pids" ]; then
            local procs=$(ps -p $(echo $all_child_pids | tr ' ' ',') -o comm= 2>/dev/null)

            # Check for common dev servers
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

    # Check cache (longer TTL - 10 seconds)
    local cache_key="$expanded_dir"
    local cache_time="${CACHE_DEV_ENV[$cache_key]:-0}"
    local now=$(date +%s)

    if [ $((now - cache_time)) -lt 10 ] && [ -n "${CACHE_DEV_ENV[$cache_key]}" ]; then
        echo "${CACHE_DEV_ENV[$cache_key]}"
        return
    fi

    local output=""

    # OPTIMIZATION: Python virtual environment - use cached version
    if [ -d "$expanded_dir/.venv" ] || [ -d "$expanded_dir/venv" ] || [ -n "$VIRTUAL_ENV" ]; then
        if [ -n "$CACHED_PYTHON_VERSION" ]; then
            output=" ${COLOR_NEON_YELLOW}${ICON_PYTHON}${CACHED_PYTHON_VERSION}${COLOR_RESET}"
        else
            output=" ${COLOR_NEON_YELLOW}${ICON_PYTHON}venv${COLOR_RESET}"
        fi
    fi

    # OPTIMIZATION: Node.js environment - check .nvmrc or use cached version
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

    # OPTIMIZATION: Rust environment - use cached version
    if [ -f "$expanded_dir/Cargo.toml" ] && [ -z "$output" ]; then
        if [ -n "$CACHED_RUST_VERSION" ]; then
            output=" ${COLOR_NEON_ORANGE}${ICON_RUST}${CACHED_RUST_VERSION}${COLOR_RESET}"
        fi
    fi

    # OPTIMIZATION: Go environment - use cached version
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
# PROJECT TYPE DETECTION (Original + Enhanced)
# ============================================================================

detect_project_type() {
    local dir="$1"
    local expanded_dir="${dir/#\~/$HOME}"

    [ ! -d "$expanded_dir" ] && return

    local icons=""

    # Check for project markers (only show if not already showing dev env)
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

    # Check if git repo (always show)
    if [ -d "$expanded_dir/.git" ]; then
        icons="${icons} ${ICON_GIT}"
    fi

    echo "$icons"
}

# ============================================================================
# ACTIVITY TRACKING (Enhanced Timeline)
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
        # Active <1h
        icon="$ICON_HOT"
        local minutes=$((idle_seconds / 60))
        time_str="${minutes}m ago"
    elif [ "$idle_seconds" -lt 86400 ]; then
        # Recent <24h
        icon="$ICON_RECENT"
        local hours=$((idle_seconds / 3600))
        time_str="${hours}h ago"
    elif [ "$idle_seconds" -lt 604800 ]; then
        # Stale 1d-7d
        icon="$ICON_IDLE"
        local days=$((idle_seconds / 86400))
        time_str="${days}d ago"
    elif [ "$idle_seconds" -lt 2592000 ]; then
        # Sleeping 7d-30d
        icon="$ICON_SLEEPING"
        local weeks=$((idle_seconds / 604800))
        time_str="${weeks}w ago"
    else
        # Archived >30d
        icon="$ICON_ARCHIVED"
        local months=$((idle_seconds / 2592000))
        time_str="${months}mo ago"
    fi

    case "$DISPLAY_MODE" in
        compact)
            echo " $icon"
            ;;
        detailed|rich)
            echo " $icon $time_str"
            ;;
    esac
}

# ============================================================================
# SESSION METADATA FUNCTIONS
# ============================================================================

get_session_metadata() {
    local session_name="$1"
    local metadata="${session_metadata[$session_name]}"

    [ -z "$metadata" ] && return

    IFS=',' read -r windows panes <<< "$metadata"

    case "$DISPLAY_MODE" in
        compact)
            echo " ${COLOR_GRAY}(${windows}w ${panes}p)${COLOR_RESET}"
            ;;
        detailed|rich)
            echo " ${COLOR_GRAY}(${windows}w ${panes}p)${COLOR_RESET}"
            ;;
    esac
}

# ============================================================================
# SORTING FUNCTIONS
# ============================================================================

sort_sessions() {
    local temp_file="$1"

    case "$SORT_MODE" in
        activity)
            # Most recently used first (default - no sorting needed, already sorted)
            cat "$temp_file"
            ;;
        resources)
            # Highest CPU/memory first - not implemented yet, return as-is
            cat "$temp_file"
            ;;
        windows)
            # Most windows first - not implemented yet, return as-is
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
    # [33m=yellow=tmuxinator, [34m=blue=tmux, [36m=cyan=zoxide, [90m=gray=custom
    sesh_type="unknown"
    case "$session" in
        *"[33m"*) sesh_type="tmuxinator" ;;
        *"[34m"*) sesh_type="tmux" ;;
        *"[36m"*) sesh_type="directory" ;;
        *"[90m"*) sesh_type="config" ;;
    esac

    # Strip ANSI codes
    clean_session=$(echo "$session" | sed 's/\x1b\[[0-9;]*m//g' | sed 's/\[[0-9;]*m//g')
    # Remove only specific icon prefixes (single-byte characters), not emojis (multi-byte)
    clean_session=$(echo "$clean_session" | sed -E 's/^[◆●◉◯📁▪▣][[:space:]]*//')
    clean_session=$(echo "$clean_session" | xargs)

    [ -z "$clean_session" ] && continue

    # Create deduplication key by stripping emojis and common prefixes
    # This ensures "⚙️ dotfiles" and "dotfiles" are treated as duplicates
    # Remove emoji characters (UTF-8 multi-byte sequences) from the start
    dedup_key=$(echo "$clean_session" | sed -E 's/^[[:space:]]*[^[:alnum:]~\/\._-]+[[:space:]]*//' | xargs)

    # Also normalize paths for deduplication (strip ~/ prefix for comparison)
    dedup_normalized=$(echo "$dedup_key" | sed 's|^~/||')

    # Global deduplication - skip if we've already seen this session name
    # Check both the dedup_key and normalized version
    if [[ -n "${seen_sessions[$dedup_key]}" ]] || [[ -n "${seen_sessions[$dedup_normalized]}" ]]; then
        continue
    fi

    # Blacklist filtering
    case "$clean_session" in
        "/Users"|"/"|"/dev"|"/usr/bin"|"/Library/Preferences"|"/Library/LaunchDaemons"|*.cache*|*node_modules*|*.Trash*|*.DS_Store*)
            continue
            ;;
    esac

    # Helper function to check if session is in sesh.toml
    # Checks both exact name and name without emoji prefix
    is_sesh_toml_session() {
        local name="$1"
        local sesh_config="${HOME}/.config/sesh/sesh.toml"

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
        grep -E "^name = \"[^\"]*${base_name}\"" "$sesh_config" 2>/dev/null | grep -q "$base_name"
    }

    # SMART DEDUPLICATION: Prioritize tmux > tmuxinator > custom > zoxide
    # Determine session type first
    is_tmux_session=false
    is_tmuxinator=false
    is_directory=false
    is_custom=false

    if [[ "$sesh_type" == "tmux" ]] || [[ -n "${tmux_sessions[$clean_session]}" ]] || [[ -n "${tmux_sessions[$dedup_key]}" ]]; then
        is_tmux_session=true
    elif [[ "$sesh_type" == "tmuxinator" ]] || [ -f "$HOME/.config/tmuxinator/${clean_session}.yml" ]; then
        is_tmuxinator=true
        # Skip if tmux session exists with same name
        [[ -n "${tmux_sessions[$clean_session]}" ]] && continue
        [[ -n "${tmux_sessions[$dedup_key]}" ]] && continue
    elif [[ "$sesh_type" == "config" ]] || is_sesh_toml_session "$clean_session"; then
        is_custom=true
        # Skip if tmux session exists with same name (check both with and without emoji)
        [[ -n "${tmux_sessions[$clean_session]}" ]] && continue
        [[ -n "${tmux_sessions[$dedup_key]}" ]] && continue
    elif [[ "$sesh_type" == "directory" ]] || [ -d "${clean_session/#\~/$HOME}" ]; then
        is_directory=true
        # Skip if this directory has a sesh.toml custom session
        is_sesh_toml_session "$dedup_normalized" && continue
        # Skip if there's a tmuxinator config for this
        [ -f "$HOME/.config/tmuxinator/${dedup_key}.yml" ] && continue
    fi

    # FILTER MODE: Apply filtering based on selected session types
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
            # Show tmux sessions and tmuxinator configs, exclude zoxide/directories
            [[ "$is_tmux_session" == true ]] || [[ "$is_tmuxinator" == true ]] || continue
            ;;
        no_zoxide)
            # Show all sessions except zoxide directories
            [[ "$is_directory" == true ]] && continue
            ;;
        git)
            # Only show sessions in git repositories
            local expanded_session="${clean_session/#\~/$HOME}"
            [ -d "$expanded_session/.git" ] || continue
            ;;
        containers)
            # Only show sessions with running containers
            local expanded_session="${clean_session/#\~/$HOME}"
            [ -f "$expanded_session/docker-compose.yml" ] || [ -f "$expanded_session/Dockerfile" ] || continue
            ;;
        all|*)
            # Show all sessions (default)
            ;;
    esac

    # Mark as seen BEFORE output to prevent duplicates
    seen_sessions["$dedup_key"]=1
    seen_sessions["$dedup_normalized"]=1

    # Build output with all enhancements
    if [[ "$is_tmux_session" == true ]]; then
        # ACTIVE TMUX SESSIONS: Adaptive metadata based on display mode
        activity_icon=$(get_activity_indicator "$clean_session")
        metadata=$(get_session_metadata "$clean_session")

        # PERFORMANCE: Only run expensive operations in detailed/rich modes
        git_info=""
        resources=""
        containers=""
        dev_env=""

        if [[ "$DISPLAY_MODE" != "compact" ]]; then
            # Detailed/Rich mode: Full metadata
            git_info=$(get_git_info "$clean_session")
            resources=$(get_session_resources "$clean_session")
            containers=$(get_container_info "$clean_session" "$clean_session")
            dev_env=$(get_dev_env_info "$clean_session" "$clean_session")
        fi

        # Check if stale for color
        last_activity="${session_activity[$clean_session]}"
        is_stale=false
        if [ -n "$last_activity" ]; then
            now=$(date +%s)
            idle_seconds=$((now - last_activity))
            [ "$idle_seconds" -gt 86400 ] && is_stale=true
        fi

        # Build output line
        if [[ "$clean_session" == "$CURRENT_SESSION" ]]; then
            # Currently attached
            echo -e "${COLOR_ATTACHED}${ICON_ATTACHED} ${clean_session}${COLOR_RESET}${git_info}${activity_icon}${resources}${containers}${dev_env}${metadata}"
        elif [ "$is_stale" = true ]; then
            # Stale session
            echo -e "${COLOR_STALE}${ICON_ACTIVE} ${clean_session}${COLOR_RESET}${git_info}${activity_icon}${resources}${containers}${dev_env}${metadata}"
        else
            # Active session
            echo -e "${COLOR_ACTIVE}${ICON_ACTIVE} ${clean_session}${COLOR_RESET}${git_info}${activity_icon}${resources}${containers}${dev_env}${metadata}"
        fi

    elif [[ "$is_tmuxinator" == true ]]; then
        # TMUXINATOR PROJECTS (not running): Lightweight - only project icons
        tmuxinator_root=$(grep "^root:" "$HOME/.config/tmuxinator/${clean_session}.yml" 2>/dev/null | sed 's/root: *//' | sed "s|~|$HOME|" | tr -d '"' | tr -d "'")
        project_icons=$(detect_project_type "$tmuxinator_root")

        echo -e "${COLOR_TMUXINATOR}${ICON_TMUXINATOR} ${clean_session}${COLOR_RESET}${project_icons}"

    elif [[ "$is_custom" == true ]]; then
        # CUSTOM SESH SESSIONS (from sesh.toml): Show with special icon
        echo -e "${COLOR_NEON_BLUE}${ICON_TMUXINATOR} ${clean_session}${COLOR_RESET}"

    elif [[ "$is_directory" == true ]]; then
        # ZOXIDE DIRECTORIES: Minimal - just project type icons (fast file checks only)
        project_icons=$(detect_project_type "$clean_session")

        echo -e "${COLOR_DIRECTORY}${ICON_DIRECTORY} ${clean_session}${COLOR_RESET}${project_icons}"
    else
        # Unknown type
        echo "${clean_session}"
    fi
done >> "$TEMP_SESSIONS"

# Apply sorting and output
sort_sessions "$TEMP_SESSIONS"

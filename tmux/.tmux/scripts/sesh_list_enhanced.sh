#!/usr/bin/env bash

# Enhanced Sesh list wrapper with deduplication, colors, and rich metadata
# Features: project type detection, activity tracking, performance optimization
# Version: 3.0

# Color definitions (ANSI escape codes)
COLOR_ACTIVE='\033[0;32m'      # Green for active tmux sessions
COLOR_ATTACHED='\033[1;32m'    # Bright green for currently attached session
COLOR_TMUXINATOR='\033[0;35m'  # Magenta for tmuxinator projects (not running)
COLOR_DIRECTORY='\033[0;33m'   # Yellow for directories/zoxide
COLOR_STALE='\033[0;90m'       # Gray for stale sessions (>24h idle)
COLOR_RESET='\033[0m'

# Icon definitions
ICON_ATTACHED='●'       # Currently attached session
ICON_ACTIVE='◉'         # Active tmux session (not attached)
ICON_TMUXINATOR='◆'     # Tmuxinator project (not running)
ICON_DIRECTORY='📁'     # Directory/zoxide entry

# Activity icons
ICON_HOT='🔥'          # Active in last hour
ICON_IDLE='⏰'         # Idle >24 hours

# Project type icons
ICON_NODE='⚛️'         # Node.js/JavaScript
ICON_PYTHON='🐍'       # Python
ICON_RUST='🦀'         # Rust
ICON_GO='🐹'           # Go
ICON_DOCKER='🐳'       # Docker
ICON_GIT='�'          # Git repository

# Get current attached session
CURRENT_SESSION=""
if [ -n "$TMUX" ]; then
    CURRENT_SESSION=$(tmux display-message -p '#S' 2>/dev/null)
fi

# Cache tmux sessions and metadata in associative arrays
declare -A tmux_sessions
declare -A session_metadata
declare -A session_activity

while IFS='|' read -r name windows activity; do
    if [ -n "$name" ]; then
        tmux_sessions["$name"]=1
        # Count panes for this session
        panes=$(tmux list-panes -s -t "$name" 2>/dev/null | wc -l | tr -d ' ')
        session_metadata["$name"]="$windows,$panes"
        session_activity["$name"]="$activity"
    fi
done < <(tmux list-sessions -F '#{session_name}|#{session_windows}|#{session_activity}' 2>/dev/null)

# Function: Detect project type from directory
detect_project_type() {
    local dir="$1"
    local expanded_dir="${dir/#\~/$HOME}"

    # Skip if not a directory
    [ ! -d "$expanded_dir" ] && return

    # Check for project markers
    if [ -f "$expanded_dir/package.json" ]; then
        echo -n " $ICON_NODE"
    elif [ -f "$expanded_dir/Cargo.toml" ]; then
        echo -n " $ICON_RUST"
    elif [ -f "$expanded_dir/go.mod" ]; then
        echo -n " $ICON_GO"
    elif [ -f "$expanded_dir/requirements.txt" ] || [ -f "$expanded_dir/pyproject.toml" ] || [ -f "$expanded_dir/setup.py" ]; then
        echo -n " $ICON_PYTHON"
    elif [ -f "$expanded_dir/docker-compose.yml" ] || [ -f "$expanded_dir/Dockerfile" ]; then
        echo -n " $ICON_DOCKER"
    fi

    # Check if git repo
    if [ -d "$expanded_dir/.git" ]; then
        echo -n " $ICON_GIT"
    fi
}

# Function: Get activity status for tmux session
get_activity_indicator() {
    local session_name="$1"
    local last_activity="${session_activity[$session_name]}"

    [ -z "$last_activity" ] && return

    local now=$(date +%s)
    local idle_seconds=$((now - last_activity))

    # Hot: active in last hour
    if [ "$idle_seconds" -lt 3600 ]; then
        echo -n " $ICON_HOT"
    # Stale: idle > 24 hours
    elif [ "$idle_seconds" -gt 86400 ]; then
        echo -n " $ICON_IDLE"
    fi
}

# Function: Get session metadata (windows/panes)
get_session_metadata() {
    local session_name="$1"
    local metadata="${session_metadata[$session_name]}"

    [ -z "$metadata" ] && return

    IFS=',' read -r windows panes <<< "$metadata"
    echo -n " (${windows}w ${panes}p)"
}

# Process sesh list output
sesh list "$@" | while IFS= read -r session; do
    # Detect sesh entry type from ANSI color code
    # [33m = yellow = tmuxinator, [34m = blue = tmux, [36m = cyan = zoxide
    sesh_type="unknown"
    case "$session" in
        *"[33m"*) sesh_type="tmuxinator" ;;
        *"[34m"*) sesh_type="tmux" ;;
        *"[36m"*) sesh_type="directory" ;;
    esac

    # Strip ANSI codes first
    clean_session=$(echo "$session" | sed 's/\x1b\[[0-9;]*m//g' | sed 's/\[[0-9;]*m//g')
    # Remove first character (sesh icon - could be UTF-8) and any following space
    clean_session=$(echo "$clean_session" | sed -E 's/^.{1}[[:space:]]*//')
    # Strip any remaining leading/trailing whitespace
    clean_session=$(echo "$clean_session" | xargs)

    # Skip empty lines
    [ -z "$clean_session" ] && continue

    # Additional blacklist filtering (supplement to sesh.toml blacklist)
    case "$clean_session" in
        "/Users"|"/"|"/dev"|"/usr/bin"|"/Library/Preferences"|"/Library/LaunchDaemons"|*.cache*|*node_modules*|*.Trash*|*.DS_Store*)
            continue
            ;;
    esac

    # DEDUPLICATION: Skip tmuxinator if matching tmux session exists
    if [[ "$sesh_type" == "tmuxinator" ]] && [[ -n "${tmux_sessions[$clean_session]}" ]]; then
        continue
    fi

    # Determine actual session type
    is_tmux_session=false
    is_tmuxinator=false
    is_directory=false

    if [[ "$sesh_type" == "tmux" ]] || [[ -n "${tmux_sessions[$clean_session]}" ]]; then
        is_tmux_session=true
    elif [[ "$sesh_type" == "tmuxinator" ]] || [ -f "$HOME/.config/tmuxinator/${clean_session}.yml" ]; then
        is_tmuxinator=true
    elif [[ "$sesh_type" == "directory" ]] || [ -d "${clean_session/#\~/$HOME}" ]; then
        is_directory=true
    fi

    # Build output with color, icon, and metadata
    if [[ "$is_tmux_session" == true ]]; then
        # Get activity indicator
        activity_icon=$(get_activity_indicator "$clean_session")
        metadata=$(get_session_metadata "$clean_session")

        # Check if session is stale (>24h idle)
        last_activity="${session_activity[$clean_session]}"
        is_stale=false
        if [ -n "$last_activity" ]; then
            now=$(date +%s)
            idle_seconds=$((now - last_activity))
            [ "$idle_seconds" -gt 86400 ] && is_stale=true
        fi

        # Currently attached session
        if [[ "$clean_session" == "$CURRENT_SESSION" ]]; then
            printf "${COLOR_ATTACHED}${ICON_ATTACHED} ${clean_session}${COLOR_RESET}${activity_icon}${metadata}\n"
        # Stale session
        elif [ "$is_stale" = true ]; then
            printf "${COLOR_STALE}${ICON_ACTIVE} ${clean_session}${COLOR_RESET}${activity_icon}${metadata}\n"
        # Active session
        else
            printf "${COLOR_ACTIVE}${ICON_ACTIVE} ${clean_session}${COLOR_RESET}${activity_icon}${metadata}\n"
        fi

    elif [[ "$is_tmuxinator" == true ]]; then
        # Tmuxinator project (not running)
        # Try to detect project type from root path
        tmuxinator_root=$(grep "^root:" "$HOME/.config/tmuxinator/${clean_session}.yml" 2>/dev/null | sed 's/root: *//' | sed "s|~|$HOME|" | tr -d '"' | tr -d "'")
        project_icons=$(detect_project_type "$tmuxinator_root")

        printf "${COLOR_TMUXINATOR}${ICON_TMUXINATOR} ${clean_session}${COLOR_RESET}${project_icons}\n"

    elif [[ "$is_directory" == true ]]; then
        # Directory/zoxide entry
        project_icons=$(detect_project_type "$clean_session")
        printf "${COLOR_DIRECTORY}${ICON_DIRECTORY} ${clean_session}${COLOR_RESET}${project_icons}\n"
    else
        # Unknown type
        printf "${clean_session}\n"
    fi
done

#!/usr/bin/env bash

# ============================================================================
# SESH ICONS - Centralized Icon Definitions
# ============================================================================
# Purpose: Single source of truth for all icons used across sesh scripts
# Usage: Source this file in any sesh script that needs icon definitions
#        Example: source "${SESH_SCRIPTS_LIB}/sesh_icons.sh"
# ============================================================================

# ----------------------------------------------------------------------------
# SESSION STATUS ICONS (ASCII for performance)
# ----------------------------------------------------------------------------
# Icons indicating the current state of a tmux session

export ICON_ATTACHED='>'       # Currently attached session (user is in this session now)
export ICON_ACTIVE='*'         # Active tmux session (running but not attached)
export ICON_DEAD='-'           # Dead/inactive session
export ICON_SESH_CUSTOM='+'    # Sesh.toml custom session (diamond shape)

# ----------------------------------------------------------------------------
# SESSION TYPE ICONS
# ----------------------------------------------------------------------------
# Icons distinguishing different types of sessions and projects

export ICON_TMUX='*'           # Standard tmux session
export ICON_TMUXINATOR='#'     # Tmuxinator project (square)
export ICON_DIRECTORY='/'      # Directory/zoxide entry
export ICON_GIT='G'            # Git repository

# Container and service icons
export ICON_DOCKER='D'         # Docker container
export ICON_SERVER='S'         # Dev server running

# ----------------------------------------------------------------------------
# PROGRAMMING LANGUAGE ICONS
# ----------------------------------------------------------------------------
# Icons for development environment and project type detection

export ICON_PYTHON='py'        # Python project
export ICON_NODE='js'          # Node.js/JavaScript project
export ICON_RUST='rs'          # Rust project
export ICON_GO='go'            # Go project

# ----------------------------------------------------------------------------
# CLAUDE CODE / AI ASSISTANT ICONS
# ----------------------------------------------------------------------------
# Icons for Claude Code instance tracking and status

export ICON_CLAUDE='C'         # Claude Code instance
export ICON_CLAUDE_THINKING='*'   # Claude is processing/thinking
export ICON_CLAUDE_WAITING='.'    # Claude waiting for user input
export ICON_CLAUDE_IDLE='_'       # Claude idle/ended

# ----------------------------------------------------------------------------
# ACTIVITY TIMELINE ICONS
# ----------------------------------------------------------------------------
# Icons showing session activity levels and recency

export ICON_HOT='!'            # Active within last hour (very recent activity)
export ICON_RECENT='+'         # Used within last 24 hours
export ICON_IDLE='~'           # Stale 1-7 days (minimal recent activity)
export ICON_SLEEPING='_'       # Sleeping >7 days (no recent activity)
export ICON_ARCHIVED='-'       # Archived >30 days (very old, likely unused)

# ----------------------------------------------------------------------------
# GIT STATUS ICONS
# ----------------------------------------------------------------------------
# Icons for git repository state and change indicators

export ICON_GIT_CLEAN='='      # Clean repository (no changes)
export ICON_GIT_AHEAD='^'      # Ahead of upstream (commits to push)
export ICON_GIT_BEHIND='v'     # Behind upstream (commits to pull)
export ICON_GIT_DIVERGED='<>'  # Diverged from upstream (both ahead and behind)
export ICON_GIT_STAGED='S'     # Staged changes (ready to commit)
export ICON_GIT_MODIFIED='M'   # Modified files (uncommitted changes)
export ICON_GIT_CONFLICT='!'   # Merge conflicts (needs resolution)

# ----------------------------------------------------------------------------
# RESOURCE MONITORING ICONS
# ----------------------------------------------------------------------------
# Icons for system resource usage indicators

export ICON_CPU='%'            # CPU usage percentage
export ICON_MEM='M'            # Memory usage
export ICON_NETWORK='N'        # Network activity

# ----------------------------------------------------------------------------
# NAVIGATION & UI ICONS
# ----------------------------------------------------------------------------
# Icons for navigation, selection, and UI elements

export ICON_ARROW='>'          # Navigation arrow
export ICON_CHECK='+'          # Checkmark (success, completed)
export ICON_CROSS='x'          # Cross mark (error, failed)
export ICON_BULLET='*'         # Bullet point (list item)

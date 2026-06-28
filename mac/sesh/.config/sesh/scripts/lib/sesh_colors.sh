#!/usr/bin/env bash

# sesh_colors.sh - Centralized color palette for all sesh scripts
#
# This file contains ONLY color definitions exported as environment variables.
# Extracted from tmux/.tmux/scripts/sesh_list_enhanced.sh (lines 80-108)
#
# Usage:
#   source "$(dirname "$0")/lib/sesh_colors.sh"
#   echo "${COLOR_NEON_GREEN}Success!${COLOR_RESET}"

# Core neon colors (RGB true color)
export COLOR_NEON_GREEN='\033[38;2;128;255;0m'     # 0xff80ff00 - Electric green
export COLOR_NEON_RED='\033[38;2;255;0;31m'        # 0xffff001f - Vibrant red
export COLOR_NEON_BLUE='\033[38;2;0;42;255m'       # 0xff002aff - Electric blue
export COLOR_NEON_ORANGE='\033[38;2;255;107;0m'    # 0xffff6b00 - Bright orange
export COLOR_NEON_YELLOW='\033[38;2;241;252;121m'  # 0xfff1fc79 - Soft yellow
export COLOR_NEON_MAGENTA='\033[38;2;164;140;242m' # 0xffa48cf2 - Purple-magenta

# Grayscale colors
export COLOR_GRAY='\033[38;2;50;52;73m'            # 0xff323449 - Stale gray
export COLOR_WHITE='\033[38;2;255;255;255m'        # 0xffffffff - White text

# Reset color
export COLOR_RESET='\033[0m'

# Status-based colors (semantic mapping)
export COLOR_ACTIVE="$COLOR_NEON_GREEN"       # Active sessions, healthy state
export COLOR_ATTACHED="$COLOR_NEON_GREEN"     # Currently attached
export COLOR_TMUXINATOR="$COLOR_NEON_MAGENTA" # Tmuxinator projects
export COLOR_DIRECTORY="$COLOR_NEON_YELLOW"   # Directories/zoxide
export COLOR_STALE="$COLOR_GRAY"              # Stale sessions

# Git status colors
export COLOR_GIT_CLEAN="$COLOR_NEON_GREEN"    # Clean repository
export COLOR_GIT_DIRTY="$COLOR_NEON_YELLOW"   # Uncommitted changes
export COLOR_GIT_CONFLICT="$COLOR_NEON_RED"   # Merge conflicts
export COLOR_GIT_AHEAD="$COLOR_NEON_BLUE"     # Ahead of upstream
export COLOR_GIT_BEHIND="$COLOR_NEON_ORANGE"  # Behind upstream

# Resource threshold colors
export COLOR_RESOURCE_LOW="$COLOR_NEON_GREEN"    # <30% usage
export COLOR_RESOURCE_MED="$COLOR_NEON_YELLOW"   # 30-70% usage
export COLOR_RESOURCE_HIGH="$COLOR_NEON_ORANGE"  # 70-90% usage
export COLOR_RESOURCE_CRIT="$COLOR_NEON_RED"     # >90% usage

#!/bin/bash

# Git plugin with error handling - optimized version

# Check if NAME variable is set
if [ -z "$NAME" ]; then
  echo "Error: NAME variable not set" >&2
  exit 1
fi

# Check if git is available
if ! command -v git &> /dev/null; then
  echo "Error: git command not found" >&2
  sketchybar --set $NAME drawing=off 2>/dev/null
  exit 1
fi

# Get git status with branch in single call (optimized)
# --porcelain --branch gives us both status and branch info
GIT_STATUS=$(git status --porcelain --branch 2>/dev/null) || {
  sketchybar --set $NAME drawing=off 2>/dev/null
  exit 0
}

# Make sure we're visible
if ! sketchybar --set $NAME drawing=on 2>/dev/null; then
  echo "Warning: Failed to set drawing=on for git plugin" >&2
fi

# Extract branch from ## line using awk (single extraction)
BRANCH=$(echo "$GIT_STATUS" | awk '/^##/ {
  # Handle "## branch...origin/branch" format
  branch=$2
  # Remove ...origin/branch part if present
  sub(/\.\.\..*/, "", branch)
  print branch
  exit
}')

# Default to detached if no branch
[ -z "$BRANCH" ] && BRANCH="detached"

# Limit branch name length using bash parameter expansion
[ ${#BRANCH} -gt 12 ] && BRANCH="${BRANCH:0:9}..."

# Determine icon and color based on git status using bash regex
if [ -z "$GIT_STATUS" ] || ! echo "$GIT_STATUS" | grep -qv '^##'; then
  # Clean repository (only has ## line or empty)
  ICON="󰊢"
  COLOR="0xffa6da95"  # Green
elif [[ "$GIT_STATUS" =~ ^(UU|AA|DD) ]]; then
  # Merge conflicts - bash regex instead of grep
  ICON="󰅙"
  COLOR="0xffed8796"  # Red
else
  # Has changes
  ICON="󰊚"
  COLOR="0xfff5a97f"  # Orange
fi

# Update sketchybar with error handling
if ! sketchybar --set $NAME icon="$ICON" icon.color=$COLOR label="$BRANCH" 2>/dev/null; then
  echo "Warning: Failed to update sketchybar for git plugin" >&2
fi

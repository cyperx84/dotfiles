#!/bin/bash

# Git plugin with error handling

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

# Check if we're in a git repository
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
  sketchybar --set $NAME drawing=off 2>/dev/null
  exit 0
fi

# Make sure we're visible
if ! sketchybar --set $NAME drawing=on 2>/dev/null; then
  echo "Warning: Failed to set drawing=on for git plugin" >&2
fi

# Get current branch
BRANCH=$(git branch --show-current 2>/dev/null)
if [ -z "$BRANCH" ]; then
  BRANCH="detached"
fi

# Limit branch name length
if [ ${#BRANCH} -gt 12 ]; then
  BRANCH="${BRANCH:0:9}..."
fi

# Check git status
GIT_STATUS=$(git status --porcelain 2>/dev/null)

# Determine icon and color based on git status
if [ -z "$GIT_STATUS" ]; then
  # Clean repository
  ICON="󰊢"
  COLOR="0xffa6da95"  # Green
elif echo "$GIT_STATUS" | grep -q "^UU\|^AA\|^DD"; then
  # Merge conflicts
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
  exit 1
fi
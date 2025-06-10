#!/bin/bash

# Check if we're in a git repository
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
  sketchybar --set $NAME drawing=off
  exit 0
fi

# Make sure we're visible
sketchybar --set $NAME drawing=on

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

sketchybar --set $NAME icon="$ICON" \
                    icon.color=$COLOR \
                    label="$BRANCH"
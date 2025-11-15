#!/usr/bin/env bash

# AeroSpace workspace indicator plugin
# Based on: https://nikitabobko.github.io/AeroSpace/goodies
# Optimized to only update changed workspaces

# Set PLUGIN_DIR if not already set
PLUGIN_DIR="${PLUGIN_DIR:-$HOME/.config/sketchybar/plugins}"

source "$CONFIG_DIR/colors.sh"

# Get the workspace ID for this space item
WORKSPACE_ID="$1"
SID="$1"  # Set SID for space.sh compatibility

# Handle mouse clicks (delegate to space.sh for interactive features)
if [ "$SENDER" = "mouse.clicked" ]; then
  source "$PLUGIN_DIR/space.sh"
  exit 0
fi

# Handle workspace changes
if [ "$SENDER" = "aerospace_workspace_change" ]; then
  # Check if this workspace is the focused one
  if [ "$WORKSPACE_ID" = "$FOCUSED_WORKSPACE" ]; then
    # Active workspace styling - orange icon with green highlight
    sketchybar --set "$NAME" \
      icon.highlight=on \
      icon.color="$SPACE_WINDOW_INDICATOR" \
      label.highlight=on \
      label.color="$SPACE_ACTIVE_TEXT" \
      background.color="$SPACE_ACTIVE_BG" \
      background.border_color="$SPACE_ACTIVE_BORDER" \
      background.border_width=2 \
      background.corner_radius=12 \
      background.height=24 \
      background.drawing=on \
      background.shadow.drawing=on \
      padding_left=3 \
      padding_right=3
  else
    # Inactive workspace styling - orange icon, green label
    sketchybar --set "$NAME" \
      icon.highlight=off \
      icon.color="$SPACE_WINDOW_INDICATOR" \
      label.highlight=off \
      label.color="$SPACE_ACTIVE_TEXT" \
      background.color="$SPACE_INACTIVE_BG" \
      background.border_color="$SPACE_INACTIVE_BORDER" \
      background.border_width=1 \
      background.corner_radius=10 \
      background.height=20 \
      background.drawing=on \
      background.shadow.drawing=off \
      padding_left=2 \
      padding_right=2
  fi

  # Update window count for this workspace
  "$PLUGIN_DIR/space_window_count.sh" "$WORKSPACE_ID"
fi

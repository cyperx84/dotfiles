#!/usr/bin/env bash

# HyprSpace workspace indicator plugin
# Optimized for instant updates on workspace/window changes

PLUGIN_DIR="${PLUGIN_DIR:-$HOME/.config/sketchybar/plugins}"
source "$CONFIG_DIR/colors.sh"

WORKSPACE_ID="$1"
SID="$1"

# Handle mouse clicks
if [ "$SENDER" = "mouse.clicked" ]; then
  source "$PLUGIN_DIR/space.sh"
  exit 0
fi

# Update window count (called by multiple events)
update_window_count() {
  "$PLUGIN_DIR/space_window_count.sh" "$WORKSPACE_ID"
}

# Get current focused workspace
get_focused() {
  hyprspace list-workspaces --focused 2>/dev/null || echo "1"
}

# Handle workspace change - update highlighting
if [ "$SENDER" = "aerospace_workspace_change" ]; then
  if [ "$WORKSPACE_ID" = "$FOCUSED_WORKSPACE" ]; then
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
  update_window_count
  exit 0
fi

# Handle window change / front app switch / routine - just update counts
if [ "$SENDER" = "window_change" ] || [ "$SENDER" = "front_app_switched" ] || [ "$SENDER" = "routine" ]; then
  update_window_count
  exit 0
fi

# Default: update window count
update_window_count

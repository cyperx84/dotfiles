#!/usr/bin/env bash

# Create and switch to a new workspace
# Fill gaps in workspace numbers or create next available

source "$CONFIG_DIR/colors.sh"
PLUGIN_DIR="${PLUGIN_DIR:-$HOME/.config/sketchybar/plugins}"

# Get all workspace names as sorted numbers
WORKSPACES=$(aerospace list-workspaces --all | grep -E '^[0-9]+$' | sort -n)

# Find the first gap in the sequence, or use next number
NEW_WORKSPACE=1
for workspace in $WORKSPACES; do
  if [ "$workspace" -eq "$NEW_WORKSPACE" ]; then
    NEW_WORKSPACE=$((NEW_WORKSPACE + 1))
  else
    break
  fi
done

# Add space indicator to SketchyBar before space_creator
sketchybar --add item space.$NEW_WORKSPACE center before space_creator \
           --subscribe space.$NEW_WORKSPACE aerospace_workspace_change mouse.clicked \
           --set space.$NEW_WORKSPACE \
           icon="$NEW_WORKSPACE  󰿉" \
           icon.color="$SPACE_WINDOW_INDICATOR" \
           icon.font="SF Pro:Semibold:14.0" \
           icon.width=40 \
           icon.drawing=on \
           icon.padding_left=8 \
           icon.padding_right=2 \
           label.width=20 \
           label.drawing=on \
           label.padding_left=2 \
           label.padding_right=8 \
           padding_left=1 \
           padding_right=1 \
           icon.highlight_color="$SPACE_ACTIVE_TEXT" \
           label.color="$SPACE_ACTIVE_TEXT" \
           label.highlight_color="$SPACE_ACTIVE_TEXT" \
           label.font="sketchybar-app-font:Medium:14.0" \
           label.y_offset=0 \
           background.color="$SPACE_INACTIVE_BG" \
           background.border_color="$SPACE_INACTIVE_BORDER" \
           background.corner_radius=10 \
           background.height=20 \
           background.border_width=1 \
           background.drawing=on \
           script="$PLUGIN_DIR/aerospace.sh $NEW_WORKSPACE"

# Set initial window count
"$PLUGIN_DIR/space_window_count.sh" "$NEW_WORKSPACE"

# Switch to new workspace
aerospace workspace "$NEW_WORKSPACE"

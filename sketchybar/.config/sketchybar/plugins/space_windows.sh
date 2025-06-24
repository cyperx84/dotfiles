#!/bin/bash

update_space_windows() {
  local space_id=$1
  
  # Get windows in the specified space
  local window_count=$(yabai -m query --windows --space $space_id | jq '. | length')
  
  # Smart window indicators based on count
  case $window_count in
    0)
      icon_strip=""  # Clean, no indicator for empty spaces
      ;;
    1)
      icon_strip="•"  # Single dot
      ;;
    2)
      icon_strip="••"  # Two dots
      ;;
    3)
      icon_strip="•••"  # Three dots
      ;;
    *)
      icon_strip="$window_count"  # Show actual number for 4+
      ;;
  esac

  sketchybar --animate tanh 12 --set space.$space_id label="$icon_strip"
}

if [ "$SENDER" = "space_windows_change" ]; then
  space="$(echo "$INFO" | jq -r '.space')"
  apps="$(echo "$INFO" | jq -r '.apps | keys[]')"
  
  # Count number of apps
  if [ -n "$apps" ] && [ "$apps" != "" ]; then
    app_count=$(echo "$apps" | wc -l | tr -d ' ')
  else
    app_count=0
  fi

  # Smart window indicators based on count
  case $app_count in
    0)
      icon_strip=""  # Clean, no indicator for empty spaces
      ;;
    1)
      icon_strip="•"  # Single dot
      ;;
    2)
      icon_strip="••"  # Two dots
      ;;
    3)
      icon_strip="•••"  # Three dots
      ;;
    *)
      icon_strip="$app_count"  # Show actual number for 4+
      ;;
  esac

  sketchybar --animate tanh 12 --set space.$space label="$icon_strip"
elif [ "$SENDER" = "windows_on_spaces" ]; then
  # Update all spaces when windows change
  for space_id in $(yabai -m query --spaces | jq -r '.[].index'); do
    update_space_windows $space_id
  done
fi

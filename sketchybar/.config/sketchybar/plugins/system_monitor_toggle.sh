#!/bin/bash

# Complete Right Side Toggle - Hide/Show all right-side items except calendar (date/time)

show_all_items() {
  # Show all right-side components
  sketchybar --set '/cpu.*/' drawing=on \
             --set memory drawing=on \
             --set temperature drawing=on \
             --set network drawing=on \
             --set battery drawing=on \
             --set volume_icon drawing=on \
             --set volume drawing=on \
             --set mic drawing=on \
             --set wifi drawing=on \
             --set brew drawing=on \
             --set github.bell drawing=on
}

hide_all_items() {
  # Hide all right-side components except calendar
  sketchybar --set '/cpu.*/' drawing=off \
             --set memory drawing=off \
             --set temperature drawing=off \
             --set network drawing=off \
             --set battery drawing=off \
             --set volume_icon drawing=off \
             --set volume drawing=off \
             --set mic drawing=off \
             --set wifi drawing=off \
             --set brew drawing=off \
             --set github.bell drawing=off
}

# Check current state by looking at memory component (any visible component works)
CURRENT_STATE="$(sketchybar --query memory | jq -r ".geometry.drawing")"

if [ "$CURRENT_STATE" = "on" ]; then
  # If currently showing, hide everything except calendar
  hide_all_items
else
  # If currently hidden, show everything
  show_all_items
fi
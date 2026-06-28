#!/bin/bash

# Tmux plugin - maximum performance version

# Check NAME variable
[ -z "$NAME" ] && exit 1

# Check tmux availability
command -v tmux &>/dev/null || { sketchybar --set "$NAME" drawing=off 2>/dev/null; exit 0; }

# Get session data in one call: "attached,name" per line
sessions=$(tmux list-sessions -F '#{session_attached},#{session_name}' 2>/dev/null) || {
  sketchybar --set "$NAME" drawing=off 2>/dev/null
  exit 0
}

# Parse with pure bash (no external processes)
attached=""
session_count=0
first_session=""

while IFS=',' read -r is_attached name; do
  ((session_count++))
  [ -z "$first_session" ] && first_session="$name"
  [ "$is_attached" = "1" ] && [ -z "$attached" ] && attached="$name"
done <<< "$sessions"

# Update SketchyBar
if [ "$session_count" -eq 0 ]; then
  sketchybar --set "$NAME" drawing=off 2>/dev/null
elif [ -n "$attached" ]; then
  sketchybar --set "$NAME" drawing=on label="$attached" label.color=0xffa6da95 2>/dev/null
elif [ "$session_count" -eq 1 ]; then
  sketchybar --set "$NAME" drawing=on label="$first_session" label.color=0xff80ff00 2>/dev/null
else
  sketchybar --set "$NAME" drawing=on label="$session_count" label.color=0xfff5a97f 2>/dev/null
fi

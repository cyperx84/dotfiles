#!/bin/bash

# Hermes status: green if the Hermes agent (gateway or dashboard) is running.
# We match the process rather than the dashboard port 9120, because the gateway
# is the persistent daemon -- the dashboard TUI may be closed while Hermes runs.

[ -z "$NAME" ] && exit 1

GREY="0xff6e6a86"
GREEN="0xffa6da95"

if pgrep -f "hermes_cli.main" &>/dev/null; then
  sketchybar --set "$NAME" drawing=on icon.color="$GREEN" 2>/dev/null
else
  sketchybar --set "$NAME" drawing=on icon.color="$GREY" 2>/dev/null
fi

#!/bin/bash

# opencode status:
#   red   = an opencode session is waiting for your input (from its plugin)
#   green = opencode is running (thinking, or a TUI process is up)
#   grey  = not running
#
# The waiting/thinking signal comes from the opencode plugin writing status files
# to ~/.cache/opencode-sessions/ (see mac/opencode/plugins/). If absent we fall
# back to a plain process check.

[ -z "$NAME" ] && exit 1

GREY="0xff6e6a86"
GREEN="0xffa6da95"
RED="0xffed8796"

source "$(dirname "$0")/agents_lib.sh"

count_states opencode   # sets AGENT_WAITING / AGENT_THINKING

if [ "${AGENT_WAITING:-0}" -gt 0 ]; then
  sketchybar --set "$NAME" drawing=on icon.color="$RED" label="$AGENT_WAITING" label.color="$RED" 2>/dev/null
elif [ "${AGENT_THINKING:-0}" -gt 0 ]; then
  sketchybar --set "$NAME" drawing=on icon.color="$GREEN" label="$AGENT_THINKING" label.color="$GREEN" 2>/dev/null
elif pgrep -f "[o]pencode" &>/dev/null; then
  sketchybar --set "$NAME" drawing=on icon.color="$GREEN" label="" 2>/dev/null
else
  sketchybar --set "$NAME" drawing=on icon.color="$GREY" label="" 2>/dev/null
fi

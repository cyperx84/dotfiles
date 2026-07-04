#!/bin/bash

# opencode status:
#   red   = an opencode TUI is waiting for your input
#   green = an opencode TUI is working (thinking)
#   grey  = no opencode TUI open
#
# opencode's plugin API doesn't deliver session events to the TUI process, so
# state is read from the pane content instead ("esc interrupt" in the footer ==
# working) -- see opencode_panes() in agents_lib.sh. Pane-only: a headless
# opencode background process without a TUI stays grey.

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
else
  sketchybar --set "$NAME" drawing=on icon.color="$GREY" label="" 2>/dev/null
fi

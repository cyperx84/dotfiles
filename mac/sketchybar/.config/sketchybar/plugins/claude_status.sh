#!/bin/bash

# Claude Code status: reduces live ~/.cache/claude-sessions/*.json into one icon.
# "waiting" = Claude finished responding, idle for your next prompt (needs attention).
# "thinking" = Claude is actively processing (busy, no action needed yet).
#
# The SessionEnd cleanup hook doesn't always fire (crashes/force-kills), so this
# directory accumulates stale files. We pre-filter by mtime, then confirm each
# candidate's recorded pid is actually alive before trusting its state.
#
# Clicking the icon (and cmd-shift-enter) jumps to the waiting session via
# claude_jump.sh; the click_script is set statically in items/agents.sh.

[ -z "$NAME" ] && exit 1

STATUS_DIR="${HOME}/.cache/claude-sessions"
GREY="0xff6e6a86"
GREEN="0xffa6da95"
RED="0xffed8796"

command -v jq &>/dev/null || { sketchybar --set "$NAME" drawing=off 2>/dev/null; exit 0; }

waiting_count=0
thinking_count=0

while IFS= read -r -d '' file; do
  data=$(jq -r '[.pid, .state] | join(" ")' "$file" 2>/dev/null) || continue
  read -r pid state <<< "$data"

  [ -z "$pid" ] && continue
  kill -0 "$pid" 2>/dev/null || continue

  if [ "$state" = "waiting" ]; then
    ((waiting_count++))
  elif [ "$state" = "thinking" ]; then
    ((thinking_count++))
  fi
done < <(find "$STATUS_DIR" -maxdepth 1 -name 'claude-*.json' -mmin -60 -print0 2>/dev/null)

if [ "$waiting_count" -gt 0 ]; then
  sketchybar --set "$NAME" drawing=on icon.color="$RED" label="$waiting_count" label.color="$RED" 2>/dev/null
elif [ "$thinking_count" -gt 0 ]; then
  sketchybar --set "$NAME" drawing=on icon.color="$GREEN" label="$thinking_count" label.color="$GREEN" 2>/dev/null
else
  sketchybar --set "$NAME" drawing=on icon.color="$GREY" label="" 2>/dev/null
fi

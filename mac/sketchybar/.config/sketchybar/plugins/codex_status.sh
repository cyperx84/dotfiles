#!/bin/bash

# Codex status:
#   red   = a Codex session is waiting for your input (from its status hooks)
#   green = Codex is running (thinking, or an app-server process is up)
#   grey  = not running
#
# The waiting/thinking signal comes from the Codex hooks writing status files to
# ~/.cache/codex-sessions/ (see mac/codex/hooks/). If those aren't present we
# fall back to a plain process check so the icon still reflects "running".

[ -z "$NAME" ] && exit 1

GREY="0xff6e6a86"
GREEN="0xffa6da95"
RED="0xffed8796"

source "$(dirname "$0")/agents_lib.sh"

count_states codex   # sets AGENT_WAITING / AGENT_THINKING

if [ "${AGENT_WAITING:-0}" -gt 0 ]; then
  sketchybar --set "$NAME" drawing=on icon.color="$RED" label="$AGENT_WAITING" label.color="$RED" 2>/dev/null
elif [ "${AGENT_THINKING:-0}" -gt 0 ]; then
  sketchybar --set "$NAME" drawing=on icon.color="$GREEN" label="$AGENT_THINKING" label.color="$GREEN" 2>/dev/null
else
  # No hook-tracked session -> reflect whether a real Codex is running at all.
  # Exclude OpenClaw-spawned `codex app-server --listen stdio://` subprocesses.
  found_real_codex=0
  for pid in $(pgrep -f "codex app-server" 2>/dev/null); do
    cmd=$(ps -p "$pid" -o command= 2>/dev/null)
    case "$cmd" in
      "") ;;
      *"listen stdio"*) ;;
      *) found_real_codex=1; break ;;
    esac
  done
  if [ "$found_real_codex" -eq 1 ]; then
    sketchybar --set "$NAME" drawing=on icon.color="$GREEN" label="" 2>/dev/null
  else
    sketchybar --set "$NAME" drawing=on icon.color="$GREY" label="" 2>/dev/null
  fi
fi

#!/usr/bin/env bash
################################################################################
# agent_jump.sh [tool] - jump to an AI agent session that needs input
################################################################################
# tool (optional): all | claude | codex | opencode   (default: all)
#
# Round-robins through waiting sessions one per invocation (SketchyBar icon
# clicks pass a tool; the Aerospace cmd-shift-enter keybind passes "all").
# Falls back to the most recent thinking session, then workspace 3.
################################################################################

source "$(dirname "$0")/agents_lib.sh"

filter="${1:-all}"
STATE_FILE="/tmp/agent_jump.${filter}.state"

command -v jq &>/dev/null || exit 0
command -v tmux &>/dev/null || { aerospace workspace 3 2>/dev/null; exit 0; }

waiting=()
think_pick=""; think_ts=""
while IFS=$'\t' read -r state tool tgt ts; do
  [ -z "$tgt" ] && continue
  if [ "$state" = waiting ]; then
    waiting+=("$tgt")
  elif [ "$state" = thinking ]; then
    if [ -z "$think_pick" ] || [[ "$ts" > "$think_ts" ]]; then
      think_pick="$tgt"; think_ts="$ts"
    fi
  fi
done < <(emit_agents "$filter")

pick=""
if [ ${#waiting[@]} -gt 0 ]; then
  # Round-robin: stable order, advance one slot per press; reset when the set
  # changes (e.g. after you answer one and it drops out).
  IFS=$'\n' waiting=($(printf '%s\n' "${waiting[@]}" | sort -u)); unset IFS
  sig=$(printf '%s|' "${waiting[@]}")
  n=${#waiting[@]}
  idx=0
  if [ -f "$STATE_FILE" ]; then
    IFS='=' read -r prev_sig prev_idx < "$STATE_FILE"
    [ "$prev_sig" = "$sig" ] && idx=$(( (prev_idx + 1) % n ))
  fi
  printf '%s=%s' "$sig" "$idx" > "$STATE_FILE"
  pick="${waiting[$idx]}"
elif [ -n "$think_pick" ]; then
  pick="$think_pick"
fi

if [ -z "$pick" ]; then
  aerospace workspace 3 2>/dev/null
  exit 0
fi

focus_tmux_target "$pick"

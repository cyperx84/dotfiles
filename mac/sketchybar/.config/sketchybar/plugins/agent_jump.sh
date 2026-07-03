#!/usr/bin/env bash
################################################################################
# agent_jump.sh [tool] - jump to an AI agent session that needs input
################################################################################
# tool (optional): all | claude | codex | opencode   (default: all)
#
# Collects every live session in state=waiting for the requested tool(s) and
# round-robins through them one per invocation (used by the SketchyBar icon
# clicks -- per tool -- and the Aerospace cmd-shift-enter keybind -- all tools).
# Falls back to the most recent 'thinking' session, then workspace 3.
################################################################################

source "$(dirname "$0")/agents_lib.sh"

filter="${1:-all}"
STATE_FILE="/tmp/agent_jump.${filter}.state"   # round-robin cursor per filter

command -v jq &>/dev/null || exit 0
command -v tmux &>/dev/null || { aerospace workspace 3 2>/dev/null; exit 0; }

waiting=()
think_pick=""; think_ts=""
for entry in "${AGENT_DIRS[@]}"; do
  dir="${entry%%:*}"; tool="${entry##*:}"
  [ "$filter" = all ] || [ "$filter" = "$tool" ] || continue
  [ -d "$dir" ] || continue
  while IFS= read -r -d '' f; do
    state=$(jq -r '.state // empty' "$f" 2>/dev/null)
    [ "$state" = waiting ] || [ "$state" = thinking ] || continue
    tgt=$(resolve_target "$f"); [ -z "$tgt" ] && continue
    if [ "$state" = waiting ]; then
      waiting+=("$tgt")
    else
      ts=$(jq -r '.last_activity // empty' "$f" 2>/dev/null)
      if [ -z "$think_pick" ] || [[ "$ts" > "$think_ts" ]]; then
        think_pick="$tgt"; think_ts="$ts"
      fi
    fi
  done < <(find "$dir" -maxdepth 1 -name '*.json' -mmin -1440 -print0 2>/dev/null)
done

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

#!/usr/bin/env bash
# Storm-proof batched refresh of ALL AeroSpace workspace indicators.
#
# Replaces the old per-space polling (which ran `aerospace list-windows` +
# `list-workspaces --focused` for each of 9 spaces on every event incl. the
# high-frequency front_app_switched -> 18 CLI calls per burst -> pile-up -> fork
# storm). Here: ONE `list-windows --all` query + ONE focused query update all 9
# spaces (highlight + window-count label + hide-empty visibility) in a single
# sketchybar transaction. An mkdir lock makes concurrent triggers a no-op, so
# triggers can never stack even if the aerospace CLI is momentarily slow.

CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"
source "$CONFIG_DIR/colors.sh"

LOCKDIR="/tmp/sketchybar_spaces_refresh.lock"
# Reclaim a stale lock (a run that hung/died) older than ~15s.
if [ -d "$LOCKDIR" ] && [ -n "$(find "$LOCKDIR" -maxdepth 0 -mmin +0.25 2>/dev/null)" ]; then
  rmdir "$LOCKDIR" 2>/dev/null
fi
# Non-blocking lock: if a refresh is already running, skip this trigger.
mkdir "$LOCKDIR" 2>/dev/null || exit 0
trap 'rmdir "$LOCKDIR" 2>/dev/null' EXIT

# Window-manager detect (AeroSpace or HyprSpace).
if pgrep -x "HyprSpace" >/dev/null 2>&1; then WM="hyprspace"; else WM="aerospace"; fi

# Exactly TWO CLI calls, regardless of workspace count.
# timeout guard: aerospace 0.20.x betas can deadlock `list-windows` on its
# server socket (blocked read, 0% CPU, never returns) under concurrent queries.
# Unguarded these leaked forever (bash + child reparented to PID 1, one per
# ~minute), piled up stuck server connections, and dragged the WM. `timeout`
# kills a wedged query at 3s (SIGKILL 1s later if it ignores TERM) so the run
# exits, releases the mkdir lock, and the lock can serialize again instead of
# being stale-reclaimed out from under a hung run.
counts="$(timeout -k 1 3 $WM list-windows --all --format '%{workspace}' 2>/dev/null | sort | uniq -c)"
focused="$(timeout -k 1 3 $WM list-workspaces --focused 2>/dev/null)"
[ -z "$focused" ] && focused=1

args=()
for sid in 1 2 3 4 5 6 7 8 9; do
  count="$(awk -v w="$sid" '$2==w {print $1; exit}' <<<"$counts")"
  count="${count:-0}"

  case "$count" in
    0) label="" ;;
    1) label="•" ;;
    2) label="••" ;;
    3) label="•••" ;;
    *) label="$count" ;;
  esac

  # Visibility: spaces 1-3 always; 4-9 only when occupied or focused.
  if [ "$sid" -le 3 ] 2>/dev/null || [ "$count" -gt 0 ] || [ "$sid" = "$focused" ]; then
    draw="on"
  else
    draw="off"
  fi

  if [ "$sid" = "$focused" ]; then
    args+=(--set "space.$sid" drawing="$draw" label="$label"
      icon.highlight=on label.highlight=on
      label.color="$SPACE_ACTIVE_TEXT" icon.color="$SPACE_WINDOW_INDICATOR"
      background.color="$SPACE_ACTIVE_BG" background.border_color="$SPACE_ACTIVE_BORDER"
      background.border_width=2 background.corner_radius=12 background.height=24
      background.shadow.drawing=off padding_left=3 padding_right=3)
  else
    args+=(--set "space.$sid" drawing="$draw" label="$label"
      icon.highlight=off label.highlight=off
      label.color="$SPACE_ACTIVE_TEXT" icon.color="$SPACE_WINDOW_INDICATOR"
      background.color="$SPACE_INACTIVE_BG" background.border_color="$SPACE_INACTIVE_BORDER"
      background.border_width=1 background.corner_radius=10 background.height=20
      background.shadow.drawing=off padding_left=2 padding_right=2)
  fi
done

sketchybar "${args[@]}"

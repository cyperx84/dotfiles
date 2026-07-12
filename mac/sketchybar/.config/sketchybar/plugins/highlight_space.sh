#!/usr/bin/env bash
# Instant workspace highlight — zero CLI calls, no lock.
#
# The aerospace on-workspace-change trigger already hands us the focused
# workspace id in $FOCUSED_WORKSPACE, so the highlight can move the instant a
# switch happens without querying aerospace at all. This is deliberately
# decoupled from refresh_spaces.sh: `aerospace list-windows --all` (window
# counts + hide-empty) runs ~1.5s under load and can deadlock, so binding the
# highlight to it made switches lag up to 5s. Here the highlight is immediate;
# refresh_spaces.sh reconciles counts/visibility on its 5s poll.
#
# Sets ONLY highlight + active/inactive pill styling. Does NOT touch `label`
# (would wipe the window-count dots) or non-focused `drawing` (hide-empty is
# owned by refresh_spaces.sh). The focused space is forced drawing=on so
# switching onto an otherwise-hidden empty workspace still shows it.

CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"
source "$CONFIG_DIR/colors.sh"

focused="${FOCUSED_WORKSPACE:-1}"

args=()
for sid in 1 2 3 4 5 6 7 8 9; do
  if [ "$sid" = "$focused" ]; then
    args+=(--set "space.$sid" drawing=on
      icon.highlight=on label.highlight=on
      label.color="$SPACE_ACTIVE_TEXT" icon.color="$SPACE_WINDOW_INDICATOR"
      background.color="$SPACE_ACTIVE_BG" background.border_color="$SPACE_ACTIVE_BORDER"
      background.border_width=2 background.corner_radius=12 background.height=24
      background.shadow.drawing=off padding_left=3 padding_right=3)
  else
    args+=(--set "space.$sid"
      icon.highlight=off label.highlight=off
      label.color="$SPACE_ACTIVE_TEXT" icon.color="$SPACE_WINDOW_INDICATOR"
      background.color="$SPACE_INACTIVE_BG" background.border_color="$SPACE_INACTIVE_BORDER"
      background.border_width=1 background.corner_radius=10 background.height=20
      background.shadow.drawing=off padding_left=2 padding_right=2)
  fi
done

sketchybar "${args[@]}"

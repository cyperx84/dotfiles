#!/usr/bin/env bash
# kanata_hrm.sh — home row mods on/off indicator.
#
# kanata runs with `--port 10000` and pushes the CURRENT layer as the first
# `{"LayerChange":...}` line on every client connect, then streams subsequent
# changes. We connect, grab that first line, map the layer name to an HRM
# mode, and colour the item. No daemon: this is a polling plugin (update_freq),
# so it self-inits on every `sketchybar --reload`.
#
# Layer -> mode map:
#   *vanilla* (vanilla/numsvanilla/fnvanilla)  -> HRM OFF
#   sym  or empty (shared / unreachable poll)  -> keep last state (exit)
#   everything else (base/nums/fn)             -> HRM ON

source "$CONFIG_DIR/colors.sh" 2>/dev/null

OFF_COLOR=0xff787c99   # muted grey, visible on the dark bar (GREY is too dark)

LAYER="$(/usr/bin/nc -w1 127.0.0.1 10000 2>/dev/null \
  | grep -m1 '"LayerChange"' \
  | /opt/homebrew/bin/jq -r '.LayerChange.new' 2>/dev/null)"

case "$LAYER" in
  *vanilla*) STATE=off ;;
  sym | "")  exit 0 ;;   # ambiguous: don't clobber the last known state
  *)         STATE=on ;;
esac

if [ "$STATE" = "on" ]; then
  sketchybar --set "$NAME" label="HRM" icon.color="$GREEN" label.color="$GREEN"
else
  sketchybar --set "$NAME" label="off" icon.color="$OFF_COLOR" label.color="$OFF_COLOR"
fi

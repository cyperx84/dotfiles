#!/usr/bin/env bash
# kanata_hrm.sh — home row mods on/off indicator (3s poll RECONCILER).
#
# The instant path is kanata_hrm_listen.sh (persistent TCP stream). This poll
# stays as a safety net: it corrects the indicator if the listener dies, misses
# an event, or hasn't started yet. Both share hrm_apply() in kanata_hrm_lib.sh.
#
# kanata runs with `--port 10000` and pushes the CURRENT layer as the first
# `{"LayerChange":...}` line on every client connect; we read that one line and
# apply it. Self-inits on every `sketchybar --reload`.

source "$CONFIG_DIR/colors.sh" 2>/dev/null
source "$CONFIG_DIR/plugins/kanata_hrm_lib.sh"

LAYER="$(/usr/bin/nc -w1 127.0.0.1 10000 2>/dev/null \
  | grep -m1 '"LayerChange"' \
  | /opt/homebrew/bin/jq -r '.LayerChange.new' 2>/dev/null)"

hrm_apply "$LAYER" "$NAME"

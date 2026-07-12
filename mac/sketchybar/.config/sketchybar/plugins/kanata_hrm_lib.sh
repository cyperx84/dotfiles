#!/usr/bin/env bash
# Shared home-row-mods indicator logic.
#
# Sourced by both kanata_hrm.sh (3s poll reconciler) and kanata_hrm_listen.sh
# (instant TCP listener) so the layer->state->colour mapping lives in one place.
# Expects colors.sh already sourced in the caller (for $GREEN).
#
# Layer -> mode map (kanata pushes {"LayerChange":{"new":"<layer>"}}):
#   *vanilla* (vanilla/numsvanilla/fnvanilla)  -> HRM OFF
#   sym or empty (transient / ambiguous poll)  -> keep last state
#   everything else (base/nums/fn)             -> HRM ON

HRM_OFF_COLOR=0xff787c99   # muted grey, visible on the dark bar (GREY too dark)

hrm_apply() {  # $1 = kanata layer name, $2 = item name (default kanata_hrm)
  local layer="$1" item="${2:-kanata_hrm}" state
  case "$layer" in
    *vanilla*) state=off ;;
    sym | "")  return 0 ;;
    *)         state=on ;;
  esac
  if [ "$state" = "on" ]; then
    sketchybar --set "$item" label="HRM" icon.color="$GREEN" label.color="$GREEN"
  else
    sketchybar --set "$item" label="off" icon.color="$HRM_OFF_COLOR" label.color="$HRM_OFF_COLOR"
  fi
}

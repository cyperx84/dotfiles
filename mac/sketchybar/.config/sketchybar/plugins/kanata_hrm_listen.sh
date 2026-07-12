#!/usr/bin/env bash
# Instant home-row-mods indicator.
#
# Stays connected to kanata's TCP layer stream (--port 10000) and applies the
# HRM indicator the moment a {"LayerChange":...} arrives — no polling latency.
# kanata emits the current layer on connect, then streams every change, so this
# also self-inits to the correct state. Reconnects if kanata restarts/drops.
#
# Launched (deduped) from items/kanata_hrm.lua on config load. The 3s
# kanata_hrm.sh poll stays as a reconciler in case this listener dies or misses.

CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"
source "$CONFIG_DIR/colors.sh" 2>/dev/null
source "$CONFIG_DIR/plugins/kanata_hrm_lib.sh"

# Single instance: kill any prior listener, keep self ($$). Makes --reload and
# sketchybar restarts idempotent instead of stacking listeners.
for p in $(pgrep -f kanata_hrm_listen.sh 2>/dev/null); do
  [ "$p" != "$$" ] && kill "$p" 2>/dev/null
done

last=""
while true; do
  # Blocks streaming layer events; returns when kanata drops the connection.
  # kanata streams ALL events (a TapActivated per keystroke, etc). grep filters
  # to LayerChange lines in C so bash only wakes on an actual layer change, not
  # on every keypress. --line-buffered keeps it real-time.
  while IFS= read -r line; do
    # Bash-extract .LayerChange.new — no jq spawn in the hot path.
    layer="${line#*\"new\":\"}"; layer="${layer%%\"*}"
    # Dedupe: only touch sketchybar when the on/off state actually flips.
    case "$layer" in
      *vanilla*) state=off ;;
      sym | "")  continue ;;
      *)         state=on ;;
    esac
    [ "$state" = "$last" ] && continue
    last="$state"
    hrm_apply "$layer"
  done < <(/usr/bin/nc 127.0.0.1 10000 2>/dev/null \
             | grep --line-buffered '"LayerChange"')
  last=""        # force re-apply after a reconnect
  sleep 2        # kanata gone / connection dropped → retry
done

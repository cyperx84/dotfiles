#!/usr/bin/env bash
# Install the kanata TCC-permission watcher as a user LaunchAgent.
#
# The watcher (kanata-perm-watch.sh) exists but does nothing unless something
# runs it. This wires it to launchd's WatchPaths on /tmp/kanata.err.log so it
# fires the moment kanata logs a missing-permission error after a
# `brew upgrade kanata` (cdhash change drops Input Monitoring + Accessibility).
#
# Idempotent + no sudo (user agent). Substitutes __HOME__ so the same tracked
# plist works on any machine (cyperx / m1 home paths). Re-run any time.
set -euo pipefail

SRC_DIR="${HOME}/.config/kanata"
TEMPLATE="${SRC_DIR}/com.cyperx.kanata-perm-watch.plist"
LABEL="com.cyperx.kanata-perm-watch"
DEST="${HOME}/Library/LaunchAgents/${LABEL}.plist"
SCRIPT="${SRC_DIR}/kanata-perm-watch.sh"

[ -r "$TEMPLATE" ] || { echo "missing template: $TEMPLATE" >&2; exit 1; }
[ -x "$SCRIPT" ] || chmod +x "$SCRIPT" 2>/dev/null || true

mkdir -p "${HOME}/Library/LaunchAgents"
# Materialize the plist with this machine's real HOME (launchd wants a concrete
# path, and copying — not symlinking — avoids launchd's symlink quirks).
sed "s|__HOME__|${HOME}|g" "$TEMPLATE" > "$DEST"

# Reload: bootout the old instance (ignore if absent), then bootstrap fresh.
launchctl bootout "gui/$(id -u)/${LABEL}" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" "$DEST"
launchctl enable "gui/$(id -u)/${LABEL}"

echo "installed + loaded: ${LABEL}"
echo "  plist:  $DEST"
echo "  watches: /tmp/kanata.err.log -> $SCRIPT"
launchctl print "gui/$(id -u)/${LABEL}" >/dev/null 2>&1 && echo "  status: loaded ✓" || echo "  status: NOT loaded — check 'launchctl print gui/$(id -u)/${LABEL}'"

#!/bin/bash
# kanata-perm-watch.sh
# Detects the TCC permission-orphan failure that happens after a kanata
# binary path change (brew upgrade moves the Cellar path; macOS pins
# Input Monitoring + Accessibility grants to the OLD resolved path).
#
# Triggered by a LaunchAgent WatchPaths on /tmp/kanata.err.log.
# Cannot re-grant TCC (SIP-protected) — instead it notifies and opens the
# exact Settings panes so re-granting is a 60-second known runbook.

set -euo pipefail

ERR_LOG="/tmp/kanata.err.log"
COOLDOWN_MARKER="/tmp/kanata-perm-watch.cooldown"
COOLDOWN_SECS=300   # don't renotify more than once per 5 min during a flap

[[ -f "$ERR_LOG" ]] || exit 0

# Only care about the tail — the current flap, not ancient history.
TAIL="$(tail -5 "$ERR_LOG" 2>/dev/null || true)"

perm_hit=""
if grep -qi 'Input Monitoring permission' <<<"$TAIL"; then
    perm_hit="Input Monitoring"
    pane="Privacy_ListenEvent"
elif grep -qi 'Accessibility permission' <<<"$TAIL"; then
    perm_hit="Accessibility"
    pane="Privacy_Accessibility"
fi

[[ -n "$perm_hit" ]] || exit 0

# Cooldown: skip if we notified recently.
if [[ -f "$COOLDOWN_MARKER" ]]; then
    last=$(stat -f %m "$COOLDOWN_MARKER" 2>/dev/null || echo 0)
    now=$(date +%s)
    (( now - last < COOLDOWN_SECS )) && exit 0
fi
touch "$COOLDOWN_MARKER"

CURRENT_BIN="$(readlink -f /opt/homebrew/bin/kanata 2>/dev/null || echo /opt/homebrew/bin/kanata)"

osascript -e "display notification \"Grant $perm_hit to kanata, remove stale entry. Current binary: $CURRENT_BIN\" with title \"kanata broken: missing $perm_hit\" sound name \"Basso\"" || true

# Open the relevant Settings pane so the toggle is one click away.
open "x-apple.systempreferences:com.apple.preference.security?$pane" || true

exit 0

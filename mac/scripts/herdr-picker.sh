#!/usr/bin/env bash
# Cold-launch entry point for herdr, run inside a fresh Ghostty window by the
# alt+space hotkey in mac/hammerspoon/.hammerspoon/init.lua:
#
#   open -na Ghostty --args --title=herdr -e herdr-picker.sh
#
# Picks a session when there's more than one, otherwise attaches straight in.
# Focusing an already-running herdr and opening its navigator is Hammerspoon's
# job, not this script's.
set -uo pipefail

HERDR=/opt/homebrew/bin/herdr

sessions() { "$HERDR" session list 2>/dev/null | awk 'NR>1 && NF {print $1}'; }

list=$(sessions)
case $(printf '%s\n' "$list" | grep -c .) in
    0) exec "$HERDR" ;;                          # no sessions yet: plain launch
    1) exec "$HERDR" session attach "$list" ;;   # only one: nothing to pick
esac

command -v fzf >/dev/null || exec "$HERDR"

session=$(printf '%s\n' "$list" | fzf --height 40% --reverse --border --prompt 'herdr ')
[[ -z "$session" ]] && exit 0
exec "$HERDR" session attach "$session"

#!/usr/bin/env bash
# Run herdr from a local build (~/github/herdr) instead of Homebrew's, and back.
#
#   herdr-build.sh status          which herdr is linked, which is running
#   herdr-build.sh switch [--force] stop herdr, link the local build
#   herdr-build.sh revert [--force] stop herdr, link Homebrew's herdr again
#
# Switching stops every running herdr session, which ends every process in its
# panes. It refuses while an agent is working or blocked unless --force. Run it
# from a terminal outside herdr, since it stops the herdr it would run inside.
# The build is copied, not linked, so a later `cargo build` cannot swap the
# binary under a running server.
set -euo pipefail

LINK=/opt/homebrew/bin/herdr
BUILD="$HOME/github/herdr/target/release/herdr"
INSTALL_DIR="$HOME/.local/share/herdr-build"
INSTALLED="$INSTALL_DIR/herdr"

current() { readlink "$LINK" 2>/dev/null || echo "(not a link)"; }

running_sessions() {
    "$LINK" session list --json 2>/dev/null |
        python3 -c 'import json,sys; [print(s["name"]) for s in json.load(sys.stdin)["sessions"] if s["running"]]'
}

busy_agents() {
    for session in $(running_sessions); do
        "$LINK" --session "$session" agent list 2>/dev/null |
            python3 -c '
import json, sys
session = sys.argv[1]
for a in json.load(sys.stdin)["result"]["agents"]:
    if a["agent_status"] in ("working", "blocked"):
        print("  %s: %s is %s" % (session, a.get("name") or a["pane_id"], a["agent_status"]))
' "$session"
    done
}

stop_all() {
    local force=$1
    local busy
    busy=$(busy_agents)
    if [[ -n $busy && $force != --force ]]; then
        printf 'Agents are still running:\n%s\nWait for them, or pass --force.\n' "$busy" >&2
        exit 1
    fi
    local sessions
    sessions=$(running_sessions)
    if [[ -n $sessions ]]; then
        printf 'This stops these herdr sessions and everything running in them:\n%s\n' "$sessions"
        read -r -p "Continue? [y/N] " answer
        [[ $answer == [yY] ]] || { echo "Nothing changed."; exit 1; }
        for session in $sessions; do
            "$LINK" session stop "$session"
        done
    fi
}

case "${1:-status}" in
status)
    echo "linked:  $(current)"
    "$LINK" --version
    "$LINK" status server 2>/dev/null | grep -E 'status|version' || true
    # Say plainly whose herdr is in the path. A Homebrew upgrade or `herdr
    # update` can put the stock binary back, and the symptom of that is not an
    # error: picker rows for other machines simply stop working, because the
    # stock build has no client.focus.
    if [[ $(current) == "$INSTALLED" ]]; then
        echo "build:   local (client.focus available)"
        if [[ -x $BUILD ]] && ! cmp -s "$BUILD" "$INSTALLED"; then
            echo "         note: $BUILD is newer than the installed copy; run: $0 switch"
        fi
    else
        echo "build:   NOT the local build — run: $0 switch"
    fi
    ;;
switch)
    [[ -x $BUILD ]] || { echo "No build at $BUILD. Run: cargo build --release" >&2; exit 1; }
    stop_all "${2:-}"
    mkdir -p "$INSTALL_DIR"
    cp "$BUILD" "$INSTALLED.new" && mv "$INSTALLED.new" "$INSTALLED"
    ln -sfn "$INSTALLED" "$LINK"
    echo "herdr now runs the local build: $("$LINK" --version). Start it with: herdr"
    ;;
revert)
    stop_all "${2:-}"
    # brew still records herdr as linked, so plain `brew link` would do nothing.
    rm -f "$LINK"
    brew unlink herdr >/dev/null
    brew link herdr >/dev/null
    echo "herdr is Homebrew's again: $("$LINK" --version). Start it with: herdr"
    ;;
*)
    sed -n '2,12p' "$0" >&2
    exit 2
    ;;
esac

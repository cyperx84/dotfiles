#!/bin/sh
# Master installer: runs each component installer in dependency order.
# Executes (not sources) each script so a failure aborts cleanly without
# leaking variables, and resolves paths relative to this script so it can be
# run from any working directory.
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

bash "$SCRIPT_DIR/install-stow.sh"
bash "$SCRIPT_DIR/install-ghostty.sh"
bash "$SCRIPT_DIR/install-kanata.sh"
bash "$SCRIPT_DIR/install-zen-browser.sh"

#!/usr/bin/env bash
# Stow ~/.config/mise and install every tool it pins: the coding harnesses
# (claude, codex) and their runtimes. Add a tool with `mise use -g <tool>`, which
# writes straight into the stowed config.toml. Hermes is the desktop app's
# (install-apps.sh), so never add it here.
set -e
source "$(dirname "$0")/lib.sh"

omarchy-pkg-add stow mise

stow_package mise

mise install

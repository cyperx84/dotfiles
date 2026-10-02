#!/usr/bin/env bash
# Stow ~/.config/mise and install every tool it pins: the coding harnesses
# (claude, codex) and their runtimes. Add a tool with `mise use -g <tool>`, which
# writes straight into the stowed config.toml. Hermes is the desktop app's
# (install-apps.sh), so never add it here.
set -e

OMARCHY_DIR="$(cd "$(dirname "$0")/.." && pwd)"

omarchy-pkg-add stow mise

# A real config.toml (e.g. from an earlier `mise use -g`) blocks the symlink.
# Compare by inode: stow links the whole ~/.config/mise dir, so the file itself
# is never a symlink.
cfg="$HOME/.config/mise/config.toml"
if [[ -f $cfg && ! $cfg -ef $OMARCHY_DIR/mise/.config/mise/config.toml ]]; then
  mv "$cfg" "$cfg.bak"
  echo "Moved existing $cfg to $cfg.bak"
fi

cd "$OMARCHY_DIR"
stow mise

mise install

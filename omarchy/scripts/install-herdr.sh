#!/usr/bin/env bash
# Stow the herdr config and install its plugins.
set -e

OMARCHY_DIR="$(cd "$(dirname "$0")/.." && pwd)"

omarchy-pkg-add stow herdr

# A real config.toml (e.g. written by herdr's first run) blocks the symlink
cfg="$HOME/.config/herdr/config.toml"
if [[ -f $cfg && ! -L $cfg ]]; then
  mv "$cfg" "$cfg.bak"
  echo "Moved existing config to $cfg.bak"
fi

cd "$OMARCHY_DIR"
stow herdr

# Plugins are machine state (plugins.json, plugins/), so install rather than stow.
# ctrl+h/j/k/l across herdr panes and nvim splits (config.toml routes through it).
herdr plugin list 2>/dev/null | grep -q herdr-navigator ||
  herdr plugin install kaar/nvim-herdr-navigator

herdr server reload-config 2>/dev/null || true
echo "Done. Plugin keys need the matching nvim side: see kaar/nvim-herdr-navigator."

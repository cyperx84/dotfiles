#!/usr/bin/env bash
# Stow the herdr config, install its plugins and the official herdr skill.
set -e
source "$(dirname "$0")/lib.sh"

omarchy-pkg-add stow herdr

stow_package herdr

# Plugins are machine state (plugins.json, plugins/), so install rather than stow.
# --yes because these run unattended; each one is bound in config.toml.
install_plugin() { # <github owner/repo> <plugin id>
  herdr plugin list 2>/dev/null | grep -q "^- $2 " || herdr plugin install "$1" --yes
}
install_plugin kaar/nvim-herdr-navigator herdr-navigator # ctrl+h/j/k/l across panes and nvim splits

# The official skill ships inside the binary (`herdr --skill`), so it is generated,
# not committed. Run it now and install it as an Omarchy post-update hook so it
# follows herdr upgrades (`omarchy update`).
"$OMARCHY_DIR/scripts/herdr-skill.hook"
omarchy-hook-install post-update "$OMARCHY_DIR/scripts/herdr-skill.hook"

herdr server reload-config 2>/dev/null || true
echo "Done. Plugin keys need the matching nvim side: see kaar/nvim-herdr-navigator."

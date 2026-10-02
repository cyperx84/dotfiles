#!/usr/bin/env bash
# Look deltas over stock Omarchy: the tokyo-night accent override and the bar tweaks.
set -e
source "$(dirname "$0")/lib.sh"

omarchy-pkg-add stow

overlay="$HOME/.config/omarchy/themes/tokyo-night/colors.toml"
[[ $overlay -ef $OMARCHY_DIR/theme/.config/omarchy/themes/tokyo-night/colors.toml ]] && linked=1

# --no-folding: a folded ~/.config/omarchy/themes would put every theme Omarchy
# installs later inside this repo.
stow_package theme --no-folding

# An overlay only takes effect when its theme is applied, so re-apply on first link
if [[ -z $linked && $(<"$HOME/.local/state/omarchy/current/theme.name") == tokyo-night ]]; then
  omarchy theme set tokyo-night
fi

# The bar rewrites shell.json on every change (write-then-rename), which would
# replace a stowed symlink, so set it through the bar CLI. Both are no-ops when
# already set. Widgets come from their own installers: kanata (install-kanata.sh),
# tailscale (`omarchy install service tailscale`).
omarchy bar transparent true
omarchy bar set omarchy.clock format "dddd h:mm AP"

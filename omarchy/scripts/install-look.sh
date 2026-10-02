#!/usr/bin/env bash
# Look deltas over stock Omarchy: the tokyo-night accent override, the ghostty
# accent template (cursor on the accent), and the bar tweaks.
set -e
source "$(dirname "$0")/lib.sh"

# Linked absolute, not stowed: omarchy-theme-set copies the theme dir with
# `cp -r`, which keeps symlinks, and a stow-relative colors.toml dangles from
# ~/.local/state/omarchy/current/theme - it goes missing and no themed config
# (ghostty, hyprland, bar) gets generated. themed/*.tpl override Omarchy's
# built-in templates by name.
changed=
while IFS= read -r -d '' src; do
  target="$HOME/${src#"$OMARCHY_DIR/theme/"}"
  [[ $target -ef $src ]] && continue
  mkdir -p "$(dirname "$target")"
  if [[ -e $target || -L $target ]]; then
    mv "$target" "$target.bak"
    echo "Moved existing $target to $target.bak"
  fi
  ln -s "$src" "$target"
  changed=1
done < <(find "$OMARCHY_DIR/theme" -type f -print0)

# Drop links whose file was removed from omarchy/theme, so a deleted template or
# overlay stops being applied
while IFS= read -r -d '' link; do
  [[ $(readlink "$link") == "$OMARCHY_DIR/theme/"* && ! -e $link ]] || continue
  rm "$link"
  echo "Removed stale $link"
  changed=1
done < <(find "$HOME/.config/omarchy/themes" "$HOME/.config/omarchy/themed" -type l -print0 2>/dev/null)

# Overlays and templates only take effect when a theme is applied, so re-apply
# the current one whenever a link was added or removed
if [[ -n $changed ]]; then
  omarchy theme set "$(<"$HOME/.local/state/omarchy/current/theme.name")"
fi

# The bar rewrites shell.json on every change (write-then-rename), which would
# replace a stowed symlink, so set it through the bar CLI. Both are no-ops when
# already set. Widgets come from their own installers: kanata (install-kanata.sh),
# tailscale (`omarchy install service tailscale`).
omarchy bar transparent true
omarchy bar set omarchy.clock format "dddd h:mm AP"

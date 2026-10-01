#!/usr/bin/env bash
# Install neovim with multiple side-by-side configs (NVIM_APPNAME).
#   ~/.config/nvim          cyperx84/nvim (main, standalone repo)
#   ~/.config/nvim-lazyvim  Omarchy's stock LazyVim, kept as an alternate
# Each name has its own config/share/state/cache dirs, so plugins never mix.
# Switch with `vv` (picker) or `n` (main); see omarchy/bash/.bashrc.
set -e

omarchy-pkg-add neovim git fd fzf

cfg="$HOME/.config/nvim"
stock="nvim-lazyvim"

# Stock config present (not our repo): move it, with its data, to its own app name
if [[ -d $cfg && ! -d $cfg/.git && ! -e $HOME/.config/$stock ]]; then
  mv "$cfg" "$HOME/.config/$stock"
  for d in .local/share .local/state .cache; do
    [[ -d $HOME/$d/nvim ]] && mv "$HOME/$d/nvim" "$HOME/$d/$stock"
  done
  echo "Kept existing config as NVIM_APPNAME=$stock"
fi

[[ -d $cfg/.git ]] || git clone https://github.com/cyperx84/nvim "$cfg"

echo "Done. Run 'n' for your config, 'vv' to pick between nvim-* configs."
echo "To add another: git clone <repo> ~/.config/nvim-<name>"

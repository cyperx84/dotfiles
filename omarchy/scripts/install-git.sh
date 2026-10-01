#!/usr/bin/env bash
# Stow ~/.config/git/config. The credential helper is `!gh auth git-credential`
# (found on PATH) rather than the absolute path `gh auth setup-git` writes, which
# pointed into a versioned mise directory and broke on every gh upgrade.
set -e

OMARCHY_DIR="$(cd "$(dirname "$0")/.." && pwd)"

omarchy-pkg-add stow git

cfg="$HOME/.config/git/config"
if [[ -f $cfg && ! -L $cfg ]]; then
  mv "$cfg" "$cfg.bak"
  echo "Moved existing $cfg to $cfg.bak"
fi

cd "$OMARCHY_DIR"
stow git

#!/usr/bin/env bash
# Stow ~/.config/git/config. The credential helper is `!gh auth git-credential`
# (found on PATH) rather than the absolute path `gh auth setup-git` writes, which
# pointed into a versioned mise directory and broke on every gh upgrade.
set -e
source "$(dirname "$0")/lib.sh"

omarchy-pkg-add stow git

stow_package git

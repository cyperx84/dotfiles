#!/usr/bin/env bash
# Stow ~/.ssh/config. Host blocks live in ~/.ssh/config.local, which is NOT tracked
# (this repo is public), so create an empty one with the right mode if it's missing.
set -e

OMARCHY_DIR="$(cd "$(dirname "$0")/.." && pwd)"

omarchy-pkg-add stow openssh

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

if [[ -f $HOME/.ssh/config && ! -L $HOME/.ssh/config ]]; then
  mv "$HOME/.ssh/config" "$HOME/.ssh/config.bak"
  echo "Moved existing ~/.ssh/config to config.bak"
fi

cd "$OMARCHY_DIR"
stow ssh

touch "$HOME/.ssh/config.local"
chmod 600 "$HOME/.ssh/config.local"
echo "Add Host blocks to ~/.ssh/config.local"

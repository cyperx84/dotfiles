#!/usr/bin/env bash
# Install the desktop apps this machine runs on top of stock Omarchy. CLI tools
# and coding harnesses live in mise instead (install-mise.sh).
set -e

# Plain packages, straight from the Arch repos
omarchy-pkg-add godot blender

# Omarchy's curated installers theme the app and launch it, so only run each
# one while its package is still missing.
omarchy_install() { # <package> <omarchy install args...>
  local pkg=$1
  shift
  omarchy-pkg-missing "$pkg" && omarchy install "$@"
  return 0
}
omarchy_install openai-codex-desktop ai chatgpt
omarchy_install t3code-bin ai t3 code
omarchy_install openclaw ai openclaw

# The desktop app owns the one Hermes on the machine, `hermes` command included:
# it removes any mise copy (pipx:hermes-agent) and builds its own in ~/.hermes.
omarchy_install hermes-desktop ai hermes

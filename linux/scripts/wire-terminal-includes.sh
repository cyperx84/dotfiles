#!/usr/bin/env bash
# Point Omarchy's terminal configs at our stowed delta files.
#
# Why this exists instead of stowing whole terminal configs:
#
#   - omarchy-display-text-size and omarchy-font-set rewrite
#     ~/.config/{alacritty/alacritty.toml,kitty/kitty.conf,ghostty/config} with
#     `sed -i`, which replaces a stow symlink with a regular file. The stow
#     package then looks fine in the repo and is dead on disk.
#   - Omarchy migrations edit those same files in place to keep them working
#     across upgrades (shift+enter as CSI-u, kitty's listen_on for cwd lookup,
#     the 3.x -> 4.x theme path move). Owning the files means never receiving
#     any of that, and having every migration show up as repo drift.
#
# So Omarchy keeps its files, and we append one include line to each that pulls
# in ours. Migrations and font changes edit around that line; only
# `omarchy-refresh-config <path>` (an explicit `cp -f`, which keeps a .bak)
# removes it, and validate-dotfiles.sh checks for that.
#
# Idempotent. Safe to re-run from bootstrap.sh.

set -uo pipefail

OMARCHY_PATH="${OMARCHY_PATH:-/usr/share/omarchy}"
BACKUP_DIR="${1:-$HOME/dotfiles-backup-$(date +%Y%m%d-%H%M%S)}"

failed=0

# target config | our delta file | include line | repo-relative stow source
wire() {
  local target="$HOME/.config/$1" delta="$HOME/.config/$2" line="$3" prefix="${4:-}"
  local name="${1%%/*}"

  if [[ ! -e $delta ]]; then
    echo "  ⚠ $name: $delta missing — stow the terminals package first"
    failed=1
    return
  fi

  if [[ ! -f $target ]]; then
    # Terminal not installed, or Omarchy never shipped its config. Seed from the
    # Omarchy default if there is one; otherwise skip — nothing to include from.
    if [[ -f "$OMARCHY_PATH/config/$1" ]]; then
      mkdir -p "$(dirname "$target")"
      cp "$OMARCHY_PATH/config/$1" "$target"
      echo "  + $name: seeded $target from the Omarchy default"
    else
      echo "  · $name: no $target and no Omarchy default — skipped"
      return
    fi
  fi

  # Old layout: the target is (or was) our stowed whole-file config. Hand the file
  # back to Omarchy, keeping a copy — the deltas now live in $delta.
  if [[ -L $target ]] || ! cmp -s "$target" "$OMARCHY_PATH/config/$1"; then
    if ! grep -qF "$line" "$target" 2>/dev/null && [[ -f "$OMARCHY_PATH/config/$1" ]]; then
      mkdir -p "$BACKUP_DIR/$(dirname "$1")"
      cp -L "$target" "$BACKUP_DIR/$1"
      rm -f "$target"
      cp "$OMARCHY_PATH/config/$1" "$target"
      echo "  ↺ $name: restored the Omarchy default (yours: $BACKUP_DIR/$1)"
    fi
  fi

  if grep -qF "$line" "$target"; then
    echo "  ✓ $name: already includes $2"
  else
    printf '\n# Personal deltas (dotfiles/linux/terminals). Keep this last.\n%s%s\n' "$prefix" "$line" >>"$target"
    echo "  ✓ $name: include appended to $target"
  fi
}

echo "Wiring Omarchy terminal configs to our deltas..."

# Ghostty and kitty resolve relative include paths against the including file,
# and both let a later value override an earlier one — so appending wins.
wire "ghostty/config"   "ghostty/cyperx.conf" 'config-file = ?"cyperx.conf"'
wire "kitty/kitty.conf" "kitty/cyperx.conf"   'include cyperx.conf'

# foot is the terminal Omarchy 4 ships. Verified on foot 1.27.0: the config is
# parsed top to bottom, `include` is an inline paste, and the last assignment
# wins — so an include at the end overrides everything above it. But `include` is
# only a [main] key, and Omarchy's file ends inside [text-bindings], where the
# line would be read as a key binding. Hence the section header in the prefix.
wire "foot/foot.ini" "foot/cyperx.ini" 'include=~/.config/foot/cyperx.ini' '[main]
'

# Alacritty is TOML: a second `general.import = [...]` key would be a duplicate,
# so extend the existing array instead of appending a line.
alacritty="$HOME/.config/alacritty/alacritty.toml"
if [[ ! -f $HOME/.config/alacritty/cyperx.toml ]]; then
  echo "  ⚠ alacritty: ~/.config/alacritty/cyperx.toml missing — stow the terminals package first"
  failed=1
elif [[ ! -f $alacritty ]]; then
  if [[ -f "$OMARCHY_PATH/config/alacritty/alacritty.toml" ]]; then
    mkdir -p "$(dirname "$alacritty")"
    cp "$OMARCHY_PATH/config/alacritty/alacritty.toml" "$alacritty"
    echo "  + alacritty: seeded $alacritty from the Omarchy default"
  fi
fi
if [[ -f $alacritty ]]; then
  if [[ -L $alacritty ]] || ! cmp -s "$alacritty" "$OMARCHY_PATH/config/alacritty/alacritty.toml"; then
    if ! grep -qF 'cyperx.toml' "$alacritty" && [[ -f "$OMARCHY_PATH/config/alacritty/alacritty.toml" ]]; then
      mkdir -p "$BACKUP_DIR/alacritty"
      cp -L "$alacritty" "$BACKUP_DIR/alacritty/alacritty.toml"
      rm -f "$alacritty"
      cp "$OMARCHY_PATH/config/alacritty/alacritty.toml" "$alacritty"
      echo "  ↺ alacritty: restored the Omarchy default (yours: $BACKUP_DIR/alacritty/alacritty.toml)"
    fi
  fi

  if grep -qF 'cyperx.toml' "$alacritty"; then
    echo "  ✓ alacritty: already imports cyperx.toml"
  elif grep -qE '^general\.import = \[' "$alacritty"; then
    # Our entry goes last: alacritty applies imports in order, later wins.
    sed -i -E 's|^(general\.import = \[.*)\]|\1, "~/.config/alacritty/cyperx.toml" ]|' "$alacritty"
    grep -qF 'cyperx.toml' "$alacritty" \
      && echo "  ✓ alacritty: cyperx.toml added to general.import" \
      || { echo "  ✗ alacritty: could not extend general.import — add it by hand"; failed=1; }
  else
    sed -i '1i general.import = [ "~/.config/alacritty/cyperx.toml" ]' "$alacritty"
    echo "  ✓ alacritty: general.import created"
  fi
fi

exit "$failed"

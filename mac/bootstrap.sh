#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
STOW_TARGET="$HOME"
PACKAGES=(zsh tmux ghostty aerospace borders sketchybar kanata karabiner sesh starship hammerspoon)

echo "==================================="
echo "  Dotfiles Bootstrap (macOS)"
echo "==================================="
echo

# 1. Check Homebrew
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
echo "✓ Homebrew available"

# 2. Install everything from the Brewfile (apps, casks, fonts, CLIs incl. stow)
BREWFILE="$DOTFILES_DIR/macos/Brewfile"
if [[ -f "$BREWFILE" ]]; then
  echo "Installing packages from Brewfile (this can take a while on a fresh machine)..."
  # Don't abort the whole bootstrap if one cask fails — surface it and continue.
  brew bundle --file="$BREWFILE" || echo "⚠ Some Brewfile entries failed — review the output above"
  echo "✓ Brewfile processed"
fi

# 3. Check stow (Brewfile installs it, but keep a fallback)
if ! command -v stow &>/dev/null; then
  echo "Installing stow..."
  brew install stow
fi
echo "✓ GNU Stow available"

# 4. Back up conflicting files and stow
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_DIR="$HOME/dotfiles-backup-$TIMESTAMP"
CONFLICTS=false

cd "$DOTFILES_DIR"
for pkg in "${PACKAGES[@]}"; do
  if ! stow --target="$STOW_TARGET" -n "$pkg" 2>/dev/null; then
    CONFLICTS=true
  fi
done

if [[ "$CONFLICTS" == true ]]; then
  echo "Backing up conflicting files to $BACKUP_DIR..."
  mkdir -p "$BACKUP_DIR"
  cd "$DOTFILES_DIR"
  for pkg in "${PACKAGES[@]}"; do
    stow --target="$STOW_TARGET" --adopt "$pkg" 2>/dev/null || true
  done
  cp -r "$DOTFILES_DIR" "$BACKUP_DIR/dotfiles-adopted"
  # Revert only THIS platform's adopted changes — never the whole repo root
  # (that would clobber uncommitted work in the other platform / repo root).
  git -C "$DOTFILES_DIR" checkout -- . 2>/dev/null || true
  echo "✓ Backup created at $BACKUP_DIR"
fi

cd "$DOTFILES_DIR"
for pkg in "${PACKAGES[@]}"; do
  stow --target="$STOW_TARGET" -R "$pkg" 2>/dev/null || stow --target="$STOW_TARGET" "$pkg"
  echo "✓ Stowed $pkg"
done

# 5. Clone TPM for tmux if missing
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
  echo "Installing Tmux Plugin Manager..."
  mkdir -p ~/.tmux/plugins
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo "✓ TPM installed (press prefix+I in tmux to install plugins)"
else
  echo "✓ TPM already installed"
fi

# 6. Kanata LaunchDaemon
PLIST_SRC="$DOTFILES_DIR/kanata/.config/kanata/com.example.kanata.plist"
PLIST_DST="/Library/LaunchDaemons/com.example.kanata.plist"
if [[ -f "$PLIST_SRC" && ! -f "$PLIST_DST" ]]; then
  echo "Installing Kanata LaunchDaemon..."
  sudo cp "$PLIST_SRC" "$PLIST_DST"
  # launchd refuses plists that aren't root:wheel 0644
  sudo chown root:wheel "$PLIST_DST"
  sudo chmod 644 "$PLIST_DST"
  # Modern API (load is deprecated and can wedge the label)
  sudo launchctl bootstrap system "$PLIST_DST"
  echo "✓ Kanata LaunchDaemon installed"
  echo "  → Grant 'Input Monitoring' to kanata in System Settings > Privacy for remaps to work"
fi

# 7. Zen Browser config (not stow-managed — random profile dir; seeded by script)
if [[ -f "$HOME/Library/Application Support/zen/profiles.ini" ]]; then
  echo "Seeding Zen config..."
  "$DOTFILES_DIR/zen/install.sh" || echo "⚠ Zen seed skipped (is Zen running?) — run mac/zen/install.sh later"
else
  echo "ℹ Zen not initialised yet — launch Zen once, quit it, then run: mac/zen/install.sh"
fi

echo
echo "Done. Restart services: AeroSpace → borders → SketchyBar"
echo "  killall AeroSpace && open -a AeroSpace"
echo "  sketchybar --reload"

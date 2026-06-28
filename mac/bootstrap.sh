#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
PACKAGES=(zsh tmux ghostty aerospace borders sketchybar kanata sesh starship)

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

# 2. Check stow
if ! command -v stow &>/dev/null; then
  echo "Installing stow..."
  brew install stow
fi
echo "✓ GNU Stow available"

# 3. Back up conflicting files and stow
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_DIR="$HOME/dotfiles-backup-$TIMESTAMP"
CONFLICTS=false

cd "$DOTFILES_DIR"
for pkg in "${PACKAGES[@]}"; do
  if ! stow -n "$pkg" 2>/dev/null; then
    CONFLICTS=true
  fi
done

if [[ "$CONFLICTS" == true ]]; then
  echo "Backing up conflicting files to $BACKUP_DIR..."
  mkdir -p "$BACKUP_DIR"
  cd "$DOTFILES_DIR"
  for pkg in "${PACKAGES[@]}"; do
    stow --adopt "$pkg" 2>/dev/null || true
  done
  cp -r "$DOTFILES_DIR" "$BACKUP_DIR/dotfiles-adopted"
  git -C "$DOTFILES_DIR/.." checkout -- . 2>/dev/null || true
  echo "✓ Backup created at $BACKUP_DIR"
fi

cd "$DOTFILES_DIR"
for pkg in "${PACKAGES[@]}"; do
  stow -R "$pkg" 2>/dev/null || stow "$pkg"
  echo "✓ Stowed $pkg"
done

# 4. Clone TPM for tmux if missing
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
  echo "Installing Tmux Plugin Manager..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo "✓ TPM installed (press prefix+I in tmux to install plugins)"
else
  echo "✓ TPM already installed"
fi

# 5. Kanata LaunchDaemon
PLIST_SRC="$DOTFILES_DIR/kanata/.config/kanata/com.example.kanata.plist"
PLIST_DST="/Library/LaunchDaemons/com.example.kanata.plist"
if [[ -f "$PLIST_SRC" && ! -f "$PLIST_DST" ]]; then
  echo "Installing Kanata LaunchDaemon..."
  sudo cp "$PLIST_SRC" "$PLIST_DST"
  sudo launchctl load "$PLIST_DST"
  echo "✓ Kanata LaunchDaemon installed"
fi

echo
echo "Done. Restart services: AeroSpace → borders → SketchyBar"
echo "  killall AeroSpace && open -a AeroSpace"
echo "  sketchybar --reload"

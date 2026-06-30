#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
PACKAGES=(zsh hypr waybar walker terminals tmux dev-tools kanata omarchy-user ssh sesh)

echo "==================================="
echo "  Dotfiles Bootstrap (Linux)"
echo "==================================="
echo

# 1. Check omarchy is installed
if [[ ! -d ~/.local/share/omarchy ]]; then
  echo "ERROR: Omarchy not found at ~/.local/share/omarchy"
  echo "Install omarchy first: https://omarchy.org"
  exit 1
fi
echo "✓ Omarchy detected ($(cat ~/.local/share/omarchy/version 2>/dev/null || echo 'unknown version'))"

# 2. Install stow if missing
if ! command -v stow &>/dev/null; then
  echo "Installing stow..."
  sudo pacman -S --noconfirm stow
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
  # Revert only THIS platform's adopted changes — never the whole repo root
  # (that would clobber uncommitted work in the other platform / repo root).
  git -C "$DOTFILES_DIR" checkout -- . 2>/dev/null || true
  echo "✓ Backup created at $BACKUP_DIR"
fi

cd "$DOTFILES_DIR"
for pkg in "${PACKAGES[@]}"; do
  stow -R "$pkg" 2>/dev/null || stow "$pkg"
  echo "✓ Stowed $pkg"
done

# 4. Re-create omarchy theme symlink for nvim
THEME_SYMLINK="$HOME/.config/nvim/lua/custom/plugins/theme.lua"
THEME_TARGET="$HOME/.config/omarchy/current/theme/neovim.lua"
if [[ -f "$THEME_TARGET" ]]; then
  mkdir -p "$(dirname "$THEME_SYMLINK")"
  ln -sf "$THEME_TARGET" "$THEME_SYMLINK"
  echo "✓ Nvim theme symlink created"
else
  echo "⚠ Omarchy theme file not found, skipping nvim theme symlink"
fi

# 5. Clone TPM for tmux if missing
if [[ ! -d ~/.config/tmux/plugins/tpm ]]; then
  echo "Installing Tmux Plugin Manager..."
  mkdir -p ~/.config/tmux/plugins
  git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
  echo "✓ TPM installed (press prefix+I in tmux to install plugins)"
else
  echo "✓ TPM already installed"
fi

# 6. Run extra install scripts (optional)
echo
read -p "Install extra packages (ghostty, kanata, zen-browser)? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  for script in install-ghostty.sh install-kanata.sh install-zen-browser.sh; do
    if [[ -f "$DOTFILES_DIR/scripts/$script" ]]; then
      echo "Running $script..."
      bash "$DOTFILES_DIR/scripts/$script"
    fi
  done
fi

echo
echo "Done. Log out and back in, then open tmux (prefix+I to install plugins)."

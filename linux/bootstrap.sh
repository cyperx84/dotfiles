#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
# Omarchy 4 owns the desktop layer (quickshell bar, omarchy-menu launcher, its
# own hypr defaults), so we stow only our deltas on top of it.
PACKAGES=(zsh hypr terminals tmux dev-tools kanata ssh sesh)

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
omarchy_version="$(cat /usr/share/omarchy/version 2>/dev/null || cat ~/.local/share/omarchy/version 2>/dev/null || echo 'unknown version')"
echo "✓ Omarchy detected ($omarchy_version)"
case "$omarchy_version" in
  4.*) ;;
  *) echo "WARNING: these configs target Omarchy 4 (Lua hypr configs, quickshell bar)." ;;
esac

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

# 4. Neovim config — separate repo, intentionally NOT stow-managed.
# Note: Omarchy ships its own LazyVim config at ~/.config/nvim and its theme
# system writes a neovim.lua into ~/.config/omarchy/current/theme/. This config
# doesn't consume that (it uses the built-in 'unokai' colorscheme), so we don't
# re-create the old theme.lua symlink here — it would only land as an untracked
# file inside the clone. The shipped Omarchy config is backed up, not clobbered.
NVIM_REPO="https://github.com/cyperx84/nvim.git"
NVIM_DIR="$HOME/.config/nvim"
# Normalise https/ssh URLs to host/owner/repo so either clone style matches.
nvim_slug() { local u="${1%.git}"; u="${u#*://}"; u="${u#*@}"; printf '%s' "${u/://}"; }
NVIM_ORIGIN="$(git -C "$NVIM_DIR" remote get-url origin 2>/dev/null || true)"
if [[ -n "$NVIM_ORIGIN" && "$(nvim_slug "$NVIM_ORIGIN")" == "$(nvim_slug "$NVIM_REPO")" ]]; then
  if [[ -z "$(git -C "$NVIM_DIR" status --porcelain)" ]]; then
    # fetch first: a reachable origin + failed fast-forward means real divergence,
    # whereas a failed fetch is just network/auth and is safe to ignore.
    if git -C "$NVIM_DIR" fetch --quiet origin 2>/dev/null; then
      git -C "$NVIM_DIR" merge --ff-only --quiet '@{u}' 2>/dev/null \
        && echo "✓ Neovim config up to date" \
        || echo "⚠ Neovim config diverged from origin — left as-is"
    else
      echo "⚠ Neovim config: couldn't reach origin — left as-is"
    fi
  else
    echo "ℹ Neovim config has local changes — left untouched"
  fi
elif [[ -e "$NVIM_DIR" ]]; then
  echo "Omarchy's nvim config found — backing it up..."
  mv "$NVIM_DIR" "$HOME/.config/nvim.backup-$TIMESTAMP"
  git clone --quiet "$NVIM_REPO" "$NVIM_DIR"
  echo "✓ Neovim config cloned (Omarchy's config kept at ~/.config/nvim.backup-$TIMESTAMP)"
else
  git clone --quiet "$NVIM_REPO" "$NVIM_DIR"
  echo "✓ Neovim config cloned"
fi
# Plugins install on first launch — that first boot is slow by design.
echo "  → run 'nvim' once to let vim.pack clone plugins and Mason install LSPs"

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

#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
STOW_TARGET="$HOME"
PACKAGES=(zsh tmux ghostty aerospace borders sketchybar kanata karabiner sesh starship hammerspoon herdr)

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

# 5. Neovim config — separate repo, intentionally NOT stow-managed.
# It's a full project (own CI, plugin patches, lockfile), so we clone it rather
# than symlink files. Cloning also keeps `stow --adopt` above from ever being
# able to swallow plugin dirs into this repo.
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
  echo "Foreign nvim config found — backing it up..."
  mv "$NVIM_DIR" "$HOME/.config/nvim.backup-$TIMESTAMP"
  git clone --quiet "$NVIM_REPO" "$NVIM_DIR"
  echo "✓ Neovim config cloned (previous config kept at ~/.config/nvim.backup-$TIMESTAMP)"
else
  git clone --quiet "$NVIM_REPO" "$NVIM_DIR"
  echo "✓ Neovim config cloned"
fi
# Plugins install on first launch — that first boot is slow by design.
echo "  → run 'nvim' once to let vim.pack clone plugins and Mason install LSPs"

# 6. Clone TPM for tmux if missing
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
  echo "Installing Tmux Plugin Manager..."
  mkdir -p ~/.tmux/plugins
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo "✓ TPM installed (press prefix+I in tmux to install plugins)"
else
  echo "✓ TPM already installed"
fi

# 7. Kanata LaunchDaemon
PLIST_SRC="$DOTFILES_DIR/kanata/.config/kanata/com.example.kanata.plist"
PLIST_DST="/Library/LaunchDaemons/com.example.kanata.plist"
if [[ -f "$PLIST_SRC" && ! -f "$PLIST_DST" ]]; then
  echo "Installing Kanata LaunchDaemon..."
  # plist ships a __HOME__ placeholder — substitute the provisioning user's home.
  # This is a *system* daemon (runs as root), so $HOME can't be resolved at runtime;
  # it must be baked in here at install time.
  sed "s|__HOME__|$HOME|g" "$PLIST_SRC" | sudo tee "$PLIST_DST" >/dev/null
  # launchd refuses plists that aren't root:wheel 0644
  sudo chown root:wheel "$PLIST_DST"
  sudo chmod 644 "$PLIST_DST"
  # Modern API (load is deprecated and can wedge the label)
  sudo launchctl bootstrap system "$PLIST_DST"
  echo "✓ Kanata LaunchDaemon installed"
  echo "  → Grant 'Input Monitoring' to kanata in System Settings > Privacy for remaps to work"
fi

# 8. Zen Browser config (not stow-managed — random profile dir; seeded by script)
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

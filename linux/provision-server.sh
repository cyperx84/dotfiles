#!/usr/bin/env bash
# ============================================================================
# Headless Linux / VPS provisioner — join the tailnet + apply the dotfiles
# ============================================================================
# Provisions a FRESH headless Linux box (VPS, cloud server, container host) onto
# the Tailscale tailnet with the shared shell dotfiles. Distro-agnostic
# (apt / dnf / pacman / zypper / apk). Idempotent — safe to re-run.
#
# This is the SERVER counterpart to bootstrap.sh (which is for Omarchy desktops
# and stows the GUI stack: hypr/waybar/walker/etc). This one stows only the
# headless shell stack.
#
# Usage:
#   ./provision-server.sh [hostname-tag]
#
# Unattended (no browser auth — generate a key at
#   https://login.tailscale.com/admin/settings/keys ):
#   TS_AUTHKEY=tskey-auth-xxxx ./provision-server.sh web1
#
# Env knobs:
#   TS_HOSTNAME   tailnet name for this node      (default: hostname -s, or $1)
#   TS_AUTHKEY    Tailscale auth key for unattended join (default: interactive)
#   REPO_URL      dotfiles git remote             (default: cyperx84/dotfiles)
#   DOTFILES_DIR  clone location                  (default: ~/dotfiles)
# ============================================================================
set -euo pipefail

REPO_URL="${REPO_URL:-https://github.com/cyperx84/dotfiles.git}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
TS_HOSTNAME="${1:-${TS_HOSTNAME:-$(hostname -s)}}"
SERVER_PACKAGES=(zsh tmux ssh dev-tools sesh scripts)
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

log()  { printf '\n\033[1;32m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[warn]\033[0m %s\n' "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }

# --- package manager abstraction ------------------------------------------
detect_pm() {
  if   have apt-get; then echo apt
  elif have dnf;     then echo dnf
  elif have pacman;  then echo pacman
  elif have zypper;  then echo zypper
  elif have apk;     then echo apk
  else echo none; fi
}
PM="$(detect_pm)"
[ "$PM" = none ] && { echo "No supported package manager found (apt/dnf/pacman/zypper/apk)."; exit 1; }

pm_install() {
  case "$PM" in
    apt)    sudo apt-get update -y && sudo apt-get install -y "$@" ;;
    dnf)    sudo dnf install -y "$@" ;;
    pacman) sudo pacman -Sy --noconfirm "$@" ;;
    zypper) sudo zypper --non-interactive install "$@" ;;
    apk)    sudo apk add "$@" ;;
  esac
}

# --- 1. prerequisites ------------------------------------------------------
log "Package manager: $PM. Installing prerequisites..."
pm_install git stow zsh curl ca-certificates openssh-server 2>/dev/null \
  || pm_install git stow zsh curl openssh    # distros that name openssh differently

# starship (the prompt + per-machine tag). Official installer = distro-agnostic.
if ! have starship; then
  log "Installing starship..."
  curl -fsSL https://starship.rs/install.sh | sh -s -- --yes
fi
# nice-to-haves, best effort (don't fail provisioning if a name differs)
pm_install fzf zoxide 2>/dev/null || warn "fzf/zoxide not installed (optional)"

# --- 2. tailscale ----------------------------------------------------------
if ! have tailscale; then
  log "Installing Tailscale..."
  curl -fsSL https://tailscale.com/install.sh | sh
fi
log "Joining tailnet as '$TS_HOSTNAME' (Tailscale-SSH enabled)..."
if [ -n "${TS_AUTHKEY:-}" ]; then
  sudo tailscale up --ssh --hostname="$TS_HOSTNAME" --accept-routes --authkey="$TS_AUTHKEY"
else
  warn "No TS_AUTHKEY set — this will print a URL to authorize in your browser."
  sudo tailscale up --ssh --hostname="$TS_HOSTNAME" --accept-routes
fi

# --- 3. dotfiles -----------------------------------------------------------
if [ -d "$DOTFILES_DIR/.git" ]; then
  log "Refreshing dotfiles in $DOTFILES_DIR..."
  git -C "$DOTFILES_DIR" pull --ff-only || warn "pull skipped (local changes?)"
else
  log "Cloning dotfiles to $DOTFILES_DIR..."
  git clone "$REPO_URL" "$DOTFILES_DIR"
fi

# --- 4. stow (with conflict backup) ---------------------------------------
stow_pkg() {
  local pkg="$1"
  # back up anything in the way (real files or foreign/dead symlinks)
  stow -n -t "$HOME" -d "$DOTFILES_DIR/linux" "$pkg" 2>&1 \
    | sed -n 's/.*not owned by stow: //p' | while IFS= read -r rel; do
        [ -z "$rel" ] && continue
        local tgt="$HOME/$rel"
        if [ -e "$tgt" ] || [ -L "$tgt" ]; then
          mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
          mv "$tgt" "$BACKUP_DIR/$rel" && echo "  backed up $tgt"
        fi
      done
  stow -t "$HOME" -d "$DOTFILES_DIR/linux" "$pkg" && echo "  stowed $pkg"
}
log "Stowing server packages: ${SERVER_PACKAGES[*]}"
for pkg in "${SERVER_PACKAGES[@]}"; do
  [ -d "$DOTFILES_DIR/linux/$pkg" ] && stow_pkg "$pkg" || warn "no package linux/$pkg, skipping"
done
[ -d "$BACKUP_DIR" ] && log "Pre-existing files backed up to $BACKUP_DIR"

# --- 5. ssh server + default shell ----------------------------------------
log "Ensuring OpenSSH server is running..."
sudo systemctl enable --now ssh 2>/dev/null \
  || sudo systemctl enable --now sshd 2>/dev/null \
  || warn "couldn't enable sshd via systemd — start it manually if needed"

if [ "$(basename "${SHELL:-}")" != zsh ] && have zsh; then
  log "Setting zsh as the default shell for $USER..."
  sudo chsh -s "$(command -v zsh)" "$USER" 2>/dev/null \
    || chsh -s "$(command -v zsh)" 2>/dev/null \
    || warn "couldn't chsh — run: chsh -s \$(command -v zsh)"
fi

log "Done. '$TS_HOSTNAME' is on the tailnet."
echo "  • From another tailnet machine:  ssh $USER@$TS_HOSTNAME"
echo "  • Add a Host alias + sesh entry for it in linux/ssh + (sesh) configs."
echo "  • Disable key expiry for it in the Tailscale admin console."

#!/usr/bin/env bash
# Validate the Linux/Omarchy dotfiles package and, when run on Linux, its deployment.

set -uo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
LINUX_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"
FAILED=0
WARNINGS=0

pass() { printf '✓ %s\n' "$1"; }
fail() { printf '✗ %s\n' "$1"; ((++FAILED)); }
warn() { printf '⚠ %s\n' "$1"; ((++WARNINGS)); }
section() { printf '\n%s\n%s\n' "$1" '-------------------------------------'; }

check_file() {
  local path="$1" label="$2"
  [[ -f "$path" ]] && pass "$label" || fail "$label missing: $path"
}

printf '%s\n' '===================================' '  Linux Dotfiles Validation' '==================================='
printf 'Source: %s\n' "$LINUX_DIR"

section '1. Repository Structure'
check_file "$LINUX_DIR/zsh/.zshrc" 'Zsh configuration'
check_file "$LINUX_DIR/tmux/.config/tmux/tmux.conf" 'Tmux configuration'
check_file "$LINUX_DIR/dev-tools/.config/starship.toml" 'Starship configuration'
check_file "$LINUX_DIR/hypr/.config/hypr/hyprland.conf" 'Hyprland configuration'
check_file "$LINUX_DIR/hypr/.config/hypr/bindings.conf" 'Hyprland bindings'
check_file "$LINUX_DIR/kanata/.config/kanata/config.kbd" 'Kanata configuration'

section '2. Configuration Syntax'
if command -v zsh >/dev/null 2>&1; then
  zsh -n "$LINUX_DIR/zsh/.zshrc" && pass 'Zsh syntax valid' || fail 'Zsh syntax invalid'
else
  warn 'zsh unavailable; skipped Zsh syntax check'
fi

shell_errors=0
while IFS= read -r -d '' script; do
  if head -n 1 "$script" | grep -q 'bash' && ! bash -n "$script"; then
    printf '  invalid: %s\n' "${script#"$LINUX_DIR/"}"
    ((++shell_errors))
  fi
done < <(find "$LINUX_DIR" -type f -name '*.sh' -print0)
[[ $shell_errors -eq 0 ]] && pass 'Bash syntax valid' || fail "$shell_errors Bash script(s) invalid"

if command -v python3 >/dev/null 2>&1 && python3 -c 'import tomllib' 2>/dev/null; then
  toml_errors=0
  while IFS= read -r -d '' file; do
    python3 -c 'import sys,tomllib; tomllib.load(open(sys.argv[1], "rb"))' "$file" 2>/dev/null || {
      printf '  invalid: %s\n' "${file#"$LINUX_DIR/"}"
      ((++toml_errors))
    }
  done < <(find "$LINUX_DIR" -type f -name '*.toml' -print0)
  [[ $toml_errors -eq 0 ]] && pass 'TOML syntax valid' || fail "$toml_errors TOML file(s) invalid"
else
  warn 'Python 3.11+ unavailable; skipped TOML syntax check'
fi

grep -q 'Aerospace-style Window Management' "$LINUX_DIR/hypr/.config/hypr/bindings.conf" \
  && pass 'Aerospace-style Hyprland bindings present' \
  || fail 'Aerospace-style Hyprland bindings missing'

section '3. Stow Layout'
if command -v stow >/dev/null 2>&1; then
  mapfile_cmd=()
  while IFS= read -r package; do mapfile_cmd+=("$package"); done < <(
    find "$LINUX_DIR" -mindepth 1 -maxdepth 1 -type d \
      ! -name scripts -exec basename {} \; | sort
  )
  stow_target=$(mktemp -d "${TMPDIR:-/tmp}/linux-dotfiles-stow.XXXXXX")
  if (cd "$LINUX_DIR" && stow -nv -t "$stow_target" "${mapfile_cmd[@]}") >/tmp/linux-dotfiles-stow.log 2>&1; then
    pass 'Stow package layout valid in an isolated target'
  else
    fail 'Stow package layout invalid (see /tmp/linux-dotfiles-stow.log)'
  fi
  rm -rf -- "$stow_target"
else
  fail 'GNU Stow is not installed'
fi

section '4. Runtime (Linux only)'
if [[ "$(uname -s)" == Linux ]]; then
  for cmd in zsh tmux fzf eza zoxide starship rg bat fd yazi sesh; do
    command -v "$cmd" >/dev/null 2>&1 && pass "$cmd installed" || fail "$cmd missing"
  done

  [[ "$SHELL" == *zsh ]] && pass 'Zsh is the default shell' || warn 'Zsh is not the default shell'
  [[ -e "$HOME/.zshrc" ]] && pass '~/.zshrc deployed' || fail '~/.zshrc not deployed'
  [[ -e "$HOME/.config/tmux/tmux.conf" ]] && pass 'tmux.conf deployed' || fail 'tmux.conf not deployed'
  [[ -e "$HOME/.config/starship.toml" ]] && pass 'starship.toml deployed' || fail 'starship.toml not deployed'
else
  warn 'Not running on Linux; skipped package and deployment checks'
fi

printf '\n===================================\nPassed with %d failure(s), %d warning(s)\n===================================\n' "$FAILED" "$WARNINGS"
(( FAILED == 0 ))

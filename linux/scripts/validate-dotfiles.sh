#!/usr/bin/env bash
# Validate the Linux/Omarchy dotfiles package and, when run on Linux, its deployment.
#
# Targets Omarchy 4 (the Lua generation):
#   - Hyprland is configured in Lua. hyprland.lua is Omarchy-owned and stays
#     untracked; only our bindings/input/looknfeel deltas ship.
#   - The current theme lives at ~/.local/state/omarchy/current/theme (3.x used
#     ~/.config/omarchy/current/theme, which no longer exists).
#   - Omarchy wires starship for bash only, so a stowed zshrc must init zsh itself.
#
# The wiring checks in section 3 exist because structure-only checks passed while
# the prompt silently fell back to stock, rendered a doubled glyph, and the
# terminals silently lost their theme colors on the 4.x upgrade.

set -uo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
LINUX_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"
HYPR_DIR="$LINUX_DIR/hypr/.config/hypr"
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

# Repo context, for the tracked/untracked invariants. Empty when not a checkout.
canon() { (cd -P -- "$1" && pwd); }
GIT_REPO=""
if command -v git >/dev/null 2>&1; then
  GIT_REPO="$(git -C "$LINUX_DIR" rev-parse --show-toplevel 2>/dev/null || true)"
fi
# git reports a physically-resolved toplevel, so compare the same way: a repo
# reached through a symlink (macOS /tmp -> /private/tmp, a symlinked ~/dotfiles)
# would otherwise look like it is not under the repo at all.
LINUX_REL=""
if [[ -n "$GIT_REPO" ]]; then
  GIT_REPO="$(canon "$GIT_REPO")"
  linux_phys="$(canon "$LINUX_DIR")"
  [[ "$linux_phys" == "$GIT_REPO"/* ]] && LINUX_REL="${linux_phys#"$GIT_REPO"/}"
fi
repo_path() { printf '%s/%s' "$LINUX_REL" "$1"; }
tracked() { git -C "$GIT_REPO" ls-files --error-unmatch "$(repo_path "$1")" >/dev/null 2>&1; }

printf '%s\n' '===================================' '  Linux Dotfiles Validation' '==================================='
printf 'Source: %s\n' "$LINUX_DIR"

section '1. Repository Structure'
check_file "$LINUX_DIR/zsh/.zshrc" 'Zsh configuration'
check_file "$LINUX_DIR/tmux/.config/tmux/tmux.conf" 'Tmux configuration'
check_file "$LINUX_DIR/dev-tools/.config/starship.toml" 'Starship configuration'
check_file "$LINUX_DIR/kanata/.config/kanata/config.kbd" 'Kanata configuration'

HYPR_DELTAS=(bindings input looknfeel)
for delta in "${HYPR_DELTAS[@]}"; do
  check_file "$HYPR_DIR/$delta.lua" "Hyprland $delta.lua"
done

if [[ -z "$GIT_REPO" ]]; then
  warn 'git unavailable or not a checkout; skipped Hyprland tracking checks'
elif [[ -z "$LINUX_REL" ]]; then
  warn 'linux/ is not inside the git work tree; skipped Hyprland tracking checks'
else
  for delta in "${HYPR_DELTAS[@]}"; do
    tracked "hypr/.config/hypr/$delta.lua" \
      && pass "hypr $delta.lua tracked in git" \
      || fail "hypr $delta.lua is not tracked in git"
  done
  # The entrypoint is Omarchy's. Tracking it would make stow fight upstream for
  # the same path on every bootstrap.
  if tracked 'hypr/.config/hypr/hyprland.lua'; then
    fail 'hyprland.lua is tracked; it is intentionally Omarchy-owned and must stay untracked'
  else
    pass 'hyprland.lua intentionally untracked (Omarchy-owned)'
  fi
fi

# Flat .conf configs were the 3.x layout. Their return means the repo drifted a
# generation back, but it does not by itself break a healthy Omarchy 4 deploy.
for stale in hyprland.conf bindings.conf; do
  [[ -e "$HYPR_DIR/$stale" ]] && warn "$stale reappeared; Omarchy 4 uses the .lua files" || true
done

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

if command -v luac >/dev/null 2>&1; then
  lua_errors=0
  while IFS= read -r -d '' file; do
    if ! luac -p "$file" >/dev/null 2>&1; then
      printf '  invalid: %s\n' "${file#"$LINUX_DIR/"}"
      ((++lua_errors))
    fi
  done < <(find "$LINUX_DIR" -type f -name '*.lua' -print0)
  [[ $lua_errors -eq 0 ]] && pass 'Lua syntax valid' || fail "$lua_errors Lua file(s) invalid"
else
  warn 'luac unavailable; skipped Lua syntax check'
fi

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

# The macOS-Aerospace port that lives in bindings.lua, checked by dispatcher shape
# so the assertions survive renames of the surrounding comments.
AEROSPACE_ANCHORS=(
  'hl.dsp.focus({ direction'
  'hl.dsp.window.swap'
  'hl.dsp.window.float'
  'hl.dsp.layout("togglesplit")'
  'hl.dsp.window.fullscreen'
  'hl.dsp.window.resize'
  'hl.dsp.focus({ workspace = "e+1" })'
  'hl.dsp.window.move({ monitor'
)
missing_anchors=0
for anchor in "${AEROSPACE_ANCHORS[@]}"; do
  grep -qF -- "$anchor" "$HYPR_DIR/bindings.lua" 2>/dev/null || ((++missing_anchors))
done
[[ $missing_anchors -eq 0 ]] \
  && pass 'Aerospace-style Hyprland bindings present (bindings.lua)' \
  || fail "Aerospace-style Hyprland bindings missing $missing_anchors anchor(s) in bindings.lua"

section '3. Prompt & Theme Wiring'

# Do not match a commented-out line: the file documents the bash-only behaviour.
zshrc_active() { grep -vE '^[[:space:]]*#' "$LINUX_DIR/zsh/.zshrc" | grep -qF -- "$1"; }

# Omarchy 4 runs `starship init bash` and ships no zsh rc, so without this the
# stowed zshrc sets STARSHIP_* and then never starts starship at all.
zshrc_active 'starship init zsh' \
  && pass 'zshrc initialises starship for zsh' \
  || fail 'zshrc does not run `starship init zsh` (zsh falls back to the stock prompt)'
zshrc_active 'export STARSHIP_MACHINE=' \
  && pass 'zshrc exports STARSHIP_MACHINE' \
  || fail 'zshrc does not export STARSHIP_MACHINE'

starship_toml="$LINUX_DIR/dev-tools/.config/starship.toml"
starship_format="$(awk '/^format = """/{f=1; next} f && /"""/{exit} f{print}' "$starship_toml")"
if [[ -z "$starship_format" ]]; then
  fail 'starship format block not found in starship.toml'
else
  # The per-machine tag carries the skull glyph itself, so a rendered $os prints
  # a second one. Matching mac's format is the converged shape.
  printf '%s\n' "$starship_format" | grep -qF '$os' \
    && fail 'starship format renders $os; the machine tag already carries the glyph (double glyph)' \
    || pass 'starship format renders the machine tag once (no $os)'
  printf '%s\n' "$starship_format" | grep -qF '${env_var.STARSHIP_MACHINE}' \
    && pass 'starship format includes the per-machine tag' \
    || fail 'starship format no longer includes ${env_var.STARSHIP_MACHINE}'
fi

# Omarchy 4 moved the current theme to $XDG_STATE_HOME; the 3.x config path does
# not exist, so a stale import silently falls back to default colors.
LEGACY_THEME='~/.config/omarchy/current/theme'
check_theme_import() {
  local rel="$1" want="$2" file="$LINUX_DIR/$1"
  if [[ ! -f "$file" ]]; then
    fail "$rel missing"
  elif grep -qF -- "$LEGACY_THEME" "$file"; then
    fail "$rel imports the dead Omarchy 3.x theme path ($LEGACY_THEME)"
  elif grep -qF -- "$want" "$file"; then
    pass "$rel imports the Omarchy 4 theme path"
  else
    fail "$rel does not import $want"
  fi
}
check_theme_import 'terminals/.config/alacritty/alacritty.toml' '~/.local/state/omarchy/current/theme/alacritty.toml'
check_theme_import 'terminals/.config/kitty/kitty.conf' '~/.local/state/omarchy/current/theme/kitty.conf'
check_theme_import 'terminals/.config/ghostty/config' '~/.local/state/omarchy/current/theme/ghostty.conf'

section '4. Stow Layout'
if command -v stow >/dev/null 2>&1; then
  stow_pkgs=()
  while IFS= read -r package; do stow_pkgs+=("$package"); done < <(
    find "$LINUX_DIR" -mindepth 1 -maxdepth 1 -type d \
      ! -name scripts -exec basename {} \; | sort
  )
  stow_target=$(mktemp -d "${TMPDIR:-/tmp}/linux-dotfiles-stow.XXXXXX")
  if (cd "$LINUX_DIR" && stow -nv -t "$stow_target" "${stow_pkgs[@]}") >/tmp/linux-dotfiles-stow.log 2>&1; then
    pass 'Stow package layout valid in an isolated target'
  else
    fail 'Stow package layout invalid (see /tmp/linux-dotfiles-stow.log)'
  fi
  rm -rf -- "$stow_target"
else
  fail 'GNU Stow is not installed'
fi

section '5. Runtime (Linux only)'
if [[ "$(uname -s)" == Linux ]]; then
  # Required: the shell, prompt and multiplexer layer the configs assume.
  for cmd in zsh tmux fzf eza zoxide starship rg bat fd; do
    command -v "$cmd" >/dev/null 2>&1 && pass "$cmd installed" || fail "$cmd missing"
  done

  # Optional: supplementary TUIs. Absent on a fresh box, and nothing in the
  # prompt/tmux/zsh layer needs them, so their absence is not a failed install.
  # Neither is installed by linux/bootstrap.sh: it only stows a sesh config
  # (sesh is in its PACKAGES list) and does not provision yazi at all.
  for cmd in yazi sesh; do
    command -v "$cmd" >/dev/null 2>&1 && pass "$cmd installed" || warn "$cmd not installed (optional)"
  done

  [[ "$SHELL" == *zsh ]] && pass 'Zsh is the default shell' || warn 'Zsh is not the default shell'
  [[ -e "$HOME/.zshrc" ]] && pass '~/.zshrc deployed' || fail '~/.zshrc not deployed'
  [[ -e "$HOME/.config/tmux/tmux.conf" ]] && pass 'tmux.conf deployed' || fail 'tmux.conf not deployed'
  [[ -e "$HOME/.config/starship.toml" ]] && pass 'starship.toml deployed' || fail 'starship.toml not deployed'
  for delta in "${HYPR_DELTAS[@]}"; do
    [[ -e "$HOME/.config/hypr/$delta.lua" ]] \
      && pass "hypr $delta.lua deployed" \
      || fail "~/.config/hypr/$delta.lua not deployed"
  done

  if [[ -d "$HOME/.local/state/omarchy/current/theme" ]]; then
    pass 'Omarchy current theme dir present'
  elif [[ -d "$HOME/.config/omarchy/current/theme" ]]; then
    fail 'theme dir is at the dead Omarchy 3.x path ~/.config/omarchy/current/theme'
  else
    warn 'Omarchy current theme dir not found; terminals fall back to default colors'
  fi
else
  warn 'Not running on Linux; skipped package and deployment checks'
fi

printf '\n===================================\nPassed with %d failure(s), %d warning(s)\n===================================\n' "$FAILED" "$WARNINGS"
(( FAILED == 0 ))

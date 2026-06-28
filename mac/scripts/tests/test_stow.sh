#!/usr/bin/env bash
# ============================================================================
# STOW SYMLINKS TEST SUITE
# ============================================================================
# Author: cyperx (https://github.com/cyperx84)
# Purpose: Validate all Stow symlinks are correctly set up
# ============================================================================

set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

PASSED=0
FAILED=0
WARNINGS=0

print_success() { echo -e "${GREEN}✓${NC} $1"; ((PASSED++)); }
print_failure() { echo -e "${RED}✗${NC} $1"; ((FAILED++)); }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; ((WARNINGS++)); }
print_skip() { echo -e "${BLUE}○${NC} $1 (skipped)"; }

echo "Testing Stow symlinks..."

# ============================================================================
# SYMLINK DEFINITIONS
# ============================================================================

# Format: "target_path:expected_source_contains"
declare -a symlinks=(
    "$HOME/.zshrc:zsh/.zshrc"
    "$HOME/.tmux.conf:tmux/.tmux.conf"
    "$HOME/.config/nvim:nvim/.config/nvim"
    "$HOME/.config/aerospace:aerospace/.config/aerospace"
    "$HOME/.config/sketchybar:sketchybar/.config/sketchybar"
    "$HOME/.config/ghostty:ghostty/.config/ghostty"
    "$HOME/.config/starship:starship/.config/starship"
    "$HOME/.config/kanata:kanata/.config/kanata"
    "$HOME/.config/karabiner:karabiner/.config/karabiner"
    "$HOME/.config/sesh:sesh/.config/sesh"
    "$HOME/.config/borders:borders/.config/borders"
)

# ============================================================================
# SYMLINK VALIDATION
# ============================================================================

echo -e "\n--- Symlink Validation ---"

for item in "${symlinks[@]}"; do
    target="${item%%:*}"
    expected="${item##*:}"
    name=$(basename "$target")

    if [[ -L "$target" ]]; then
        actual=$(readlink "$target" 2>/dev/null || echo "")
        if [[ "$actual" == *"dotfiles"* ]] || [[ -e "$target" ]]; then
            print_success "$name symlink valid"
        else
            print_failure "$name symlink broken (points to: $actual)"
        fi
    elif [[ -e "$target" ]]; then
        print_warning "$name exists but is NOT a symlink"
    else
        print_skip "$name not found"
    fi
done

# ============================================================================
# BROKEN SYMLINKS CHECK
# ============================================================================

echo -e "\n--- Broken Symlinks ---"

broken_count=0
while IFS= read -r -d '' link; do
    if [[ ! -e "$link" ]]; then
        print_failure "Broken symlink: $link"
        ((broken_count++))
    fi
done < <(find "$HOME" -maxdepth 3 -type l -print0 2>/dev/null | head -100)

if [[ $broken_count -eq 0 ]]; then
    print_success "No broken symlinks found in home directory"
fi

# ============================================================================
# STOW PACKAGES
# ============================================================================

echo -e "\n--- Stow Packages ---"

if [[ -d "$DOTFILES_DIR" ]]; then
    packages=$(find "$DOTFILES_DIR" -maxdepth 1 -type d -not -name ".*" -not -name "scripts" -not -name "docs" | wc -l | tr -d ' ')
    print_success "Found $packages stow packages in dotfiles"
else
    print_failure "Dotfiles directory not found at $DOTFILES_DIR"
fi

# ============================================================================
# DRY-RUN CHECK
# ============================================================================

echo -e "\n--- Stow Dry-Run ---"

if command -v stow &>/dev/null; then
    print_success "Stow is installed"

    # Check for conflicts (dry-run)
    cd "$DOTFILES_DIR"
    conflicts=$(stow -nv */ 2>&1 | grep -c "CONFLICT" || true)
    if [[ $conflicts -eq 0 ]]; then
        print_success "No stow conflicts detected"
    else
        print_warning "$conflicts potential stow conflicts"
    fi
else
    print_failure "Stow is not installed"
fi

# ============================================================================
# SUMMARY
# ============================================================================

echo -e "\n--- Summary ---"
echo -e "Passed: $PASSED | Failed: $FAILED | Warnings: $WARNINGS"

if [[ $FAILED -gt 0 ]]; then
    exit 1
fi
exit 0

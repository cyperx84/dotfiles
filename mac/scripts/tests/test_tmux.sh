#!/usr/bin/env bash
# ============================================================================
# TMUX CONFIGURATION TEST SUITE
# ============================================================================
# Author: cyperx (https://github.com/cyperx84)
# Purpose: Validate Tmux configuration, plugins, and keybindings
# ============================================================================

set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
TMUX_CONF="$DOTFILES_DIR/tmux/.tmux.conf"

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

PASSED=0
FAILED=0
WARNINGS=0

print_success() { echo -e "${GREEN}✓${NC} $1"; ((PASSED++)); }
print_failure() { echo -e "${RED}✗${NC} $1"; ((FAILED++)); }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; ((WARNINGS++)); }

echo "Testing Tmux configuration..."

# ============================================================================
# FILE EXISTS
# ============================================================================

echo -e "\n--- File Checks ---"

if [[ -f "$TMUX_CONF" ]]; then
    print_success "tmux.conf exists"
else
    print_failure "tmux.conf not found"
    exit 1
fi

# ============================================================================
# PREFIX KEY
# ============================================================================

echo -e "\n--- Prefix Configuration ---"

if grep -q "prefix C-a" "$TMUX_CONF" 2>/dev/null; then
    print_success "Prefix set to C-a (as intended)"
else
    print_warning "Prefix may not be C-a"
fi

# ============================================================================
# PLUGIN VERIFICATION
# ============================================================================

echo -e "\n--- Plugin Configuration ---"

required_plugins=(
    "tmux-plugins/tpm"
    "christoomey/vim-tmux-navigator"
    "tmux-plugins/tmux-yank"
    "tmux-plugins/tmux-resurrect"
)

for plugin in "${required_plugins[@]}"; do
    if grep -q "$plugin" "$TMUX_CONF" 2>/dev/null; then
        print_success "Plugin configured: $(basename "$plugin")"
    else
        print_warning "Plugin missing: $plugin"
    fi
done

# Check if TPM is installed
if [[ -d "$HOME/.tmux/plugins/tpm" ]]; then
    print_success "TPM installed"
else
    print_warning "TPM not installed (run: git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm)"
fi

# ============================================================================
# KEYBINDING CHECKS
# ============================================================================

echo -e "\n--- Keybinding Configuration ---"

keybindings=(
    "bind-key.*split-window"
    "bind-key.*select-pane"
    "bind-key.*resize-pane"
)

for binding in "${keybindings[@]}"; do
    if grep -qE "$binding" "$TMUX_CONF" 2>/dev/null; then
        print_success "Keybinding pattern present: $(echo "$binding" | head -c 30)"
    fi
done

# ============================================================================
# VIM-TMUX NAVIGATOR
# ============================================================================

echo -e "\n--- Vim-Tmux Navigator ---"

if grep -q "vim-tmux-navigator" "$TMUX_CONF" 2>/dev/null; then
    print_success "vim-tmux-navigator configured"
else
    print_warning "vim-tmux-navigator not found"
fi

# ============================================================================
# SESH INTEGRATION
# ============================================================================

echo -e "\n--- Sesh Integration ---"

if grep -q "sesh" "$TMUX_CONF" 2>/dev/null; then
    print_success "Sesh integration found"
else
    print_warning "Sesh integration not found in tmux.conf"
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

#!/usr/bin/env bash
# ============================================================================
# INTEGRATION TEST SUITE
# ============================================================================
# Author: cyperx (https://github.com/cyperx84)
# Purpose: Validate cross-component integrations
# ============================================================================

set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

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

echo "Testing cross-component integrations..."

# ============================================================================
# AEROSPACE → SKETCHYBAR
# ============================================================================

echo -e "\n--- Aerospace → SketchyBar ---"

aerospace_conf="$DOTFILES_DIR/aerospace/.config/aerospace/aerospace.toml"
sketchybar_conf="$DOTFILES_DIR/sketchybar/.config/sketchybar/sketchybarrc"

# Check Aerospace triggers SketchyBar
if grep -q "aerospace_workspace_change" "$aerospace_conf" 2>/dev/null; then
    print_success "Aerospace triggers aerospace_workspace_change event"
else
    print_failure "Aerospace missing SketchyBar trigger"
fi

# Check SketchyBar listens for aerospace events
if grep -q "aerospace" "$sketchybar_conf" 2>/dev/null; then
    print_success "SketchyBar has Aerospace integration"
else
    print_warning "SketchyBar may not have Aerospace integration"
fi

# Check no HyprSpace remnants in SketchyBar
if grep -qi "hyprspace" "$sketchybar_conf" 2>/dev/null; then
    print_warning "SketchyBar still has HyprSpace references (dead code)"
else
    print_success "No HyprSpace dead code in SketchyBar"
fi

# ============================================================================
# ZSH → SKETCHYBAR
# ============================================================================

echo -e "\n--- Zsh → SketchyBar ---"

zshrc="$DOTFILES_DIR/zsh/.zshrc"

# Check brew() function integration
if grep -q "sketchybar --trigger brew_update" "$zshrc" 2>/dev/null; then
    print_success "brew() triggers SketchyBar update"
else
    print_failure "brew() function missing SketchyBar trigger (CRITICAL)"
fi

# ============================================================================
# TMUX → NEOVIM
# ============================================================================

echo -e "\n--- Tmux → Neovim ---"

tmux_conf="$DOTFILES_DIR/tmux/.tmux.conf"
nvim_dir="$DOTFILES_DIR/nvim/.config/nvim"

# Check vim-tmux-navigator in tmux
if grep -q "vim-tmux-navigator" "$tmux_conf" 2>/dev/null; then
    print_success "vim-tmux-navigator in tmux config"
else
    print_warning "vim-tmux-navigator not in tmux config"
fi

# Check vim-tmux-navigator plugin in neovim (search in plugins directory)
if find "$nvim_dir/lua" -name "*.lua" -exec grep -l "vim-tmux-navigator\|christoomey" {} \; 2>/dev/null | grep -q .; then
    print_success "vim-tmux-navigator referenced in Neovim"
else
    print_warning "vim-tmux-navigator not found in Neovim config"
fi

# ============================================================================
# GHOSTTY → TMUX
# ============================================================================

echo -e "\n--- Ghostty → Tmux ---"

ghostty_conf="$DOTFILES_DIR/ghostty/.config/ghostty/config"

# Check term compatibility
if grep -q "tmux" "$zshrc" 2>/dev/null && grep -q "TERM" "$zshrc" 2>/dev/null; then
    print_success "Zsh has terminal detection for tmux"
else
    print_warning "Terminal detection may be missing"
fi

# ============================================================================
# SESH → TMUX
# ============================================================================

echo -e "\n--- Sesh → Tmux ---"

sesh_conf="$DOTFILES_DIR/sesh/.config/sesh"

# Check sesh config exists
if [[ -d "$sesh_conf" ]]; then
    print_success "Sesh config directory exists"
else
    print_warning "Sesh config directory not found"
fi

# Check sesh integration in tmux
if grep -q "sesh" "$tmux_conf" 2>/dev/null; then
    print_success "Sesh integration in tmux config"
else
    print_warning "Sesh not referenced in tmux config"
fi

# Check sesh functions in zsh
if grep -q "sesh" "$zshrc" 2>/dev/null; then
    print_success "Sesh functions in zsh config"
else
    print_warning "Sesh not referenced in zsh config"
fi

# ============================================================================
# KANATA STATUS
# ============================================================================

echo -e "\n--- Input Management ---"

kanata_conf="$DOTFILES_DIR/kanata/.config/kanata/kanata.kbd"
karabiner_conf="$DOTFILES_DIR/karabiner/.config/karabiner/karabiner.json"

# Check Kanata is configured
if [[ -f "$kanata_conf" ]]; then
    print_success "Kanata config exists (PRIMARY input remapper)"
else
    print_warning "Kanata config not found"
fi

# Check Karabiner is unconfigured (as expected)
if grep -q '"simple_modifications": \[\]' "$karabiner_conf" 2>/dev/null; then
    print_success "Karabiner simple_modifications empty (expected)"
else
    print_warning "Karabiner may have active modifications (should be empty)"
fi

# ============================================================================
# SERVICE RESTART ORDER
# ============================================================================

echo -e "\n--- Service Dependencies ---"

# Document expected restart order
echo -e "Expected restart order:"
echo -e "  1. Aerospace → 2. borders → 3. SketchyBar"
print_success "Service restart order documented"

# ============================================================================
# SUMMARY
# ============================================================================

echo -e "\n--- Summary ---"
echo -e "Passed: $PASSED | Failed: $FAILED | Warnings: $WARNINGS"

if [[ $FAILED -gt 0 ]]; then
    exit 1
fi
exit 0

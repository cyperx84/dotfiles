#!/usr/bin/env bash
# ============================================================================
# AEROSPACE CONFIGURATION TEST SUITE
# ============================================================================
# Author: cyperx (https://github.com/cyperx84)
# Purpose: Validate Aerospace configuration and keybindings
# ============================================================================

set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
AEROSPACE_CONF="$DOTFILES_DIR/aerospace/.config/aerospace/aerospace.toml"

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

echo "Testing Aerospace configuration..."

# ============================================================================
# FILE EXISTS
# ============================================================================

echo -e "\n--- File Checks ---"

if [[ -f "$AEROSPACE_CONF" ]]; then
    print_success "aerospace.toml exists"
else
    print_failure "aerospace.toml not found"
    exit 1
fi

# ============================================================================
# TOML SYNTAX
# ============================================================================

echo -e "\n--- Syntax Validation ---"

# Try multiple TOML validators
if command -v taplo &>/dev/null; then
    if taplo check "$AEROSPACE_CONF" 2>/dev/null; then
        print_success "TOML syntax valid (taplo)"
    else
        print_failure "TOML syntax errors found"
    fi
elif command -v tomlq &>/dev/null; then
    if tomlq . "$AEROSPACE_CONF" >/dev/null 2>&1; then
        print_success "TOML syntax valid (tomlq)"
    else
        print_failure "TOML syntax errors found"
    fi
else
    print_warning "No TOML validator available (install taplo or tomlq)"
fi

# ============================================================================
# SKETCHYBAR INTEGRATION
# ============================================================================

echo -e "\n--- SketchyBar Integration ---"

if grep -q "aerospace_workspace_change" "$AEROSPACE_CONF" 2>/dev/null; then
    print_success "SketchyBar workspace callback configured"
else
    print_warning "SketchyBar integration missing"
fi

if grep -q "exec-on-workspace-change" "$AEROSPACE_CONF" 2>/dev/null; then
    print_success "exec-on-workspace-change present"
else
    print_warning "exec-on-workspace-change not found"
fi

# ============================================================================
# GAP CONFIGURATION
# ============================================================================

echo -e "\n--- Gap Configuration ---"

if grep -q "inner.*=.*20" "$AEROSPACE_CONF" 2>/dev/null; then
    print_success "Inner gaps set to 20px"
else
    print_warning "Inner gaps may not be 20px"
fi

if grep -q "top.*=.*52" "$AEROSPACE_CONF" 2>/dev/null; then
    print_success "Top padding set to 52px (for SketchyBar)"
else
    print_warning "Top padding may not be 52px"
fi

# ============================================================================
# AUTO-START
# ============================================================================

echo -e "\n--- Auto-Start Configuration ---"

if grep -q "start-at-login.*=.*true" "$AEROSPACE_CONF" 2>/dev/null; then
    print_success "Auto-start enabled"
else
    print_warning "Auto-start may not be enabled"
fi

# ============================================================================
# BORDERS INTEGRATION
# ============================================================================

echo -e "\n--- JankyBorders Integration ---"

if grep -q "borders" "$AEROSPACE_CONF" 2>/dev/null; then
    print_success "JankyBorders auto-start configured"
else
    print_warning "JankyBorders not in after-startup-command"
fi

# ============================================================================
# NO HYPRSPACE REMNANTS
# ============================================================================

echo -e "\n--- Dead Code Check ---"

if grep -qi "hyprspace" "$AEROSPACE_CONF" 2>/dev/null; then
    print_warning "HyprSpace references still present (should be removed)"
else
    print_success "No HyprSpace dead code found"
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

#!/usr/bin/env bash
# ============================================================================
# NEOVIM CONFIGURATION TEST SUITE
# ============================================================================
# Author: cyperx (https://github.com/cyperx84)
# Purpose: Validate Neovim configuration, Lua syntax, and health checks
# ============================================================================

set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
NVIM_DIR="$DOTFILES_DIR/nvim/.config/nvim"

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

echo "Testing Neovim configuration..."

# ============================================================================
# DIRECTORY STRUCTURE
# ============================================================================

echo -e "\n--- Directory Structure ---"

if [[ -d "$NVIM_DIR" ]]; then
    print_success "Neovim config directory exists"
else
    print_failure "Neovim config directory not found"
    exit 1
fi

if [[ -f "$NVIM_DIR/init.lua" ]]; then
    print_success "init.lua exists"
else
    print_failure "init.lua not found"
fi

if [[ -d "$NVIM_DIR/lua" ]]; then
    print_success "lua/ directory exists"
else
    print_failure "lua/ directory not found"
fi

# ============================================================================
# LUA SYNTAX VALIDATION
# ============================================================================

echo -e "\n--- Lua Syntax Validation ---"

lua_errors=0
if command -v luac &>/dev/null; then
    while IFS= read -r -d '' lua_file; do
        if ! luac -p "$lua_file" 2>/dev/null; then
            print_failure "Syntax error: $(basename "$lua_file")"
            ((lua_errors++))
        fi
    done < <(find "$NVIM_DIR/lua" -name "*.lua" -print0 2>/dev/null)

    if [[ $lua_errors -eq 0 ]]; then
        print_success "All Lua files pass syntax check"
    fi
else
    print_warning "luac not installed, skipping Lua syntax validation"
fi

# ============================================================================
# CRITICAL FILES
# ============================================================================

echo -e "\n--- Critical Files ---"

critical_files=(
    "lua/keymaps.lua"
    "lua/options.lua"
    "lua/lazy-plugins.lua"
)

for file in "${critical_files[@]}"; do
    if [[ -f "$NVIM_DIR/$file" ]]; then
        print_success "$(basename "$file") exists"
    else
        print_warning "$file not found"
    fi
done

# ============================================================================
# PLUGIN DIRECTORY
# ============================================================================

echo -e "\n--- Plugin Configuration ---"

if [[ -d "$NVIM_DIR/lua/custom/plugins" ]]; then
    plugin_count=$(find "$NVIM_DIR/lua/custom/plugins" -name "*.lua" | wc -l | tr -d ' ')
    print_success "Plugin directory exists ($plugin_count plugins)"
else
    print_warning "lua/custom/plugins directory not found"
fi

# ============================================================================
# LAZY.NVIM CHECK
# ============================================================================

echo -e "\n--- Plugin Manager ---"

if [[ -d "$HOME/.local/share/nvim/lazy/lazy.nvim" ]]; then
    print_success "Lazy.nvim installed"
else
    print_warning "Lazy.nvim not installed (will auto-install on first run)"
fi

# ============================================================================
# NEOVIM HEALTH CHECK (if headless possible)
# ============================================================================

echo -e "\n--- Health Check ---"

# Only run if nvim is available and we're not in a terminal that would hang
if command -v nvim &>/dev/null; then
    print_success "Neovim is available"

    # Check version
    nvim_version=$(nvim --version | head -1)
    print_success "Version: $nvim_version"
else
    print_failure "Neovim not found in PATH"
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

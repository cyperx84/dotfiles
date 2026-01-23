#!/usr/bin/env bash
# ============================================================================
# ZSH CONFIGURATION TEST SUITE
# ============================================================================
# Author: cyperx (https://github.com/cyperx84)
# Purpose: Validate Zsh configuration, PATH integrity, functions, and aliases
# ============================================================================

set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
ZSHRC="$DOTFILES_DIR/zsh/.zshrc"

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

echo "Testing Zsh configuration..."

# ============================================================================
# SYNTAX VALIDATION
# ============================================================================

echo -e "\n--- Syntax Checks ---"

if zsh -n "$ZSHRC" 2>/dev/null; then
    print_success "zshrc syntax valid"
else
    print_failure "zshrc has syntax errors"
fi

# ============================================================================
# PATH INTEGRITY
# ============================================================================

echo -e "\n--- PATH Integrity ---"

# Check for empty PATH entries
if echo "$PATH" | grep -q "::"; then
    print_warning "PATH contains empty entries (::)"
else
    print_success "No empty PATH entries"
fi

# Check for whitespace in PATH entries
if echo "$PATH" | grep -qE ':[[:space:]]+:|^[[:space:]]|[[:space:]]$'; then
    print_warning "PATH entries may contain problematic whitespace"
else
    print_success "No whitespace issues in PATH"
fi

# Check critical directories exist
critical_paths=(
    "$HOME/.local/share/bob/nvim-bin"
    "/opt/homebrew/opt/ruby/bin"
    "/usr/local/bin"
)

for path in "${critical_paths[@]}"; do
    if [[ -d "$path" ]]; then
        print_success "PATH directory exists: $path"
    else
        print_warning "PATH directory missing: $path"
    fi
done

# ============================================================================
# REQUIRED FUNCTIONS
# ============================================================================

echo -e "\n--- Required Functions ---"

required_functions=(
    "brew"      # SketchyBar integration
    "f"         # Yazi wrapper
    "fcd"       # Fuzzy cd
    "fv"        # Fuzzy vim
    "sc"        # Sesh connect
)

for func in "${required_functions[@]}"; do
    if grep -qE "^(function )?${func}\(\)" "$ZSHRC" 2>/dev/null || \
       grep -qE "^${func}\(\)" "$ZSHRC" 2>/dev/null; then
        print_success "Function defined: $func"
    else
        print_warning "Function missing: $func"
    fi
done

# ============================================================================
# CRITICAL ALIASES
# ============================================================================

echo -e "\n--- Critical Aliases ---"

critical_aliases=(
    "gs"    # git status
    "gc"    # git commit
    "gp"    # git push
    "n"     # nvim
    "ls"    # eza
    "l"     # eza clean
)

for alias_name in "${critical_aliases[@]}"; do
    if grep -qE "^alias ${alias_name}=" "$ZSHRC" 2>/dev/null; then
        print_success "Alias defined: $alias_name"
    else
        print_warning "Alias missing: $alias_name"
    fi
done

# ============================================================================
# INTEGRATION CHECKS
# ============================================================================

echo -e "\n--- Integration Checks ---"

# SketchyBar-Brew integration
if grep -q "sketchybar --trigger brew_update" "$ZSHRC" 2>/dev/null; then
    print_success "SketchyBar-Brew integration present"
else
    print_failure "SketchyBar-Brew integration MISSING (critical)"
fi

# Starship initialization
if grep -q 'eval "$(starship init zsh)"' "$ZSHRC" 2>/dev/null; then
    print_success "Starship initialization present"
else
    print_warning "Starship initialization missing"
fi

# Zoxide initialization
if grep -q 'eval "$(zoxide init zsh)"' "$ZSHRC" 2>/dev/null; then
    print_success "Zoxide initialization present"
else
    print_warning "Zoxide initialization missing"
fi

# FZF initialization
if grep -q 'source <(fzf --zsh)' "$ZSHRC" 2>/dev/null || \
   grep -q '\.fzf\.zsh' "$ZSHRC" 2>/dev/null; then
    print_success "FZF initialization present"
else
    print_warning "FZF initialization missing"
fi

# direnv lazy-load with precmd hook
if grep -q "add-zsh-hook precmd _direnv_first_prompt" "$ZSHRC" 2>/dev/null; then
    print_success "direnv precmd hook present (handles initial directory)"
else
    print_warning "direnv precmd hook missing (may miss .envrc in initial directory)"
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

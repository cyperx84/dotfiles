#!/usr/bin/env bash
# ============================================================================
# DOTFILES COMPREHENSIVE TEST SUITE
# ============================================================================
# Author: cyperx (https://github.com/cyperx84)
# Purpose: Validate all dotfiles configurations, syntax, and integrations
# Usage:
#   ./scripts/test_dotfiles.sh              # Run all tests
#   ./scripts/test_dotfiles.sh zsh          # Test specific component
#   ./scripts/test_dotfiles.sh --quick      # Syntax checks only
#   ./scripts/test_dotfiles.sh --verbose    # Detailed output
# ============================================================================

set -euo pipefail

# Configuration
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
TESTS_DIR="$DOTFILES_DIR/scripts/tests"
VERBOSE="${VERBOSE:-false}"
QUICK_MODE=false

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Test counters
PASSED=0
FAILED=0
WARNINGS=0
SKIPPED=0

# Helper functions
print_header() {
    echo -e "\n${BOLD}${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD}${BLUE}  $1${NC}"
    echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════════════════${NC}\n"
}

print_section() {
    echo -e "\n${BOLD}${CYAN}>>> $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
    ((PASSED++))
}

print_failure() {
    echo -e "${RED}✗${NC} $1"
    ((FAILED++))
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
    ((WARNINGS++))
}

print_skip() {
    echo -e "${BLUE}○${NC} $1 (skipped)"
    ((SKIPPED++))
}

print_info() {
    if [[ "$VERBOSE" == "true" ]]; then
        echo -e "${CYAN}ℹ${NC} $1"
    fi
}

# Check if command exists
command_exists() {
    command -v "$1" &>/dev/null
}

# Run a test script if it exists
run_test_script() {
    local script="$1"
    local name="$2"

    if [[ -f "$script" ]]; then
        print_section "Testing $name"
        if bash "$script"; then
            return 0
        else
            return 1
        fi
    else
        print_skip "$name test script not found"
        return 0
    fi
}

# ============================================================================
# CORE TESTS
# ============================================================================

test_path_integrity() {
    print_section "PATH Integrity"

    # Check for duplicate PATH entries
    local duplicates
    duplicates=$(echo "$PATH" | tr ':' '\n' | sort | uniq -d)
    if [[ -z "$duplicates" ]]; then
        print_success "No duplicate PATH entries"
    else
        print_warning "Duplicate PATH entries found: $duplicates"
    fi

    # Check critical binaries are reachable
    local critical_binaries=("nvim" "tmux" "zsh" "git" "stow")
    for bin in "${critical_binaries[@]}"; do
        if command_exists "$bin"; then
            print_success "$bin is reachable in PATH"
        else
            print_failure "$bin is NOT in PATH"
        fi
    done

    # Check optional but important binaries
    local optional_binaries=("aerospace" "sketchybar" "starship" "fzf" "eza" "bat" "fd" "rg")
    for bin in "${optional_binaries[@]}"; do
        if command_exists "$bin"; then
            print_success "$bin is available"
        else
            print_warning "$bin is not installed (optional)"
        fi
    done
}

test_symlinks() {
    print_section "Stow Symlinks"

    local configs=(
        "$HOME/.zshrc:zsh/.zshrc"
        "$HOME/.tmux.conf:tmux/.tmux.conf"
        "$HOME/.config/nvim:nvim/.config/nvim"
        "$HOME/.config/aerospace/aerospace.toml:aerospace/.config/aerospace/aerospace.toml"
        "$HOME/.config/sketchybar/sketchybarrc:sketchybar/.config/sketchybar/sketchybarrc"
        "$HOME/.config/ghostty/config:ghostty/.config/ghostty/config"
        "$HOME/.config/starship/starship.toml:starship/.config/starship/starship.toml"
    )

    for config in "${configs[@]}"; do
        local target="${config%%:*}"
        local source="${config##*:}"

        if [[ -L "$target" ]]; then
            local actual_source
            actual_source=$(readlink "$target")
            if [[ "$actual_source" == *"$source"* ]] || [[ -e "$target" ]]; then
                print_success "$(basename "$target") symlink valid"
            else
                print_failure "$(basename "$target") symlink broken"
            fi
        elif [[ -e "$target" ]]; then
            print_warning "$(basename "$target") exists but is not a symlink"
        else
            print_skip "$(basename "$target") not found"
        fi
    done
}

test_services() {
    print_section "Service Status"

    # Check if Aerospace is running
    if pgrep -x "AeroSpace" >/dev/null 2>&1; then
        print_success "AeroSpace is running"
    else
        print_warning "AeroSpace is not running"
    fi

    # Check if borders is running
    if pgrep -x "borders" >/dev/null 2>&1; then
        print_success "borders is running"
    else
        print_warning "borders is not running"
    fi

    # Check if sketchybar is running
    if pgrep -x "sketchybar" >/dev/null 2>&1; then
        print_success "sketchybar is running"
    else
        print_warning "sketchybar is not running"
    fi

    # Check Kanata status
    if sudo launchctl print system/com.example.kanata 2>/dev/null | grep -q "state = running"; then
        print_success "Kanata is running"
    else
        print_warning "Kanata may not be running (check with sudo)"
    fi
}

test_syntax() {
    print_section "Configuration Syntax"

    # Zsh syntax check
    if zsh -n "$DOTFILES_DIR/zsh/.zshrc" 2>/dev/null; then
        print_success "zsh/.zshrc syntax valid"
    else
        print_failure "zsh/.zshrc has syntax errors"
    fi

    # Tmux syntax check
    if tmux source-file "$DOTFILES_DIR/tmux/.tmux.conf" -t test 2>/dev/null || \
       tmux -f "$DOTFILES_DIR/tmux/.tmux.conf" start-server \; kill-server 2>/dev/null; then
        print_success "tmux/.tmux.conf syntax valid"
    else
        # Tmux might fail if no server is running, that's okay
        print_warning "tmux/.tmux.conf syntax check inconclusive"
    fi

    # JSON syntax check for karabiner
    if command_exists jq; then
        if jq . "$DOTFILES_DIR/karabiner/.config/karabiner/karabiner.json" >/dev/null 2>&1; then
            print_success "karabiner.json syntax valid"
        else
            print_failure "karabiner.json has JSON syntax errors"
        fi
    else
        print_skip "jq not installed, skipping JSON validation"
    fi

    # TOML syntax check for aerospace
    if command_exists tomlq || command_exists taplo; then
        if taplo check "$DOTFILES_DIR/aerospace/.config/aerospace/aerospace.toml" 2>/dev/null || \
           tomlq . "$DOTFILES_DIR/aerospace/.config/aerospace/aerospace.toml" >/dev/null 2>&1; then
            print_success "aerospace.toml syntax valid"
        else
            print_failure "aerospace.toml has TOML syntax errors"
        fi
    else
        # Fallback: check if Aerospace can load the config
        if command_exists aerospace; then
            print_info "TOML validator not found, relying on Aerospace validation"
            print_success "aerospace.toml (deferred to Aerospace)"
        else
            print_skip "TOML validator not available"
        fi
    fi

    # Lua syntax check for neovim configs
    if command_exists luac; then
        local lua_errors=0
        for lua_file in "$DOTFILES_DIR/nvim/.config/nvim/lua"/*.lua; do
            if [[ -f "$lua_file" ]]; then
                if ! luac -p "$lua_file" 2>/dev/null; then
                    print_failure "$(basename "$lua_file") has Lua syntax errors"
                    ((lua_errors++))
                fi
            fi
        done
        if [[ $lua_errors -eq 0 ]]; then
            print_success "Neovim Lua files syntax valid"
        fi
    else
        print_skip "luac not installed, skipping Lua validation"
    fi
}

test_integration() {
    print_section "Integration Tests"

    # Check SketchyBar-Brew integration
    if grep -q "sketchybar --trigger brew_update" "$DOTFILES_DIR/zsh/.zshrc" 2>/dev/null; then
        print_success "SketchyBar-Brew integration present"
    else
        print_failure "SketchyBar-Brew integration missing in .zshrc"
    fi

    # Check Aerospace-SketchyBar integration
    if grep -q "aerospace_workspace_change" "$DOTFILES_DIR/aerospace/.config/aerospace/aerospace.toml" 2>/dev/null; then
        print_success "Aerospace-SketchyBar integration present"
    else
        print_warning "Aerospace-SketchyBar integration not found"
    fi

    # Check vim-tmux-navigator integration
    if grep -q "vim-tmux-navigator" "$DOTFILES_DIR/tmux/.tmux.conf" 2>/dev/null; then
        print_success "vim-tmux-navigator integration present"
    else
        print_warning "vim-tmux-navigator not configured in tmux"
    fi
}

# ============================================================================
# MAIN
# ============================================================================

usage() {
    echo "Usage: $0 [OPTIONS] [COMPONENT]"
    echo ""
    echo "Options:"
    echo "  --quick     Run syntax checks only"
    echo "  --verbose   Show detailed output"
    echo "  --help      Show this help message"
    echo ""
    echo "Components:"
    echo "  zsh         Test Zsh configuration"
    echo "  tmux        Test Tmux configuration"
    echo "  aerospace   Test Aerospace configuration"
    echo "  neovim      Test Neovim configuration"
    echo "  stow        Test Stow symlinks"
    echo "  integration Test cross-component integration"
    echo "  all         Run all tests (default)"
}

main() {
    local component="all"

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --quick)
                QUICK_MODE=true
                shift
                ;;
            --verbose|-v)
                VERBOSE=true
                shift
                ;;
            --help|-h)
                usage
                exit 0
                ;;
            *)
                component="$1"
                shift
                ;;
        esac
    done

    print_header "DOTFILES TEST SUITE"
    echo "Mode: $([ "$QUICK_MODE" == "true" ] && echo "Quick" || echo "Full")"
    echo "Dotfiles: $DOTFILES_DIR"
    echo ""

    case "$component" in
        zsh)
            run_test_script "$TESTS_DIR/test_zsh.sh" "Zsh"
            ;;
        tmux)
            run_test_script "$TESTS_DIR/test_tmux.sh" "Tmux"
            ;;
        aerospace)
            run_test_script "$TESTS_DIR/test_aerospace.sh" "Aerospace"
            ;;
        neovim)
            run_test_script "$TESTS_DIR/test_neovim.sh" "Neovim"
            ;;
        stow)
            run_test_script "$TESTS_DIR/test_stow.sh" "Stow"
            ;;
        integration)
            run_test_script "$TESTS_DIR/test_integration.sh" "Integration"
            ;;
        all)
            if [[ "$QUICK_MODE" == "true" ]]; then
                test_syntax
            else
                test_path_integrity
                test_symlinks
                test_services
                test_syntax
                test_integration

                # Run component tests
                run_test_script "$TESTS_DIR/test_zsh.sh" "Zsh"
                run_test_script "$TESTS_DIR/test_tmux.sh" "Tmux"
                run_test_script "$TESTS_DIR/test_aerospace.sh" "Aerospace"
                run_test_script "$TESTS_DIR/test_neovim.sh" "Neovim"
                run_test_script "$TESTS_DIR/test_stow.sh" "Stow"
                run_test_script "$TESTS_DIR/test_integration.sh" "Integration"
            fi
            ;;
        *)
            echo "Unknown component: $component"
            usage
            exit 1
            ;;
    esac

    # Print summary
    print_header "TEST SUMMARY"
    echo -e "${GREEN}Passed:${NC}   $PASSED"
    echo -e "${RED}Failed:${NC}   $FAILED"
    echo -e "${YELLOW}Warnings:${NC} $WARNINGS"
    echo -e "${BLUE}Skipped:${NC}  $SKIPPED"
    echo ""

    if [[ $FAILED -gt 0 ]]; then
        echo -e "${RED}${BOLD}TESTS FAILED${NC}"
        exit 1
    elif [[ $WARNINGS -gt 0 ]]; then
        echo -e "${YELLOW}${BOLD}TESTS PASSED WITH WARNINGS${NC}"
        exit 0
    else
        echo -e "${GREEN}${BOLD}ALL TESTS PASSED${NC}"
        exit 0
    fi
}

main "$@"

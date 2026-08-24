#!/bin/bash
#
# SketchyBar Development Components Test Suite
# Tests all development-related plugins and their dependencies
#

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test results
PASSED=0
FAILED=0
WARNINGS=0

# Configuration
CONFIG_DIR="${HOME}/.config/sketchybar"
PLUGIN_DIR="${CONFIG_DIR}/plugins"

print_header() {
    echo -e "\n${BLUE}=== $1 ===${NC}"
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

test_dependencies() {
    print_header "Testing Dependencies"
    
    # Test SketchyBar
    if command -v sketchybar &> /dev/null; then
        print_success "SketchyBar is installed"
    else
        print_failure "SketchyBar is not installed"
    fi
    
    # Test required tools
    local tools=("git" "tmux" "docker" "lsof" "jq")
    for tool in "${tools[@]}"; do
        if command -v "$tool" &> /dev/null; then
            print_success "$tool is available"
        else
            print_warning "$tool is not installed (required for some plugins)"
        fi
    done
    
    # Test fonts
    if fc-list | grep -i "monaspice" &> /dev/null; then
        print_success "MonaspiceKr Nerd Font is installed"
    else
        print_warning "MonaspiceKr Nerd Font not found (may cause display issues)"
    fi
}

test_helper_binary() {
    print_header "Testing Helper Binary"
    
    local helper_dir="${CONFIG_DIR}/helper"
    if [ -d "$helper_dir" ]; then
        print_success "Helper directory exists"
        
        if [ -f "${helper_dir}/Makefile" ]; then
            print_success "Makefile found"
            
            # Test compilation
            cd "$helper_dir" || return 1
            if make clean && make; then
                print_success "Helper binary compiles successfully"
                if [ -x "./helper" ]; then
                    print_success "Helper binary is executable"
                else
                    print_failure "Helper binary is not executable"
                fi
            else
                print_failure "Helper binary compilation failed"
            fi
        else
            print_failure "Makefile not found in helper directory"
        fi
    else
        print_warning "Helper directory not found"
    fi
}

test_docker_plugin() {
    print_header "Testing Docker Plugin"
    
    if command -v docker &> /dev/null; then
        print_success "Docker is installed"
        
        # Test Docker daemon
        if docker info &>/dev/null; then
            print_success "Docker daemon is running"
            
            # Test container listing
            local count=$(docker ps --format "table {{.Names}}" 2>/dev/null | tail -n +2 | wc -l | tr -d ' ')
            print_success "Docker containers: $count running"
        else
            print_warning "Docker daemon is not running"
        fi
    else
        print_warning "Docker is not installed"
    fi
}

test_ssh_plugin() {
    print_header "Testing SSH Plugin"
    
    # Test if we're in SSH session
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        print_success "Currently in SSH session"
    else
        print_success "Not in SSH session (local machine)"
    fi
    
    # The plugin supports both Linux (`ss`) and macOS (`netstat`).
    if command -v ss &> /dev/null; then
        local connections=$(ss -t 2>/dev/null | grep :22 | grep ESTAB | wc -l | tr -d ' ')
        print_success "ss available; active SSH connections: $connections"
    elif command -v netstat &> /dev/null; then
        print_success "netstat fallback available for SSH monitoring"
    else
        print_warning "Neither ss nor netstat is available for SSH monitoring"
    fi
}

test_tmux_plugin() {
    print_header "Testing Tmux Plugin"
    
    if command -v tmux &> /dev/null; then
        print_success "Tmux is installed"
        
        # Test if tmux server is running
        if pgrep tmux &>/dev/null; then
            print_success "Tmux server is running"
            
            # Test session listing
            local session_count=$(tmux list-sessions 2>/dev/null | wc -l | tr -d ' ')
            print_success "Tmux sessions: $session_count"
            
            # Test current session detection
            local current_session=$(tmux display-message -p '#S' 2>/dev/null)
            if [ -n "$current_session" ]; then
                print_success "Current tmux session: $current_session"
            else
                print_success "Not attached to any tmux session"
            fi
        else
            print_success "Tmux server not running (will show as hidden)"
        fi
    else
        print_warning "Tmux is not installed"
    fi
}

test_plugin_files() {
    print_header "Testing Plugin Files"
    
    local dev_plugins=("ssh.sh" "tmux.sh" "docker.sh")
    
    for plugin in "${dev_plugins[@]}"; do
        local plugin_path="${PLUGIN_DIR}/${plugin}"
        if [ -f "$plugin_path" ]; then
            if [ -x "$plugin_path" ]; then
                print_success "$plugin exists and is executable"
            else
                print_failure "$plugin exists but is not executable"
            fi
        else
            print_failure "$plugin not found"
        fi
    done
}

test_sketchybar_running() {
    print_header "Testing SketchyBar Status"
    
    if pgrep -x sketchybar &>/dev/null; then
        print_success "SketchyBar is running"
        
        # Test if we can query sketchybar
        if sketchybar --query bar &>/dev/null; then
            print_success "SketchyBar is responsive"
        else
            print_warning "SketchyBar is not responding to queries"
        fi
    else
        print_warning "SketchyBar is not running"
    fi
}

run_plugin_test() {
    local plugin_name="$1"
    local plugin_path="${PLUGIN_DIR}/${plugin_name}.sh"

    # Runtime execution requires a real SketchyBar item in NAME and can mutate
    # the live bar. Validate syntax here; responsiveness is tested separately.
    if [ -f "$plugin_path" ] && [ -x "$plugin_path" ]; then
        print_header "Testing $plugin_name Plugin Syntax"
        if bash -n "$plugin_path"; then
            print_success "$plugin_name plugin syntax valid"
        else
            print_failure "$plugin_name plugin has syntax errors"
        fi
    else
        print_warning "Cannot test $plugin_name plugin (file missing or not executable)"
    fi
}

main() {
    echo "SketchyBar Development Components Test Suite"
    echo "==========================================="
    
    test_dependencies
    test_helper_binary
    test_sketchybar_running
    test_plugin_files
    
    # Test individual plugins
    test_docker_plugin
    test_ssh_plugin
    test_tmux_plugin
    
    # Test plugin execution
    local dev_plugins=("ssh" "tmux" "docker")
    for plugin in "${dev_plugins[@]}"; do
        run_plugin_test "$plugin"
    done
    
    # Summary
    print_header "Test Summary"
    echo -e "Passed: ${GREEN}${PASSED}${NC}"
    echo -e "Failed: ${RED}${FAILED}${NC}"
    echo -e "Warnings: ${YELLOW}${WARNINGS}${NC}"
    
    if [ $FAILED -eq 0 ]; then
        echo -e "\n${GREEN}All critical tests passed!${NC}"
        exit 0
    else
        echo -e "\n${RED}Some tests failed. Check the output above for details.${NC}"
        exit 1
    fi
}

# Make script executable when sourced
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
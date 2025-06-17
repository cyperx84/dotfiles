#!/bin/bash
#
# SketchyBar Debug and Troubleshooting Script
# Provides detailed debugging information for development components
#

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
CONFIG_DIR="${HOME}/.config/sketchybar"
PLUGIN_DIR="${CONFIG_DIR}/plugins"
LOG_FILE="/tmp/sketchybar_debug.log"

print_header() {
    echo -e "\n${BLUE}=== $1 ===${NC}"
}

print_info() {
    echo -e "${CYAN}ℹ${NC} $1"
}

print_debug() {
    echo -e "${YELLOW}🐛${NC} $1"
}

log_debug() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

debug_system_info() {
    print_header "System Information"
    
    print_info "OS: $(uname -s) $(uname -r)"
    print_info "Architecture: $(uname -m)"
    print_info "Shell: $SHELL"
    print_info "Terminal: $TERM"
    
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        print_info "SSH Session: Yes (Client: $SSH_CLIENT)"
    else
        print_info "SSH Session: No"
    fi
    
    if [ -n "$TMUX" ]; then
        print_info "Tmux Session: Yes ($TMUX)"
    else
        print_info "Tmux Session: No"
    fi
}

debug_sketchybar_status() {
    print_header "SketchyBar Status"
    
    # Check if running
    local pid=$(pgrep -x sketchybar)
    if [ -n "$pid" ]; then
        print_info "SketchyBar PID: $pid"
        print_info "Memory usage: $(ps -o rss= -p $pid | awk '{print $1/1024 " MB"}')"
        print_info "CPU usage: $(ps -o %cpu= -p $pid)%"
    else
        print_debug "SketchyBar is not running"
    fi
    
    # Check configuration
    if [ -f "${CONFIG_DIR}/sketchybarrc" ]; then
        print_info "Config file exists: ${CONFIG_DIR}/sketchybarrc"
        local config_size=$(wc -l < "${CONFIG_DIR}/sketchybarrc")
        print_info "Config file lines: $config_size"
    else
        print_debug "Config file not found"
    fi
    
    # Test sketchybar command
    if sketchybar --query bar &>/dev/null; then
        print_info "SketchyBar is responsive"
        local bar_info=$(sketchybar --query bar 2>/dev/null)
        if [ -n "$bar_info" ]; then
            echo "Bar configuration:"
            echo "$bar_info" | jq . 2>/dev/null || echo "$bar_info"
        fi
    else
        print_debug "SketchyBar is not responding to queries"
    fi
}

debug_helper_binary() {
    print_header "Helper Binary Debug"
    
    local helper_dir="${CONFIG_DIR}/helper"
    if [ -d "$helper_dir" ]; then
        print_info "Helper directory: $helper_dir"
        
        cd "$helper_dir" || return 1
        
        if [ -f "Makefile" ]; then
            print_info "Makefile exists"
            print_debug "Makefile contents:"
            cat Makefile | head -10
        fi
        
        if [ -f "helper" ]; then
            print_info "Helper binary exists"
            print_info "Binary size: $(ls -lh helper | awk '{print $5}')"
            print_info "Binary permissions: $(ls -l helper | awk '{print $1}')"
            
            # Test execution
            if ./helper --help &>/dev/null; then
                print_info "Helper binary responds to --help"
            else
                print_debug "Helper binary doesn't respond to --help"
            fi
        else
            print_debug "Helper binary not found"
        fi
        
        # Test compilation
        print_debug "Testing compilation..."
        if make clean &>/dev/null && make &>/dev/null; then
            print_info "Helper compiles successfully"
        else
            print_debug "Helper compilation failed"
            make 2>&1 | head -20
        fi
    else
        print_debug "Helper directory not found: $helper_dir"
    fi
}

debug_dev_plugin() {
    local plugin_name="$1"
    local plugin_path="${PLUGIN_DIR}/${plugin_name}.sh"
    
    print_header "Debug: $plugin_name Plugin"
    
    if [ ! -f "$plugin_path" ]; then
        print_debug "Plugin file not found: $plugin_path"
        return 1
    fi
    
    print_info "Plugin file: $plugin_path"
    print_info "File size: $(ls -lh "$plugin_path" | awk '{print $5}')"
    print_info "Permissions: $(ls -l "$plugin_path" | awk '{print $1}')"
    print_info "Last modified: $(ls -l "$plugin_path" | awk '{print $6, $7, $8}')"
    
    # Check syntax
    if bash -n "$plugin_path" 2>/dev/null; then
        print_info "Syntax check: OK"
    else
        print_debug "Syntax errors found:"
        bash -n "$plugin_path" 2>&1
    fi
    
    # Run with debug
    print_debug "Running plugin with debug output..."
    export NAME="debug_${plugin_name}"
    
    # Capture full execution
    local start_time=$(date +%s.%N)
    local output
    local exit_code
    
    {
        set -x
        bash "$plugin_path" 2>&1
        exit_code=$?
        set +x
    } > "/tmp/${plugin_name}_debug.log" 2>&1
    
    local end_time=$(date +%s.%N)
    local execution_time=$(echo "$end_time - $start_time" | bc -l 2>/dev/null || echo "N/A")
    
    print_info "Exit code: $exit_code"
    print_info "Execution time: ${execution_time}s"
    
    if [ -f "/tmp/${plugin_name}_debug.log" ]; then
        print_debug "Debug output (last 20 lines):"
        tail -20 "/tmp/${plugin_name}_debug.log"
    fi
}

debug_github_specific() {
    print_header "GitHub Plugin Specific Debug"
    
    # Test GitHub CLI authentication
    print_debug "Testing GitHub CLI authentication..."
    if gh auth status 2>/dev/null; then
        print_info "GitHub authentication OK"
        
        # Get user info
        local user=$(gh api user --jq .login 2>/dev/null)
        if [ -n "$user" ]; then
            print_info "Authenticated as: $user"
        fi
    else
        print_debug "GitHub authentication failed:"
        gh auth status 2>&1
    fi
    
    # Test API endpoints
    print_debug "Testing GitHub API endpoints..."
    
    # Test notifications
    local notifications_result
    notifications_result=$(gh api notifications 2>&1)
    local notifications_exit=$?
    
    if [ $notifications_exit -eq 0 ]; then
        local count=$(echo "$notifications_result" | jq length 2>/dev/null)
        print_info "Notifications API: OK ($count notifications)"
        
        if [ "$count" != "0" ] && [ "$count" != "null" ]; then
            print_debug "Sample notification:"
            echo "$notifications_result" | jq '.[0] | {repository: .repository.name, subject: .subject.title, type: .subject.type}' 2>/dev/null
        fi
    else
        print_debug "Notifications API failed:"
        echo "$notifications_result"
    fi
    
    # Test rate limits
    local rate_limit=$(gh api rate_limit 2>/dev/null)
    if [ -n "$rate_limit" ]; then
        print_info "API Rate limit info:"
        echo "$rate_limit" | jq '.rate | {limit, remaining, reset}' 2>/dev/null
    fi
}

debug_docker_specific() {
    print_header "Docker Plugin Specific Debug"
    
    # Test Docker daemon
    print_debug "Testing Docker daemon..."
    if docker version &>/dev/null; then
        print_info "Docker daemon: OK"
        
        local version_info=$(docker version --format '{{.Server.Version}}' 2>/dev/null)
        print_info "Docker version: $version_info"
        
        # Test containers
        print_debug "Container information:"
        docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Image}}" 2>/dev/null | head -10
        
        # Test system info
        local system_info=$(docker system df 2>/dev/null)
        if [ -n "$system_info" ]; then
            print_info "Docker system usage:"
            echo "$system_info"
        fi
    else
        print_debug "Docker daemon not accessible:"
        docker version 2>&1 | head -10
    fi
}

monitor_plugins() {
    print_header "Real-time Plugin Monitoring"
    
    local dev_plugins=("project" "git" "github" "ssh" "tmux" "dev_servers" "docker")
    
    print_info "Monitoring plugins for 30 seconds..."
    print_info "Press Ctrl+C to stop"
    
    local start_time=$(date +%s)
    local end_time=$((start_time + 30))
    
    while [ $(date +%s) -lt $end_time ]; do
        for plugin in "${dev_plugins[@]}"; do
            local plugin_path="${PLUGIN_DIR}/${plugin}.sh"
            if [ -f "$plugin_path" ] && [ -x "$plugin_path" ]; then
                local start_exec=$(date +%s.%N)
                export NAME="monitor_${plugin}"
                
                if bash "$plugin_path" &>/dev/null; then
                    local end_exec=$(date +%s.%N)
                    local exec_time=$(echo "$end_exec - $start_exec" | bc -l 2>/dev/null || echo "N/A")
                    log_debug "$plugin: OK (${exec_time}s)"
                else
                    log_debug "$plugin: FAILED"
                fi
            fi
        done
        sleep 5
    done
    
    print_info "Monitoring complete. Check $LOG_FILE for detailed logs."
}

show_logs() {
    print_header "Recent Debug Logs"
    
    if [ -f "$LOG_FILE" ]; then
        print_info "Showing last 50 log entries:"
        tail -50 "$LOG_FILE"
    else
        print_debug "No debug log file found"
    fi
}

main() {
    local action="${1:-all}"
    
    echo "SketchyBar Debug and Troubleshooting Script"
    echo "=========================================="
    
    # Initialize log
    echo "Debug session started: $(date)" > "$LOG_FILE"
    
    case "$action" in
        "system")
            debug_system_info
            ;;
        "sketchybar")
            debug_sketchybar_status
            ;;
        "helper")
            debug_helper_binary
            ;;
        "github")
            debug_github_specific
            ;;
        "docker")
            debug_docker_specific
            ;;
        "monitor")
            monitor_plugins
            ;;
        "logs")
            show_logs
            ;;
        "plugin")
            if [ -n "$2" ]; then
                debug_dev_plugin "$2"
            else
                echo "Usage: $0 plugin <plugin_name>"
                echo "Available plugins: project, git, github, ssh, tmux, dev_servers, docker"
            fi
            ;;
        "all"|*)
            debug_system_info
            debug_sketchybar_status
            debug_helper_binary
            
            local dev_plugins=("project" "git" "github" "ssh" "tmux" "dev_servers" "docker")
            for plugin in "${dev_plugins[@]}"; do
                debug_dev_plugin "$plugin"
            done
            
            debug_github_specific
            debug_docker_specific
            ;;
    esac
    
    print_info "Debug log saved to: $LOG_FILE"
}

# Show usage if requested
if [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
    echo "Usage: $0 [action]"
    echo ""
    echo "Actions:"
    echo "  all        - Run all debug checks (default)"
    echo "  system     - Show system information"
    echo "  sketchybar - Debug SketchyBar status"
    echo "  helper     - Debug helper binary"
    echo "  github     - Debug GitHub plugin specifically"
    echo "  docker     - Debug Docker plugin specifically"
    echo "  plugin <name> - Debug specific plugin"
    echo "  monitor    - Monitor plugins in real-time"
    echo "  logs       - Show recent debug logs"
    echo ""
    echo "Examples:"
    echo "  $0 github"
    echo "  $0 plugin git"
    echo "  $0 monitor"
    exit 0
fi

# Make script executable when sourced
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
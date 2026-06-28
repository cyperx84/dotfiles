#!/bin/bash
#
# SketchyBar Plugin Health Monitoring System
# Monitors the health and performance of all development plugins
#

# Configuration
CONFIG_DIR="${HOME}/.config/sketchybar"
PLUGIN_DIR="${CONFIG_DIR}/plugins"
HEALTH_LOG="/tmp/sketchybar_health.log"
ERROR_LOG="/tmp/sketchybar_errors.log"
HEALTH_FILE="/tmp/sketchybar_plugin_health.json"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Health monitoring configuration
HEALTH_CHECK_INTERVAL=30  # seconds
MAX_EXECUTION_TIME=5      # seconds
MAX_ERRORS_PER_HOUR=10

# Initialize logging
init_logging() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Health monitor started" > "$HEALTH_LOG"
    echo "{}" > "$HEALTH_FILE"
}

# Log health events
log_health() {
    local level="$1"
    local plugin="$2"
    local message="$3"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    echo "[$timestamp] [$level] [$plugin] $message" >> "$HEALTH_LOG"
    
    if [ "$level" = "ERROR" ]; then
        echo "[$timestamp] [$plugin] $message" >> "$ERROR_LOG"
    fi
}

# Update plugin health status in JSON file
update_health_status() {
    local plugin="$1"
    local status="$2"
    local exec_time="$3"
    local error_count="$4"
    local last_check=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    
    # Create temporary file with updated health data
    cat "$HEALTH_FILE" | jq \
        --arg plugin "$plugin" \
        --arg status "$status" \
        --arg exec_time "$exec_time" \
        --arg error_count "$error_count" \
        --arg last_check "$last_check" \
        '. += {($plugin): {
            status: $status,
            last_check: $last_check,
            execution_time: $exec_time,
            error_count: ($error_count | tonumber),
            last_error: (if $status == "error" then $last_check else .[$plugin].last_error // null end)
        }}' > "${HEALTH_FILE}.tmp" && mv "${HEALTH_FILE}.tmp" "$HEALTH_FILE"
}

# Get error count for plugin in the last hour
get_error_count() {
    local plugin="$1"
    local one_hour_ago=$(date -d '1 hour ago' '+%Y-%m-%d %H:%M:%S' 2>/dev/null || date -v-1H '+%Y-%m-%d %H:%M:%S')
    
    if [ -f "$ERROR_LOG" ]; then
        grep "\\[$plugin\\]" "$ERROR_LOG" | awk -v cutoff="$one_hour_ago" '$1 " " $2 > cutoff' | wc -l | tr -d ' '
    else
        echo "0"
    fi
}

# Test a single plugin
test_plugin() {
    local plugin_name="$1"
    local plugin_path="${PLUGIN_DIR}/${plugin_name}.sh"
    
    if [ ! -f "$plugin_path" ] || [ ! -x "$plugin_path" ]; then
        log_health "ERROR" "$plugin_name" "Plugin file missing or not executable"
        update_health_status "$plugin_name" "error" "0" "1"
        return 1
    fi
    
    # Set environment for plugin
    export NAME="health_check_${plugin_name}"
    export SENDER="health_check"
    
    # Execute plugin with timeout and measure execution time
    local start_time=$(date +%s.%N)
    local output
    local exit_code
    
    # Use timeout command if available
    if command -v timeout &> /dev/null; then
        output=$(timeout $MAX_EXECUTION_TIME bash "$plugin_path" 2>&1)
        exit_code=$?
    else
        # Fallback without timeout
        output=$(bash "$plugin_path" 2>&1)
        exit_code=$?
    fi
    
    local end_time=$(date +%s.%N)
    local execution_time=$(echo "$end_time - $start_time" | bc -l 2>/dev/null || echo "unknown")
    
    # Get current error count
    local error_count=$(get_error_count "$plugin_name")
    
    # Determine status
    local status="healthy"
    
    if [ $exit_code -ne 0 ]; then
        status="error"
        log_health "ERROR" "$plugin_name" "Plugin exited with code $exit_code: $output"
        error_count=$((error_count + 1))
    elif [ "$execution_time" != "unknown" ] && [ "$(echo "$execution_time > $MAX_EXECUTION_TIME" | bc -l 2>/dev/null)" = "1" ]; then
        status="slow"
        log_health "WARN" "$plugin_name" "Plugin execution time ($execution_time s) exceeded threshold ($MAX_EXECUTION_TIME s)"
    elif [ "$error_count" -gt "$MAX_ERRORS_PER_HOUR" ]; then
        status="unstable"
        log_health "WARN" "$plugin_name" "Plugin has $error_count errors in the last hour"
    else
        log_health "INFO" "$plugin_name" "Plugin healthy (${execution_time}s)"
    fi
    
    update_health_status "$plugin_name" "$status" "$execution_time" "$error_count"
    
    # Clean up environment
    unset NAME SENDER
    
    return $exit_code
}

# Test all development plugins
test_all_plugins() {
    local dev_plugins=("project" "git" "github" "ssh" "tmux" "dev_servers" "docker")
    local healthy_count=0
    local total_count=${#dev_plugins[@]}
    
    echo -e "${BLUE}Running health checks for all development plugins...${NC}"
    
    for plugin in "${dev_plugins[@]}"; do
        echo -n "Testing $plugin... "
        
        if test_plugin "$plugin"; then
            echo -e "${GREEN}✓${NC}"
            ((healthy_count++))
        else
            echo -e "${RED}✗${NC}"
        fi
    done
    
    echo ""
    echo -e "Health Summary: ${GREEN}$healthy_count${NC}/$total_count plugins healthy"
    
    return $((total_count - healthy_count))
}

# Generate health report
generate_health_report() {
    echo "SketchyBar Plugin Health Report"
    echo "==============================="
    echo "Generated: $(date)"
    echo ""
    
    if [ ! -f "$HEALTH_FILE" ]; then
        echo "No health data available."
        return 1
    fi
    
    # Parse and display health data
    jq -r '
        to_entries | 
        map(select(.value.status)) |
        sort_by(.value.status) |
        .[] | 
        "\(.key): \(.value.status) (last check: \(.value.last_check), exec time: \(.value.execution_time)s, errors/hr: \(.value.error_count))"
    ' "$HEALTH_FILE" 2>/dev/null || echo "Error parsing health data"
    
    echo ""
    echo "Recent Errors (last 50):"
    echo "------------------------"
    if [ -f "$ERROR_LOG" ]; then
        tail -50 "$ERROR_LOG"
    else
        echo "No errors logged."
    fi
}

# Monitor plugins continuously
monitor_continuously() {
    echo -e "${BLUE}Starting continuous plugin monitoring (interval: ${HEALTH_CHECK_INTERVAL}s)${NC}"
    echo "Press Ctrl+C to stop monitoring"
    
    while true; do
        test_all_plugins > /dev/null
        sleep $HEALTH_CHECK_INTERVAL
    done
}

# Check plugin dependencies
check_dependencies() {
    echo "Checking Plugin Dependencies"
    echo "============================"
    
    local deps=("git" "tmux" "docker" "gh" "lsof" "ss" "jq" "bc")
    local missing_deps=()
    
    for dep in "${deps[@]}"; do
        if command -v "$dep" &> /dev/null; then
            echo -e "${GREEN}✓${NC} $dep"
        else
            echo -e "${RED}✗${NC} $dep (missing)"
            missing_deps+=("$dep")
        fi
    done
    
    if [ ${#missing_deps[@]} -gt 0 ]; then
        echo ""
        echo -e "${YELLOW}Missing dependencies:${NC} ${missing_deps[*]}"
        echo "Some plugins may not function correctly."
        return 1
    else
        echo ""
        echo -e "${GREEN}All dependencies satisfied.${NC}"
        return 0
    fi
}

# Get plugin status for specific plugin
get_plugin_status() {
    local plugin="$1"
    
    if [ ! -f "$HEALTH_FILE" ]; then
        echo "No health data available"
        return 1
    fi
    
    jq -r --arg plugin "$plugin" '.[$plugin] // "Plugin not found"' "$HEALTH_FILE"
}

# Reset health data
reset_health_data() {
    echo "Resetting health monitoring data..."
    rm -f "$HEALTH_LOG" "$ERROR_LOG" "$HEALTH_FILE"
    init_logging
    echo "Health data reset complete."
}

# Show help
show_help() {
    echo "SketchyBar Plugin Health Monitor"
    echo "Usage: $0 [command] [options]"
    echo ""
    echo "Commands:"
    echo "  test [plugin]    - Test specific plugin or all plugins"
    echo "  monitor          - Continuously monitor all plugins"
    echo "  report           - Generate health report"
    echo "  status <plugin>  - Get status of specific plugin"
    echo "  deps             - Check plugin dependencies"
    echo "  reset            - Reset health monitoring data"
    echo "  help             - Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 test git      - Test only the git plugin"
    echo "  $0 test          - Test all development plugins"
    echo "  $0 monitor       - Start continuous monitoring"
    echo "  $0 status git    - Get status of git plugin"
}

# Main execution
main() {
    local command="${1:-test}"
    
    case "$command" in
        "test")
            init_logging
            if [ -n "$2" ]; then
                test_plugin "$2"
            else
                test_all_plugins
            fi
            ;;
        "monitor")
            init_logging
            monitor_continuously
            ;;
        "report")
            generate_health_report
            ;;
        "status")
            if [ -n "$2" ]; then
                get_plugin_status "$2"
            else
                echo "Error: Plugin name required for status command"
                exit 1
            fi
            ;;
        "deps")
            check_dependencies
            ;;
        "reset")
            reset_health_data
            ;;
        "help"|"-h"|"--help")
            show_help
            ;;
        *)
            echo "Unknown command: $command"
            show_help
            exit 1
            ;;
    esac
}

# Initialize if being executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
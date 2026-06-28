#!/bin/bash

# Kanata Diagnostic Script for macOS
# Checks the health of your kanata installation and identifies common issues
# Usage: ./kanata-check.sh [--verbose] [--fix]

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Counters
WARNINGS=0
ERRORS=0
CHECKS_PASSED=0
TOTAL_CHECKS=0

# Options
VERBOSE=false
FIX_MODE=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -f|--fix)
            FIX_MODE=true
            shift
            ;;
        -h|--help)
            cat << 'EOF'
Kanata Diagnostic Script for macOS

USAGE:
    ./kanata-check.sh [OPTIONS]

OPTIONS:
    -v, --verbose    Show detailed output for all checks
    -f, --fix        Attempt to fix issues automatically (requires sudo)
    -h, --help       Show this help message

DESCRIPTION:
    This script performs comprehensive diagnostics on your kanata installation:
    - Checks if all required services are running
    - Detects duplicate or conflicting services
    - Verifies file permissions and ownership
    - Checks for port conflicts
    - Scans logs for errors
    - Detects Karabiner Elements conflicts
    - Validates configuration files

EXIT CODES:
    0    All checks passed
    1    Warnings found (non-critical issues)
    2    Errors found (critical issues)

EXAMPLES:
    ./kanata-check.sh              # Basic health check
    ./kanata-check.sh --verbose    # Detailed output
    ./kanata-check.sh --fix        # Try to fix issues

EOF
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Helper functions
print_header() {
    echo ""
    echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BOLD}${CYAN}  $1${NC}"
    echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

print_section() {
    echo ""
    echo -e "${BOLD}${BLUE}▶ $1${NC}"
    echo ""
}

print_check() {
    echo -n "  Checking $1... "
}

print_pass() {
    echo -e "${GREEN}✓ PASS${NC}"
    if [ "$VERBOSE" = true ] && [ -n "${1:-}" ]; then
        echo -e "    ${GREEN}→${NC} $1"
    fi
    ((CHECKS_PASSED++))
    ((TOTAL_CHECKS++))
}

print_warn() {
    echo -e "${YELLOW}⚠ WARN${NC}"
    echo -e "    ${YELLOW}→${NC} $1"
    ((WARNINGS++))
    ((TOTAL_CHECKS++))
}

print_error() {
    echo -e "${RED}✗ ERROR${NC}"
    echo -e "    ${RED}→${NC} $1"
    ((ERRORS++))
    ((TOTAL_CHECKS++))
}

print_info() {
    echo -e "    ${CYAN}ℹ${NC} $1"
}

print_fix() {
    echo -e "    ${MAGENTA}⚙${NC} Fix: $1"
}

# Check if we need sudo for certain operations
need_sudo() {
    if [ "$EUID" -ne 0 ] && [ "$FIX_MODE" = true ]; then
        echo -e "${YELLOW}Note: Fix mode requires sudo privileges. Please run with sudo.${NC}"
        exit 1
    fi
}

# ============================================================================
# MAIN CHECKS
# ============================================================================

print_header "KANATA DIAGNOSTICS FOR MACOS"
echo ""
echo "Starting diagnostic checks..."
echo "Date: $(date)"
echo "User: $USER"
echo "macOS: $(sw_vers -productVersion)"

# ----------------------------------------------------------------------------
# 1. Check Homebrew and Kanata Installation
# ----------------------------------------------------------------------------

print_section "1. Installation Check"

print_check "Homebrew"
if command -v brew &> /dev/null; then
    BREW_VERSION=$(brew --version | head -1)
    print_pass "$BREW_VERSION"
else
    print_error "Homebrew not found"
    print_info "Install from: https://brew.sh"
fi

print_check "Kanata binary"
if command -v kanata &> /dev/null; then
    KANATA_PATH=$(which kanata)
    KANATA_VERSION=$(kanata --version 2>&1 || echo "unknown")
    print_pass "Found at $KANATA_PATH ($KANATA_VERSION)"
else
    print_error "Kanata binary not found"
    print_fix "Run: brew install kanata"
fi

print_check "Karabiner-DriverKit-VirtualHIDDevice"
if [ -d "/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice" ]; then
    print_pass "Driver installed"
else
    print_error "VirtualHIDDevice driver not found"
    print_fix "Run: brew install --cask karabiner-driverkit-virtualhiddevice"
fi

# ----------------------------------------------------------------------------
# 2. Configuration Files
# ----------------------------------------------------------------------------

print_section "2. Configuration Files"

CONFIG_FILE="$HOME/.config/kanata/kanata.kbd"
print_check "Kanata config file"
if [ -f "$CONFIG_FILE" ]; then
    FILE_SIZE=$(stat -f%z "$CONFIG_FILE")
    print_pass "Found ($FILE_SIZE bytes)"

    # Validate config if kanata is available
    if command -v kanata &> /dev/null; then
        print_check "Config file syntax"
        if kanata -c "$CONFIG_FILE" --check 2>/dev/null; then
            print_pass "Valid configuration"
        else
            print_error "Invalid configuration"
            print_fix "Run: kanata -c $CONFIG_FILE --check"
        fi
    fi
else
    print_error "Config file not found at $CONFIG_FILE"
    print_fix "Create config at: $CONFIG_FILE"
fi

# ----------------------------------------------------------------------------
# 3. LaunchDaemon Plist Files
# ----------------------------------------------------------------------------

print_section "3. LaunchDaemon Configuration"

KANATA_PLISTS=($(find /Library/LaunchDaemons -name "*kanata*.plist" 2>/dev/null))
VHD_PLISTS=($(find /Library/LaunchDaemons -name "*karabiner*vhid*.plist" 2>/dev/null))

print_check "Kanata plist files"
if [ ${#KANATA_PLISTS[@]} -eq 0 ]; then
    print_error "No kanata plist files found"
    print_fix "Create plist files in /Library/LaunchDaemons/ (see SETUP_GUIDE.md)"
elif [ ${#KANATA_PLISTS[@]} -eq 1 ]; then
    print_pass "Found 1 plist: ${KANATA_PLISTS[0]}"
else
    print_warn "Found ${#KANATA_PLISTS[@]} plist files (possible duplicates)"
    for plist in "${KANATA_PLISTS[@]}"; do
        print_info "- $plist"
    done
    print_fix "Remove duplicate plists to avoid conflicts"
fi

# Check plist ownership and permissions
for plist in "${KANATA_PLISTS[@]}"; do
    if [ -f "$plist" ]; then
        OWNER=$(stat -f "%Su:%Sg" "$plist")
        PERMS=$(stat -f "%Op" "$plist" | cut -c 3-)

        print_check "Plist ownership: $(basename $plist)"
        if [ "$OWNER" = "root:wheel" ] || [ "$OWNER" = "root:admin" ] || [[ "$OWNER" =~ ^root: ]]; then
            print_pass "Owned by $OWNER"
        else
            print_error "Incorrect ownership: $OWNER (should be root:wheel or root:*)"
            if [ "$FIX_MODE" = true ]; then
                print_fix "Fixing ownership..."
                sudo chown root:wheel "$plist"
            else
                print_fix "Run: sudo chown root:wheel $plist"
            fi
        fi
    fi
done

print_check "VirtualHIDDevice plist files"
if [ ${#VHD_PLISTS[@]} -ge 2 ]; then
    print_pass "Found ${#VHD_PLISTS[@]} plists"
    if [ "$VERBOSE" = true ]; then
        for plist in "${VHD_PLISTS[@]}"; do
            print_info "- $(basename $plist)"
        done
    fi
else
    print_warn "Expected 2 VirtualHIDDevice plists, found ${#VHD_PLISTS[@]}"
    print_info "Need: vhidmanager and vhiddaemon"
fi

# ----------------------------------------------------------------------------
# 4. Service Status
# ----------------------------------------------------------------------------

print_section "4. Service Status"

# Check kanata services
print_check "Kanata services"
KANATA_SERVICES=$(sudo launchctl list | grep kanata | wc -l | tr -d ' ')
if [ "$KANATA_SERVICES" -eq 0 ]; then
    print_error "No kanata services loaded"
    print_fix "Run: sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist"
elif [ "$KANATA_SERVICES" -eq 1 ]; then
    SERVICE_INFO=$(sudo launchctl list | grep kanata)
    PID=$(echo "$SERVICE_INFO" | awk '{print $1}')
    STATUS=$(echo "$SERVICE_INFO" | awk '{print $2}')

    if [ "$STATUS" = "0" ] && [ "$PID" != "-" ]; then
        print_pass "1 service running (PID: $PID)"
    elif [ "$STATUS" = "0" ] && [ "$PID" = "-" ]; then
        print_warn "Service loaded but not running"
        print_fix "Check logs: sudo tail /Library/Logs/Kanata/kanata.err.log"
    else
        print_error "Service in error state (exit code: $STATUS)"
        print_fix "Check logs: sudo tail /Library/Logs/Kanata/kanata.err.log"
    fi
else
    print_error "Multiple kanata services loaded ($KANATA_SERVICES)"
    sudo launchctl list | grep kanata | while read line; do
        print_info "- $line"
    done
    print_fix "Unload duplicates: sudo launchctl bootout system/SERVICE_NAME"
fi

# Check VirtualHIDDevice services
print_check "VirtualHIDDevice services"
VHD_SERVICES=$(sudo launchctl list | grep -E "karabiner.*vhid" | wc -l | tr -d ' ')
if [ "$VHD_SERVICES" -ge 2 ]; then
    print_pass "$VHD_SERVICES services running"
    if [ "$VERBOSE" = true ]; then
        sudo launchctl list | grep -E "karabiner.*vhid" | while read line; do
            print_info "- $line"
        done
    fi
else
    print_warn "Expected 2+ VirtualHIDDevice services, found $VHD_SERVICES"
    print_fix "Check: sudo launchctl list | grep karabiner"
fi

# Check for Karabiner Elements conflict
print_check "Karabiner Elements (conflict check)"
if sudo launchctl list | grep -q "karabiner_grabber"; then
    print_error "Karabiner Elements grabber service is running"
    print_info "Karabiner Elements conflicts with kanata"
    print_fix "Unload: sudo launchctl bootout system/org.pqrs.service.daemon.karabiner_grabber"
    print_fix "Remove: sudo rm -rf '/Applications/Karabiner-Elements.app'"
elif [ -d "/Applications/Karabiner-Elements.app" ]; then
    print_warn "Karabiner Elements app found but not running"
    print_fix "Consider removing: sudo rm -rf '/Applications/Karabiner-Elements.app'"
else
    print_pass "Not installed (good)"
fi

# ----------------------------------------------------------------------------
# 5. Process Check
# ----------------------------------------------------------------------------

print_section "5. Running Processes"

print_check "Kanata processes"
KANATA_PROCS=$(ps aux | grep -v grep | grep kanata | wc -l | tr -d ' ')
if [ "$KANATA_PROCS" -eq 0 ]; then
    print_error "No kanata processes running"
    print_fix "Start service: sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist"
elif [ "$KANATA_PROCS" -eq 1 ]; then
    PROC_INFO=$(ps aux | grep -v grep | grep kanata | head -1)
    PID=$(echo "$PROC_INFO" | awk '{print $2}')
    USER=$(echo "$PROC_INFO" | awk '{print $1}')
    print_pass "1 process running (PID: $PID, User: $USER)"
else
    print_error "Multiple kanata processes running ($KANATA_PROCS)"
    ps aux | grep -v grep | grep kanata | while read line; do
        PID=$(echo "$line" | awk '{print $2}')
        USER=$(echo "$line" | awk '{print $1}')
        print_info "- PID $PID (User: $USER)"
    done
    print_fix "Kill duplicates: sudo killall kanata"
fi

# ----------------------------------------------------------------------------
# 6. Port Check
# ----------------------------------------------------------------------------

print_section "6. Network Port Check"

print_check "Port 10000 (TCP server)"
PORT_CHECK=$(sudo lsof -i :10000 2>/dev/null | grep LISTEN || true)
if [ -n "$PORT_CHECK" ]; then
    PORT_PROC=$(echo "$PORT_CHECK" | awk '{print $1}')
    PORT_PID=$(echo "$PORT_CHECK" | awk '{print $2}')

    if [ "$PORT_PROC" = "kanata" ]; then
        print_pass "Bound to kanata (PID: $PORT_PID)"
    else
        print_error "Bound to $PORT_PROC (PID: $PORT_PID) - not kanata!"
        print_fix "Kill process: sudo kill $PORT_PID"
    fi
else
    print_warn "Port 10000 not in use"
    print_info "Kanata may not have --port argument configured"
fi

# ----------------------------------------------------------------------------
# 7. Permissions Check
# ----------------------------------------------------------------------------

print_section "7. Permissions Check"

print_check "Input Monitoring permission"
# This is tricky to check programmatically, so we'll check logs for permission errors
if [ -f "/Library/Logs/Kanata/kanata.err.log" ]; then
    PERM_ERRORS=$(grep -i "IOHIDDeviceOpen.*not permitted" /Library/Logs/Kanata/kanata.err.log 2>/dev/null | wc -l | tr -d ' ')

    if [ "$PERM_ERRORS" -gt 0 ]; then
        print_error "Permission errors detected in logs"
        print_info "Found $PERM_ERRORS 'not permitted' errors"
        print_fix "Grant Input Monitoring permission in System Settings → Privacy & Security"
    else
        print_pass "No permission errors in logs"
    fi
else
    print_warn "Cannot check (log file not found)"
fi

print_check "Log directory"
if [ -d "/Library/Logs/Kanata" ]; then
    LOG_PERMS=$(stat -f "%Op" /Library/Logs/Kanata | cut -c 3-)
    print_pass "Exists (permissions: $LOG_PERMS)"
else
    print_error "Log directory doesn't exist"
    if [ "$FIX_MODE" = true ]; then
        print_fix "Creating log directory..."
        sudo mkdir -p /Library/Logs/Kanata
        sudo chmod 755 /Library/Logs/Kanata
    else
        print_fix "Run: sudo mkdir -p /Library/Logs/Kanata && sudo chmod 755 /Library/Logs/Kanata"
    fi
fi

# ----------------------------------------------------------------------------
# 8. Log Analysis
# ----------------------------------------------------------------------------

print_section "8. Log Analysis"

OUT_LOG="/Library/Logs/Kanata/kanata.out.log"
ERR_LOG="/Library/Logs/Kanata/kanata.err.log"

if [ -f "$OUT_LOG" ]; then
    print_check "Output log"
    LOG_SIZE=$(stat -f%z "$OUT_LOG")
    RECENT_ENTRIES=$(tail -1 "$OUT_LOG" 2>/dev/null || echo "")

    if [ -n "$RECENT_ENTRIES" ]; then
        print_pass "Active (size: $LOG_SIZE bytes)"

        # Check for successful startup messages
        if grep -q "Starting kanata proper" "$OUT_LOG" 2>/dev/null; then
            print_check "Kanata startup"
            print_pass "Successfully started"

            # Check driver connection
            if grep -q "driver connected: true" "$OUT_LOG" 2>/dev/null; then
                print_check "Driver connection"
                print_pass "Driver connected"
            else
                print_check "Driver connection"
                print_warn "Driver connection not confirmed"
            fi
        fi
    else
        print_warn "Empty or no recent entries"
    fi
else
    print_error "Output log not found at $OUT_LOG"
fi

if [ -f "$ERR_LOG" ]; then
    print_check "Error log"
    ERR_SIZE=$(stat -f%z "$ERR_LOG")

    # Count recent errors (last 50 lines)
    RECENT_PANICS=$(tail -50 "$ERR_LOG" 2>/dev/null | grep -c "panic" || echo "0")
    RECENT_ERRORS=$(tail -50 "$ERR_LOG" 2>/dev/null | grep -c "error" || echo "0")

    if [ "$RECENT_PANICS" -gt 0 ]; then
        print_error "$RECENT_PANICS panic(s) in recent logs"

        # Check for specific error types
        if grep -q "Address already in use" "$ERR_LOG" 2>/dev/null; then
            print_info "Port conflict detected"
            print_fix "Check for duplicate services or processes"
        fi

        if grep -q "IOHIDDeviceOpen" "$ERR_LOG" 2>/dev/null; then
            print_info "Permission error detected"
            print_fix "Grant Input Monitoring permission"
        fi

        if [ "$VERBOSE" = true ]; then
            print_info "Recent errors:"
            tail -20 "$ERR_LOG" 2>/dev/null | grep -E "panic|error" | while read line; do
                echo "      $line"
            done
        fi
    elif [ "$RECENT_ERRORS" -gt 0 ]; then
        print_warn "$RECENT_ERRORS error(s) in recent logs"
        if [ "$VERBOSE" = true ]; then
            tail -20 "$ERR_LOG" 2>/dev/null | grep "error" | while read line; do
                echo "      $line"
            done
        fi
    else
        print_pass "No recent errors (size: $ERR_SIZE bytes)"
    fi
else
    print_warn "Error log not found"
fi

# ----------------------------------------------------------------------------
# 9. System Extension Check
# ----------------------------------------------------------------------------

print_section "9. System Extension Check"

print_check "VirtualHIDDevice driver"
if system_profiler SPExtensionsDataType 2>/dev/null | grep -q "Karabiner-DriverKit-VirtualHIDDevice"; then
    print_pass "Loaded and active"
else
    print_warn "Driver not detected in system extensions"
    print_fix "Check System Settings → Privacy & Security for blocked extensions"
fi

# ----------------------------------------------------------------------------
# SUMMARY
# ----------------------------------------------------------------------------

print_header "SUMMARY"
echo ""

TOTAL_ISSUES=$((WARNINGS + ERRORS))

echo -e "${BOLD}Results:${NC}"
echo -e "  ${GREEN}Passed:${NC}   $CHECKS_PASSED / $TOTAL_CHECKS"
echo -e "  ${YELLOW}Warnings:${NC} $WARNINGS"
echo -e "  ${RED}Errors:${NC}   $ERRORS"
echo ""

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}${BOLD}✓ All checks passed! Kanata is healthy.${NC}"
    exit 0
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}${BOLD}⚠ Checks completed with warnings.${NC}"
    echo -e "  Your kanata setup is working but has minor issues."
    echo -e "  Review the warnings above for potential improvements."
    exit 1
else
    echo -e "${RED}${BOLD}✗ Critical errors detected.${NC}"
    echo -e "  Your kanata setup has issues that need attention."
    echo -e "  Review the errors above and apply suggested fixes."
    echo ""
    echo -e "${CYAN}Quick fixes:${NC}"
    echo -e "  1. Check logs: sudo tail -50 /Library/Logs/Kanata/kanata.err.log"
    echo -e "  2. Restart service: sudo launchctl bootout system/com.example.kanata && \\"
    echo -e "                      sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist"
    echo -e "  3. Review guide: cat ~/dotfiles/kanata/SETUP_GUIDE.md"
    echo ""
    exit 2
fi

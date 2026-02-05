#!/usr/bin/env bash
# ============================================================================
# macOS SYSTEM CONFIGURATION
# ============================================================================
# Author: cyperx
# Purpose: Configure macOS system defaults and 24/7 server operation
# Usage:
#   ./macos/setup.sh              # Apply all settings (requires sudo)
#   ./macos/setup.sh --check      # Show current settings without changing
#
# Note: Some settings require a logout/restart to take effect.
#       Dock and Finder are restarted automatically after applying.
# ============================================================================

set -euo pipefail

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

CHECK_ONLY=false
[[ "${1:-}" == "--check" ]] && CHECK_ONLY=true

# ============================================================================
# Helper functions
# ============================================================================

print_header() {
    echo -e "\n${BOLD}${BLUE}━━━ $1 ━━━${NC}"
}

check_default() {
    local domain="$1" key="$2" desired="$3" label="$4"
    local current
    current=$(defaults read "$domain" "$key" 2>/dev/null || echo "(not set)")
    if [[ "$current" == "$desired" ]]; then
        echo -e "  ${GREEN}✓${NC} ${label}: ${current}"
    else
        echo -e "  ${YELLOW}✗${NC} ${label}: ${current} → ${BOLD}${desired}${NC}"
    fi
}

apply_default() {
    local domain="$1" key="$2" type="$3" value="$4"
    defaults write "$domain" "$key" "$type" "$value"
}

# ============================================================================
# Close affected apps (only when applying)
# ============================================================================

if [[ "$CHECK_ONLY" == false ]]; then
    echo -e "${BOLD}Closing System Settings to prevent conflicts...${NC}"
    osascript -e 'tell application "System Settings" to quit' 2>/dev/null || true
    sleep 1
fi

# ============================================================================
# Dock
# ============================================================================

print_header "Dock"

check_default com.apple.dock autohide "1" "Auto-hide dock"
check_default com.apple.dock tilesize "45" "Icon size"
check_default com.apple.dock show-recents "0" "Show recent apps"

if [[ "$CHECK_ONLY" == false ]]; then
    apply_default com.apple.dock autohide -bool true
    apply_default com.apple.dock tilesize -int 45
    apply_default com.apple.dock show-recents -bool false
    echo -e "  ${GREEN}✓ Dock settings applied${NC}"
fi

# ============================================================================
# Finder
# ============================================================================

print_header "Finder"

check_default com.apple.finder FXPreferredViewStyle "Nlsv" "Default view (list)"

if [[ "$CHECK_ONLY" == false ]]; then
    apply_default com.apple.finder FXPreferredViewStyle -string "Nlsv"
    echo -e "  ${GREEN}✓ Finder settings applied${NC}"
fi

# ============================================================================
# Window Manager
# ============================================================================

print_header "Window Manager"

check_default com.apple.WindowManager HideDesktop "1" "Hide desktop icons"
check_default com.apple.WindowManager StandardHideDesktopIcons "1" "Hide desktop icons (standard)"

if [[ "$CHECK_ONLY" == false ]]; then
    apply_default com.apple.WindowManager HideDesktop -bool true
    apply_default com.apple.WindowManager StandardHideDesktopIcons -bool true
    echo -e "  ${GREEN}✓ Window Manager settings applied${NC}"
fi

# ============================================================================
# Screenshots
# ============================================================================

print_header "Screenshots"

check_default com.apple.screencapture location "~/Documents/" "Save location"

if [[ "$CHECK_ONLY" == false ]]; then
    apply_default com.apple.screencapture location -string "~/Documents/"
    echo -e "  ${GREEN}✓ Screenshot settings applied${NC}"
fi

# ============================================================================
# Scroll & Input
# ============================================================================

print_header "Scroll & Input"

check_default NSGlobalDomain com.apple.swipescrolldirection "0" "Natural scrolling (off)"

if [[ "$CHECK_ONLY" == false ]]; then
    apply_default NSGlobalDomain com.apple.swipescrolldirection -bool false
    echo -e "  ${GREEN}✓ Scroll settings applied${NC}"
fi

# ============================================================================
# Hot Corners
# ============================================================================

print_header "Hot Corners"

# Hot corner values:
#  0: No action     2: Mission Control   3: App Windows
#  4: Desktop       5: Start Screensaver 6: Disable Screensaver
#  7: Dashboard    10: Put Display to Sleep
# 11: Launchpad   12: Notification Center
# 13: Lock Screen  14: Quick Note

check_default com.apple.dock wvous-br-corner "14" "Bottom-right (Quick Note)"

if [[ "$CHECK_ONLY" == false ]]; then
    apply_default com.apple.dock wvous-br-corner -int 14
    apply_default com.apple.dock wvous-br-modifier -int 0
    echo -e "  ${GREEN}✓ Hot corners applied${NC}"
fi

# ============================================================================
# Power Management (pmset) — 24/7 Server Mode
# ============================================================================

print_header "Power Management (pmset)"

declare -A POWER_SETTINGS=(
    ["sleep"]="0"              # Never sleep
    ["disksleep"]="0"          # Never spin down disks
    ["displaysleep"]="10"      # Screen off after 10 min (Mac stays awake)
    ["autorestart"]="1"        # Auto-restart after power failure
    ["womp"]="1"               # Wake on network access (Wake-on-LAN)
    ["powernap"]="0"           # Disable Power Nap (unnecessary for always-on)
    ["networkoversleep"]="0"   # Don't wake for network tasks during sleep
    ["tcpkeepalive"]="1"      # Keep TCP connections alive
)

for key in "${!POWER_SETTINGS[@]}"; do
    current=$(pmset -g | grep "^ ${key}" | awk '{print $2}' 2>/dev/null || echo "?")
    desired="${POWER_SETTINGS[$key]}"
    if [[ "$current" == "$desired" ]]; then
        echo -e "  ${GREEN}✓${NC} ${key}: ${current}"
    else
        echo -e "  ${YELLOW}✗${NC} ${key}: ${current} → ${BOLD}${desired}${NC}"
    fi
done

if [[ "$CHECK_ONLY" == false ]]; then
    echo -e "\n  ${BLUE}Applying power settings (requires sudo)...${NC}"
    for key in "${!POWER_SETTINGS[@]}"; do
        sudo pmset -a "$key" "${POWER_SETTINGS[$key]}"
    done
    echo -e "  ${GREEN}✓ Power settings applied${NC}"
fi

# ============================================================================
# Remote Access
# ============================================================================

print_header "Remote Access"

if systemsetup -getremotelogin 2>/dev/null | grep -q "On"; then
    echo -e "  ${GREEN}✓${NC} Remote Login (SSH): On"
else
    echo -e "  ${YELLOW}✗${NC} Remote Login (SSH): Off"
    if [[ "$CHECK_ONLY" == false ]]; then
        sudo systemsetup -setremotelogin on
        echo -e "  ${GREEN}✓ Remote Login enabled${NC}"
    fi
fi

# ============================================================================
# Restart affected apps
# ============================================================================

if [[ "$CHECK_ONLY" == false ]]; then
    print_header "Restarting Affected Apps"
    killall Dock 2>/dev/null && echo -e "  ${GREEN}✓${NC} Dock restarted" || true
    killall Finder 2>/dev/null && echo -e "  ${GREEN}✓${NC} Finder restarted" || true
    killall SystemUIServer 2>/dev/null && echo -e "  ${GREEN}✓${NC} SystemUIServer restarted" || true
fi

# ============================================================================
# Summary
# ============================================================================

print_header "Summary"

if [[ "$CHECK_ONLY" == true ]]; then
    echo -e "  ${YELLOW}Dry run — no changes made. Run without --check to apply.${NC}"
else
    echo -e "  ${GREEN}All settings applied.${NC}"
fi

echo ""
echo -e "  ${BOLD}Manual steps (can't be scripted):${NC}"
echo -e "  • System Settings → Users & Groups → Automatic Login → cyperx"
echo -e "  • System Settings → Privacy & Security → FileVault → Off"
echo -e "  • Consider a UPS battery backup for power outage protection"
echo ""
echo -e "  ${BOLD}Services (managed separately):${NC}"
echo -e "  • OpenClaw gateway: openclaw daemon install"
echo -e "  • SketchyBar: brew services start sketchybar"
echo -e "  • JankyBorders: brew services start borders"
echo ""

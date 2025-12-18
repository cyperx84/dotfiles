#!/bin/bash
# sidecar.sh - Connect iPad as extended display via Sidecar (NOT Universal Control)
#
# Usage:
#   ./sidecar-ipad.sh              # Connect first available iPad via Sidecar
#   ./sidecar-ipad.sh "iPad Pro"   # Connect specific iPad by name
#   ./sidecar-ipad.sh --disconnect # Disconnect Sidecar
#   ./sidecar-ipad.sh --list       # List available displays in menu
#
# Edge cases handled:
#   - Dynamically finds "Mirror or extend to" section position
#   - Supports multiple iPads (specify name as argument)
#   - Handles timing variations with retries
#   - Disconnect option to end Sidecar session

set -euo pipefail

IPAD_NAME="${1:-iPad}"

# List menu items for debugging
if [[ "${1:-}" == "--list" ]]; then
    osascript <<'EOF'
open location "x-apple.systempreferences:com.apple.Displays-Settings.extension"
delay 1.2
tell application "System Events"
    tell process "System Settings"
        set menuBtn to menu button 1 of group 1 of group 3 of splitter group 1 of group 1 of window 1
        click menuBtn
        delay 0.5

        set menuItems to every menu item of menu 1 of menuBtn
        set output to ""
        set idx to 1
        repeat with menuItem in menuItems
            try
                set itemName to name of menuItem
                set output to output & idx & ": " & itemName & "\n"
            end try
            set idx to idx + 1
        end repeat

        key code 53 -- escape
        return output
    end tell
end tell
EOF
    echo "Run without --list to connect, or specify iPad name as argument"
    exit 0
fi

# Disconnect Sidecar
if [[ "${1:-}" == "--disconnect" ]]; then
    osascript <<'EOF'
open location "x-apple.systempreferences:com.apple.Displays-Settings.extension"
delay 1.2
tell application "System Events"
    tell process "System Settings"
        try
            set displayGroup to group 1 of group 3 of splitter group 1 of group 1 of window 1
            set buttons to every button of displayGroup
            repeat with btn in buttons
                if name of btn contains "iPad" then
                    click btn
                    delay 0.3
                    try
                        click button "Disconnect" of sheet 1 of window 1
                    end try
                    exit repeat
                end if
            end repeat
        end try
    end tell
end tell
delay 0.2
tell application "System Settings" to quit
return "Disconnected"
EOF
    echo "Sidecar disconnected"
    exit 0
fi

# Main connection logic - optimized for speed
osascript <<EOF
on findSidecarPosition(menuItems, targetName)
    set mirrorSectionIdx to 0
    set targetIdx to 0
    set idx to 1

    repeat with menuItem in menuItems
        try
            set itemName to name of menuItem
            if itemName contains "Mirror" or itemName contains "extend" then
                set mirrorSectionIdx to idx
            end if
            if mirrorSectionIdx > 0 and idx > mirrorSectionIdx then
                if itemName contains "$IPAD_NAME" then
                    set targetIdx to idx
                    exit repeat
                end if
            end if
        end try
        set idx to idx + 1
    end repeat

    return targetIdx
end findSidecarPosition

open location "x-apple.systempreferences:com.apple.Displays-Settings.extension"
delay 1.2

tell application "System Events"
    tell process "System Settings"
        -- Quick retry loop with minimal delay
        repeat 5 times
            try
                set menuBtn to menu button 1 of group 1 of group 3 of splitter group 1 of group 1 of window 1
                exit repeat
            on error
                delay 0.2
            end try
        end repeat

        click menuBtn
        delay 0.8

        set menuItems to every menu item of menu 1 of menuBtn
        set targetPos to my findSidecarPosition(menuItems, "$IPAD_NAME")

        if targetPos = 0 then
            key code 53
            return "Error: iPad not found in Sidecar section"
        end if

        -- Fast arrow key navigation
        repeat (targetPos - 1) times
            key code 125
            delay 0.04
        end repeat

        delay 0.4
        key code 36
        delay 0.3

    end tell
end tell

delay 0.3
tell application "System Settings" to quit
return "Connected"
EOF

#!/usr/bin/env bash

# ============================================================================
# Aerospace Startup Apps Script
# Launches default apps on specific workspaces
# Edit the variables below to customize your setup
# ============================================================================

# Workspace 1 - Terminal
SPACE_1_APP="Ghostty"

# Workspace 2 - Browser
SPACE_2_APP="Zen"

# Workspace 3 - IDE/Editor
SPACE_3_APP="Claude"

# Workspace 4 - Other
SPACE_4_APP="Antigravity"

# Delay (in seconds) between launching apps
# Increase if apps aren't moving to correct workspaces
LAUNCH_DELAY=0.8

# ============================================================================
# Launch function
# ============================================================================

launch_app_on_workspace() {
    local app_name=$1
    local workspace=$2

    echo "Launching $app_name on workspace $workspace..."
    open -a "$app_name"
    sleep "$LAUNCH_DELAY"
    aerospace move-node-to-workspace "$workspace"
}

# ============================================================================
# Launch all apps
# ============================================================================

launch_app_on_workspace "$SPACE_1_APP" "1"
launch_app_on_workspace "$SPACE_2_APP" "2"
launch_app_on_workspace "$SPACE_3_APP" "3"
launch_app_on_workspace "$SPACE_4_APP" "4"

echo "✓ Startup apps launched"

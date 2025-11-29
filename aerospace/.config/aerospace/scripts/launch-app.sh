#!/usr/bin/env bash

# ============================================================================
# Launch App with Workspace Assignment
# Usage: launch-app.sh "App Name" workspace_number [delay]
# Example: launch-app.sh "Ghostty" 1 0.8
# ============================================================================

APP_NAME=$1
WORKSPACE=$2
DELAY=${3:-0.8}

if [[ -z "$APP_NAME" || -z "$WORKSPACE" ]]; then
    echo "Usage: $0 'App Name' workspace [delay]"
    exit 1
fi

open -a "$APP_NAME"
sleep "$DELAY"
aerospace move-node-to-workspace "$WORKSPACE"

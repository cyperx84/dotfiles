#!/bin/bash

# GitHub plugin with improved error handling and debugging

# Debug logging function
debug_log() {
  if [ "$GITHUB_DEBUG" = "1" ]; then
    echo "[$(date '+%H:%M:%S')] GitHub Plugin: $1" >> "/tmp/sketchybar_github.log"
  fi
}

# Check GitHub CLI availability and authentication
check_github_cli() {
  if ! command -v gh &> /dev/null; then
    debug_log "GitHub CLI not found"
    return 1
  fi
  
  if ! gh auth status &>/dev/null; then
    debug_log "GitHub CLI not authenticated"
    return 1
  fi
  
  return 0
}

update() {
  source "$CONFIG_DIR/colors.sh"
  source "$CONFIG_DIR/icons.sh"
  
  debug_log "Update triggered by: $SENDER"
  
  # Check GitHub CLI availability
  if ! check_github_cli; then
    debug_log "GitHub CLI check failed"
    sketchybar --set $NAME drawing=off
    return 1
  fi
  
  # Get notifications with error handling
  local notifications_json
  local api_exit_code
  
  notifications_json=$(gh api notifications 2>/dev/null)
  api_exit_code=$?
  
  if [ $api_exit_code -ne 0 ]; then
    debug_log "GitHub API call failed with exit code: $api_exit_code"
    sketchybar --set $NAME icon=$BELL label="?" icon.color=$RED
    return 1
  fi
  
  # Parse notification count
  local count
  count=$(echo "$notifications_json" | jq length 2>/dev/null)
  
  if [ "$count" = "" ] || [ "$count" = "null" ]; then
    debug_log "Failed to parse notification count"
    count=0
  fi
  
  debug_log "Found $count notifications"
  
  args=()
  if [ "$count" -eq 0 ]; then
    args+=(--set $NAME icon=$BELL label="0" icon.color=$GREEN drawing=on)
  else
    args+=(--set $NAME icon=$BELL_DOT label="$count" icon.color=$YELLOW drawing=on)
  fi

  # Get previous count for change detection
  local prev_count
  prev_count=$(sketchybar --query github.bell 2>/dev/null | jq -r .label.value 2>/dev/null)
  if [ "$prev_count" = "" ] || [ "$prev_count" = "null" ]; then
    prev_count=0
  fi
  
  debug_log "Previous count: $prev_count, Current count: $count"
  
  # Play sound on new notifications (optional)
  if [ "$count" -gt "$prev_count" ] 2>/dev/null && [ "$SENDER" != "forced" ]; then
    debug_log "New notifications detected"
    # Uncomment to enable sound: afplay /System/Library/Sounds/Morse.aiff &
  fi

  args+=(--remove '/github.notification\.*/')

  local counter=0
  local color=$GREEN

  # Process notifications for popup
  if [ "$count" -gt 0 ]; then
    while read -r repo url type title; do
      counter=$((counter + 1))
      local important
      important="$(echo "$title" | grep -iE "(deprecat|break|broke)" || true)"
      color=$BLUE
      local padding=0

      # Handle empty values
      if [ -z "${repo}" ] && [ -z "${title}" ]; then
        repo="GitHub"
        title="Notification"
      fi
      
      debug_log "Processing notification $counter: $repo - $title"
      # Set icon and color based on notification type
      local icon=$GIT_ISSUE
      local notification_url="https://github.com/notifications"
      
      case "${type}" in
      "'Issue'" | "Issue")
        color=$GREEN
        icon=$GIT_ISSUE
        # Try to get HTML URL, fallback to notifications page
        if [ -n "$url" ]; then
          local clean_url=$(echo "${url}" | sed -e "s/^'//" -e "s/'$//")
          notification_url=$(gh api "$clean_url" --jq .html_url 2>/dev/null || echo "https://github.com/notifications")
        fi
        ;;
      "'Discussion'" | "Discussion")
        color=$WHITE
        icon=$GIT_DISCUSSION
        ;;
      "'PullRequest'" | "PullRequest")
        color=$BLUE
        icon=$GIT_PULL_REQUEST
        if [ -n "$url" ]; then
          local clean_url=$(echo "${url}" | sed -e "s/^'//" -e "s/'$//")
          notification_url=$(gh api "$clean_url" --jq .html_url 2>/dev/null || echo "https://github.com/notifications")
        fi
        ;;
      "'Commit'" | "Commit")
        color=$WHITE
        icon=$GIT_COMMIT
        if [ -n "$url" ]; then
          local clean_url=$(echo "${url}" | sed -e "s/^'//" -e "s/'$//")
          notification_url=$(gh api "$clean_url" --jq .html_url 2>/dev/null || echo "https://github.com/notifications")
        fi
        ;;
      *)
        debug_log "Unknown notification type: $type"
        ;;
      esac

      # Highlight important notifications
      if [ -n "$important" ]; then
        color=$RED
        icon="⚠"
        debug_log "Important notification detected: $title"
      fi

      # Clean title and repo for display
      local clean_title=$(echo "$title" | sed -e "s/^'//" -e "s/'$//")
      local clean_repo=$(echo "$repo" | sed -e "s/^'//" -e "s/'$//")
      
      notification=(
        label="$clean_title"
        icon="$icon $clean_repo:"
        icon.padding_left="$padding"
        label.padding_right="$padding"
        icon.color=$color
        position=popup.github.bell
        icon.background.color=$color
        drawing=on
        click_script="open \"$notification_url\"; sketchybar --set github.bell popup.drawing=off; sleep 5; sketchybar --trigger github.update"
      )

      args+=(--clone github.notification.$counter github.template
        --set github.notification.$counter "${notification[@]}")
    done <<<"$(echo "$notifications_json" | jq -r '.[] | [.repository.name, .subject.latest_comment_url, .subject.type, .subject.title] | @sh' 2>/dev/null)"
  fi

  # Apply all changes
  if [ ${#args[@]} -gt 0 ]; then
    sketchybar -m "${args[@]}" >/dev/null 2>&1
    debug_log "Applied ${#args[@]} sketchybar arguments"
  fi

  # Animate on new notifications
  if [ "$count" -gt "$prev_count" ] 2>/dev/null && [ "$SENDER" != "forced" ]; then
    sketchybar --animate tanh 15 --set github.bell label.y_offset=5 label.y_offset=0 2>/dev/null
    debug_log "Animation triggered for new notifications"
  fi
  
  debug_log "Update completed successfully"
}

popup() {
  sketchybar --set $NAME popup.drawing=$1
}

# Main execution logic
case "$SENDER" in
"routine" | "forced" | "github.update")
  debug_log "Running update for sender: $SENDER"
  update
  ;;
"system_woke")
  debug_log "System woke - waiting for network then updating"
  sleep 10 && update # Wait for network to connect
  ;;
"mouse.entered")
  debug_log "Mouse entered - showing popup"
  popup on
  ;;
"mouse.exited" | "mouse.exited.global")
  debug_log "Mouse exited - hiding popup"
  popup off
  ;;
"mouse.clicked")
  debug_log "Mouse clicked - toggling popup"
  popup toggle
  ;;
*)
  debug_log "Unknown sender: $SENDER"
  ;;
esac

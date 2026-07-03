#!/bin/bash
################################################################################
# agents_lib.sh - shared helpers for the AI agent status cluster
################################################################################
# Sourced by agent_jump.sh and the *_status.sh plugins. Defines the common
# status-file convention and the logic that resolves a session to its live tmux
# target.
#
# Each agent writes ~/.cache/<tool>-sessions/<id>.json with at least:
#   { "state": "waiting"|"thinking", "last_activity": ISO8601,
#     "tmux_pane": "%5"|"",   # tmux pane id ($TMUX_PANE) for codex/opencode
#     "pid": 12345 }          # agent pid, used for Claude's live resolution
################################################################################

# "<status dir>:<tool name>" — order here is the cluster order.
AGENT_DIRS=(
  "$HOME/.cache/claude-sessions:claude"
  "$HOME/.cache/codex-sessions:codex"
  "$HOME/.cache/opencode-sessions:opencode"
)

# resolve_pane_by_pid PID -> "session:window.pane"  (or nothing)
# A TUI agent's parent is the pane's shell, whose pid == the pane's #{pane_pid}.
resolve_pane_by_pid() {
  local ppid
  ppid=$(ps -o ppid= -p "$1" 2>/dev/null | tr -d ' ')
  [ -z "$ppid" ] && return
  tmux list-panes -a -F '#{pane_pid} #{session_name}:#{window_index}.#{pane_index}' 2>/dev/null \
    | awk -v p="$ppid" '$1==p {print $2; exit}'
}

# resolve_target STATUS_FILE -> "session:window.pane" if the session is live.
# Prefers a recorded tmux pane id (%N, reliable, used by codex/opencode); falls
# back to live PID resolution (Claude, whose hook doesn't record a %pane id).
resolve_target() {
  local f="$1" pane pid tgt
  pane=$(jq -r '.tmux_pane // empty' "$f" 2>/dev/null)
  case "$pane" in
    %*)
      tgt=$(tmux display-message -t "$pane" -p '#{session_name}:#{window_index}.#{pane_index}' 2>/dev/null)
      [ -n "$tgt" ] && { printf '%s' "$tgt"; return; }
      ;;
  esac
  pid=$(jq -r '.pid // empty' "$f" 2>/dev/null)
  if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
    resolve_pane_by_pid "$pid"
  fi
}

# focus_tmux_target "session:window.pane" — bring that pane to the foreground.
focus_tmux_target() {
  local pick="$1" session rest win client
  session="${pick%%:*}"; rest="${pick#*:}"; win="${rest%%.*}"
  client=$(tmux list-clients -t "$session" -F '#{client_name}' 2>/dev/null | head -1)
  [ -z "$client" ] && client=$(tmux list-clients -F '#{client_name}' 2>/dev/null | head -1)
  if [ -n "$client" ]; then
    tmux switch-client -c "$client" -t "$session" 2>/dev/null
    tmux select-window -t "${session}:${win}" 2>/dev/null
    tmux select-pane -t "$pick" 2>/dev/null
  else
    open -na Ghostty --args -e tmux attach -t "$session" 2>/dev/null
  fi
  open -a Ghostty 2>/dev/null
}

# count_states TOOL_FILTER -> sets globals AGENT_WAITING and AGENT_THINKING to
# the number of live waiting/thinking sessions matching the filter (or "all").
count_states() {
  local filter="$1" entry dir tool f state
  AGENT_WAITING=0; AGENT_THINKING=0
  command -v jq &>/dev/null || return
  for entry in "${AGENT_DIRS[@]}"; do
    dir="${entry%%:*}"; tool="${entry##*:}"
    [ "$filter" = all ] || [ "$filter" = "$tool" ] || continue
    [ -d "$dir" ] || continue
    while IFS= read -r -d '' f; do
      state=$(jq -r '.state // empty' "$f" 2>/dev/null)
      [ "$state" = waiting ] || [ "$state" = thinking ] || continue
      [ -n "$(resolve_target "$f")" ] || continue
      if [ "$state" = waiting ]; then ((AGENT_WAITING++)); else ((AGENT_THINKING++)); fi
    done < <(find "$dir" -maxdepth 1 -name '*.json' -mmin -60 -print0 2>/dev/null)
  done
}

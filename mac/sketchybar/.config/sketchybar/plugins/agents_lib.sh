#!/bin/bash
################################################################################
# agents_lib.sh - shared helpers for the AI agent status cluster
################################################################################
# Sourced by agent_jump.sh and the *_status.sh plugins. Two ways an agent's
# state is discovered:
#
#   status files  (Claude, Codex): ~/.cache/<tool>-sessions/<id>.json with
#     { state: waiting|thinking, last_activity, tmux_pane: "%5"|"", pid }
#     Claude via its hooks; Codex via the hooks in mac/codex/hooks/.
#
#   pane content  (opencode): opencode's plugin API doesn't deliver session
#     events to the TUI process, so we read the pane instead -- the footer shows
#     "esc interrupt" while working and drops it when idle/waiting.
#
# emit_agents() unifies both into one stream the callers consume.
################################################################################

# "<status dir>:<tool>" for the status-file agents (cluster order).
AGENT_DIRS=(
  "$HOME/.cache/claude-sessions:claude"
  "$HOME/.cache/codex-sessions:codex"
)

# resolve_pane_by_pid PID -> "session:window.pane" (or nothing)
# Walks up the process ancestry until an ancestor pid equals a pane's #{pane_pid}
# (the pane's top process). Claude's tree can be several layers deep
# (claude -> ClaudeCode.app -> claude bin -> claude -> shell) and the recorded
# pid varies by launch method, so a single parent hop isn't enough.
resolve_pane_by_pid() {
  local cur="$1" panes tgt hops=0
  panes=$(tmux list-panes -a -F '#{pane_pid} #{session_name}:#{window_index}.#{pane_index}' 2>/dev/null)
  [ -z "$panes" ] && return
  while [ -n "$cur" ] && [ "$cur" -gt 1 ] && [ "$hops" -lt 12 ]; do
    tgt=$(printf '%s\n' "$panes" | awk -v p="$cur" '$1==p {print $2; exit}')
    [ -n "$tgt" ] && { printf '%s' "$tgt"; return; }
    cur=$(ps -o ppid= -p "$cur" 2>/dev/null | tr -d ' ')
    hops=$((hops + 1))
  done
}

# resolve_target STATUS_FILE -> "session:window.pane" if the session is live.
# Prefers a recorded %pane id (codex); falls back to live PID resolution (Claude).
resolve_target() {
  local f="$1" pane pid tgt
  pane=$(jq -r '.tmux_pane // empty' "$f" 2>/dev/null)
  case "$pane" in
    %*)
      tgt=$(tmux display-message -t "$pane" -p '#{session_name}:#{window_index}.#{pane_index}' 2>/dev/null)
      # A closed pane yields an empty ":." rather than an error; require a
      # non-empty session before the ':' to reject it.
      if [ -n "${tgt%%:*}" ] && [ "$tgt" != "${tgt%%:*}" ]; then
        printf '%s' "$tgt"; return
      fi
      ;;
  esac
  pid=$(jq -r '.pid // empty' "$f" 2>/dev/null)
  if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
    resolve_pane_by_pid "$pid"
  fi
}

# opencode_panes -> lines "state<TAB>opencode<TAB>target<TAB>" for each opencode
# pane. "esc interrupt" in the pane content means it is working (thinking);
# otherwise it is idle and waiting for input.
opencode_panes() {
  tmux list-panes -a -F '#{pane_id}|#{session_name}:#{window_index}.#{pane_index}|#{pane_current_command}' 2>/dev/null \
  | while IFS='|' read -r pid tgt cmd; do
      case "$cmd" in opencode*) ;; *) continue ;; esac
      if tmux capture-pane -p -t "$pid" 2>/dev/null | grep -q "esc interrupt"; then
        printf 'thinking\topencode\t%s\t\n' "$tgt"
      else
        printf 'waiting\topencode\t%s\t\n' "$tgt"
      fi
    done
}

# emit_agents FILTER -> lines "state<TAB>tool<TAB>target<TAB>last_activity" for
# every live waiting/thinking session matching FILTER (all|claude|codex|opencode).
emit_agents() {
  local filter="$1" entry dir tool f state tgt ts
  command -v jq &>/dev/null || return
  for entry in "${AGENT_DIRS[@]}"; do
    dir="${entry%%:*}"; tool="${entry##*:}"
    [ "$filter" = all ] || [ "$filter" = "$tool" ] || continue
    [ -d "$dir" ] || continue
    while IFS= read -r -d '' f; do
      state=$(jq -r '.state // empty' "$f" 2>/dev/null)
      [ "$state" = waiting ] || [ "$state" = thinking ] || continue
      tgt=$(resolve_target "$f"); [ -z "$tgt" ] && continue
      ts=$(jq -r '.last_activity // empty' "$f" 2>/dev/null)
      printf '%s\t%s\t%s\t%s\n' "$state" "$tool" "$tgt" "$ts"
    done < <(find "$dir" -maxdepth 1 -name '*.json' -mmin -1440 -print0 2>/dev/null)
  done
  if [ "$filter" = all ] || [ "$filter" = opencode ]; then
    opencode_panes
  fi
}

# count_states FILTER -> sets AGENT_WAITING / AGENT_THINKING.
count_states() {
  local state rest
  AGENT_WAITING=0; AGENT_THINKING=0
  while IFS=$'\t' read -r state rest; do
    [ "$state" = waiting ] && ((AGENT_WAITING++))
    [ "$state" = thinking ] && ((AGENT_THINKING++))
  done < <(emit_agents "$1")
}

# focus_tmux_target "session:window.pane" — bring that pane to the foreground.
# Redirects the MOST-RECENTLY-ACTIVE client (i.e. the window you were last in,
# which `open -a Ghostty` also resurfaces) rather than an arbitrary client --
# otherwise focus jumps to a different Ghostty window.
focus_tmux_target() {
  local pick="$1" session rest win client focused gwin cur_ws
  session="${pick%%:*}"; rest="${pick#*:}"; win="${rest%%.*}"

  # "Pull to you": redirect the most-recently-active client -- i.e. the terminal
  # window you were last in -- to the target pane. This works with any number of
  # Ghostty windows because it never has to identify a specific one: the waiting
  # agent simply comes to the window you're using.
  client=$(tmux list-clients -F '#{client_activity} #{client_name}' 2>/dev/null \
           | sort -rn | head -1 | cut -d' ' -f2-)
  if [ -z "$client" ]; then
    # No attached client anywhere: open a terminal on the target session.
    open -na Ghostty --args -e tmux attach -t "$session" 2>/dev/null
    return
  fi

  tmux switch-client -c "$client" -t "$session" 2>/dev/null
  tmux select-window -t "${session}:${win}" 2>/dev/null
  tmux select-pane -t "$pick" 2>/dev/null

  # If you're already in a Ghostty window, the switch above brought the agent to
  # you -- nothing more to do. Otherwise (pressed from a browser, etc.) bring a
  # Ghostty window forward via aerospace, which switches to its workspace without
  # spawning a phantom window. Prefer one on the current workspace, else any.
  focused=$(aerospace list-windows --focused --format '%{app-bundle-id}' 2>/dev/null)
  [ "$focused" = "com.mitchellh.ghostty" ] && return

  # (`--all` can't be combined with --app-bundle-id, so filter with awk instead.)
  cur_ws=$(aerospace list-workspaces --focused 2>/dev/null)
  gwin=$(aerospace list-windows --all --format '%{window-id}|%{app-bundle-id}|%{workspace}' 2>/dev/null \
         | awk -F'|' -v ws="$cur_ws" '$2=="com.mitchellh.ghostty" && $3==ws {print $1; exit}')
  [ -z "$gwin" ] && gwin=$(aerospace list-windows --all --format '%{window-id}|%{app-bundle-id}' 2>/dev/null \
         | awk -F'|' '$2=="com.mitchellh.ghostty"{print $1; exit}')
  [ -n "$gwin" ] && aerospace focus --window-id "$gwin" 2>/dev/null
}

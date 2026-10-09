# Omarchy environment (OMARCHY_PATH + PATH), needed even for non-interactive shells
[[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap

# If not running interactively, don't do anything else (leave this above the rc source)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source "$OMARCHY_PATH/default/bash/rc"

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'

# OpenClaw Completion
[ -f '/home/mbp/.openclaw/completions/openclaw.bash' ] && source '/home/mbp/.openclaw/completions/openclaw.bash'

# Per-machine prompt tag, consumed by starship's $env_var.STARSHIP_MACHINE.
# Same skull + colour scheme as linux/zsh/.zshrc; this box runs bash.
case "${HOSTNAME%%.*}" in
  m4*)          export STARSHIP_MACHINE=$'\e[38;2;0;255;0m󰯈\e[0m' ;;    # green  — m4
  m1*)          export STARSHIP_MACHINE=$'\e[38;2;255;69;1m󰯈\e[0m' ;;   # orange — m1
  mbp*|omarchy*) export STARSHIP_MACHINE=$'\e[38;2;0;255;0m󰯈\e[0m' ;;     # green  — omarchy
  *)            export STARSHIP_MACHINE=$'\e[38;2;102;92;84m󰯈\e[0m' ;;  # grey   — unknown host
esac
# fzf border follows the same per-machine colour
case "${HOSTNAME%%.*}" in
  m4*)           export MACHINE_ACCENT='#00ff00' ;;
  m1*)           export MACHINE_ACCENT='#ff4501' ;;
  mbp*|omarchy*) export MACHINE_ACCENT='#00ff00' ;;
  *)             export MACHINE_ACCENT='#665c54' ;;
esac

# Personal aliases, functions and fzf/PATH setup ported from the mac zshrc
[[ -r ~/.config/bash/personal.sh ]] && source ~/.config/bash/personal.sh

# Neovim: several configs side by side via NVIM_APPNAME. ~/.config/nvim is the
# main one (Omarchy's own `n` opens it); any other ~/.config/nvim-* dir shows up
# in the `vv` picker. EDITOR stays Omarchy's omarchy-launch-editor default.
vv() {
  local config
  config=$(fd --max-depth 1 --type d --glob 'nvim*' ~/.config | fzf --prompt='Neovim Configs > ' --height=~50% --layout=reverse --border --exit-0)
  [[ -z $config ]] && echo "No config selected" && return
  NVIM_APPNAME=$(basename "$config") nvim "$@"
}

# Inside herdr, name Remote Control sessions after the herdr workspace (herdr-<workspace>)
unalias claude 2>/dev/null
function claude {
  if [ -n "$HERDR_WORKSPACE_ID" ] && { [ $# -eq 0 ] || [[ "$1" == -* && "$1" != -p && "$1" != --print && "$1" != -v && "$1" != --version && "$1" != -h && "$1" != --help ]]; }; then
    local ws
    ws=$(herdr workspace get "$HERDR_WORKSPACE_ID" 2>/dev/null | jq -r '.result.workspace.label // empty' | tr -cs 'A-Za-z0-9_-' '-' | sed 's/-$//')
    env -u TMUX -u TMUX_PANE claude --remote-control-session-name-prefix "herdr-${ws:-pane}" "$@"
  else
    env -u TMUX -u TMUX_PANE claude "$@"
  fi
}

# Command Code Provider API key (GOAT plan) — used by pi, codex, opencode, openclaw, claude-cc
[ -f "$HOME/.config/secrets/commandcode.env" ] && . "$HOME/.config/secrets/commandcode.env"

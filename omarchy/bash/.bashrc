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
  mbp*|omarchy*) export STARSHIP_MACHINE=$'\e[38;2;177;98;134m󰯈\e[0m' ;; # purple — omarchy
  *)            export STARSHIP_MACHINE=$'\e[38;2;102;92;84m󰯈\e[0m' ;;  # grey   — unknown host
esac

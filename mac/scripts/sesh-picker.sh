#!/bin/bash
set -e

session=$(sesh list | fzf --height 40% --reverse --border)
[[ -z "$session" ]] && exit 0

unset TMUX
exec sesh connect "$session"

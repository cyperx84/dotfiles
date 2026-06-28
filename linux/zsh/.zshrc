# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load Omarchy default zsh configuration
source ~/.local/share/omarchy/default/zsh/rc

# ============================================================================
# USER CUSTOMIZATIONS (overrides Omarchy defaults)
# ============================================================================

# Vi mode escape with jk
bindkey jk vi-cmd-mode
bindkey '^f' vi-forward-word
bindkey '^u' up-line-or-search
bindkey '^p' down-line-or-search

# PATH additions
export PATH="$HOME/.local/bin:$PATH"
export GOPATH="$HOME/.local/go"
export PATH="$GOPATH/bin:$PATH"

# Bat theme (override Omarchy default)
export BAT_THEME=tokyonight_night

# FZF green border (override Omarchy default)
export FZF_DEFAULT_OPTS='--border=rounded --color=border:#00ff00'

# Starship config path (use our custom config)
export STARSHIP_CONFIG=~/.config/starship.toml

# Aliases
alias vim='nvim'
alias cl='clear'
alias cc="claude --dangerously-skip-permissions"
alias conf="cd ~/.config && nvim"

# Sesh session management
alias sl='sesh list -t -c -d'

sc() {
    exec </dev/tty
    exec <&1
    local session="${1:-$(sesh list | fzf --height 40% --reverse --border)}"
    [[ -z "$session" ]] && return
    TMUX= sesh connect "$session"
}

alias tkas='tmux kill-server'

# Git extras (beyond Omarchy defaults)
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'

# Nmap
alias nm="nmap -sC -sV -oN nmap"

# HTTP requests with xh
alias http="xh"

# Lazy-load direnv
if (( $+commands[direnv] )); then
  _direnv_lazy_load() {
    add-zsh-hook -d chpwd _direnv_lazy_load
    add-zsh-hook -d precmd _direnv_first_prompt
    eval "$(direnv hook zsh)"
    unfunction _direnv_lazy_load _direnv_first_prompt 2>/dev/null
    [[ -f .envrc ]] && direnv allow
  }
  _direnv_first_prompt() { _direnv_lazy_load; }
  autoload -U add-zsh-hook
  add-zsh-hook chpwd _direnv_lazy_load
  add-zsh-hook precmd _direnv_first_prompt
fi

# Lazy-load UV Python completions
if (( $+commands[uv] )); then
  _uv_completion_loaded=0
  uv() {
    if (( !_uv_completion_loaded )); then
      source <(command uv generate-shell-completion zsh)
      _uv_completion_loaded=1
    fi
    command uv "$@"
  }
fi

# OpenClaw Completion
source "/home/cyperx/.openclaw/completions/openclaw.zsh"

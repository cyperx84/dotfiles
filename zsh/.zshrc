# ============================================================================
# ZSH CONFIGURATION
# ============================================================================
# Author: cyperx (https://github.com/cyperx84)
# Purpose: Zsh shell configuration with aliases, functions, and integrations
# ============================================================================

unsetopt PROMPT_SP
ENABLE_CORRECTION="false"
HIST_STAMPS="dd/mm/yy"
INSTALLER_NO_MODIFY_PATH=1

# Ensure proper prompt formatting in tmux
setopt PROMPT_SUBST
setopt TRANSIENT_RPROMPT

export LC_ALL=en_US.UTF-8

# Enhanced terminal detection for Ghostty + tmux
if [ -n "$TMUX" ]; then
    export TERM="tmux-256color"
elif [ "$TERM_PROGRAM" = "ghostty" ]; then
    export TERM="xterm-ghostty"
else
    export TERM="xterm-256color"
fi

export COLORTERM="truecolor"

# Ensure proper color support in tmux + Ghostty
if [ -n "$TMUX" ] && [ "$TERM_PROGRAM" = "ghostty" ]; then
    export TERM_PROGRAM="ghostty"
fi

export GPG_TTY=$(tty)

# Lazy-load GPG agent (saves 50-100ms, only launches when GPG is used)
if (( $+commands[gpg] )); then
  gpg() {
    gpgconf --launch gpg-agent > /dev/null 2>&1
    unfunction gpg
    command gpg "$@"
  }
fi


if command -v sketchybar &>/dev/null; then
function brew() {
	command brew "$@"
	if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]] || [[ $* =~ "list" ]] || [[ $* =~ "install" ]] || [[ $* =~ "uninstall" ]] || [[ $* =~ "bundle" ]] || [[ $* =~ "doctor" ]] || [[ $* =~ "info" ]] || [[ $* =~ "cleanup" ]]; then
		sketchybar --trigger brew_update
	fi
}
fi

# Lazy-load gopass completion (saves 100-200ms on shell startup)
if (( $+commands[gopass] )); then
  gopass() {
    source <(command gopass completion zsh)
    unfunction gopass
    command gopass "$@"
  }
fi

# Navigation
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && l; }
ff() { echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy }
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }

### FZF ###
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
source <(fzf --zsh)

# Green border styling for FZF (matches Ghostty cursor - applies to Sesh and other FZF interfaces)
export FZF_DEFAULT_OPTS='--border=rounded --border-label="" --color=border:#00ff00'

export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always --icons --level=3 {} | head -200'"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.fzf/shell/key-bindings.zsh ] && source ~/.fzf/shell/key-bindings.zsh
[ -f ~/.fzf/shell/completion.zsh ] && source ~/.fzf/shell/completion.zsh

# Cache brew --prefix to avoid repeated calls (saves 100-200ms)
HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-$(brew --prefix)}"
source "$HOMEBREW_PREFIX/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# Completion initialization with cache optimization (must be before UV/Starship/Zoxide)
fpath=(/Users/cyperx/.docker/completions ~/.zfunctions $fpath)
autoload -Uz compinit

# Only rebuild completion cache once per day (speeds up shell startup)
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qNmh+24) ]]; then
  compinit -i
else
  compinit -C -i
fi

# Yazi
function f() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# UV Python
eval "$(uv generate-shell-completion zsh)"

bindkey '^f' vi-forward-word
bindkey '^u' up-line-or-search
bindkey '^p' down-line-or-search

# Starship prompt initialization with proper tmux integration
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Ensure proper prompt handling in tmux
if [ -n "$TMUX" ]; then
    export STARSHIP_SHELL="zsh"
fi

eval "$(starship init zsh)"

alias pass="gopass"

# Git
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gs="git status"

# Kanata - restart to pick up Bluetooth keyboards after boot
alias kr='sudo launchctl kickstart -k system/com.example.kanata'

alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'

#Github
alias ghl="gh repo list"

# Docker
alias dock="open -a docker && while ! docker info > /dev/null 2>&1; do sleep 1 ; done"
alias dkill='killall "Docker Desktop" && sleep 1 && dock'
alias dco="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias dx="docker exec -it"

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Nmap
alias nm="nmap -sC -sV -oN nmap"

# K8S
alias k="kubectl"
alias ka="kubectl apply -f"
alias kg="kubectl get"
alias kd="kubectl describe"
alias kdel="kubectl delete"
alias kgpo="kubectl get pod"
alias kgd="kubectl get deployments"
alias kc="kubectx"
alias kns="kubens"
alias kl="kubectl logs -f"
alias ke="kubectl exec -it"
alias kcns='kubectl config set-context --current --namespace'

# HTTP requests with xh!
alias http="xh"

# Eza
alias ls="eza -l --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"
alias ltree="eza --tree --level=2  --icons --git"
alias l="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias ll="eza --color=always --long --git --icons=always"

export EDITOR='nvim'
export VISUAL='nvim'

# NEOVIM
alias n='NVIM_APPNAME="nvim" nvim'
alias vim='nvim'

# NVIM config selecting
vv() {
  # Assumes all configs exist in directories named ~/.config/nvim-*
  local config=$(fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)
  [[ -z $config ]] && echo "No config selected" && return
  NVIM_APPNAME=$(basename $config) nvim $@
}

# VI Mode!!!
bindkey jk vi-cmd-mode

# Quality of life keymaps
alias cl='clear'
alias ta='tmux attach -d'

# Config
alias conf="cd $HOME/dotfiles && nvim"

# notes
alias note="cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/notes && nvim Index.md"
alias notes="cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/cyperx && nvim 00-Index.md"
alias no="cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/snowboard && nvim Index.md"

# ======================
# SESH SESSION MANAGEMENT
# ======================

# Core aliases
alias sl='sesh list -t -c -d'                      # List sessions (compact, deduplicated)

sc() {
    exec </dev/tty
    exec <&1
    local session="${1:-$(sesh list | fzf --height 40% --reverse --border)}"
    [[ -z "$session" ]] && return
    TMUX= sesh connect "$session"
}

# Management aliases
alias tk='tmux kill-session -t'              # Kill specific session
alias tkas='tmux kill-server'              # Kill all sessions

# Code Workspaces
alias C="cd ~/Code/"

# ----- Bat (better cat) -----
export BAT_THEME=tokyonight_night

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

# ============================================================================
# PATH CONFIGURATION (Consolidated)
# ============================================================================
# Order: Higher priority paths first
# Author: cyperx (https://github.com/cyperx84)

export GOPATH="$HOME/.local/go"

# High-priority paths (prepended)
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"       # Bob-managed Neovim
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"             # Homebrew Ruby
export PATH="$GOPATH/bin:$PATH"                            # Go binaries
export PATH="$HOME/.npm-global/bin:$PATH"                  # Global npm
export PATH="/opt/homebrew/opt/icu4c@77/bin:$PATH"         # ICU library
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Low-priority paths (appended)
export PATH="$PATH:$HOME/.antigravity/antigravity/bin"     # Antigravity
export PATH="$PATH:$HOME/.lmstudio/bin"                    # LM Studio CLI

alias oc="opencode"
alias cc="claude --dangerously-skip-permissions"

# ======================
# AUDIO DEVICE SWITCHING
# ======================

# FZF-based output device selector
audio-output() {
    local device
    device=$(SwitchAudioSource -a -t output | fzf --prompt="Output > " --height=40% --reverse --border)
    [[ -n "$device" ]] && SwitchAudioSource -t output -s "$device" && echo "Output: $device"
}

# FZF-based input device selector
audio-input() {
    local device
    device=$(SwitchAudioSource -a -t input | fzf --prompt="Input > " --height=40% --reverse --border)
    [[ -n "$device" ]] && SwitchAudioSource -t input -s "$device" && echo "Input: $device"
}

# Quick aliases
alias ao='audio-output'
alias ai='audio-input'
alias as='echo "Output: $(SwitchAudioSource -c -t output)" && echo "Input: $(SwitchAudioSource -c -t input)"'

# Quick output device switches
alias speakers='SwitchAudioSource -t output -s "Mac mini Speakers"'
alias monitor='SwitchAudioSource -t output -s "LG ULTRAGEAR+"'
alias mod-out='SwitchAudioSource -t output -s "Mod"'
alias scarlett-out='SwitchAudioSource -t output -s "Scarlett 2i2 USB"'
alias blackhole-out='SwitchAudioSource -t output -s "BlackHole 16ch"'

# Quick input device switches
alias scarlett-in='SwitchAudioSource -t input -s "Scarlett 2i2 USB"'
alias mod-in='SwitchAudioSource -t input -s "Mod"'
alias blackhole-in='SwitchAudioSource -t input -s "BlackHole 16ch"'

# Recording mode (Multi-Output + BlackHole input for screen recording with system audio)
alias rec='SwitchAudioSource -t output -s "Multi-Output Device" && SwitchAudioSource -t input -s "BlackHole 16ch" && echo "Recording mode ON"'
alias rec-off='SwitchAudioSource -t output -s "Mac mini Speakers" && SwitchAudioSource -t input -s "Scarlett 2i2 USB" && echo "Recording mode OFF"'

# Lazy-load direnv (saves 50-100ms, handles initial directory)
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
  add-zsh-hook precmd _direnv_first_prompt  # Trigger on first prompt
fi


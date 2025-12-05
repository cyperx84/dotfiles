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

autoload -U compinit && compinit
source <(gopass completion zsh)

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
export FZF_CTRL_F_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
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

# List all images in Dir
alias iva='find . -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.tiff" -o -iname "*.webp" -o -iname "*.svg" \) -exec kitty +kitten icat {} \;'

export EDITOR='nvim'
export VISUAL='nvim'

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

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
alias no="cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/notes && nvim INDEX.md"

# ======================
# SESH SESSION MANAGEMENT
# ======================

# Core aliases
alias sl='sesh list -t -c -d'                      # List sessions (compact, deduplicated)

# Fuzzy connect with FZF cancellation handling
sc() {
    local selected_session
    selected_session=$(sesh list -d | fzf)
    if [[ -n "${selected_session}" ]]; then
        sesh connect "${selected_session}"
    fi
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

# Consolidated PATH configuration (order matters: higher priority first)
export PATH="$HOME/.npm-global/bin:/opt/homebrew/opt/icu4c@77/bin:/usr/local/bin:/usr/local/sbin:$PATH"

alias oc="opencode"
alias cc="claude --dangerously-skip-permissions"
# Antigravity PATH (appended to main PATH configuration above)
export PATH="$PATH:/Users/cyperx/.antigravity/antigravity/bin"

# Lazy-load direnv (saves 50-100ms, only loads when entering directory with .envrc)
if (( $+commands[direnv] )); then
  _direnv_lazy_load() {
    eval "$(direnv hook zsh)"
    unfunction _direnv_lazy_load
    # Check current directory after loading
    [[ -f .envrc ]] && direnv allow
  }
  # Hook into directory change
  autoload -U add-zsh-hook
  add-zsh-hook chpwd _direnv_lazy_load
fi


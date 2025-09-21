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

autoload -U compinit; compinit

export GPG_TTY=$(tty)
gpgconf --launch gpg-agent > /dev/null 2>&1

# NOTE gopass workaround not working
# source /dev/stdin <<<"$(gopass completion bash)"

# sketchybar
# This will update the brew package count after running a brew upgrade, brew
# update or brew outdated command
# Personally I added "list" and "install", and everything that is after but
# that's just a personal preference.
# That way sketchybar updates when I run those commands as well
if command -v sketchybar &>/dev/null; then

# Define a custom 'brew' function to wrap the Homebrew command.
function brew() {
	# Execute the original Homebrew command with all passed arguments.
	command brew "$@"
	# Check if the command includes "upgrade", "update", or "outdated".
	if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]] || [[ $* =~ "list" ]] || [[ $* =~ "install" ]] || [[ $* =~ "uninstall" ]] || [[ $* =~ "bundle" ]] || [[ $* =~ "doctor" ]] || [[ $* =~ "info" ]] || [[ $* =~ "cleanup" ]]; then
		# If so, notify SketchyBar to trigger a custom action.
		sketchybar --trigger brew_update
	fi
}
fi

function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    zle reset-prompt > /dev/null 2>&1 || true
  [[ -z "$session" ]] && return
    sesh connect $session
  }
}

zle     -N             sesh-sessions
bindkey '^[s' sesh-sessions
bindkey -M viins '\es' sesh-sessions

# Source enhanced sesh aliases if available
[[ -f ~/.config/sesh/scripts/sesh_aliases.sh ]] && source ~/.config/sesh/scripts/sesh_aliases.sh

# Navigation
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && l; }
f() { echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy }
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }

### FZF ###
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
source <(fzf --zsh)
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always --icons --level=3 {} | head -200'"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.fzf/shell/key-bindings.zsh ] && source ~/.fzf/shell/key-bindings.zsh
[ -f ~/.fzf/shell/completion.zsh ] && source ~/.fzf/shell/completion.zsh
source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh
source $(brew --prefix zsh-fast-syntax-highlighting)/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8,bold'
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
# alias uvsa="$(source .venv/bin/activate)"

bindkey '^e' autosuggest-execute
bindkey '^w' autosuggest-accept
bindkey '^u' autosuggest-toggle
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

# Git
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gs="git status"
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

# Docker add kill all
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
# export KUBECONFIG=~/.kube/config
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
alias podname=''

# HTTP requests with xh!
alias http="xh"

# Eza
alias ls="eza -l --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"
alias ltree="eza --tree --level=2  --icons --git"
alias l="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias ll="eza --color=always --long --git --icons=always"

# SEC STUFF
# alias gobust='gobuster dir --wordlist ~/security/wordlists/diccnoext.txt --wildcard --url'
# alias dirsearch='python dirsearch.py -w db/dicc.txt -b -u'
# alias massdns='~/hacking/tools/massdns/bin/massdns -r ~/hacking/tools/massdns/lists/resolvers.txt -t A -o S bf-targets.txt -w livehosts.txt -s 4000'
# alias server='python -m http.server 4445'
# alias tunnel='ngrok http 4445'
# alias fuzz='ffuf -w ~/hacking/SecLists/content_discovery_all.txt -mc all -u'
# alias gr='~/go/src/github.com/tomnomnom/gf/gf'

# source <(kubectl completion zsh)
# complete -C '/usr/local/bin/aws_completer' aws


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

# Code Workspaces
alias C="cd ~/Code/"

# ----- Bat (better cat) -----
export BAT_THEME=tokyonight_night

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="/opt/homebrew/opt/icu4c@77/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/cyperx/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

alias cld="/Users/cyperx/.claude/local/claude --dangerously-skip-permissions"
alias claude="/Users/cyperx/.claude/local/claude"

ENABLE_CORRECTION="false"
HIST_STAMPS="dd/mm/yy"
INSTALLER_NO_MODIFY_PATH=1
export TERM="xterm-ghostty"
export TERM="xterm-256color"
export COLORTERM="truecolor"
export LANG=en_US.UTF-8
autoload -U compinit; compinit

export GPG_TTY=$(tty)
# gpg-preset-passphrase --preset $(gpg --with-keygrip -K | grep -A1 "sec" | grep Keygrip | awk '{print $3}')

# Navigation
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && l; }
f() { echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy }
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }

# Yazi 
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# source <(kubectl completion zsh)
# complete -C '/usr/local/bin/aws_completer' aws

eval "$(uv generate-shell-completion zsh)"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^e' autosuggest-execute
bindkey '^w' autosuggest-accept
bindkey '^u' autosuggest-toggle
bindkey '^f' vi-forward-word
bindkey '^u' up-line-or-search
bindkey '^p' down-line-or-search

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Git
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
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

# Docker
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
alias kl="kubectl logs"
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

# Images in the terminal
lp() {
    eza --icons --tree --color=always "$@" | while read -r line; do
        if [[ "$line" =~ \.(png|jpg|jpeg|gif|bmp|tiff|webp)$ ]]; then
            kitty +kitten icat "$line"
        else
            echo "$line"
        fi
    done
}

iv() {
    for img in "$@"; do
        if [[ -f "$img" && "$img" =~ \.(png|jpg|jpeg|gif|bmp|tiff|webp|svg)$ ]]; then
            kitty +kitten icat "$img"
        else
            echo "Not an image file: $img"
        fi
    done
}

alias iva='find . -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.tiff" -o -iname "*.webp" -o -iname "*.svg" \) -exec kitty +kitten icat {} \;'

export EDITOR=nvim
export VISUAL=nvim

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

# NEOVIM
alias n='NVIM_APPNAME="nvim" nvim'

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
alias t=tmux

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

export PATH=$PATH:/Users/cyperx/.claude/local

export PATH="/opt/homebrew/opt/icu4c@77/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

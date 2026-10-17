# Personal shell setup, ported from mac/zsh/.zshrc. Sourced from ~/.bashrc, on top
# of Omarchy's defaults (default/bash/*). Left out on purpose: macOS-only bits
# (brew, sketchybar, SwitchAudioSource, Docker Desktop, launchctl), zsh-only
# bits (compinit, zle), anything whose tool isn't installed here.

# ── Git (Omarchy already has g, gcm, gcam, gcad) ────────────────────────────
alias gc='git commit -m'
alias gca='git commit -a -m'
alias gp='git push origin HEAD'
alias gpu='git pull origin'
alias gs='git status'
alias gdiff='git diff'
alias gco='git checkout'
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias ghl='gh repo list'

# ── Directories ─────────────────────────────────────────────────────────────
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias C='cd ~/Code/'

# ── eza (overrides Omarchy's ls: always show hidden, git status) ────────────
alias ls='eza -l --icons --git -a'
alias ltree='eza --tree --level=2 --icons --git'
alias l='eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions'
alias ll='eza --color=always --long --git --icons=always'

# ── Docker (Omarchy has d) ──────────────────────────────────────────────────
alias dco='docker compose'
alias dps='docker ps'
alias dpa='docker ps -a'
alias dl='docker ps -l -q'
alias dx='docker exec -it'

# ── Kubernetes ──────────────────────────────────────────────────────────────
alias k='kubectl'
alias ka='kubectl apply -f'
alias kg='kubectl get'
alias kd='kubectl describe'
alias kdel='kubectl delete'
alias kgpo='kubectl get pod'
alias kgd='kubectl get deployments'
alias kc='kubectx'
alias kns='kubens'
alias kl='kubectl logs -f'
alias ke='kubectl exec -it'
alias kcns='kubectl config set-context --current --namespace'

# ── Misc tools ──────────────────────────────────────────────────────────────
alias http='xh'
alias nm='nmap -sC -sV -oN nmap'
alias cl='clear'
alias pass='gopass'
alias ta='tmux attach -d'
alias tki='tmux kill-session -t'
alias tkas='tmux kill-server'

# Claude Code: hide $TMUX so it doesn't downgrade itself to 256-color inside tmux.
alias claude='env -u TMUX -u TMUX_PANE claude'
alias cc='claude --dangerously-skip-permissions'

# Restart kanata to pick up a Bluetooth keyboard connected after boot.
alias kr='systemctl --user restart kanata.service'

# ── Config / notes ──────────────────────────────────────────────────────────
alias conf='cd ~/dotfiles && nvim'
alias confn='cd ~/.config/nvim && nvim'
alias notes='cd ~/vaults/CyperX && nvim 00-index.md'
alias vaults='cd ~/vaults && nvim'

# ── Navigation helpers ──────────────────────────────────────────────────────
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && l; }
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)"; }

# Yazi, cd-on-exit. Named `y` and not `f`/`s`: those are kanata home-row-mod keys,
# and a leaked tap would open yazi's find/search box (see yazi/keymap.toml too).
# Drain buffered type-ahead first for the same reason.
y() {
  local tmp cwd
  tmp=$(mktemp -t 'yazi-cwd.XXXXXX')
  while read -r -t 0 && read -r -n 1 -s -t 0.01; do :; done
  command yazi "$@" --cwd-file="$tmp"
  if cwd=$(command cat -- "$tmp") && [[ -n $cwd && $cwd != "$PWD" ]]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
alias yazi='y'

# ── fzf ─────────────────────────────────────────────────────────────────────
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
export FZF_DEFAULT_OPTS="--border=rounded --color=border:${MACHINE_ACCENT:-#00ff00}"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always --icons --level=3 {} | head -200'"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"

# Same remap as the zsh config: Ctrl-F = cd widget (Alt-C), Alt-F = file widget
# (Ctrl-T, kept). Macros, so they follow whatever Omarchy's key-bindings.bash binds.
bind '"\C-f": "\ec"'
bind '"\ef": "\C-t"'
# Ctrl-U / Ctrl-P walk history by prefix (up-line-or-search in zsh).
bind '"\C-u": history-search-backward'
bind '"\C-p": history-search-forward'

# ── Environment / PATH ──────────────────────────────────────────────────────
export GPG_TTY=$(tty)
export GOPATH="$HOME/.local/go"
for dir in "$GOPATH/bin" "$HOME/.npm-global/bin" "$HOME/bin"; do
  [[ -d $dir ]] && case ":$PATH:" in *":$dir:"*) ;; *) PATH="$dir:$PATH" ;; esac
done
unset dir
export PATH

# Gemini CLI OAuth workaround (CodeAssist 400)
export GOOGLE_CLOUD_PROJECT='gemini-cli'

# ── Guarded integrations (no-ops until the tool is installed) ───────────────
command -v direnv &>/dev/null && eval "$(direnv hook bash)"
command -v uv &>/dev/null && eval "$(uv generate-shell-completion bash 2>/dev/null)"
command -v gog &>/dev/null && eval "$(gog completion bash 2>/dev/null)"

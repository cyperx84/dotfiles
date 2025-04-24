if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

zstyle ':omz:update' frequency 13

ENABLE_CORRECTION="false"

HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(
  ansible
  brew
  dotenv
  fzf
  gh
  git
  github
  golang
  macos
  pass
  pip
  python
  man
  ruby
  ssh
  thor
  tmux
  tmuxinator
  vscode
  zoxide
)

source $ZSH/oh-my-zsh.sh
export EDITOR=nvim
export VISUAL=nvim
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi



export PATH="/Frameworks/Library/Python.framework/Versions/3.12/bin:$PATH"
export MODULAR_HOME="$HOME/.modular"
export PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"

# NVIM
alias n='NVIM_APPNAME="nvim" nvim'

# NVIM config selecting
vv() {
  # Assumes all configs exist in directories named ~/.config/nvim-*
  local config=$(fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)
 
  # If I exit fzf without selecting a config, don't open Neovim
  [[ -z $config ]] && echo "No config selected" && return
 
  # Open Neovim with the selected config
  NVIM_APPNAME=$(basename $config) nvim $@
}

# Quality of life keymaps
alias t=tmux
alias python=python3
alias l=lsd
alias ll='lsd -la'

alias s='source bin/activate'
alias venv='python3 -m venv .'

alias conf="cd $HOME/dotfiles && nvim"

alias notes="cd ~/vaults/brain && nvim INDEX.md"


[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# ----- Bat (better cat) -----
export BAT_THEME=tokyonight_night

# ---- Eza (better ls) -----
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
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

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/cyperx/.lmstudio/bin"

# Added by Windsurf
export PATH="/Users/cyperx/.codeium/windsurf/bin:$PATH"

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd="z"

# thefuck alias
eval $(thefuck --alias)
eval $(thefuck --alias fk)

source ~/fzf-git.sh/fzf-git.sh
alias cld="/Users/cyperx/.claude/local/claude"

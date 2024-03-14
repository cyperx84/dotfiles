if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

zstyle ':omz:update' frequency 13

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(
  ansible
  brew
  dotenv
  fd
  flutter
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
  rust
  ripgrep
  ssh
  thor
  tmux
  tmuxinator
  vscode
  zoxide
)

source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

export PATH="/Frameworks/Library/Python.framework/Versions/3.12/bin:$PATH"
export MODULAR_HOME="$HOME/.modular"
export PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"

# python virtual env quality of life
if [[ -n $VIRTUAL_ENV && -e $VIRTUAL_ENV/bin/activate ]]; then
  source $VIRTUAL_ENV/bin/activate
fi

alias venv='. ./venv/bin/activate'
alias mkvenv='python3 -m venv .venv && venv'
alias nvim-cyperx='NVIM_APPNAME="nvim-cyperx" nvim'
alias v=nvim-cyperx
alias nv=nvim
alias nvk='NVIM_APPNAME="nvim-kickstart" nvim'
alias tm=tmux
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

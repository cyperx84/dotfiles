if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="muse"
 ENABLE_CORRECTION="false"
plugins=(git tmux python brew pip web-search )
source $ZSH/oh-my-zsh.sh
eval "$(github-copilot-cli alias -- "$0")"
alias vim="nvim"
alias mux=tmuxinator
export EDITOR=nvim
[ -s "/Users/cyperx/.bun/_bun" ] && source "/Users/cyperx/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH=~/bin:$PATH
export PATH="/usr/local/sbin:$PATH"
source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme
export MODULAR_HOME="$HOME/.modular"
export PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

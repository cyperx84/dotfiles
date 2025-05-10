ENABLE_CORRECTION="false"

HIST_STAMPS="dd/mm/yy"

# FZF
autoload -U compinit; compinit
source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh
[ -f ~/.fzf/shell/key-bindings.zsh ] && source ~/.fzf/shell/key-bindings.zsh
[ -f ~/.fzf/shell/completion.zsh ] && source ~/.fzf/shell/completion.zsh
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
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

export EDITOR=nvim
export VISUAL=nvim

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

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

alias gs='git status'

alias s='source bin/activate'
alias venv='python3 -m venv .'

alias conf="cd $HOME/dotfiles && nvim"

# notes brain
alias no="cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/notes && nvim INDEX.md"

# ----- Bat (better cat) -----
export BAT_THEME=tokyonight_night

# ---- Eza (better ls) -----
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"


# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd="z"

# thefuck alias
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
export PATH=$PATH:/Users/cyperx/.claude/local
alias cld="/Users/cyperx/.claude/local/claude"
alias claude="/Users/cyperx/.claude/local/claude"

export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"
export PATH="/opt/homebrew/opt/icu4c@77/bin:$PATH"

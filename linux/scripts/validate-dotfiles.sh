#!/bin/bash

echo "==================================="
echo "  Dotfiles Migration Validation"
echo "==================================="
echo

# Check shell
echo "1. Shell Configuration"
echo "-------------------------------------"
if [[ $SHELL == *"zsh"* ]]; then
  echo "✓ Zsh is default shell"
else
  echo "✗ Zsh not default shell"
  echo "  Run: chsh -s \$(which zsh)"
fi

# Check tmux
echo
echo "2. Tmux Installation"
echo "-------------------------------------"
if command -v tmux &>/dev/null; then
  echo "✓ Tmux installed"
  if [[ -d ~/.config/tmux/plugins/tpm ]]; then
    echo "✓ TPM (Tmux Plugin Manager) installed"
  else
    echo "✗ TPM not found"
  fi
else
  echo "✗ Tmux not installed"
fi

# Check key packages
echo
echo "3. Required Packages"
echo "-------------------------------------"
for pkg in zsh tmux fzf eza zoxide starship ripgrep bat fd yazi sesh; do
  if command -v $pkg &>/dev/null; then
    echo "✓ $pkg"
  else
    echo "✗ $pkg missing"
  fi
done

# Check Omarchy zsh structure
echo
echo "4. Omarchy Zsh Integration"
echo "-------------------------------------"
if [[ -f ~/.local/share/omarchy/default/zsh/rc ]]; then
  echo "✓ Zsh rc file exists"
else
  echo "✗ Zsh rc file missing"
fi

if [[ -f ~/.local/share/omarchy/default/zsh/shell ]]; then
  echo "✓ Zsh shell config exists"
else
  echo "✗ Zsh shell config missing"
fi

if [[ -f ~/.local/share/omarchy/default/zsh/aliases ]]; then
  echo "✓ Zsh aliases exist"
else
  echo "✗ Zsh aliases missing"
fi

if [[ -f ~/.local/share/omarchy/default/zsh/functions ]]; then
  echo "✓ Zsh functions exist"
else
  echo "✗ Zsh functions missing"
fi

if [[ -f ~/.local/share/omarchy/default/zsh/completions ]]; then
  echo "✓ Zsh completions exist"
else
  echo "✗ Zsh completions missing"
fi

# Check configs
echo
echo "5. Configuration Files"
echo "-------------------------------------"
[[ -f ~/.zshrc ]] && echo "✓ .zshrc" || echo "✗ .zshrc missing"
[[ -f ~/.config/tmux/tmux.conf ]] && echo "✓ tmux.conf" || echo "✗ tmux.conf missing"
[[ -f ~/.config/starship.toml ]] && echo "✓ starship.toml" || echo "✗ starship.toml missing"
[[ -f ~/.config/nvim/init.lua ]] && echo "✓ nvim config" || echo "✗ nvim config missing"

# Check Neovim plugins
echo
echo "6. Neovim Plugin Configs"
echo "-------------------------------------"
[[ -f ~/.config/nvim/lua/plugins/ai-codecompanion.lua ]] && echo "✓ CodeCompanion plugin" || echo "✗ CodeCompanion missing"
[[ -f ~/.config/nvim/lua/plugins/git-enhanced.lua ]] && echo "✓ Git plugins" || echo "✗ Git plugins missing"
[[ -f ~/.config/nvim/lua/plugins/navigation-enhanced.lua ]] && echo "✓ Navigation plugins" || echo "✗ Navigation plugins missing"

# Check Hyprland bindings
echo
echo "7. Hyprland Configuration"
echo "-------------------------------------"
if grep -q "Aerospace-style" ~/.config/hypr/bindings.conf 2>/dev/null; then
  echo "✓ Aerospace keybindings added"
else
  echo "✗ Aerospace keybindings not found"
fi

# Check backup
echo
echo "8. Backup Status"
echo "-------------------------------------"
if ls ~/dotfiles-backup-*.tar.gz 1> /dev/null 2>&1; then
  echo "✓ Backup found: $(ls -t ~/dotfiles-backup-*.tar.gz | head -1)"
else
  echo "✗ No backup found"
fi

echo
echo "==================================="
echo "  Validation Complete"
echo "==================================="
echo
echo "Next Steps:"
echo "1. Install missing packages (if any shown above)"
echo "2. Change shell to zsh: chsh -s \$(which zsh)"
echo "3. Log out and log back in"
echo "4. Open tmux and install plugins: Ctrl+A then Shift+I"
echo "5. Open nvim to let plugins install automatically"
echo

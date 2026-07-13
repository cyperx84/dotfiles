# Single source of truth for the per-machine accent colour.
# Sourced by: zsh (.zshrc — starship skull + fzf/sesh border) and tmux
# (.tmux.conf — status bar bg). POSIX sh so tmux's run-shell can source it too.
# Keyed on short hostname:
#   MACHINE_ACCENT      hex "#RRGGBB"  — tmux / fzf / ghostty
#   MACHINE_ACCENT_RGB  "R;G;B"        — ANSI truecolor (starship skull)
case "$(hostname -s)" in
  m1*)      MACHINE_ACCENT="#0A84FF"; MACHINE_ACCENT_RGB="10;132;255" ;;  # blue   — m1
  m4*)      MACHINE_ACCENT="#00FF00"; MACHINE_ACCENT_RGB="0;255;0" ;;     # green  — m4
  omarchy*) MACHINE_ACCENT="#B16286"; MACHINE_ACCENT_RGB="177;98;134" ;;  # purple — omarchy
  *)        MACHINE_ACCENT="#665C54"; MACHINE_ACCENT_RGB="102;92;84" ;;   # grey   — unknown
esac

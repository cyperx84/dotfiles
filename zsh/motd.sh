#!/usr/bin/env zsh
# MOTD: Glitchy Rainbow Header + System Info + Tips
# ------------------------------------------------
# — Color Palette
RED=$(printf '\033[38;5;196m')
ORANGE=$(printf '\033[38;5;202m')
YELLOW=$(printf '\033[38;5;226m')
GREEN=$(printf '\033[38;5;082m')
TEAL=$(printf '\033[1;36m')
BLUE=$(printf '\033[38;5;021m')
PURPLE=$(printf '\033[38;5;093m')
PINK=$(printf '\033[38;5;163m')
WHITE=$(printf '\033[1;37m')
RESET=$(printf '\033[0m')

# — Rainbow sequence
RAINBOW=($GREEN $TEAL $BLUE $PURPLE)
LEN=${#RAINBOW[@]}



print_sysinfo() {
  user_host="$(whoami)@$(hostname -s)"
  datetime="$(date '+%Y-%m-%d %H:%M')"
  uptime_str="$(uptime | sed -E 's/^.*up ([^,]*), .*$/\1/')"
  load="$(sysctl -n vm.loadavg | awk '{print $2","$3","$4}')"

  echo "${WHITE}${user_host}${RESET} · ${PINK}${datetime}${RESET} · up ${GREEN}${uptime_str}${RESET} · load ${RED}${load}${RESET}"
  echo
}

print_logo() {
  printf "%s          ▄████▄  ▓██   ██▓ ██▓███  ▓█████  ██▀███  ▒██   ██▒%s\n" "$BLUE" "$RESET"
  printf "%s         ▒██▀ ▀█   ▒██  ██▒▓██░  ██▒▓█   ▀ ▓██ ▒ ██▒▒▒ █ █ ▒░%s\n" "$BLUE" "$RESET"
  printf "%s         ▒▓█    ▄   ▒██ ██░▓██░ ██▓▒▒███   ▓██ ░▄█ ▒░░  █   ░%s\n" "$BLUE" "$RESET"
  printf "%s         ▒▓▓▄ ▄██▒  ░ ▐██▓░▒██▄█▓▒ ▒▒▓█  ▄ ▒██▀▀█▄   ░ █ █ ▒ %s\n" "$BLUE" "$RESET"
  printf "%s         ▒ ▓███▀ ░  ░ ██▒▓░▒██▒ ░  ░░▒████▒░██▓ ▒██▒▒██▒ ▒██▒%s\n" "$BLUE" "$RESET"
  printf "%s         ░ ░▒ ▒  ░   ██▒▒▒ ▒▓▒░ ░  ░░░ ▒░ ░░ ▒▓ ░▒▓░▒▒ ░ ░▓ ░%s\n" "$BLUE" "$RESET"
  printf "%s           ░  ▒    ▓██ ░▒░ ░▒ ░      ░ ░  ░  ░▒ ░ ▒░░░   ░▒ ░%s\n" "$BLUE" "$RESET"
  printf "%s         ░         ▒ ▒ ░░  ░░          ░     ░░   ░  ░    ░  %s\n" "$BLUE" "$RESET"
  printf "%s         ░ ░       ░ ░                    ░   ░      ░    ░  %s\n" "$BLUE" "$RESET"
  printf "%s           ░       ░                   ░  ░   ░      ░    ░  %s\n" "$BLUE" "$RESET"
  printf "%s           ░       ░                   ░      ░           ░  %s\n" "$BLUE" "$RESET"
  echo
}

# — Print glitch header via heredoc to avoid quoting hell
print_skull() {
  echo
  i=0
  while IFS= read -r line; do
    color_index=$(( i % LEN ))
    printf "%s%s%s\n" "${RAINBOW[$color_index]}" "$line" "$RESET"
    ((i++))
  done << 'EOF'
    .o oOOOOOOOo                                            OOOo
    Ob.OOOOOOOo  OOOo.      oOOo.                      .adOOOOOOO
    OboO""""""""""".OOo. .oOOOOOo.    OOOo.oOOOOOo..""""""""""'OO
    OOP.oOOOOOOOOOOO "POOOOOOOOOOOo.   `"OOOOOOOOOP,OOOOOOOOOOOB'
    `O'OOOO'     `OOOOo"OOOOOOOOOOO` .adOOOOOOOOO"oOOO'    `OOOOo
    .OOOO'            `OOOOOOOOOOOOOOOOOOOOOOOOOO'            `OO
    OOOOO                 '"OOOOOOOOOOOOOOOO'`                oOO
   oOOOOOba.                .adOOOOOOOOOOba               .adOOOOo.
  oOOOOOOOOOOOOOba.    .adOOOOOOOOOO@^OOOOOOOba.     .adOOOOOOOOOOOO
 OOOOOOOOOOOOOOOOO.OOOOOOOOOOOOOO"`  '"OOOOOOOOOOOOO.OOOOOOOOOOOOOO
 "OOOO"       "YOoOOOOMOIONODOO"`  .   '"OOROAOPOEOOOoOY"     "OOO"
    Y           'OOOOOOOOOOOOOO: .oOOo. :OOOOOOOOOOO?'         :`
    :            .oO%OOOOOOOOOOo.OOOOOO.oOOOOOOOOOOOO?         .
    .            oOOP"%OOOOOOOOoOOOOOOO?oOOOOO?OOOO"OOo
                 '%o  OOOO"%OOOO%"%OOOOO"OOOOOO"OOO':
                      `\$"  `OOOO' `O"Y ' `OOOO'  o             .
    .                  .     OP"          : o     .
                              :
                              :
EOF
  echo
}


# print_footer() {
#   tips=(
#     "Tip: ssh into your rigs like a boss 💀"
#     "Quote: Code, carve, repeat."
#     "Glitch mode: engage."
#   )
#   tip_index=$(( RANDOM % ${#tips[@]} ))
#   echo "${RAINBOW[RANDOM % LEN]}▶${RESET} ${tips[$tip_index]}"
#   echo
# }

# ─── MAIN ───────────────────────────────────────────────────────────────────
print_logo
print_skull
macchina













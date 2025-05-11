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
  echo "${WHITE}${user_host}${RESET} · ${PINK}${datetime}${RESET} · up ${GREEN}${uptime_str}${RESET} · load ${RED}${load}${RESET}"
  echo
}

print_logo() {
  printf "%s         ▄████▄  ▓██   ██▓ ██████  ▓█████  ██▀███  ▒██   ██▒%s\n" "$BLUE" "$RESET"
  printf "%s        ▒██▀ ▀█   ▒██  ██▒▓██░  ██▒▓█   ▀ ▓██ ▒ ██▒▒▒ █ █ ▒░%s\n" "$BLUE" "$RESET"
  printf "%s        ▒▓█    ▄   ▒██ ██░▓██░ ██▓▒▒███   ▓██ ░▄█ ▒░░  █   ░%s\n" "$BLUE" "$RESET"
  printf "%s        ▒▓▓▄ ▄██▒  ░ ▐██▓░▒██▄█▓▒ ▒▒▓█  ▄ ▒██▀▀█▄   ░ █ █ ▒ %s\n" "$BLUE" "$RESET"
  printf "%s        ▒ ▓███▀ ░  ░ ██▒▓░▒██▒ ░  ░░▒████▒░██▓ ▒██▒▒██▒ ▒██▒%s\n" "$BLUE" "$RESET"
  printf "%s        ░ ░▒ ▒  ░   ██▒▒▒ ▒▓▒░ ░  ░░░ ▒░ ░░ ▒▓ ░▒▓░▒▒ ░ ░▓ ░%s\n" "$BLUE" "$RESET"
  printf "%s          ░  ▒    ▓██ ░▒░ ░▒ ░      ░ ░  ░  ░▒ ░ ▒░░░   ░▒ ░%s\n" "$BLUE" "$RESET"
  printf "%s        ░         ▒ ▒ ░░  ░░          ░     ░░   ░  ░    ░  %s\n" "$BLUE" "$RESET"
  printf "%s        ░ ░       ░ ░                    ░   ░      ░    ░  %s\n" "$BLUE" "$RESET"
  printf "%s          ░       ░                   ░  ░   ░      ░    ░  %s\n" "$BLUE" "$RESET"
  echo
}

print_skull() {
  echo
  DRIP_COLS=(10 18 38 45 57)   # 0-based columns to tint blue
  while IFS= read -r line; do
    out="${GREEN}"
    len=${#line}
    for ((idx=1; idx<=len; idx++)); do        # zsh strings are 1-based
      ch="${line[$idx]}"
      col=$((idx-1))                          # convert to 0-based
      if [[ " ${DRIP_COLS[*]} " == *" $col "* && "$ch" != ' ' ]]; then
        out+="${BLUE}${ch}${GREEN}"
      else
        out+="$ch"
      fi
    done
    printf '%s%s\n' "$out" "$RESET"
  done <<'EOF'
    .o oOOOOOOOo                                            OOOo
    Ob.OOOOOOOo  OOOo.      oOOo.                      .adOOOOOOO
    OboO00ooOOO00OO.OOo. .oOOOOOo.    OOOo.oOOOOOo..OOOOOOO000OOOO
    OOP.oOOOOOOOOOOO OPOOOOOOOOOOOo.   OOOOOOOOOOOP,OOOOOOOOOOOBO
    oOoOOOOo     oOOOOooOOOOOOOOOOOo .adOOOOOOOOOooOOOo    oOOOOo
    .OOOOo            oOOOOOOOOOOOOOOOOOOOOOOOOOOo            oOO
    OOOOO                 OoOOOOOOOOOOOOOOOOOo                oOO
   oOOOOOba.                .adOOOOOOOOOOba               .adOOOOo.
  oOOOOOOOOOOOOOba.    .adOOOOOOOOOO@^OOOOOOOba.     .adOOOOOOOOOOOO
 OOOOOOOOOOOOOOOOO.OOOOOOOOOOOOOOOo  oOOOOOOOOOOOOOO.OOOOOOOOOOOOOO
 oOOOOo       oYOoOOOOMOIONODOOoo  .   oOOOROAOPOEOOOoOYo     oOOOo
    Y           oOOOOOOOOOOOOOO: .oOOo. :OOOOOOOOOOO?o         :o
    :            .oO%OOOOOOOOOOo.OOOOOO.oOOOOOOOOOOOO?         .
    .            oOOPo%OOOOOOOOoOOOOOOO?oOOOOO?OOOOoOOo
                 o%o  OOOOo%OOOO%o%OOOOOoOOOOOOoOOOo:
                      o\$o  oOOOOo oOoY o oOOOOo  o             .
    .                  .     OPo          : o     .
                              :
                              :
EOF
  echo
}

print_tip() {
  tips=(
    "Tip: ssh into your rigs like a boss 💀"
    "Quote: Code, carve, repeat."
    "Glitch mode: engage."
  )
  tip_index=$(( RANDOM % ${#tips[@]} ))
  echo "${RAINBOW[RANDOM % LEN]}▶${RESET} ${tips[$tip_index]}"
  echo
}

# ─── MAIN ───────────────────────────────────────────────────────────────────
print_logo
print_skull
macchina
print_tip












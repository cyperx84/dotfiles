#!/usr/bin/env zsh

RED=$(printf '\033[38;5;196m')
ORANGE=$(printf '\033[38;5;202m')
YELLOW=$(printf '\033[38;5;226m')
GREEN=$(printf '\033[38;5;082m')
TEAL=$(printf '\033[1;36m')
BLUE=$(printf '\033[38;5;021m')
PURPLE=$(printf '\033[38;5;093m')
PINK=$(printf '\033[38;5;163m')
RESET=$(printf '\033[0m')

LINE_1=$(cat << 'EOF'
  _          _ _                            _     _ 
EOF
)
LINE_2=$(cat << 'EOF'
 | |        | | |                          | |   | |
EOF
)
LINE_3=$(cat << 'EOF'
 | |__   ___| | | ___   __      _____  _ __| | __| |
EOF
)
LINE_4=$(cat << 'EOF'
 | '_ \ / _ \ | |/ _ \  \ \ /\ / / _ \| '__| |/ _` |
EOF
)
LINE_5=$(cat << 'EOF'
 | | | |  __/ | | (_) |  \ V  V / (_) | |  | | (_| |
EOF
)
LINE_6=$(cat << 'EOF'
 |_| |_|\___|_|_|\___/    \_/\_/ \___/|_|  |_|\__,_|
EOF
)

printf "\n"
printf "%s%s%s\n" "$PURPLE" "$LINE_1" "$RESET"
printf "%s%s%s\n" "$BLUE"   "$LINE_2" "$RESET"
printf "%s%s%s\n" "$GREEN"  "$LINE_3" "$RESET"
printf "%s%s%s\n" "$YELLOW" "$LINE_4" "$RESET"
printf "%s%s%s\n" "$ORANGE" "$LINE_5" "$RESET"
printf "%s%s%s\n" "$RED"    "$LINE_6" "$RESET"
printf "\n"

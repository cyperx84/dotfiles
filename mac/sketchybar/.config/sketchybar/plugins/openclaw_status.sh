#!/bin/bash

# OpenClaw status: green if the gateway is listening on 18789, grey otherwise.

[ -z "$NAME" ] && exit 1

GREY="0xff6e6a86"
GREEN="0xffa6da95"

if lsof -iTCP:18789 -sTCP:LISTEN -n -P &>/dev/null; then
  sketchybar --set "$NAME" drawing=on icon.color="$GREEN" label="" 2>/dev/null
else
  sketchybar --set "$NAME" drawing=on icon.color="$GREY" label="" 2>/dev/null
fi

require("bar")
require("default")
require("bootstrap")
require("items")

-- Trigger initial workspace highlight (AeroSpace) — from the bash rc tail.
sbar.exec([[/bin/bash -c 'workspace=$(aerospace list-workspaces --focused 2>/dev/null); ]] ..
  [[[ -z "$workspace" ] && workspace="1"; ]] ..
  [[sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE="$workspace"']])

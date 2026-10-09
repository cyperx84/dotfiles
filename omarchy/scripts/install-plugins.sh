#!/usr/bin/env bash
# Install the user's Omarchy shell plugins, preferring local development clones.
set -euo pipefail

plugins_dir="$HOME/.config/omarchy/plugins"
shell_config="$HOME/.config/omarchy/shell.json"
shell_running=
changed=
plugin_ids=()
plugin_sections=()
retry_plugins=()

if omarchy-shell shell ping >/dev/null 2>&1; then
  shell_running=1
fi

plugin_enabled() { # <id>
  local id=$1
  [[ -f $shell_config ]] && jq -e --arg id "$id" '
    any(.bar.layout[][]?; .id == $id)
    or any(.plugins[]?; (if type == "object" then .id else . end) == $id)
  ' "$shell_config" >/dev/null
}

join_names() {
  local joined= name
  for name in "$@"; do
    [[ -z $joined ]] || joined+=", "
    joined+="$name"
  done
  printf '%s' "$joined"
}

link_local_plugin() { # <id> <repo>
  local id=$1 repo=$2 target
  target="$plugins_dir/$id"

  if [[ ! -f $repo/manifest.json ]]; then
    echo "Skipping $id: $repo exists but has no manifest.json"
    return 1
  fi

  mkdir -p "$plugins_dir"
  if [[ -L $target && $target -ef $repo ]]; then
    echo "$id is already linked to $repo"
    return 0
  fi
  if [[ -e $target && ! -L $target ]]; then
    local backup="$target.bak"
    if [[ -e $backup || -L $backup ]]; then
      backup="$target.bak.$(date +%s)"
    fi
    mv "$target" "$backup"
    echo "Moved existing $target to $backup"
  fi
  ln -sfn "$repo" "$target"
  changed=1
  echo "Linked $id -> $repo"
}

prepare_plugin() { # <id> <repo> <url> <section>
  local id=$1 repo=$2 url=$3 section=$4

  if [[ -d $repo ]]; then
    link_local_plugin "$id" "$repo" || return 0
  elif [[ -f $plugins_dir/$id/manifest.json ]]; then
    echo "$id is already installed"
  elif [[ -z $shell_running ]]; then
    echo "Skipping install for $id: omarchy-shell is not running"
    retry_plugins+=("$id")
    return 0
  elif GIT_TERMINAL_PROMPT=0 git ls-remote --exit-code "$url" HEAD >/dev/null 2>&1; then
    omarchy plugin add "$url" --yes
    changed=1
  else
    echo "Skipping $id: no local clone and GitHub repository is unavailable"
    return 0
  fi

  plugin_ids+=("$id")
  plugin_sections+=("$section")
}

prepare_plugin cyperx84.pulse "$HOME/Code/omarchy-pulse" \
  https://github.com/cyperx84/omarchy-pulse right
prepare_plugin cyperx84.spaces "$HOME/Code/omarchy-spaces" \
  https://github.com/cyperx84/omarchy-spaces left
prepare_plugin cyperx84.fleet "$HOME/Code/omarchy-fleet" \
  https://github.com/cyperx84/omarchy-fleet right

if [[ -f $HOME/Code/omarchy-fleet/beacon/install.sh ]]; then
  echo "Fleet beacon installer available at ~/Code/omarchy-fleet/beacon/install.sh (run manually)"
fi

if [[ -n $shell_running && ${#plugin_ids[@]} -gt 0 ]]; then
  declare -A undiscovered_plugins=()

  if [[ -n $changed ]]; then
    omarchy-shell shell rescanPlugins >/dev/null
    echo "Rescanned Omarchy shell plugins"

    for id in "${plugin_ids[@]}"; do
      discovered=
      for ((attempt = 0; attempt < 40; attempt++)); do
        if omarchy plugin list --json | jq -e --arg id "$id" \
          'any(.[]; .id == $id)' >/dev/null; then
          discovered=1
          break
        fi
        sleep 0.05
      done
      if [[ -z $discovered ]]; then
        echo "Warning: plugin $id was not discovered after rescan; leaving it disabled" >&2
        undiscovered_plugins["$id"]=1
      fi
    done
  fi

  for i in "${!plugin_ids[@]}"; do
    id=${plugin_ids[$i]}
    section=${plugin_sections[$i]}
    [[ -z ${undiscovered_plugins[$id]:-} ]] || continue
    if plugin_enabled "$id"; then
      echo "$id is already enabled"
    else
      omarchy plugin enable "$id" --section "$section"
    fi
  done
elif [[ ${#plugin_ids[@]} -gt 0 || ${#retry_plugins[@]} -gt 0 ]]; then
  disabled_plugins=("${retry_plugins[@]}")
  for id in "${plugin_ids[@]}"; do
    plugin_enabled "$id" || disabled_plugins+=("$id")
  done
  if [[ ${#disabled_plugins[@]} -gt 0 ]]; then
    printf 'Plugins pending install or enable: %s; after logging in run: ~/dotfiles/omarchy/scripts/install-plugins.sh\n' \
      "$(join_names "${disabled_plugins[@]}")"
  fi
fi

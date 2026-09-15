#!/usr/bin/env bash
# Regression harness for the nvim provisioning block in the bootstrap scripts.
#
# Guards against the bootstrap clobbering a working ~/.config/nvim: it exercises
# every branch of that block (fresh clone, foreign config, dirty clone, behind,
# diverged, unreachable origin) for BOTH mac/bootstrap.sh and linux/bootstrap.sh.
#
# The blocks under test are extracted from the real scripts, never duplicated,
# so this cannot silently drift from what actually ships. Each case runs against
# its own private local bare remote -- no network, no dependence on GitHub.
#
# Needs only bash and git. Exits nonzero if any case fails.
#
# Usage: tests/bootstrap-nvim-provision.sh

set -u

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP="$(mktemp -d)"
export TIMESTAMP=20260101-000000

FAILED=0
PASS_COUNT=0
TOTAL=0

cleanup() {
  # Keep the sandbox on failure so the failing case can be inspected.
  if [ "$FAILED" -eq 0 ]; then rm -rf "$TMP"; else echo "sandbox kept for debugging: $TMP"; fi
}
trap cleanup EXIT

# --- extract the blocks under test from the real scripts -------------------
extract() { # $1=script $2=start-regex $3=end-regex $4=out
  local s e
  s=$(grep -n "$2" "$1" | cut -d: -f1)
  e=$(grep -n "$3" "$1" | cut -d: -f1)
  if [ -z "$s" ] || [ -z "$e" ]; then
    echo "EXTRACT FAILED: could not locate block in $1" >&2
    echo "  start=$2 end=$3" >&2
    FAILED=1
    return 1
  fi
  sed -n "${s},${e}p" "$1" > "$4"
  [ -s "$4" ] || { echo "EXTRACT FAILED: empty block from $1" >&2; FAILED=1; return 1; }
}

extract "$REPO_ROOT/mac/bootstrap.sh"   '^# 5\. Neovim config' "run 'nvim' once" "$TMP/mac.tpl"   || exit 1
extract "$REPO_ROOT/linux/bootstrap.sh" '^# 4\. Neovim config' "run 'nvim' once" "$TMP/linux.tpl" || exit 1
echo "blocks under test: mac $(wc -l < "$TMP/mac.tpl" | tr -d ' ') lines, linux $(wc -l < "$TMP/linux.tpl" | tr -d ' ') lines"

chk() { # $1=ok|no $2=label
  TOTAL=$((TOTAL + 1))
  if [ "$1" = ok ]; then PASS_COUNT=$((PASS_COUNT + 1)); echo "  $2 PASS"; else FAILED=1; echo "  $2 FAIL"; fi
}
fresh() { export HOME="$TMP/h-$1"; rm -rf "$HOME"; mkdir -p "$HOME/.config"; }

# --- private local remote per case, so cases cannot perturb each other -----
make_remote() {
  local tag="$1"
  local seed="$TMP/seed-$tag"
  mkdir -p "$seed"
  (
    cd "$seed" || exit 1
    git init -q -b main .
    git config user.email t@t
    git config user.name t
    echo v1 > init.lua
    git add -A
    git commit -qm v1
    git clone -q --bare . "$TMP/origin-$tag.git"
  )
  echo "$TMP/origin-$tag.git"
}
advance() { # $1=tag $2=newfile
  local tag="$1" f="$2"
  (
    cd "$TMP/seed-$tag" || exit 1
    echo x > "$f"
    git add -A
    git commit -qm "$f"
    git push -q "$TMP/origin-$tag.git" main
  )
}

for plat in mac linux; do
  echo "================ $plat ================"
  TPL="$TMP/$plat.tpl"
  render() { sed "s|https://github.com/cyperx84/nvim.git|$1|" "$TPL" > "$TMP/r.sh"; }

  # A: no ~/.config/nvim -> clone
  R=$(make_remote "$plat-a"); fresh "$plat-a"; render "$R"
  ( set -e; . "$TMP/r.sh" ) >/dev/null 2>&1
  [ "$(cat "$HOME/.config/nvim/init.lua" 2>/dev/null)" = v1 ] \
    && chk ok "A fresh-clone    " || chk no "A fresh-clone    "

  # B: foreign config (e.g. Omarchy's LazyVim) -> backed up, then cloned
  R=$(make_remote "$plat-b"); fresh "$plat-b"
  mkdir -p "$HOME/.config/nvim"; echo foreign > "$HOME/.config/nvim/init.lua"
  render "$R"
  ( set -e; . "$TMP/r.sh" ) >/dev/null 2>&1
  { [ "$(cat "$HOME/.config/nvim/init.lua" 2>/dev/null)" = v1 ] \
    && [ "$(cat "$HOME/.config/nvim.backup-20260101-000000/init.lua" 2>/dev/null)" = foreign ]; } \
    && chk ok "B foreign->backup" || chk no "B foreign->backup"

  # C: our clone with uncommitted work -> left untouched, no backup
  R=$(make_remote "$plat-c"); fresh "$plat-c"
  git clone -q "$R" "$HOME/.config/nvim"
  echo dirty >> "$HOME/.config/nvim/init.lua"
  render "$R"
  o=$( ( set -e; . "$TMP/r.sh" ) 2>&1 )
  { grep -q dirty "$HOME/.config/nvim/init.lua" \
    && [ ! -e "$HOME/.config/nvim.backup-20260101-000000" ] \
    && grep -q 'local changes' <<<"$o"; } \
    && chk ok "C dirty->untouched" || chk no "C dirty->untouched"

  # D: our clone clean, remote advanced -> fast-forward
  R=$(make_remote "$plat-d"); fresh "$plat-d"
  git clone -q "$R" "$HOME/.config/nvim"
  advance "$plat-d" v2.txt
  render "$R"
  o=$( ( set -e; . "$TMP/r.sh" ) 2>&1 )
  { [ -f "$HOME/.config/nvim/v2.txt" ] && grep -q 'up to date' <<<"$o"; } \
    && chk ok "D behind->ffwd   " || chk no "D behind->ffwd   "

  # E: both sides moved -> real divergence, local work kept
  R=$(make_remote "$plat-e"); fresh "$plat-e"
  git clone -q "$R" "$HOME/.config/nvim"
  ( cd "$HOME/.config/nvim" && git config user.email t@t && git config user.name t \
    && echo m > mine.txt && git add -A && git commit -qm mine )
  advance "$plat-e" theirs.txt
  render "$R"
  o=$( ( set -e; . "$TMP/r.sh" ) 2>&1 )
  { [ -f "$HOME/.config/nvim/mine.txt" ] \
    && [ ! -f "$HOME/.config/nvim/theirs.txt" ] \
    && [ ! -e "$HOME/.config/nvim.backup-20260101-000000" ] \
    && grep -q 'diverged from origin' <<<"$o"; } \
    && chk ok "E diverged       " || chk no "E diverged       "

  # F: origin unreachable (slug still matches) -> reported as unreachable, not diverged
  R=$(make_remote "$plat-f"); fresh "$plat-f"
  git clone -q "$R" "$HOME/.config/nvim"
  git -C "$HOME/.config/nvim" remote set-url origin "$TMP/nope-$plat.git"
  render "$TMP/nope-$plat.git"
  o=$( ( set -e; . "$TMP/r.sh" ) 2>&1 )
  { grep -q "couldn't reach origin" <<<"$o" \
    && [ ! -e "$HOME/.config/nvim.backup-20260101-000000" ]; } \
    && chk ok "F unreachable    " || chk no "F unreachable    "
done

echo
if [ "$FAILED" -eq 0 ]; then
  echo "PASS: $PASS_COUNT/$TOTAL cases"
else
  echo "FAIL: $((TOTAL - PASS_COUNT))/$TOTAL cases failed"
fi
exit "$FAILED"

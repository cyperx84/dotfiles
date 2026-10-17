# Shared by the install-*.sh scripts: source it, don't run it.

OMARCHY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# stow_package <package> [stow options...]
# Stow omarchy/<package> into $HOME. Omarchy (or an app's first run) usually
# wrote its own copy of the files we ship, and stow refuses to link over a real
# file, so move each one aside to <file>.bak first. A target that already
# resolves to our file (linked, or inside a folded directory) is left alone.
stow_package() {
  local pkg=$1 src target
  shift

  while IFS= read -r -d '' src; do
    target="$HOME/${src#"$OMARCHY_DIR/$pkg/"}"
    if [[ (-e $target || -L $target) && ! $target -ef $src ]]; then
      mv "$target" "$target.bak"
      echo "Moved existing $target to $target.bak"
    fi
  done < <(find "$OMARCHY_DIR/$pkg" -type f -print0)

  stow --dir="$OMARCHY_DIR" --target="$HOME" "$@" "$pkg"
}

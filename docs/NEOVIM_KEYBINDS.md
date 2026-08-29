# Neovim Keybinds

**Moved 2026-08-28.** The full Neovim keymap reference now lives with the config
that defines it:

**→ [`cyperx84/nvim` · `docs/keybindings.md`](https://github.com/cyperx84/nvim/blob/main/docs/keybindings.md)**
(locally: `~/.config/nvim/docs/keybindings.md`)

## Why it moved

Neovim is a standalone repo at `~/.config/nvim` — it is *not* part of dotfiles.
A keymap reference kept here drifted for three months, because the commits that
invalidated it landed in the other repo. Doc now sits next to the code, so a
keymap change and its documentation land in one commit.

## What still lives here

[`KEYBINDS.md`](KEYBINDS.md) — the cross-tool arbitration table: which layer owns
which modifier across herdr, Neovim, kanata and AeroSpace. That one belongs in
dotfiles because it is about the seams between tools, and no single tool's repo
can own it.

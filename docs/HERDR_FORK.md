# herdr fork: cross-machine jump

> **Status (2026-10-16):** not in use. This Mac runs Homebrew's stock herdr;
> the fork below is kept for a later rebase. Run `mac/scripts/herdr-build.sh switch`
> to use it again, then `brew pin herdr` and set `[update] version_check = false`.

When in use, the `herdr` on this Mac is a local build, not Homebrew's. It carries three
commits that upstream does not have, and they are what makes the sesh-bro
picker able to jump to another machine.

- Repo: `~/github/herdr`, branch `feat/client-focus` (never pushed).
- Installed copy: `~/.local/share/herdr-build/herdr`, with
  `/opt/homebrew/bin/herdr` symlinked to it.
- Switch, revert, and check: `mac/scripts/herdr-build.sh`.

## Why a fork at all

herdr decides which machine the window shows inside the client, and no API
reaches that. Without these commits a picker row for another machine can list
work but cannot take you to it, and a plugin key pressed while a machine is on
screen goes to that machine, which does not have the plugin.

Upstream has closed this class of request as not planned (issues #3820, #3749,
#4007), so the fork is the way to have it.

## The three commits

1. **`client.focus`** — an API method that moves the attached client to a
   machine and, optionally, a workspace, tab or pane on it, through the same
   client function the sidebar and navigator use. The server forwards it to the
   foreground client as the optional `client.focus.v1` endpoint control.
2. **`machine = "local"` on `[[keys.command]]`** — a key that switches the
   window to Local first, then runs its command there. Without it alt+e does
   nothing while a machine is on screen.
3. **Keeping a Local-pinned key alive on another machine** — the client rebuilds
   custom-command keys from the machine it is showing, so Local's commands are
   merged in for pinned keys and the pin survives.

## What depends on it

- `sesh-bro connect machine|mworkspace|magent` and `sesh-bro focus`.
- alt+e from a machine (`[ui]`-level config in `mac/herdr/.config/herdr/config.toml`).
- Nothing else. Local picker rows, agent status and cross-machine triage
  (`read`, `prompt`, `reply`) work on stock herdr.

## Staying put is fine

While the fork is in use, Homebrew's formula is pinned (`brew pin herdr`) and `[update] version_check` is
false, so nothing replaces the build behind your back. There is no need to track
herdr releases; upgrade when a release has something you want.

## Upgrading to a new herdr release

```sh
cd ~/github/herdr
git fetch --tags origin
git branch backup/client-focus-$(git describe --tags --abbrev=0)   # keep the old base
git rebase --onto v<new> <old-base-commit> feat/client-focus
```

Expect conflicts in the same four places every time, all of them additive:

| Where | What happens |
| --- | --- |
| `src/protocol/endpoint.rs` | upstream adds control-kind constants beside `CLIENT_FOCUS_KIND`; keep both |
| `src/client/endpoint/control.rs` | new `EndpointControlMessage` variants and tests beside `Focus`; keep both |
| `src/client/mod.rs` | new arms in the endpoint-control match beside the `Focus` arm; keep both |
| `src/client/shell/config.rs` | `apply_snapshot_keybindings` is called there; upstream edits the error handling around the call, the fork adds a `local_commands` argument |

Signature drift is the other recurring cost: in 0.9.1 `finish_client_shell_input`
took `&mut scheduled_activation` where it used to take the event sender. When a
call of the fork's fails to compile, copy the shape of the nearest upstream call.

Then:

```sh
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"     # rustup is keg-only
cargo build --release
HERDR_UPDATE_API_SCHEMA=1 cargo nextest run --cargo-profile release --bin herdr \
  -E 'test(generated_protocol_schema)'               # regenerate the API schema artifact
cargo nextest run --cargo-profile release --bin herdr
```

Use `cargo nextest`, not `cargo test`: herdr's tests mutate environment
variables and collide when they share a process.

A fork test may fail because upstream changed behaviour deliberately — in 0.9.1
a same-machine selection started routing through activation so it can cancel a
handoff in flight. Read the upstream change before "fixing" the code.

## Verifying it still does the job

Tests do not cover the two things that matter. Check them in a real client:

1. Pick another machine's workspace row in the picker — the window goes there.
2. Press alt+e while that machine is on screen — the window returns to Local
   and the picker opens.

Then `mac/scripts/herdr-build.sh switch` (from a terminal outside herdr; it
stops every session and refuses while an agent is working).

## Remote machines

Remote machines run stock herdr — the fork only matters where the client runs.
Each one needs a herdr-prefixed window title, or alt+e cannot find the window
and cold-launches a second herdr:

```toml
[ui]
window_title = "herdr · {hostname} · {workspace}"
```

From 0.9.1 on, `herdr --machine <label> <command>` reaches a machine's server
directly (both ends must be 0.9.1), which is tidier than sesh-bro's ssh calls.

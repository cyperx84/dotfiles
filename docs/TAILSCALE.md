# Tailscale & SSH Runbook

How the tailnet is set up, how to SSH between machines, how to add new machines
(macOS + Linux), and how to get unstuck. Tailnet account: **cyperx84@gmail.com**
(MagicDNS suffix `tailc04492.ts.net`).

---

## Current machines

| Name        | Type        | Client            | SSH server                  |
|-------------|-------------|-------------------|-----------------------------|
| `m4-mini`   | Mac mini M4 | GUI app (cask)    | macOS Remote Login (OpenSSH)|
| `m1-mini`   | Mac mini M1 | GUI app (cask)    | macOS Remote Login (OpenSSH)|
| `omarchy`   | Linux (Arch/Omarchy) | `tailscaled` (pkg) | Tailscale-SSH + OpenSSH |
| `ipad157`   | iPad        | iOS app           | client only                 |
| `iphone-13` | iPhone      | iOS app           | client only                 |

Connect from any machine: `ssh cyperx@<name>` (e.g. `ssh cyperx@m1-mini`).

---

## Golden rules (learned the hard way)

1. **macOS = the GUI app, never the Homebrew formula.** Use `cask "tailscale-app"`
   (already in `mac/macos/Brewfile`). Installing the `tailscale` *formula* alongside
   the app makes TWO tailnet nodes for one machine (the `m4` / `m4-mac-mini` duplicate
   mess). One client per machine, always.
2. **macOS GUI builds cannot run a Tailscale-SSH server** ("does not run in sandboxed
   Tailscale GUI builds"). So on Macs, SSH is plain **OpenSSH over the tailnet** via
   **Remote Login**. Tailscale-SSH (`--ssh` + ACL `ssh` block) only works on Linux /
   the open-source `tailscaled`.
3. **App CLI path on macOS:** `/Applications/Tailscale.app/Contents/MacOS/Tailscale`
   (there is no `/opt/homebrew/bin/tailscale` when using the cask). Alias it if you want:
   `alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"`.
4. **Disable key expiry** on always-on machines (minis, servers) in the admin console,
   or they silently drop off the tailnet every ~6 months.
5. In your zsh, `#` is NOT a comment in interactive paste — never paste commands with
   trailing `# comments`, they become arguments and break.

---

## SSH access model

- **Macs:** OpenSSH server via System Settings -> General -> Sharing -> **Remote Login -> On**.
  Auth = SSH keys (see below) over the encrypted tailnet. No Tailscale-SSH.
- **Linux:** can use Tailscale-SSH (`tailscale up --ssh`) AND/OR OpenSSH (`sshd`). omarchy
  uses Tailscale-SSH. Either is fine.
- **iOS:** clients only (SSH out with an app like Termius; nothing to enable).

### SSH key mesh (passwordless)

Each machine has its own `~/.ssh/id_ed25519`; each machine's PUBLIC key goes into every
other machine's `~/.ssh/authorized_keys`. From the machine you want to connect FROM:

```
ssh-copy-id cyperx@<target>
```

Enter the target's password once; thereafter it's keyless. Verify:

```
ssh -o BatchMode=yes cyperx@<target> hostname
```

To generate a key if a machine has none:

```
ssh-keygen -t ed25519 -C "cyperx@<machine>"
```

---

## Add a new macOS machine to the tailnet

1. Install the app (reproducible, already in Brewfile):
   ```
   brew install --cask tailscale-app
   open -a Tailscale
   ```
   Approve the System Extension if prompted: System Settings -> Privacy & Security -> Allow.
2. Log in with a clean tailnet name:
   ```
   sudo /Applications/Tailscale.app/Contents/MacOS/Tailscale up --hostname=<name> --accept-routes
   ```
   Open the printed `https://login.tailscale.com/...` URL and authorize.
   (Do NOT pass `--ssh` on macOS — it errors; use Remote Login instead.)
3. Enable SSH: System Settings -> General -> Sharing -> **Remote Login -> On**.
4. Admin console (login.tailscale.com/admin/machines): on the new node, `...` ->
   **Disable key expiry**. Delete any stale duplicate node.
5. Add to the SSH key mesh (`ssh-copy-id` both directions).

---

## Add a new Linux machine to the tailnet (provision guide)

Tested mental model = Arch / Omarchy, but adapt the install line per distro.

1. **Install Tailscale.**
   - Arch / Omarchy: `sudo pacman -S tailscale`
   - Debian/Ubuntu/Fedora/etc (universal): `curl -fsSL https://tailscale.com/install.sh | sh`
2. **Enable the daemon:**
   ```
   sudo systemctl enable --now tailscaled
   ```
3. **Join the tailnet** (Linux CAN run Tailscale-SSH, so enable it here):
   ```
   sudo tailscale up --ssh --hostname=<name> --accept-routes
   ```
   Open the printed URL and authorize as cyperx84@gmail.com.
4. **(Optional) OpenSSH too,** for parity with the Macs:
   ```
   sudo systemctl enable --now sshd
   ```
5. **Admin console:** on the new node, `...` -> **Disable key expiry**.
6. **SSH key mesh:** `ssh-copy-id cyperx@<name>` from the machines that need keyless in,
   and from the new box out to the others.
7. **ACL note:** Tailscale-SSH needs an `ssh` block in Access Controls. For a single-user
   tailnet this rule allows all your own devices to use Tailscale-SSH:
   ```json
   "ssh": [
     { "action": "accept", "src": ["autogroup:member"],
       "dst": ["autogroup:self"], "users": ["autogroup:nonroot", "root"] }
   ]
   ```
   (Not needed for plain OpenSSH-over-tailnet, which the Macs use.)

---

## Troubleshooting

### Two nodes for one machine (duplicate)
Cause: two Tailscale clients running at once (e.g. Homebrew formula + GUI app on macOS).
Fix: remove one client, then delete its now-stale node in the console.

Remove the Homebrew formula cleanly on macOS (run on that machine; comment-free):
```
sudo /opt/homebrew/bin/tailscale logout
sudo launchctl bootout system/homebrew.mxcl.tailscale 2>/dev/null
sudo pkill -9 -f 'opt/homebrew.*tailscaled'
brew uninstall --formula --force tailscale
sudo rm -rf /opt/homebrew/Cellar/tailscale
brew cleanup tailscale 2>/dev/null
```
The launchd `bootout` matters: just killing the daemon lets launchd respawn it.

### Node shows "offline" / "logged out" / "Expired"
- Check the node's own view: `tailscale status` (first line is self). "logged out" =
  re-run `tailscale up ...`. "Expired" = key expiry kicked in; re-auth and then disable
  key expiry in the console.
- macOS app CLI is at `/Applications/Tailscale.app/Contents/MacOS/Tailscale`.

### Can't reach an offline machine to fix it
- You generally need physical/local access if it's asleep or powered off. Wake-on-LAN
  needs the target's MAC + "Wake for network access" pre-enabled + same LAN.
- Enable **System Settings -> Energy -> Wake for network access** on always-on Macs so a
  tailnet ping can wake them from sleep.

### `tailscale up` complains about non-default flags
Re-run with the exact line it prints (it wants you to restate current settings like
`--accept-routes`). Or add `--reset` to drop back to defaults plus your flags.

### Client/daemon version mismatch warning
Harmless (`client version != tailscaled server version`). Resolves after the app/daemon
restarts or updates.

### Verify SSH server is up
```
nc -z -G 2 127.0.0.1 22 && echo "ssh up" || echo "ssh closed"
```

---

## Quick reference

```
tailscale status                 # who's on the tailnet (use app CLI path on macOS)
tailscale ip -4                  # this node's tailnet IP
tailscale ping <name>            # test tailnet reachability
ssh cyperx@<name>                # connect over the tailnet
```

Admin console: https://login.tailscale.com/admin/machines
Access controls (ACLs): https://login.tailscale.com/admin/acls

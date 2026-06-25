#!/bin/bash
# Kanata startup wrapper for LaunchDaemon.
# Waits for Karabiner DriverKit VirtualHID to be fully ready before starting kanata.
# Without this, kanata fails to register keyboard devices on boot.

LOG_PREFIX="[kanata-start]"

# Step 1: Wait for Karabiner VirtualHIDDevice-Daemon process (up to 30s)
echo "$LOG_PREFIX Waiting for Karabiner VirtualHIDDevice-Daemon..."
for i in $(seq 1 30); do
    if pgrep -x "Karabiner-VirtualHIDDevice-Daemon" > /dev/null 2>&1; then
        echo "$LOG_PREFIX Daemon found after ${i}s"
        break
    fi
    sleep 1
done

if ! pgrep -x "Karabiner-VirtualHIDDevice-Daemon" > /dev/null 2>&1; then
    echo "$LOG_PREFIX ERROR: Karabiner daemon not found after 30s, starting kanata anyway"
fi

# Step 2: Wait for VirtualHIDKeyboard to appear in kanata device list (up to 30s)
echo "$LOG_PREFIX Waiting for VirtualHIDKeyboard device..."
for i in $(seq 1 30); do
    if /opt/homebrew/bin/kanata --list 2>/dev/null | grep -q "VirtualHIDKeyboard"; then
        echo "$LOG_PREFIX VirtualHIDKeyboard ready after ${i}s"
        break
    fi
    sleep 1
done

# Step 3: Extra buffer for driver to fully stabilize
sleep 3
echo "$LOG_PREFIX Starting kanata"

# Resolve the logged-in console user (this runs as root in a LaunchDaemon,
# so $HOME is /var/root — derive the real user's config path instead).
KANATA_USER="${KANATA_USER:-$(stat -f%Su /dev/console)}"
exec /opt/homebrew/bin/kanata -c "/Users/${KANATA_USER}/.config/kanata/kanata.kbd" --port 10000

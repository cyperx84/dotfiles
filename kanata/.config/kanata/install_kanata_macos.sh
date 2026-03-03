#!/usr/bin/env bash
# Installs Karabiner DriverKit, Kanata, and sets up LaunchDaemons (no disk logging)

set -euo pipefail

# Color variables
MAGENTA='\033[35m'
RESET='\033[0m'
ARROW="${MAGENTA}==>${RESET}"

#### CONFIGURATION ####
KANATA_CONFIG="${HOME}/.config/kanata/kanata.kbd"
KANATA_PORT=10000
PLIST_DIR="/Library/LaunchDaemons"
# Use Homebrew symlink - survives brew upgrade so TCC permissions persist
# See: https://github.com/jtroo/kanata/discussions/1537
KANATA_BIN="/opt/homebrew/bin/kanata"
###################################

# 1. Fetch & install latest Karabiner DriverKit pkg
echo "Fetching latest Karabiner DriverKit pkg URL..."
DRIVERKIT_PKG_URL=$(
    curl -s "https://api.github.com/repos/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/releases/latest" |
        jq -r '.assets[] | select(.name|endswith(".pkg")) | .browser_download_url'
)
echo "Downloading DriverKit from: $DRIVERKIT_PKG_URL"
curl -L -o /tmp/karabiner-driverkit.pkg "$DRIVERKIT_PKG_URL"
echo "Installing DriverKit..."
sudo installer -pkg /tmp/karabiner-driverkit.pkg -target /
rm -f /tmp/karabiner-driverkit.pkg

# 2. Install Kanata via Homebrew if not present
brew list kanata >/dev/null 2>&1 || brew install kanata

# 3. Verify Homebrew kanata is available
if [ ! -f "${KANATA_BIN}" ] && [ ! -L "${KANATA_BIN}" ]; then
    echo -e "${ARROW} ERROR: Kanata not found at ${KANATA_BIN}"
    echo "  Install with: brew install kanata"
    exit 1
fi
echo -e "${ARROW} Using kanata at: ${KANATA_BIN} ($(readlink -f ${KANATA_BIN}))"

# 3. Write plist files
# Uses bash wrapper with 5s delay so Karabiner DriverKit can initialize on boot
# Uses Homebrew symlink so Input Monitoring permissions survive brew upgrade
sudo tee "${PLIST_DIR}/com.example.kanata.plist" >/dev/null <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
  <key>Label</key><string>com.example.kanata</string>
  <key>ProgramArguments</key><array>
    <string>/bin/bash</string>
    <string>-c</string>
    <string>sleep 5 &amp;&amp; exec ${KANATA_BIN} -c ${KANATA_CONFIG} --port ${KANATA_PORT}</string>
  </array>
  <key>RunAtLoad</key><true/>
  <key>KeepAlive</key><true/>
  <key>ThrottleInterval</key><integer>5</integer>
  <key>StandardOutPath</key><string>/tmp/kanata.out.log</string>
  <key>StandardErrorPath</key><string>/tmp/kanata.err.log</string>
</dict></plist>
EOF
sudo chown root:wheel "${PLIST_DIR}/com.example.kanata.plist"
sudo chmod 644 "${PLIST_DIR}/com.example.kanata.plist"

sudo tee "${PLIST_DIR}/com.example.karabiner-vhiddaemon.plist" >/dev/null <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
  <key>Label</key><string>com.example.karabiner-vhiddaemon</string>
  <key>ProgramArguments</key><array>
    <string>/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon</string>
  </array>
  <key>RunAtLoad</key><true/>
  <key>KeepAlive</key><true/>
</dict></plist>
EOF
sudo chown root:wheel "${PLIST_DIR}/com.example.karabiner-vhiddaemon.plist"
sudo chmod 644 "${PLIST_DIR}/com.example.karabiner-vhiddaemon.plist"

sudo tee "${PLIST_DIR}/com.example.karabiner-vhidmanager.plist" >/dev/null <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
  <key>Label</key><string>com.example.karabiner-vhidmanager</string>
  <key>ProgramArguments</key><array>
    <string>/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager</string>
    <string>activate</string>
  </array>
  <key>RunAtLoad</key><true/>
</dict></plist>
EOF
sudo chown root:wheel "${PLIST_DIR}/com.example.karabiner-vhidmanager.plist"
sudo chmod 644 "${PLIST_DIR}/com.example.karabiner-vhidmanager.plist"

# 4. Bootstrap and enable services
# Kanata
sudo launchctl bootout system "${PLIST_DIR}/com.example.kanata.plist" 2>/dev/null || true
sudo launchctl bootstrap system "${PLIST_DIR}/com.example.kanata.plist"
sudo launchctl enable system/com.example.kanata

# Karabiner-VHIDDaemon
sudo launchctl bootout system "${PLIST_DIR}/com.example.karabiner-vhiddaemon.plist" 2>/dev/null || true
sudo launchctl bootstrap system "${PLIST_DIR}/com.example.karabiner-vhiddaemon.plist"
sudo launchctl enable system/com.example.karabiner-vhiddaemon

# Karabiner-VHIDManager
sudo launchctl bootout system "${PLIST_DIR}/com.example.karabiner-vhidmanager.plist" 2>/dev/null || true
sudo launchctl bootstrap system "${PLIST_DIR}/com.example.karabiner-vhidmanager.plist"
sudo launchctl enable system/com.example.karabiner-vhidmanager

# 5. Prompt for permissions
echo -e "${ARROW} You'll now allow Karabiner to use a system extension."
echo -e "On the next screen, approve the extension when prompted."
read -rp "Press Enter to open System Extensions..."
open "x-apple.systempreferences:com.apple.LoginItems-Settings.extension"
echo
read -rp "Press Enter once you're done..."
echo

echo -e "${ARROW} You'll now add Kanata to Accessibility settings."
echo -e "On the next screen:"
echo -e "- Click '+' to add a new item"
echo -e "- Press Shift+Command+G and enter ${MAGENTA}/opt/homebrew/bin${RESET}"
echo -e "- Select the ${MAGENTA}kanata${RESET} binary"
echo -e ""
echo -e "${ARROW} IMPORTANT: Always use ${MAGENTA}/opt/homebrew/bin/kanata${RESET} (the Homebrew symlink)"
echo -e "  This path survives brew upgrades so you won't lose permissions."
read -rp "Press Enter to open Accessibility settings..."
open "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility"
echo
read -rp "Press Enter once you're done..."
echo

echo -e "${ARROW} Now add Kanata to Input Monitoring as well."
echo -e "Same path: ${MAGENTA}/opt/homebrew/bin/kanata${RESET}"
echo -e "- Click '+', press Shift+Command+G, enter ${MAGENTA}/opt/homebrew/bin${RESET}"
echo -e "- Select the ${MAGENTA}kanata${RESET} binary"
read -rp "Press Enter to open Input Monitoring settings..."
open "x-apple.systempreferences:com.apple.preference.security?Privacy_ListenEvent"
echo
read -rp "Press Enter once you're done..."
echo

echo "Kanata and Karabiner services are now installed and enabled."
echo ""
echo -e "${ARROW} NOTE: If kanata stops working after 'brew upgrade kanata':"
echo -e "  1. Go to System Settings → Privacy & Security → Input Monitoring"
echo -e "  2. Remove kanata, then re-add ${MAGENTA}/opt/homebrew/bin/kanata${RESET}"
echo -e "  3. Run: sudo launchctl kickstart -k system/com.example.kanata"

#!/bin/bash
set -euo pipefail

# Comprehensive fix for MacBook Pro T2 (15,3) lid close & suspend issues
# Run with: sudo bash ~/fix-suspend.sh

if [[ $EUID -ne 0 ]]; then
  echo "Run this script with sudo: sudo bash ~/fix-suspend.sh"
  exit 1
fi

OMARCHY_PATH="/home/cyperx/.local/share/omarchy"

echo "=== Step 1: Fix NVMe d3cold suspend service ==="

# Fix: remove the backslash escaping that causes systemd warnings
tee /etc/systemd/system/omarchy-nvme-suspend-fix.service >/dev/null <<'EOF'
[Unit]
Description=Omarchy NVMe Suspend Fix for MacBook

[Service]
Type=oneshot
ExecStart=/bin/bash -c 'echo 0 > /sys/bus/pci/devices/0000:04:00.0/d3cold_allowed'

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable --now omarchy-nvme-suspend-fix.service
echo "d3cold_allowed = $(cat /sys/bus/pci/devices/0000:04:00.0/d3cold_allowed)"

echo ""
echo "=== Step 2: Add apple_bce suspend/resume handling ==="

# T2 Macs need apple_bce unloaded before suspend and reloaded after.
# Without this, apple_bce crashes on resume with bce_vhci_drop_endpoint page faults.
# Using a systemd service with Before=sleep.target (recommended by t2linux wiki)
# instead of /etc/systemd/system-sleep/ hooks (which systemd 259 only reads from
# /usr/lib/systemd/system-sleep/).
# Requires CONFIG_MODULE_FORCE_UNLOAD=y (confirmed in our kernel).

# Remove old broken hook if present
rm -f /etc/systemd/system-sleep/t2-suspend.sh

# Helper script: switches Touch Bar USB device to DRM mode (config 2)
# Required because the udev rule that sets bConfigurationValue=2 only fires on
# ACTION=="add" (boot/plug), not after suspend/resume.
tee /usr/local/bin/touchbar-set-drm-mode.sh >/dev/null <<'EOF'
#!/bin/bash
# Find Touch Bar Display USB device (05ac:8302) and switch to DRM mode (config 2)
for dev in /sys/bus/usb/devices/*/; do
    vendor=$(cat "${dev}idVendor" 2>/dev/null)
    product=$(cat "${dev}idProduct" 2>/dev/null)
    if [ "$vendor" = "05ac" ] && [ "$product" = "8302" ]; then
        echo 0 > "${dev}bConfigurationValue"
        sleep 1
        echo 2 > "${dev}bConfigurationValue"
        exit 0
    fi
done
echo "touchbar-set-drm-mode: Touch Bar USB device (05ac:8302) not found" >&2
exit 1
EOF
chmod +x /usr/local/bin/touchbar-set-drm-mode.sh
echo "Created /usr/local/bin/touchbar-set-drm-mode.sh"

# apple_bce + Touch Bar suspend service
# Pre-suspend (ExecStart): tears down full Touch Bar stack then apple-bce
# Post-resume (ExecStop): reloads apple-bce, switches TB to DRM mode, reloads stack
tee /etc/systemd/system/suspend-fix-t2.service >/dev/null <<'EOF'
[Unit]
Description=Unload apple-bce and Touch Bar stack before suspend, restore on resume
Before=sleep.target
StopWhenUnneeded=yes

[Service]
User=root
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/systemctl stop tiny-dfr.service
ExecStart=/usr/bin/modprobe -r appletbdrm
ExecStart=/usr/bin/modprobe -r hid_appletb_kbd
ExecStart=/usr/bin/modprobe -r hid_appletb_bl
ExecStart=/usr/bin/rmmod -f apple-bce
ExecStop=/usr/bin/modprobe apple-bce
ExecStop=/usr/bin/sleep 4
ExecStop=/usr/local/bin/touchbar-set-drm-mode.sh
ExecStop=/usr/bin/sleep 2
ExecStop=/usr/bin/modprobe hid_appletb_bl
ExecStop=/usr/bin/sleep 1
ExecStop=/usr/bin/modprobe hid_appletb_kbd
ExecStop=/usr/bin/sleep 1
ExecStop=/usr/bin/modprobe appletbdrm
ExecStop=/usr/bin/sleep 3
ExecStop=/usr/bin/udevadm settle --timeout=10
ExecStop=/usr/bin/systemctl start tiny-dfr.service

[Install]
WantedBy=sleep.target
EOF
systemctl daemon-reload
systemctl enable suspend-fix-t2.service
echo "Created and enabled suspend-fix-t2.service"

# brcmfmac (WiFi) suspend service — known resume issues on T2
tee /etc/systemd/system/suspend-fix-wifi.service >/dev/null <<'EOF'
[Unit]
Description=Unload brcmfmac before suspend and reload on resume
Before=sleep.target
After=suspend-fix-t2.service
StopWhenUnneeded=yes

[Service]
User=root
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/modprobe -r brcmfmac
ExecStop=/usr/bin/modprobe brcmfmac

[Install]
WantedBy=sleep.target
EOF
systemctl daemon-reload
systemctl enable suspend-fix-wifi.service
echo "Created and enabled suspend-fix-wifi.service"

# Ensure appletbdrm (Touch Bar display driver) loads at boot
if ! grep -q appletbdrm /etc/modules-load.d/*.conf 2>/dev/null; then
  echo "appletbdrm" >> /etc/modules-load.d/apple-bce.conf
  echo "Added appletbdrm to modules-load"
fi

echo ""
echo "=== Step 3: Fix mkinitcpio resume hook position ==="

# The resume hook must come AFTER encrypt but BEFORE filesystems
# Currently it's appended at the end via HOOKS+=(resume), which is wrong
# Fix: override the full HOOKS line with resume in the correct position
MKINITCPIO_CONF="/etc/mkinitcpio.conf.d/omarchy_resume.conf"
mkdir -p /etc/mkinitcpio.conf.d

# Insert resume after encrypt, before filesystems
cat > "$MKINITCPIO_CONF" <<'EOF'
# Override HOOKS to insert resume after encrypt and before filesystems
# Original: base udev autodetect microcode modconf kms keyboard keymap consolefont block encrypt filesystems fsck
HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block encrypt resume filesystems fsck)
EOF
echo "Fixed hook order: ...encrypt resume filesystems..."

echo ""
echo "=== Step 4: Configure hibernation swap ==="

SWAP_SUBVOLUME="/swap"
SWAP_FILE="$SWAP_SUBVOLUME/swapfile"

# Create btrfs subvolume for swap
if ! btrfs subvolume show "$SWAP_SUBVOLUME" &>/dev/null; then
  echo "Creating Btrfs subvolume"
  btrfs subvolume create "$SWAP_SUBVOLUME"
  chattr +C "$SWAP_SUBVOLUME"
fi

# Create swapfile
if ! swaplabel "$SWAP_FILE" &>/dev/null; then
  echo "Creating swapfile in Btrfs subvolume"
  MEM_TOTAL_KB="$(awk '/MemTotal/ {print $2}' /proc/meminfo)k"
  btrfs filesystem mkswapfile -s "$MEM_TOTAL_KB" "$SWAP_FILE"
fi

# Add swapfile to fstab
if ! grep -Fq "$SWAP_FILE" /etc/fstab; then
  echo "Adding swapfile to /etc/fstab"
  cp -a /etc/fstab "/etc/fstab.$(date +%Y%m%d%H%M%S).back"
  printf "\n# Btrfs swapfile for system hibernation\n%s none swap defaults,pri=0 0 0\n" "$SWAP_FILE" >> /etc/fstab
fi

# Enable swap
if ! swapon --show | grep -q "$SWAP_FILE"; then
  echo "Enabling swap on $SWAP_FILE"
  swapon -p 0 "$SWAP_FILE"
fi

echo ""
echo "=== Step 5: Add resume= and resume_offset= to kernel cmdline ==="

# Get the resume offset for the btrfs swapfile
RESUME_OFFSET=$(btrfs inspect-internal map-swapfile -r "$SWAP_FILE")
echo "Swapfile resume offset: $RESUME_OFFSET"

# The resume device is the unlocked LUKS container
RESUME_DEVICE="/dev/mapper/root"

# Use limine-entry-tool drop-in config (the proper way — editing limine.conf
# directly gets overwritten by limine-mkinitcpio)
RESUME_DROPIN="/etc/limine-entry-tool.d/resume.conf"
cat > "$RESUME_DROPIN" <<EOF
# Hibernation resume parameters for btrfs swapfile
KERNEL_CMDLINE[default]+="resume=${RESUME_DEVICE} resume_offset=${RESUME_OFFSET}"
EOF
echo "Created $RESUME_DROPIN"
cat "$RESUME_DROPIN"

echo ""
echo "=== Step 6: Configure suspend-then-hibernate ==="

mkdir -p /etc/systemd/logind.conf.d /etc/systemd/sleep.conf.d
cp "$OMARCHY_PATH/default/systemd/lid.conf" /etc/systemd/logind.conf.d/

# Override omarchy default (30min) with shorter delay for T2 MacBook.
# T2 suspend draws significant power due to apple-bce firmware, so hibernate
# quickly to preserve battery.
cat > /etc/systemd/sleep.conf.d/hibernate.conf <<'EOF'
[Sleep]
HibernateDelaySec=5min
HibernateOnACPower=no
EOF
echo "logind: HandleLidSwitch=suspend-then-hibernate"
echo "sleep: HibernateDelaySec=5min"

echo ""
echo "=== Step 7: Regenerate initramfs ==="

limine-mkinitcpio

echo ""
echo "=== Step 8: Patch resume params into limine.conf cmdline ==="

# limine-entry-tool --add-uki doesn't apply KERNEL_CMDLINE drop-ins to the
# cmdline in limine.conf (UKI+snapper mode uses --no-cmdline and preserves
# the existing cmdline). So we patch it directly AFTER limine-mkinitcpio.
LIMINE_CONF="/boot/limine.conf"
RESUME_PARAMS="resume=${RESUME_DEVICE} resume_offset=${RESUME_OFFSET}"

if ! grep -q "resume=" "$LIMINE_CONF"; then
  sed -i "/^  cmdline:.*rootfstype=btrfs/s|rootfstype=btrfs|rootfstype=btrfs ${RESUME_PARAMS}|" "$LIMINE_CONF"
  echo "Patched limine.conf with: $RESUME_PARAMS"
else
  echo "resume= already present in limine.conf"
fi

# amdgpu fixes for Vega 20 suspend/resume (t2linux wiki recommended):
# - dcdebugmask=0x10: disable Panel Self Refresh (fixes post-resume flicker)
# - dpm=0: disable Dynamic Power Management (fixes Vega 20 resume crashes)
# - runpm=0: disable runtime power management (prevents deep sleep recovery issues)
AMDGPU_PARAMS="amdgpu.dcdebugmask=0x10 amdgpu.dpm=0 amdgpu.runpm=0"
for param in $AMDGPU_PARAMS; do
  key="${param%%=*}"
  if ! grep -q "$key" "$LIMINE_CONF"; then
    sed -i "/^  cmdline:/s|$| ${param}|" "$LIMINE_CONF"
    echo "Patched limine.conf with: $param"
  else
    echo "$key already present in limine.conf"
  fi
done

grep "^  cmdline:" "$LIMINE_CONF" | head -1

echo ""
echo "=== Verification ==="
echo ""
echo "d3cold_allowed = $(cat /sys/bus/pci/devices/0000:04:00.0/d3cold_allowed)"
echo ""
echo "NVMe service:"
systemctl status omarchy-nvme-suspend-fix.service --no-pager 2>&1 | head -8 || true
echo ""
echo "T2 suspend services:"
systemctl is-enabled suspend-fix-t2.service suspend-fix-wifi.service 2>&1 || true
echo ""
echo "mkinitcpio hooks:"
grep "^HOOKS=" "$MKINITCPIO_CONF"
echo ""
echo "Kernel cmdline drop-ins:"
cat /etc/limine-entry-tool.d/*.conf
echo ""
echo "Swap:"
swapon --show
echo ""
echo "/sys/power/resume = $(cat /sys/power/resume)"
echo "/sys/power/resume_offset = $(cat /sys/power/resume_offset)"
echo ""
echo "NOTE: resume= and resume_offset= take effect after reboot."
echo ""
echo "=== Done! Reboot recommended, then test lid close. ==="

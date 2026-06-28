#!/bin/bash
set -euo pipefail

# Set up automated system maintenance for Arch Linux T2 MacBook
# Run with: sudo bash ~/dotfiles/scripts/setup-maintenance.sh

if [[ $EUID -ne 0 ]]; then
  echo "Run with sudo: sudo bash ~/dotfiles/scripts/setup-maintenance.sh"
  exit 1
fi

echo "=== 1. Install maintenance tools ==="
pacman -S --noconfirm --needed pacman-contrib reflector

echo ""
echo "=== 2. Enable weekly SSD TRIM ==="
systemctl enable --now fstrim.timer

echo ""
echo "=== 3. Configure reflector (mirror optimization) ==="
mkdir -p /etc/xdg/reflector
cat > /etc/xdg/reflector/reflector.conf <<'EOF'
--country Australia
--protocol https
--sort rate
--latest 10
--save /etc/pacman.d/mirrorlist
EOF
systemctl enable --now reflector.timer

echo ""
echo "=== 4. Set up pacman cache auto-cleanup ==="
mkdir -p /etc/pacman.d/hooks
cat > /etc/pacman.d/hooks/clean_cache.hook <<'EOF'
[Trigger]
Operation = Upgrade
Operation = Install
Operation = Remove
Type = Package
Target = *

[Action]
Description = Cleaning pacman cache...
When = PostTransaction
Exec = /usr/bin/paccache -r
EOF

echo ""
echo "=== 5. Set journal size limit ==="
mkdir -p /etc/systemd/journald.conf.d
cat > /etc/systemd/journald.conf.d/size.conf <<'EOF'
[Journal]
SystemMaxUse=200M
EOF
journalctl --vacuum-size=200M

echo ""
echo "=== 6. Set makepkg parallelism ==="
if ! grep -q '^MAKEFLAGS="-j\$(nproc)"' /etc/makepkg.conf; then
  if grep -q '^#MAKEFLAGS' /etc/makepkg.conf; then
    sed -i 's/^#MAKEFLAGS.*/MAKEFLAGS="-j$(nproc)"/' /etc/makepkg.conf
  else
    echo 'MAKEFLAGS="-j$(nproc)"' >> /etc/makepkg.conf
  fi
  echo "Set MAKEFLAGS to use all cores"
else
  echo "MAKEFLAGS already set"
fi

echo ""
echo "=== Verification ==="
echo "fstrim.timer:    $(systemctl is-enabled fstrim.timer)"
echo "reflector.timer: $(systemctl is-enabled reflector.timer)"
echo "pacman hook:     $(ls /etc/pacman.d/hooks/clean_cache.hook)"
echo "journal limit:   $(cat /etc/systemd/journald.conf.d/size.conf | grep SystemMaxUse)"
echo "journal usage:   $(journalctl --disk-usage)"
grep '^MAKEFLAGS' /etc/makepkg.conf

echo ""
echo "=== Done! ==="

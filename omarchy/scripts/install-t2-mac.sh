#!/usr/bin/env bash
# Extras for T2 MacBooks, on top of what the Omarchy installer already sets up
# there (linux-t2, apple-bcm-firmware, t2fanrd and the arch-mact2 repo; see
# $OMARCHY_PATH/install/hardware/apple/fix-t2.sh). Does nothing on other machines.
set -e

# Same detection Omarchy uses: Apple T2 security chip PCI IDs
if ! lspci -nn | grep -q "106b:180[12]"; then
  echo "Not a T2 Mac, nothing to do."
  exit 0
fi

# t2bce_audio-alsa-ucm-conf: speaker/mic profiles for the t2bce audio driver
# supergfxctl: switch between the Intel iGPU and the AMD dGPU. Its daemon owns
# /etc/supergfxd.conf (rewritten on every mode change), so it is not tracked;
# the default Hybrid mode is the one we use.
omarchy-pkg-add t2bce_audio-alsa-ucm-conf supergfxctl
systemctl is-enabled --quiet supergfxd.service || sudo systemctl enable --now supergfxd.service

#!/usr/bin/env bash
# Extras for T2 MacBooks, on top of what the Omarchy installer already sets up
# there (linux-t2, apple-bcm-firmware, t2fanrd and the arch-mact2 repo; see
# $OMARCHY_PATH/install/hardware/apple/fix-t2.sh). Does nothing on other machines.
set -e
source "$(dirname "$0")/lib.sh"

# Same detection Omarchy uses: Apple T2 security chip PCI IDs
if ! lspci -nn | grep -q "106b:180[12]"; then
  echo "Not a T2 Mac, nothing to do."
  exit 0
fi

# t2bce_audio-alsa-ucm-conf: speaker/mic profiles for the t2bce audio driver
# lsp-plugins-lv2: safety limiters in "Speakers"; compressor/limiter/loudness in
# the "Speakers (DSP)" sink
# supergfxctl: switch between the Intel iGPU and the AMD dGPU. Its daemon owns
# /etc/supergfxd.conf (rewritten on every mode change), so it is not tracked;
# the default Hybrid mode is the one we use.
omarchy-pkg-add t2bce_audio-alsa-ucm-conf lsp-plugins-lv2 supergfxctl
systemctl is-enabled --quiet supergfxd.service || sudo systemctl enable --now supergfxd.service

# "Speakers" sink: L/R on the tweeters, mono bass on the left woofer, since the
# right woofer is silent (see t2-audio/.config/pipewire/pipewire.conf.d/90-t2-speakers.conf)
if [[ $(cat /sys/class/dmi/id/product_name) == MacBookPro15,3 ]]; then
  speakers=$HOME/.config/pipewire/pipewire.conf.d/90-t2-speakers.conf
  [[ -L $speakers ]] && linked=1 || linked=0
  stow_package t2-audio --no-folding
  ((linked)) || systemctl --user restart pipewire pipewire-pulse wireplumber
fi

# Hardware video decode: the AMD dGPU has no VP9 or AV1 decoder, so Zen asks
# YouTube for H.264 (see scripts/t2-zen-user.js). Profile directories are named
# at random, so link the prefs into each one instead of stowing them.
for profile in "$HOME"/.config/zen/*/; do
  [[ -f $profile/prefs.js ]] || continue
  ln -sfn "$OMARCHY_DIR/scripts/t2-zen-user.js" "$profile/user.js"
done

# Chromium and Chrome decode through VA-API only with these features on.
# Chromium honours just the last --enable-features, so extend Omarchy's line.
for flags in "$HOME"/.config/chromium-flags.conf "$HOME"/.config/chrome-flags.conf; do
  [[ -f $flags ]] || continue
  grep -q AcceleratedVideoDecodeLinuxGL "$flags" ||
    sed -i '/^--enable-features=/s/$/,AcceleratedVideoDecodeLinuxGL,AcceleratedVideoDecodeLinuxZeroCopyGL,AcceleratedVideoEncoder/' "$flags"
done

# BD PROCHOT: the SMC sometimes throttles the CPU to 800 MHz at normal temps
# (charger/battery events). A root timer clears it; these are system units, so
# they are installed into /etc rather than stowed.
omarchy-pkg-add msr-tools
sudo install -Dm755 "$OMARCHY_DIR/t2-prochot/t2-clear-prochot" /usr/local/bin/t2-clear-prochot
sudo install -Dm644 -t /etc/systemd/system "$OMARCHY_DIR"/t2-prochot/t2-clear-prochot.{service,timer}
sudo systemctl daemon-reload
sudo systemctl enable --now t2-clear-prochot.timer

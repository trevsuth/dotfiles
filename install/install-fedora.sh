#!/usr/bin/env bash
set -euo pipefail

packages=(
  sway
  waybar
  rofi
  alacritty
  wezterm
  fish
  ripgrep
  fzf
  git
  grim
  slurp
  wl-clipboard
  libnotify
  mako
  swaylock
  swayidle
  playerctl
  pulseaudio-utils
)

echo "Installing Fedora packages: ${packages[*]}"
sudo dnf install -y "${packages[@]}"
echo "Done."

#!/usr/bin/env bash
set -euo pipefail

packages=(
  sway
  waybar
  rofi
  alacritty
  fish
  ripgrep
  fzf
  git
  grim
  slurp
  wl-clipboard
  libnotify-bin
  mako-notifier
  swaylock
  swayidle
  playerctl
  pulseaudio-utils
)

echo "Updating apt and installing: ${packages[*]}"
sudo apt update
sudo apt install -y "${packages[@]}"

cat <<'NOTE'
wezterm is not in Ubuntu's default repos. Install from:
  https://wezfurlong.org/wezterm/installation.html#ubuntu
NOTE
echo "Done."

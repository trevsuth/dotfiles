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
)

echo "Installing Fedora packages: ${packages[*]}"
sudo dnf install -y "${packages[@]}"
echo "Done."

#!/usr/bin/env bash
set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Install from https://brew.sh first." >&2
  exit 1
fi

brew update
brew install ripgrep fzf git fish neovim stow
brew install --cask wezterm alacritty

cat <<'NOTE'
Sway/Waybar are Linux-only; skip on macOS. If you need a launcher, consider
`brew install --cask raycast` or stick with the default Spotlight.
NOTE
echo "Done."

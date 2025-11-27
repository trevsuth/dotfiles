#!/usr/bin/env bash
# Simple Wayland screenshot helper for sway: full screen by default, region with -s.
set -euo pipefail

out_dir="${XDG_PICTURES_DIR:-"$HOME/Pictures"}/Screenshots"
mkdir -p "$out_dir"

timestamp="$(date +%Y-%m-%d_%H-%M-%S)"
outfile="$out_dir/screenshot-$timestamp.png"

region=false
if [[ ${1:-} == "-s" ]]; then
  region=true
fi

if $region; then
  selection="$(slurp)"
  grim -g "$selection" "$outfile"
else
  grim "$outfile"
fi

if command -v wl-copy >/dev/null 2>&1; then
  wl-copy < "$outfile"
fi

if command -v notify-send >/dev/null 2>&1; then
  notify-send "Screenshot saved" "$outfile"
fi

#!/usr/bin/env bash

# Minimal Waybar music script using playerctl.
# Outputs nothing if no player is active.

status=$(playerctl status 2>/dev/null) || exit 0

case "$status" in
  Playing|Paused)
    artist=$(playerctl metadata artist 2>/dev/null)
    title=$(playerctl metadata title 2>/dev/null)
    if [ -n "$artist" ] && [ -n "$title" ]; then
      echo "$artist - $title"
    elif [ -n "$title" ]; then
      echo "$title"
    else
      echo ""
    fi
    ;;
  *)
    echo ""
    ;;
esac

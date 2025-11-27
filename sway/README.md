# Sway Config Overview

This directory mirrors `~/.config/sway`.

## Contents
- `config` – main sway configuration (imports themes, binds keys, launches Waybar, etc.).
- `config.d/` – upstream systemd integration snippets from Fedora.
- `scripts/` – small helpers referenced by keybindings:
  - `screen.sh` – screenshots with `grim` (full screen) or `grim -g $(slurp)` when run with `-s`; copies to clipboard via `wl-copy` and notifies if available.
  - `volume` – `pactl`-based volume up/down/mute; ignores extra flags left over from older scripts so existing keybinds keep working; optional notification.
  - `cwd-term.sh` – prints the current working directory for the “launch terminal in cwd” binding.
- `themes/` – color/theme includes (e.g., `expanse_hud`).

## Dependencies
Install alongside sway to avoid missing-command errors when bindings fire:
- `grim`, `slurp`, `wl-clipboard` (for screenshots + clipboard copy)
- `mako` (notifications used by scripts), `swaylock`, `swayidle`
- `pipewire-pulse` or PulseAudio with `pactl` available (volume control)
- `playerctl` (media keys)

## Notes
- Waybar is started from `bar { swaybar_command waybar }`; `exec_always pkill -x waybar` prevents duplicate instances when a user service already runs Waybar.
- Theme is included near the top of `config` (`include ~/.config/sway/themes/expanse_hud`). Change that line to swap themes.

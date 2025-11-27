# Dotfiles

This repo centralizes my desktop configs (sway, waybar, rofi, alacritty, wezterm, nvim-mini, fish) plus `.bashrc`. Live locations are symlinked from `~/Code/dotfiles` so edits here take effect immediately.

## Layout
- `sway/`, `waybar/`, `rofi/`, `alacritty/`, `wezterm/`, `nvim-mini/`, `fish/` — mirrors of `~/.config/*`.
- `.bashrc` — symlinked to `~/.bashrc`.
- `install/bootstrap.sh` — idempotent symlink + backup helper.
- `AGENTS.md` — contributor notes.

## Quick Start
```bash
git clone git@github.com:<user>/dotfiles.git ~/Code/dotfiles
cd ~/Code/dotfiles
# Dry run to see actions:
install/bootstrap.sh --dry-run
# Link everything:
install/bootstrap.sh
# Link a subset:
install/bootstrap.sh --only sway,waybar
```
The script links each item into `~/.config/...` (and `.bashrc` into `$HOME`). If a target exists, it is moved to `~/.config/dotfiles-backups/<timestamp>/` before linking.

## Packages to Install
- Fedora: `install/install-fedora.sh`
- Ubuntu: `install/install-ubuntu.sh` (WezTerm requires the upstream repo; see script note.)
- macOS: `install/install-macos.sh` (skips Sway/Waybar; installs terminal tools and shells)

### Sway helper dependencies
Install these with your package manager so sway keybinds don’t break:
- `grim`, `slurp`, `wl-clipboard` (screenshots + clipboard copy)
- `mako`, `swayidle`, `swaylock` (notifications/lock/idle)
- `playerctl` (media keys)
- `pactl` via PipeWire/PulseAudio (`pipewire-pulse` or `pulseaudio-utils`) for volume control

## Themes
- Sway: themes live in `sway/themes/`. To try the Expanse HUD variant, set `include ~/.config/sway/themes/expanse_hud` near the top of `sway/config`.
- Waybar: point `style.css` to the theme you want, e.g. `ln -sf expanse-hud.css ~/.config/waybar/style.css`.

## Adding/Updating Configs
1) Place the config inside this repo following the XDG-ish layout (e.g., add `kitty` as `kitty/` for `~/.config/kitty`).
2) Run `install/bootstrap.sh` to refresh symlinks and back up any live files.
3) Verify with `ls -l ~/.config/<name>`; it should point into `~/Code/dotfiles/<name>`.

## Editing & Testing
- Edit files directly in this repo; the symlinked locations stay current.
- For shell scripts, run `shellcheck bin/*.sh` if applicable.
- For nvim configs, launch `nvim --clean -u nvim-mini/init.lua` to validate.
- For sway/waybar/rofi, reload with their native commands (`swaymsg reload`, etc.) after edits.

## Git Workflow
- Conventional commits recommended (`feat:`, `fix:`, `chore:`).
- Keep commits focused; avoid committing machine-specific secrets. If needed, add ignored overrides (e.g., `private/` or `.env.local` outside this repo).

## Fedora & Portability Notes
- Prefer distro-agnostic commands and paths (`$HOME`, `$XDG_CONFIG_HOME`); avoid hard-coded package names.
- If adding package lists, note the Fedora package name and an upstream alternative (e.g., `dnf install sway` / `pacman -S sway`).

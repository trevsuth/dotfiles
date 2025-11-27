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
install/bootstrap.sh
```
The script links each item into `~/.config/...` (and `.bashrc` into `$HOME`). If a target exists, it is moved to `~/.config/dotfiles-backups/<timestamp>/` before linking.

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

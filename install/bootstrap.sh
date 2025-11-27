#!/usr/bin/env bash
# Symlink dotfiles from this repo into the live locations.
# Usage: bootstrap.sh [--dry-run|-n] [--only name[,name...]] [--help]
set -euo pipefail

repo_root="$(cd -- "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
timestamp="$(date +%Y%m%d-%H%M%S)"
backup_root="$HOME/.config/dotfiles-backups/$timestamp"
dry_run=false
filters=()

usage() {
  cat <<'EOF'
Usage: bootstrap.sh [OPTIONS]
  --dry-run | -n      Show actions without changing files
  --only <names>      Comma/space-separated list (e.g., sway,waybar,.bashrc)
  --help              Show this help
EOF
}

items=(
  "sway:.config/sway"
  "waybar:.config/waybar"
  "rofi:.config/rofi"
  "alacritty:.config/alacritty"
  "wezterm:.config/wezterm"
  "nvim-mini:.config/nvim-mini"
  "fish:.config/fish"
  ".bashrc:.bashrc"
)

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run|-n) dry_run=true ;;
    --only)
      shift || { echo "--only requires a value" >&2; exit 1; }
      IFS=' ,'; read -ra parts <<<"${1//,/ }"
      filters+=("${parts[@]}")
      ;;
    --help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage; exit 1 ;;
  esac
  shift || true
done

should_process() {
  local name="$1"
  if [[ ${#filters[@]} -eq 0 ]]; then
    return 0
  fi
  for f in "${filters[@]}"; do
    [[ "$f" == "$name" ]] && return 0
  done
  return 1
}

link_item() {
  local name="$1" rel_target="$2"
  local src="$repo_root/$name"
  local dest="$HOME/$rel_target"

  if [[ ! -e "$src" ]]; then
    echo "Skipping $name (source missing at $src)" >&2
    return
  fi

  local existing="none"
  if [[ -L "$dest" ]]; then
    existing="symlink"
  elif [[ -e "$dest" ]]; then
    existing="file"
  fi

  if $dry_run; then
    case "$existing" in
      none) echo "DRY-RUN: would link $dest -> $src" ;;
      symlink) echo "DRY-RUN: would replace symlink at $dest (backup to $backup_root/$rel_target)" ;;
      file) echo "DRY-RUN: would move $dest to $backup_root/$rel_target and link" ;;
    esac
    return
  fi

  mkdir -p "$(dirname "$dest")"

  if [[ "$existing" != "none" ]]; then
    mkdir -p "$backup_root/$(dirname "$rel_target")"
    mv "$dest" "$backup_root/$rel_target"
  fi

  ln -sfn "$src" "$dest"
  echo "Linked $dest -> $src"
}

if ! $dry_run; then
  mkdir -p "$backup_root"
fi

for entry in "${items[@]}"; do
  IFS=":" read -r name rel_target <<<"$entry"
  should_process "$name" || continue
  link_item "$name" "$rel_target"
done

echo "Done. Backups (if any) stored in $backup_root"

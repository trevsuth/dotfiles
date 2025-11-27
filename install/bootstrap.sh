#!/usr/bin/env bash
# Symlink dotfiles from this repo into the live locations.
set -euo pipefail

repo_root="$(cd -- \"$(dirname \"${BASH_SOURCE[0]}\")/..\" && pwd)"
timestamp=\"$(date +%Y%m%d-%H%M%S)\"
backup_root=\"$HOME/.config/dotfiles-backups/$timestamp\"

items=(
  \"sway:.config/sway\"
  \"waybar:.config/waybar\"
  \"rofi:.config/rofi\"
  \"alacritty:.config/alacritty\"
  \"wezterm:.config/wezterm\"
  \"nvim-mini:.config/nvim-mini\"
  \"fish:.config/fish\"
  \".bashrc:.bashrc\"
)

link_item() {
  local name=\"$1\" rel_target=\"$2\"
  local src=\"$repo_root/$name\"
  local dest=\"$HOME/$rel_target\"

  if [[ ! -e \"$src\" ]]; then
    echo \"Skipping $name (source missing at $src)\" >&2
    return
  fi

  mkdir -p \"$(dirname \"$dest\")\"

  if [[ -L \"$dest\" ]]; then
    # If it already points at us, we're done.
    if [[ \"$(readlink -f \"$dest\")\" == \"$src\" ]]; then
      echo \"OK: $dest already points to repo\"
      return
    fi
    # Otherwise back it up before replacing.
    mkdir -p \"$backup_root/$(dirname \"$rel_target\")\"
    mv \"$dest\" \"$backup_root/$rel_target\"
  elif [[ -e \"$dest\" ]]; then
    mkdir -p \"$backup_root/$(dirname \"$rel_target\")\"
    mv \"$dest\" \"$backup_root/$rel_target\"
  fi

  ln -sfn \"$src\" \"$dest\"
  echo \"Linked $dest -> $src\"
}

mkdir -p \"$backup_root\"

for entry in \"${items[@]}\"; do
  IFS=\":\" read -r name rel_target <<<\"$entry\"
  link_item \"$name\" \"$rel_target\"
done

echo \"Done. Backups (if any) stored in $backup_root\"

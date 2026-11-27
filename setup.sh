#!/bin/bash
set -euo pipefail # no command output

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_BIN_SRC="$SCRIPT_DIR/local/bin"
LOCAL_BIN_DEST="$HOME/.local/bin"

echo -e "Dotfile directory: \e[35m$SCRIPT_DIR\e[0m"

#########################################
# Helper functions
#########################################

confirm() {
    local prompt="$1"
    read -rp "$prompt (y/N): " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}

symlink() {
    local src="$1"
    local dest="$2"

    mkdir -p "$(dirname "$dest")"

    if [[ -L "$dest" && "$(readlink -f "$dest")" == "$(readlink -f "$src")" ]]; then
        echo -e "\e[36m✔\e[0m Already linked: $dest"
        return
    fi

    if [[ -e "$dest" || -L "$dest" ]]; then
        if ! confirm "Overwrite $dest?"; then
            echo -e "\e[31m✖\e[0m Skipping $dest"
            return
        fi
        rm -rf "$dest"
    fi

    ln -s "$src" "$dest"
    echo -e "\e[32m→\e[0m Linked $dest"
}

#########################################
# Dotfile Symlinks
#########################################

configs=(
    "bashrc:$HOME/.bashrc"
    "tmux.conf:$HOME/.tmux.conf"
    "i3:$HOME/.config/i3"
    "gitconfig:$HOME/.gitconfig"
    "nvim:$HOME/.config/nvim"
    "vimrc:$HOME/.vimrc"
    "local/bin:$HOME/.local/bin"
)

echo
for config in "${configs[@]}"; do
  IFS=':' read -r src_file dest_path <<< "$config"
  src_path="$SCRIPT_DIR/$src_file"

  if [[ ! -e "$src_path" ]]; then
      echo -e "\e[31m✖\e[0m Source not found, skipping $src_path"
      continue
  fi

  if confirm "Install $src_file"?; then
      symlink "$src_path" "$dest_path"
  else
      echo -e "\e[31m✖\e[0m Skipping $src_file"
  fi
done

echo -e "\e[32m✔ All requested configs applied ✔\e[0m"

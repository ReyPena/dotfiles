#!/bin/bash

create_link() {
    if [ ! -L "$1" ]; then
        ln -s "$2" "$1"
        echo "Created symlink: $1 -> $2"
    else
        echo "Symlink already exists: $1"
    fi
}

create_link "$HOME/.config/wezterm" "$(pwd)/.config/wezterm"
create_link "$HOME/.config/karabiner" "$(pwd)/.config/karabiner"

exit 0
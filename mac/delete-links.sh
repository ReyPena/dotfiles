#!/bin/bash

delete_link() {
    if [ -L "$1" ]; then
        rm "$1"
        echo "Deleted symlink: $1"
    else
        echo "Symlink does not exist: $1"
    fi
}

delete_link "$HOME/.config/wezterm"
delete_link "$HOME/.config/karabiner"

exit 0
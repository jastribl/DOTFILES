#!/usr/bin/env bash

# Check if we have it already
if [[ $(fc-list | grep -i "Powerline.ttf") ]]; then
    echo "Font already installed"
    exit 0
fi

temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT

git clone https://github.com/powerline/fonts.git --depth=1 "$temp_dir/fonts"
(
    cd "$temp_dir/fonts"
    ./install.sh
)

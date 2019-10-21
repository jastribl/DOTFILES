#!/usr/bin/env bash


# Hacky check to see if we're on a fb machine
if ! which fbclone > /dev/null; then
    echo "Not on FB machine, moving on"
    exit 0
fi

if [[ $(uname -s) == "Darwin" ]]; then
    echo "On OSX, moving on"
    exit 0
fi

apps=(
    the_silver_searcher
    fb-vim
    cmake
)


for app in "${apps[@]}"; do
    if yum list installed "$app" >/dev/null 2>&1; then
        sudo yum upgrade $app
    else
        sudo yum install $app
    fi
done

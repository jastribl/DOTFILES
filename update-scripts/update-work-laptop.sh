#!/usr/bin/env bash


# Hacky check to see if we're on a fb machine
if ! which fbclone > /dev/null; then
    echo "Not on FB machine, moving on"
    exit 0
fi

if [[ $(uname -s) != "Darwin" ]]; then
    echo "Not on OSX, moving on"
    exit 0
fi

# Backup list of VS Code extensions
code-fb --list-extensions --show-versions > dotfiles/vs-code/fb-extensions.txt

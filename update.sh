#!/usr/bin/env bash

if [ "$PWD" != "$HOME/Github/DOTFILES" ]; then
    echo "Update script must be ran from root DOTFILES repo"
    exit 1
fi

usage() { echo "Usage: $0 [-f (force-run-all)]" 1>&2; exit 1; }

force=0

while getopts ":f" o; do
    case "${o}" in
        f)
            force=1
            ;;
        *)
            usage
            ;;
    esac
done

updateScripts=(
    update-submodules.sh
    update-osx.sh
    update-vim.sh
    update-tmux.sh
    update-powerline-fonts.sh
    update-diff-so-fancy.sh
    cleanup-files.sh
)

for updateScript in "${updateScripts[@]}"; do
    run=0
    if [ $force = 1 ]; then
        run=1
    else
        read -p "Would you like to run $updateScript (y/n/q)? " choice
        case "$choice" in
            y|Y ) run=1 ;;
            n|N ) echo "moving on" ;;
            q|Q ) exit ;;
            * ) echo "invalid option" ;;
        esac
    fi

    if [ $run = 1 ]; then
        echo "--- Running $updateScript ---" && ./update-scripts/$updateScript && echo "done"
    fi
done

touch ~/.hushlogin

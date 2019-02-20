#!/usr/bin/env bash

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
    read -p "Would you like to run $updateScript (y/n/q)? " choice
    case "$choice" in
      y|Y ) echo "--- Running $updateScript ---" && ./$updateScript && echo "done" ;;
      n|N ) echo "moving on" ;;
      q|Q ) exit ;;
      * ) echo "invalid option" ;;
    esac
done

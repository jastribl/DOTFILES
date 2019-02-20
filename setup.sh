#!/usr/bin/env bash

installScripts=(
    setup-dotfiles.sh
)

for installScript in "${installScripts[@]}"; do
    read -p "Would you like to run $installScript (y/n/q)? " choice
    case "$choice" in
      y|Y ) echo "running $installScript" && ./$installScript && echo "done" ;;
      n|N ) echo "moving on" ;;
      q|Q ) exit ;;
      * ) echo "invalid option" ;;
    esac
done

# !/bin/bash

installScripts=(
    setup-submodules.sh
    setup-brew.sh
    setup-zsh.sh
    setup-vim.sh
    setup-tmux.sh
    setup-dotfiles.sh
    setup-powerline-fonts.sh
    setup-mac.sh
    setup-sublime.sh
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

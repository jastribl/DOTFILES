#!/usr/bin/env bash


# update vim plugin manager
if which fbclone > /dev/null; then
    env $(fwdproxy-config --format=sh curl) curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install missing plugins
vim +PlugInstall +qall

# Update existing plugins
vim +PlugUpdate +qall

# Clean old plugins
vim +PlugClean! +qall

#!/usr/bin/env bash


if [[ ! -e ~/.vim ]]; then
    ln -s "$PWD/vim" ~/.vim
fi

# update vim plugin manager
curl -fLo vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install missing plugins
vim +PlugInstall +qall

# Update existing plugins
vim +PlugUpdate +qall

# Clean old plugins
vim +PlugClean! +qall


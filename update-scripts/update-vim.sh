#!/usr/bin/env bash


# update vim plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install missing plugins
vim +PlugInstall +qall

# Update existing plugins
vim +PlugUpdate +qall

# Clean old plugins
vim +PlugClean! +qall

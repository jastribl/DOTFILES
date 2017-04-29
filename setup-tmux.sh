# !/bin/bash

if [[ -e ~/.tmux ]]; then
    echo "~/.tmux already exists!"
else
    echo === Checking out Tmux Plugin Manager
    git submodule update --init

    echo === Linking  Tmux Plugin Manager directories
    ln -s "$PWD/tmux" ~/.tmux

    echo === Done
fi

# !/bin/bash

echo "---------- installing tmux stuff ----------"

if [[ -e ~/.tmux ]]; then
    echo "~/.tmux already exists!"
else
    echo === Linking  Tmux Plugin Manager directories
    ln -s "$PWD/tmux" ~/.tmux

    echo === Done
fi

# !/bin/bash

echo "---------- installing vim stuff ----------"

if [[ -e ~/.vim ]]; then
    echo "~/.vim already exists!"
else
    echo === Linking vim directories
    ln -s "$PWD/vim" ~/.vim

    echo === Vundling
    vim +PlugInstall +qall

    echo === Done
fi

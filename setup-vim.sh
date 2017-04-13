# !/bin/bash

if [[ -e ~/.vim ]]; then
    echo "~/.vim already exists!"
else
    echo === Checking out vundle
    git submodule update --init
    cd -

    echo === Linking vim directories
    ln -s "$PWD/vim" ~/.vim

    echo === Vundling
    vim +BundleInstall +qall

    echo === Done
fi

#!/usr/bin/env bash

if [[ -e ~/.oh-my-zsh ]]; then
    echo "~/oh-my-zsh already installed!"
else
    echo "---------- getting oh my zsh ----------"
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

echo "---------- setting default shell to zsh ----------"
chsh -s $(which zsh)

# !/bin/bash

echo "---------- installing stuff ----------"
./setup-installs.sh

echo "---------- installing vim stuff ----------"
./setup-vim.sh

echo "---------- installing dotfiles ----------"
./setup-dotfiles.sh

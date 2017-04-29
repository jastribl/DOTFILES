# !/bin/bash

echo "---------- installing stuff ----------"
./setup-installs.sh

echo "---------- installing vim stuff ----------"
./setup-vim.sh

echo "---------- installing tmux stuff ----------"
./setup-tmux.sh

echo "---------- installing dotfiles ----------"
./setup-dotfiles.sh

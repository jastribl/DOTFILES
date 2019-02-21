#!/usr/bin/env bash

if [[ ! -e ~/.tmux ]]; then
    ln -s "$PWD/tmux" ~/.tmux
fi

# Installs plugins
./tmux/plugins/tpm/scripts/install_plugins.sh

# Updates plugins
./tmux/plugins/tpm/scripts/update_plugin.sh

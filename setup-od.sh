#!/usr/bin/env bash

# Make all dirs!
mkdir -p 'update-scripts/cache/prefs/ssh'

# Set all the things!
printf 'facebook.devserver' > update-scripts/cache/prefs/bashrc.local.pref
printf 'facebook.devserver' > update-scripts/cache/prefs/gitconfig.local.pref
printf 'facebook' > update-scripts/cache/prefs/hgrc.local.pref
printf 'facebook.devserver' > update-scripts/cache/prefs/ssh/config.local.pref
printf 'devserver' > update-scripts/cache/prefs/vimrc-plugins.vim.pref
printf 'facebook' > update-scripts/cache/prefs/vimrc-pre-local.vim.pref

if sed '9!d'  update.sh | grep -q "Update script requires that an ssh key as been generated and added to Github"; then
    if sed '10!d'  update.sh | grep -q "exit 1"; then
        sed -i '10d' update.sh
    fi
fi

# Run Update
./update.sh

# Change to work dir
cd ~/www

# Launch Tmux
tmux

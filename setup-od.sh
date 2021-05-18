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

# Run Update
./update.sh

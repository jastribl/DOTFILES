#!/usr/bin/env bash

if [[ $(uname -s) == "Darwin" ]]; then
    echo "On OSX, moving on"
    exit 0
fi

if [[ ! -e ~/diff-so-fancy ]]; then
    mkdir ~/diff-so-fancy
fi

curl https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy > ~/diff-so-fancy/diff-so-fancy
chmod +x ~/diff-so-fancy/diff-so-fancy

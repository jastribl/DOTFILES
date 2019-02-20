#!/usr/bin/env bash

if [[ ! -e ~/diff-so-fancy ]]; then
    mkdir ~/diff-so-fancy
fi

wget -O ~/diff-so-fancy/diff-so-fancy https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
chmod +x ~/diff-so-fancy/diff-so-fancy

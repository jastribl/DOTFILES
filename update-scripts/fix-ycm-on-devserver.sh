#!/usr/bin/env bash

cd dotfiles/vim/plugged/YouCompleteMe/
env $(fwdproxy-config --format=sh curl) wget -O third_party/ycmd/clang_archives/libclang-8.0.0-x86_64-unknown-linux-gnu.tar.bz2 https://dl.bintray.com/micbou/libclang/libclang-8.0.0-x86_64-unknown-linux-gnu.tar.bz2
./install.py --clang-completer
cd -

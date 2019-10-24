#!/usr/bin/env bash


OUTPUT_PATH="third_party/ycmd/clang_archives/libclang-9.0.0-x86_64-unknown-linux-gnu.tar.bz2"
DOWNLOAD_LINK="https://dl.bintray.com/ycm-core/libclang/libclang-9.0.0-x86_64-unknown-linux-gnu.tar.bz2"

cd dotfiles/vim/plugged/YouCompleteMe/
env $(fwdproxy-config --format=sh curl) wget -O "$OUTPUT_PATH" "$DOWNLOAD_LINK"
./install.py --clang-completer
cd -

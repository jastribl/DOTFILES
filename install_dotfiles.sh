#!/bin/bash

files=".bashrc .vimrc .zshrc .gitconfig"

currentDir=`pwd`
dir="$currentDir/dotfiles"
olddir="$currentDir/dotfiles_old/backup_$(date +%Y-%m-%d:%H:%M:%S)"

mkdir -p $olddir

cd $dir

for file in $files; do
    echo "moving ~/$file to $olddir/"
    mv ~/$file $olddir/
    echo "linking $dir/$file in ~/$file"
    ln -s $dir/$file ~/$file
done

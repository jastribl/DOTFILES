#!/usr/bin/env bash

DOTFILES_DIR="$PWD/dotfiles"
BACKUP_DIR="$PWD/backup_dotfiles/backup_$(date +%Y-%m-%d:%H:%M:%S)"

function backup_dotfile() {
    existing_dotfile=~/.$1
    if [ -L $existing_dotfile ]; then
        rm $existing_dotfile
    elif [ -f $existing_dotfile ]; then
        mkdir -p $BACKUP_DIR
        mv $existing_dotfile $BACKUP_DIR/
    fi
}

all_dotfiles=$(find $DOTFILES_DIR -mindepth 1 -maxdepth 1 -not -name "*.local" -exec basename {} \;)
for file in $all_dotfiles; do
    backup_dotfile $file

    ln -s $DOTFILES_DIR/$file ~/.$file

    if [ -d "$DOTFILES_DIR/$file.local" ]; then
        echo "enter the name of the local dotfile you would like to use"
        select localFolderName in $(find $DOTFILES_DIR/$file.local -mindepth 1 -maxdepth 1 -exec basename {} \;); do
            if [[ -e "$DOTFILES_DIR/$file.local/$localFolderName/$file" ]]; then
                backup_dotfile $file.local
                ln -s $DOTFILES_DIR/$file.local/$localFolderName/$file ~/.$file.local
                break;
            fi
        done
    fi
done

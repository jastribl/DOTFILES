#!/usr/bin/env bash

DOTFILES_DIR="$PWD/dotfiles"
BACKUP_DIR="$PWD/backup_dotfiles/backup_$(date +%Y-%m-%d:%H:%M:%S)"

UPDATE_SCRIPTS_DIR="update-scripts"
UPDATE_CACHE_DIR="$UPDATE_SCRIPTS_DIR/cache"
SAVED_PREFS_DIR="$UPDATE_CACHE_DIR/prefs"

mkdir -p $SAVED_PREFS_DIR

function backup_dotfile() {
    local existing_dotfile=~/.$1
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
        local_pref_cache_file="$SAVED_PREFS_DIR/$file.local.pref"
        if [ -f $local_pref_cache_file ]; then
            localFolderName=$(cat $local_pref_cache_file)
        else
            echo "enter the name of the local dotfile you would like to use"
            select localFolderName in $(find $DOTFILES_DIR/$file.local -mindepth 1 -maxdepth 1 -exec basename {} \;); do
                if [[ -e "$DOTFILES_DIR/$file.local/$localFolderName/$file" ]]; then
                    printf "$localFolderName" > $local_pref_cache_file
                    break;
                fi
            done
        fi
        backup_dotfile $file.local
        ln -s $DOTFILES_DIR/$file.local/$localFolderName/$file ~/.$file.local
    elif [ -d "$DOTFILES_DIR/$file.os.local" ]; then
        if [[ $(uname -s) == "Darwin" ]]; then
            os_suffix="osx"
        elif [[ $(uname -s) == "Linux" ]]; then
            os_suffix="linux"
        else
            continue;
        fi
        backup_dotfile $file.local
        ln -s $DOTFILES_DIR/$file.os.local/$os_suffix/$file ~/.$file.local
    fi
done

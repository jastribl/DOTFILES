#!/usr/bin/env bash

DOTFILES_DIR="$PWD/dotfiles"
BACKUP_DIR="$PWD/backup_dotfiles/backup_$(date +%Y-%m-%d:%H:%M:%S)"

UPDATE_SCRIPTS_DIR="update-scripts"
UPDATE_CACHE_DIR="$UPDATE_SCRIPTS_DIR/cache"
SAVED_PREFS_DIR="$UPDATE_CACHE_DIR/prefs"

mkdir -p $SAVED_PREFS_DIR

function backup_and_link() {
    local source_file=$DOTFILES_DIR/$1
    local destination_path=$2

    # backup
    if [ -L $destination_path ]; then
        rm $destination_path
    elif [ -f $destination_path ]; then
        mkdir -p $BACKUP_DIR
        mv $destination_path $BACKUP_DIR/
    fi

    # link
    mkdir -p $(dirname $destination_path)
    ln -s $source_file $destination_path
}

# mappings from file in ./dotfiles/ to path to be placed
declare -A global_files
declare -A local_files
declare -A os_specific_files

function register_global_file() {
    global_files[$1]=${2:-~/.$1}
}
function register_local_file() {
    local_files[$1]=${2:-~/.$1}
}
function register_os_specific_file() {
    os_specific_files[$1]=${2:-~/.$1}
}

# deployed on all machines
register_global_file bash_profile
register_global_file bashrc
register_global_file bashrc.plugables
register_global_file gitconfig
register_global_file gitignore_global
register_global_file inputrc
register_global_file tmux
register_global_file tmux.conf
register_global_file tmux.conf.local
register_global_file vim
register_global_file vimrc
register_global_file ssh/config ~/.ssh/config

# machine-specific deployment
register_local_file bashrc.local

# os-specific deployment
register_os_specific_file gitconfig.os

# process all global files
for file in "${!global_files[@]}"; do
    backup_and_link $file ${global_files[$file]}
done

# process all machine-specific files
for file in "${!local_files[@]}"; do
    local_pref_cache_file="$SAVED_PREFS_DIR/$file.pref"
    if [ -f $local_pref_cache_file ]; then
        local_file_name=$(cat $local_pref_cache_file)
    else
        echo "Select the machine-specific dotfile you would like to use"
        select local_file_name in $(find $DOTFILES_DIR/$file -mindepth 1 -maxdepth 1 -exec basename {} \;); do
            if [[ -e "$DOTFILES_DIR/$file/$local_file_name" ]]; then
                printf "$local_file_name" > $local_pref_cache_file
                break;
            fi
        done
    fi

    backup_and_link $file/$local_file_name ${local_files[$file]}
done

# process all os-specific files
OS="$(uname -s)"
if [[ "$OS" == "Darwin" ]]; then
    os_suffix="osx"
elif [[ "$OS" == "Linux" ]]; then
    os_suffix="linux"
else
    echo "**Unable to find matching operating system for '$OS'**"
    exit
fi

for file in "${!os_specific_files[@]}"; do
    local_file_name=$file/$os_suffix
    if [[ -e "$DOTFILES_DIR/$file/$os_suffix" ]]; then
        backup_and_link $file/$os_suffix ${os_specific_files[$file]}
    else
        echo "**No os-specific version of '$file'**"
    fi
done

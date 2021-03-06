#!/usr/bin/env bash

DOTFILES_DIR="$PWD/dotfiles"
BACKUP_DIR="$PWD/backup_dotfiles/backup_$(date +%Y-%m-%d:%H:%M:%S)"

UPDATE_SCRIPTS_DIR="update-scripts"
UPDATE_CACHE_DIR="$UPDATE_SCRIPTS_DIR/cache"
SAVED_PREFS_DIR="$UPDATE_CACHE_DIR/prefs"

OS="$(uname -s)"

mkdir -p $SAVED_PREFS_DIR

# mappings from file in ./dotfiles/ to path to be placed
declare -A global_files
declare -A local_files
declare -A os_specific_files
declare -A should_copy_not_link

function backup_and_link() {
    local source_file=$DOTFILES_DIR/$1
    local destination_path=$2
    should_copy=${should_copy_not_link[$file]}

    # backup
    if [ -L "$destination_path" ]; then
        # If link, just remove it
        rm "$destination_path"
    elif [ -f "$destination_path" ]; then
        # If file
        if [ $should_copy ]; then
            # If copy, only backup if different than new file
            if ! cmp -s "$source_file" "$destination_path"; then
                echo "backing up $source_file"
                mkdir -p "$BACKUP_DIR"
                mv "$destination_path" "$BACKUP_DIR/"
            fi
        else
            # If link, backup exisitng file
            echo "backing up $source_file"
            mkdir -p "$BACKUP_DIR"
            mv "$destination_path" "$BACKUP_DIR/"
        fi
    fi

    mkdir -p "$(dirname "$destination_path")"
    if [ $should_copy ] ; then
        # copy
        cp "$source_file" "$destination_path"
    else
        # link
        ln -s "$source_file" "$destination_path"
    fi
}

function register_global_file() {
    global_files[$1]=${2:-~/.$1}
}
function register_local_file() {
    local_files[$1]=${2:-~/.$1}
    if [ ! -z "$3" ]; then
        should_copy_not_link[$1]=1
    fi
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
if [[ "$OS" == "Darwin" ]]; then
    if which fbclone > /dev/null; then
        register_global_file work-mosh.sh
    fi
fi

# machine-specific deployment
register_local_file bashrc.local
register_local_file gitconfig.local
register_local_file ssh/config.local ~/.ssh/configs/config.local
register_local_file hgrc.local ~/.hgrc 1
register_local_file vimrc-pre-local.vim ~/.vim/vimrc-pre-local.vim
register_local_file vimrc-plugins.vim ~/.vim/plugins.vim
if [[ "$OS" == "Darwin" ]]; then
    register_local_file brew-list $UPDATE_SCRIPTS_DIR/brew/brew-list
    register_local_file cask-list $UPDATE_SCRIPTS_DIR/brew/cask-list
    register_local_file cookies-to-keep.local random-settings/cookies-to-keep.txt
    register_local_file time-machine-excludes.local random-settings/time-machine-excludes.txt

    if which fbclone > /dev/null; then
        register_global_file vs-code/settings.json "/Users/justinstribling/Library/Application Support/VS Code @ FB/User/settings.json"
        register_global_file vs-code/keybindings.json "/Users/justinstribling/Library/Application Support/VS Code @ FB/User/keybindings.json"
    else
        register_global_file vs-code-personal/settings.json "/Users/justinstribling/Library/Application Support/Code/User/settings.json"
        register_global_file vs-code-personal/keybindings.json "/Users/justinstribling/Library/Application Support/Code/User/keybindings.json"
    fi
fi

# os-specific deployment
register_os_specific_file gitconfig.os
register_os_specific_file ssh/config.os ~/.ssh/configs/config.os

# process all global files
for file in "${!global_files[@]}"; do
    backup_and_link "$file" "${global_files[$file]}"
done

# process all machine-specific files
for file in "${!local_files[@]}"; do
    local_pref_cache_file="$SAVED_PREFS_DIR/$file.pref"
    if [ -f $local_pref_cache_file ]; then
        local_file_name=$(cat $local_pref_cache_file)
    else
        echo "Select the machine-specific dotfile you would like to use for '$file'"
        select local_file_name in $(find $DOTFILES_DIR/$file -mindepth 1 -maxdepth 1 -exec basename {} \;); do
            if [[ -f "$DOTFILES_DIR/$file/$local_file_name" ]]; then
                mkdir -p $(dirname $local_pref_cache_file)
                printf "$local_file_name" > $local_pref_cache_file
                break;
            else
                echo "Please try again..."
            fi
        done
    fi

    backup_and_link $file/$local_file_name ${local_files[$file]}
done

# process all os-specific files
if [[ "$OS" == "Darwin" ]]; then
    os_suffix="osx"
elif [[ "$OS" == "Linux" ]]; then
    os_suffix="linux"
else
    echo "**Unable to find matching operating system for '$OS'**"
    exit
fi

for file in "${!os_specific_files[@]}"; do
    if [[ -e "$DOTFILES_DIR/$file/$os_suffix" ]]; then
        backup_and_link $file/$os_suffix ${os_specific_files[$file]}
    else
        echo "**No os-specific version of '$file'**"
    fi
done

# Specific post-linking tasks

# Combine ssh configs into master config for use
rm ~/.ssh/config
echo "# AUTO-GENERATED - DO NOT EDIT" > ~/.ssh/config
cat ~/.ssh/configs/* >> ~/.ssh/config

#!/usr/bin/env bash

echo "---------- installing dotfiles ----------"

files="bash_profile bashrc bashrc.plugables gitconfig gitignore_global ideavimrc inputrc tmux.conf tmux.conf.local vimrc"

dotfileDir="$PWD/dotfiles"
backupDir="$PWD/backup_dotfiles/backup_$(date +%Y-%m-%d:%H:%M:%S)"

mkdir -p $backupDir

cd $dotfileDir

for file in $files; do
    read -p "Would you like to install $file (y/n/q)? " choice
    case "$choice" in
        y|Y )
            mv ~/.$file $backupDir/
            ln -s $dotfileDir/$file ~/.$file
            if [ -d "$file.local" ]; then
                echo "enter the name of the local dotfile you would like to use"
                select localFolderName in `ls $file.local/`; do
                    if [[ -e "$file.local/$localFolderName/$file" ]]; then
                        mv ~/.$file.local $backupDir/
                        ln -s $dotfileDir/$file.local/$localFolderName/$file ~/.$file.local
                        break;
                    fi
                done
            fi
            ;;
        n|N ) echo "moving on" ;;
        q|Q ) exit ;;
        * ) echo "invalid option" ;;
    esac
done

touch ~/.hushlogin

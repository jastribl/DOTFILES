#!/usr/bin/env bash

echo "---------- installing dotfiles ----------"

files="bash_profile bashrc bashrc.plugables gitconfig gitignore_global ideavimrc inputrc tmux.conf tmux.conf.local vimrc"

dotfileDir="$PWD/dotfiles"
backupDir="$PWD/dotfiles_old/backup_$(date +%Y-%m-%d:%H:%M:%S)"

mkdir -p $backupDir

cd $dotfileDir

for file in $files; do
    read -p "Would you like to install $file (y/n/q)? " choice
    case "$choice" in
        y|Y )
            echo "> mv ~/.$file $backupDir/"
            mv ~/.$file $backupDir/
            echo "> ln -s $dotfileDir/$file ~/.$file"
            ln -s $dotfileDir/$file ~/.$file
            if [ -d "$file.local" ]; then
                echo "enter the name of the local dotfile you would like to use\n"
                select localFolderName in `ls $file.local/`; do
                    echo "checking: $file.local/$localFolderName/$file"
                    if [[ -e "$file.local/$localFolderName/$file" ]]; then
                        echo "> mv ~/.$file.local $backupDir/"
                        mv ~/.$file.local $backupDir/
                        echo "> ln -s $dotfileDir/$file.local/$localFolderName/$file ~/.$file.local"
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

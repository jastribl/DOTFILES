# !/bin/bash

echo "---------- installing dotfiles ----------"

files="bashrc vimrc zshrc gitconfig gitignore_global tmux.conf tmux.conf.local"

dotfileDir="$PWD/dotfiles"
backupDir="$PWD/dotfiles_old/backup_$(date +%Y-%m-%d:%H:%M:%S)"

mkdir -p $backupDir

cd $dotfileDir

for file in $files; do
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
done

touch ~/.hushlogin

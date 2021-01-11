#!/usr/bin/env bash

if [ "$PWD" != "$HOME/Github/DOTFILES" ]; then
    echo "Update script must be ran from root DOTFILES repo"
    exit 1
fi

if [ ! -f ~/.ssh/id_rsa.pub ]; then
    echo "Update script requires that an ssh key as been generated and added to Github"
    exit 1
fi

if [ ${BASH_VERSINFO[0]} -lt 4 ]; then
    echo "Update script requires that bash be updated to version 4+"
    exit 1
fi

case "$PWD" in
    *\ * )
        echo "DOTFILES repo path must not contain spaces"
        ;;
    *)
        ;;
esac

if which fbclone > /dev/null; then
    if [[ $(uname -s) != "Darwin" ]]; then
        if ! ps -p $SSH_AGENT_PID > /dev/null; then
            eval `ssh-agent -s`
            trap "ssh-agent -k" exit
        fi
        if ssh-add -l | grep -q "The agent has no identities."; then
            ssh-add ~/.ssh/id_rsa
        fi
    fi
fi

function usage() {
    echo "Usage: $0 [-f (force)]" 1>&2; exit 1;
}

force=0

while getopts ":f" o; do
    case "${o}" in
        f)
            force=1
            ;;
        *)
            usage
            ;;
    esac
done

ONE_SECOND=$(( 1 ))
ONE_MUNUTE=$(( $ONE_SECOND * 60 ))
ONE_HOUR=$(( $ONE_MUNUTE * 60 ))
ONE_DAY=$(( $ONE_HOUR * 24 ))
ONE_WEEK=$(( $ONE_DAY * 7 ))
ONE_MONTH=$(( $ONE_DAY * 30 ))

NOW=$(date +%s)
UPDATE_SCRIPTS_DIR="update-scripts"
UPDATE_CACHE_DIR="$UPDATE_SCRIPTS_DIR/cache"

mkdir -p $UPDATE_CACHE_DIR

declare -a update_scripts
declare -A update_script_delays

function add_update_script() {
    update_scripts+=( $1 )
    update_script_delays[$1]=$2
}

add_update_script update-submodules.sh $ONE_SECOND
add_update_script update-dotfiles.sh $ONE_SECOND
add_update_script update-devserver.sh $ONE_WEEK
add_update_script update-osx.sh $ONE_DAY
add_update_script update-vim.sh $ONE_DAY
add_update_script update-tmux.sh $ONE_DAY
add_update_script update-powerline-fonts.sh $ONE_SECOND
add_update_script update-diff-so-fancy.sh $ONE_WEEK
add_update_script cleanup-files.sh $ONE_DAY


function run_update_script() {
    update_script_to_run=$1

    if [[ $force != 1 && -e $UPDATE_CACHE_DIR/$update_script_to_run.last_run ]]; then
        last_run_time=$(cat $UPDATE_CACHE_DIR/$1.last_run)
        delay_seconds=${update_script_delays[$update_script_to_run]}
        must_be_after=$((last_run_time + delay_seconds))
        if (( $NOW < $must_be_after )); then
            echo "--- Skipping $update_script_to_run ---"
            return
        fi
    fi

    echo "--- Running $update_script_to_run ---"

    ./$UPDATE_SCRIPTS_DIR/$update_script_to_run
    echo $NOW > $UPDATE_CACHE_DIR/$1.last_run

    echo "--- Done running $update_script_to_run ---"
}

for update_script in "${update_scripts[@]}"; do
    run_update_script $update_script
done


touch -a ~/.hushlogin

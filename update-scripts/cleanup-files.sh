#!/usr/bin/env bash

declare -A dirs_to_clean

dirs_to_clean["$HOME/Desktop"]=""
dirs_to_clean["$HOME/Github"]="-not -type d"
dirs_to_clean["$HOME"]="-not -name '.*'-not -name '\..*'"

for dir_to_clean in "${!dirs_to_clean[@]}"; do
    rm -f $dir_to_clean/.DS_Store
    extra_files=$(find "$dir_to_clean" -mindepth 1 -maxdepth 1 ${dirs_to_clean[$dir_to_clean]})
    if [ ! -z "$extra_files" ]; then
        echo "Clean up your $dir_to_clean directory:"
        echo "$extra_files"
    fi
    broken_links=$(find -L "$dir_to_clean" -mindepth 1 -maxdepth 1 -type l)
    if [ ! -z "$broken_links" ]; then
        echo "Broken Links:"
        echo "$broken_links"
    fi
done

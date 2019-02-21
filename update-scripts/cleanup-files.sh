#!/usr/bin/env bash

declare -A dirs_to_clean

dirs_to_clean["$HOME/Desktop"]=""
dirs_to_clean["$HOME/Github"]="-not -type d"

for dir_to_clean in "${!dirs_to_clean[@]}"; do
    rm -f $dir_to_clean/.DS_Store
    NUM_FILES=$(find "$dir_to_clean" -mindepth 1 -maxdepth 1 ${dirs_to_clean[$dir_to_clean]} | wc -l)
    if [ ! $NUM_FILES = 0 ]; then
        echo "Clean up your $dir_to_clean directory!"
    fi
done

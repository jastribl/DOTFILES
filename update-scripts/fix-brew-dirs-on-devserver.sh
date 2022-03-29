#!/usr/bin/env bash

brew_prefix="$(brew --prefix)"

# Check write permissions for dirs required by brew
for dir in "$brew_prefix/bin" "$brew_prefix/lib" "$brew_prefix/sbin"; do
    if [ ! -w "$dir" ]; then
        echo "Incorrect ownership of $dir.... Fixing...."
        sudo chown -R $(whoami) "$dir"
        chmod u+w "$dir"
    fi
done

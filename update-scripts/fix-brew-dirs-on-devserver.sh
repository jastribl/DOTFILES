#!/usr/bin/env bash

# Check write permissions for dirs required by brew
for dir in '/usr/local/bin' '/usr/local/lib' '/usr/local/sbin'; do
    if [ ! -w "$dir" ]; then
        echo "Incorrect ownership of $dir.... Fixing...."
        sudo chown -R $(whoami) "$dir"
        chmod u+w "$dir"
    fi
done

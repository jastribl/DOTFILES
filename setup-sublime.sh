#!/usr/bin/env bash

rm -rf "/Users/$(whoami)/Library/Application Support/Sublime Text 3/Packages/User"
ln -f -s $PWD/Sublime/User "/Users/$(whoami)/Library/Application Support/Sublime Text 3/Packages/User"

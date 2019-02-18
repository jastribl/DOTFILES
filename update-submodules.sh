#!/usr/bin/env bash

# install sub-modules
git submodule update --init

# update sub-modules
git submodule foreach git pull origin master

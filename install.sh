#!/usr/bin/env bash

SCRIPT_DIRECTORY=$(dirname $(readlink -f $0))

ln -s $SCRIPT_DIRECTORY/zshrc $HOME/.zshrc

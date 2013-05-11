#!/usr/bin/env bash

SCRIPT_DIRECTORY=$(dirname $(readlink -f $0))

ln -s $SCRIPT_DIRECTORY/zshrc $HOME/.zshrc

git clone https://github.com/zsh-users/antigen.git $SCRIPT_DIRECTORY/../antigen

#!/usr/bin/env bash

SCRIPT_DIRECTORY=$(dirname $(readlink -f $0))

ln -s $SCRIPT_DIRECTORY/zshrc $HOME/.zshrc
ln -s $SCRIPT_DIRECTORY/global.fuzzy-match-ignore $HOME/.global.fuzzy-match-ignore

git clone https://github.com/zsh-users/antigen.git $SCRIPT_DIRECTORY/../antigen

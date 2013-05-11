#!/usr/bin/env bash

SCRIPT_DIRECTORY="$( cd "$( dirname "$0" )" && pwd )"

ln -s $SCRIPT_DIRECTORY/zshrc $HOME/.zshrc

cd ..
git clone https://github.com/zsh-users/antigen.git antigen

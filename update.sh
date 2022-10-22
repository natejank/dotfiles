#!/usr/bin/env bash

# vim
cp $HOME/.vimrc vimrc

# zsh
cp $HOME/.zshrc zshrc

# ncspot
mkdir ncspot 2> /dev/null
cp $HOME/.config/ncspot/config.toml ncspot/config.toml

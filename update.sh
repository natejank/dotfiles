#!/usr/bin/env bash

# vim
cp $HOME/.vimrc vimrc

# zsh
cp $HOME/.zshrc zshrc

# ncspot
mkdir ncspot 2> /dev/null
cp $HOME/.config/ncspot/config.toml ncspot/config.toml

# vscode
case `uname -s` in
    'Darwin')
        vscode_settings="$HOME/Library/Application Support/Code/User/settings.json"
        ;;
    *)
        echo 'Unsupported os! Where is your vscode settings.json?'
        ;;
esac
cp "$vscode_settings" vscode_settings.json

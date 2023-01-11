#!/usr/bin/env bash

# vim
system_vimrc="$HOME/.vimrc"
VIMRC="vimrc"

cp "$system_vimrc" "$VIMRC" &> /dev/null

# zsh
system_zshrc="$HOME/.zshrc"
ZSHRC="zshrc"

cp "$system_zshrc" "$ZSHRC" &> /dev/null

# ncspot
system_ncspot="$HOME/.config/ncspot/config.toml"
NCSPOT_DIR="ncspot"
NCSPOT_CFG="$NCSPOT_DIR/config.toml"

mkdir "$NCSPOT_DIR" &> /dev/null
cp "$system_ncspot" "$NCSPOT_CFG" &> /dev/null

# vscode
VSCODE_SETTINGS='vscode_settings.json'
VSCODE_EXTENSIONS='install_vscode_extensions.sh'

# find settings.json
case `uname -s` in
    'Darwin')
        system_vscode_settings="$HOME/Library/Application Support/Code/User/settings.json"
        ;;
    *)
        echo 'Unsupported os! Where is your vscode settings.json?'
        ;;
esac

cp "$system_vscode_settings" "$VSCODE_SETTINGS" &> /dev/null

# generate script to install vscode extensions
# this allows for easier migration, and prevents typosquatting attacks
# by ensuring I am reinstalling the exact same extension as before.
if command -v code &> /dev/null; then
    rm "$VSCODE_EXTENSIONS" &> /dev/null
    echo "# Script to reinstall vscode extensions automatically" > "$VSCODE_EXTENSIONS"
    for ext in `code --list-extensions`; do
        echo "code --install-extension $ext" >> "$VSCODE_EXTENSIONS"
    done
    chmod +x "$VSCODE_EXTENSIONS" &> /dev/null
fi

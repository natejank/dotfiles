#!/bin/bash
# does what it says on the tin. pulls a tag from github, compiles, and installs it :)

set -euo pipefail
trap 'echo "Error: $? at line $LINENO" >&2' ERR
. ./common.sh

export VERSION="v0.11.1"

if command -v nvim &> /dev/null; then
	if nvim -v | grep "$VERSION" &> /dev/null; then
		echo "Neovim already installed!"
		exit 0
	fi
fi

ensure_installed git ninja-build gettext cmake curl build-essential

if [ ! -d "$HOME/dist" ]; then
	mkdir "$HOME/dist"
fi

git clone --branch="$VERSION" --single-branch --depth=1 https://github.com/neovim/neovim.git "$HOME/dist/neovim"

pushd "$HOME/dist/neovim"

make CMAKE_BUILD_TYPE=Release
sudo make install

popd


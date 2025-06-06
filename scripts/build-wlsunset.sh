#!/bin/bash
# pulls the latest version of wlsunset, which supports toggling with SIGUSR1

set -euo pipefail
trap 'echo "Error: $? at line $LINENO" >&2' ERR
. ./common.sh

export VERSION="0.4.0"

if [ -f /usr/local/bin/wlsunset ]; then
	echo "wlsunset already installed!"
	exit 0
fi

ensure_installed libwayland-dev meson scdoc wayland-protocols wayland-scanner++

if [ ! -d "$HOME/dist" ]; then
	mkdir "$HOME/dist"
fi

git clone --branch="$VERSION" --single-branch --depth=1 https://git.sr.ht/~kennylevinsen/wlsunset "$HOME/dist/wlsunset"

pushd "$HOME/dist/wlsunset"

meson build
ninja -C build
sudo ninja -C build install

popd


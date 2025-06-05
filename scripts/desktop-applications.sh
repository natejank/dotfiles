#!/bin/bash
# configures a set of desktop applications to install

set -euo pipefail
trap 'echo "Error: $? at line $LINENO" >&2' ERR
. ./common.sh

# install flatpak
ensure_installed flatpak
if ! flatpak --user remotes | grep 'flathub' &> /dev/null ; then
	echo "Adding flathub"
	flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
fi

# install tailscale
ensure_installed curl
if ! dpkg-query -W -f'${Status}' tailscale | grep -q "install ok installed" &> /dev/null; then
	echo "Installing tailscale..."
	curl -fsSL https://tailscale.com/install.sh | sh
else
	echo "Tailscale already installed!"
fi

ensure_installed curl
if ! dpkg-query -W -f'${Status}' syncthing | grep -q "install ok installed" &> /dev/null; then
	echo "Installing syncthing"
	# Add the release PGP keys:
	sudo mkdir -p /etc/apt/keyrings
	sudo curl -L -o /etc/apt/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
	# Add the "stable" channel to your APT sources:
	echo "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
	# Pin syncthing's version
	printf "Package: *\nPin: origin apt.syncthing.net\nPin-Priority: 990\n" | sudo tee /etc/apt/preferences.d/syncthing.pref
	sudo apt-get update
	ensure_installed syncthing
else
	echo "Syncthing already installed!"
fi


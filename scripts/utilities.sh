#!/bin/bash
# a set of common shell utilities to install
set -euo pipefail
trap 'echo "Error: $? at line $LINENO" >&2' ERR
. ./common.sh

ensure_installed unzip curl git ripgrep fd-find fzf build-essential ffmpeg htop tmux entr git-filter-repo mosh nvtop pandoc pipx tree gdb valgrind whois
ensure_installed_nir restic

# honorable mentions
# ensure_installed gocryptfs

# setup fd
if [ ! -f /usr/local/bin/fd ]; then
	echo "Linking fdfind to fd"
	sudo ln -s /usr/bin/fdfind /usr/local/bin/fd
fi


#!/bin/bash
# installs pyenv and friends
set -euo pipefail
trap 'echo "Error: $? at line $LINENO" >&2' ERR
. ./common.sh
ensure_installed make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev curl git libncursesw5-dev xz-utils libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

curl -fsSL https://pyenv.run | bash

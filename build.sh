#!/usr/bin/bash

set -o nounset
set -o errexit

cd "$(dirname $0)"

ROOT_DIR="debian-build"
NEOVIM_DIR="$ROOT_DIR/usr/share/nvim"
SERVICE_DIR="$ROOT_DIR/usr/lib/systemd/system"


if [ ! -e "$NEOVIM_DIR" ]; then
    mkdir -pv "$NEOVIM_DIR"
fi
if [ ! -e "$SERVICE_DIR" ]; then
    mkdir -pv "$SERVICE_DIR"
fi

rsync -ruv \
    neovimd.service \
    "$SERVICE_DIR"

rsync -ruv \
    src/aszswaz \
    src/plugins \
    src/ginit.vim \
    src/sysinit.vim \
    src/templates \
    "$NEOVIM_DIR"

dpkg-deb --build debian-build aszswaz-neovim.deb

echo -e "the package can now be installed using \"\033[32msudo dpkg -i aszswaz-neovim.deb\033[0m\""

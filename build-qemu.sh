#!/bin/bash
#
# Script to configure and build QEMU to run RPi3B+ images.
#
# See: https://github.com/cu-ecen-aeld/final-project-tham7107/wiki/Building-QEMU
#
# Thomas Ames, ECEA 5307, July 23, 2024
#

# Make sure QEMU submodule is ready to build
git submodule init
git submodule sync
git submodule update

echo "***Installing QEMU build prerequisites."
echo "***Enter your password for sudo apt install command:"

# Echo commands (to show sudo apt install) and abort script if commands fail
set -xe

sudo apt install ninja-build libslirp-dev libpixman-1-dev libgtk-3-dev

cd `dirname $0`/qemu
./configure --disable-docs --enable-gtk
make qemu-system-aarch64

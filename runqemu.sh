#!/bin/bash
#Script to run QEMU for buildroot as the default configuration qemu_aarch64_virt_defconfig
#Host forwarding: Host Port 10022 ->> QEMU Port 22 
#Author: Siddhant Jajoo.

# original command
#qemu-system-aarch64 \
#    -M virt  \
#    -cpu cortex-a53 -nographic -smp 1 \
#    -kernel buildroot/output/images/Image \
#    -append "rootwait root=/dev/vda console=ttyAMA0" \
#    -netdev user,id=eth0,hostfwd=tcp::10022-:22,hostfwd=tcp::9000-:9000 \
#    -device virtio-net-device,netdev=eth0 \
#    -drive file=buildroot/output/images/rootfs.ext4,if=none,format=raw,id=hd0 \
#    -device virtio-blk-device,drive=hd0 -device virtio-rng-pci

# Figure out where invoked to get path to QEMU and images
BASEDIR=`dirname $0`

# Ubuntu 20.04 (version spec'ed for ECEA530x) comes with QEMU
# version 4.2.1, which has limited RPi emulation. I manually
# downloaded and built 9.0.1 to get better RPi emulation.
QEMU=$BASEDIR/qemu/build/qemu-system-aarch64
# Default is ctrl-a (0x01), which interferes with bash line editing.
# 0x1c is ctrl-\ (FS, "file separator")
QEMU_ESC_CHAR=0x1c

# DTB from build
# DTB=output/images/bcm2710-rpi-3-b-plus.dtb
# Bookworm default Pi 3B+ DTB with BT disabled and ttyAMA0 added
DTB=$BASEDIR/bcm2710-rpi-3-b-plus-no-bt-w-uart0-for-qemu.dtb
KERNEL_CMD_LINE="rootwait root=/dev/mmcblk0p2 console=ttyAMA0"

case "$1" in
    bookworm)
	KERNEL=kernel8.img
	IMG=2024-03-15-raspios-bookworm-arm64-lite.img
	;;
    *)
	KERNEL=$BASEDIR/buildroot/output/images/Image
	IMG=$BASEDIR/buildroot/output/images/sdcard.img
    ;;
esac

# Use qemu-img to resize spare file to power of 2 (required by qemu).
# For more info, see:
# https://github.com/cu-ecen-aeld/final-project-tham7107/wiki/Building-QEMU#running-qemu
#echo qemu-img resize -f raw $IMG 2G
#echo $QEMU -echr $QEMU_ESC_CHAR -M raspi3b -m 1G -kernel $KERNEL -dtb $DTB -append \"$KERNEL_CMD_LINE\" -drive file=$IMG,if=sd,format=raw -device usb-net,netdev=usbnet0 -netdev user,id=usbnet0,hostfwd=tcp::10022-:22,hostfwd=tcp::9000-:9000 -nographic

set -xe

qemu-img resize -f raw $IMG 2G
$QEMU -echr $QEMU_ESC_CHAR -M raspi3b -m 1G -kernel $KERNEL -dtb $DTB -append "$KERNEL_CMD_LINE" -drive file=$IMG,if=sd,format=raw -device usb-net,netdev=usbnet0 -netdev user,id=usbnet0,hostfwd=tcp::10022-:22,hostfwd=tcp::9000-:9000 -nographic

#!/bin/sh -e
[ $(id -u) -eq 0 ] || { echo "Please run this script as root." ; exit 1 ; }
[ $(command -v lb) ] ||  { echo "Please install live-build to run this script." ; exit 1 ; }
START_DIR="$PWD"
BUILD_DIR="$PWD/build"
mkdir -p $BUILD_DIR || true
cd $BUILD_DIR
lb config --architecture amd64 --distribution bookworm \
    --binary-images iso-hybrid --bootappend-live "boot=live components username=act_runner" \
    --mirror-bootstrap "https://deb.debian.org/debian" --mirror-chroot "https://deb.debian.org/debian" --mirror-chroot-security "https://deb.debian.org/debian-security/" \
    --archive-areas "main contrib non-free non-free-firmware"
cd "$START_DIR"
cp -r hooks/normal/* "$BUILD_DIR/config/hooks/normal/."
mkdir -p "$BUILD_DIR/config/hooks/normal"
cp -r hooks/normal/* "$BUILD_DIR/config/hooks/normal/."
cp -r package-lists/* "$BUILD_DIR/config/package-lists/."
mkdir -p "$BUILD_DIR/config/package-lists"
mkdir -p "$BUILD_DIR/config/includes.chroot"
cp -r includes/* "$BUILD_DIR/config/includes.chroot/."
cd $BUILD_DIR
lb build
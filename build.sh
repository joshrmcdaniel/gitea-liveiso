#!/bin/sh -e
[ -f .env ] && source .env
[ $(id -u) -eq 0 ] || { echo "Please run this script as root." ; exit 1 ; }
if ! $(command -v lb) ; then
    if [ "$1" = "install" ] ; then
        echo "Installing live-build."
        { 
          apt update >/dev/null || true ;
          apt install -y live-build ;
        } 1> /dev/null
        echo "Installed live build"
    else
        echo "Please install live-build to run this script."
        exit 1
    fi
fi
START_DIR="$PWD"
BUILD_DIR="$PWD/build"
mkdir -p $BUILD_DIR || true
cd $BUILD_DIR
lb config --architecture amd64 --distribution bookworm \
    --binary-images iso-hybrid --bootappend-live "boot=live components username=act_runner" \
    --mirror-bootstrap "https://deb.debian.org/debian" --mirror-chroot "https://deb.debian.org/debian" --mirror-chroot-security "https://deb.debian.org/debian-security/" \
    --archive-areas "main contrib non-free non-free-firmware"
cd "$START_DIR"
mkdir -p "$BUILD_DIR/config/hooks/normal"
cp -r hooks/normal/* "$BUILD_DIR/config/hooks/normal/."
mkdir -p "$BUILD_DIR/config/package-lists"
cp -r package-lists/* "$BUILD_DIR/config/package-lists/."
mkdir -p "$BUILD_DIR/config/includes.chroot"
cp -r includes/* "$BUILD_DIR/config/includes.chroot/."
cd $BUILD_DIR
lb build
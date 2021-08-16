#!/bin/sh

[ -z $1 ] && exit 1

TEMPDIR=$(mktemp -d)
cd $TEMPDIR

cp "/usr/share/kbd/keymaps/i386/qwerty/$1.map.gz" ./
gunzip "$1.map.gz"
sed -i -e 's/\(keycode\s\+1\s*=\s*\).*/\1Caps_Lock/' -e 's/\(keycode\s\+58\s*=\s*\).*/\1Escape/' "$1.map"
gzip "$1.map"
sudo mv "$1.map.gz" "/usr/share/kbd/keymaps/i386/qwerty/$1-custom.map.gz"

cd
rmdir $TEMPDIR

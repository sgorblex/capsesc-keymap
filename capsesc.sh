#!/bin/sh

KEYMAP_DIR=/usr/share/kbd/keymaps
CUST_KEYMAP_DIR=$KEYMAP_DIR/custom

USAGE="$0: create a tty keymap with the caps_lock and esc keys switched.

USAGE:
$0 [OPTIONS] [MAP_NAME]

If neither --load nor --install are specified, leaves the new keymap in the current directory.

OPTIONS:
-l, --load			Load keymap after creating it (requires root privileges)
-i, --install NEW_NAME		Install keymap in after creating it (requires root privileges)
				(puts it in $CUST_KEYMAP_DIR)
-h, --help			Show this help

Created by Sgorblex."

set -e

OPTS=li:h
LONGOPTS=load,install:,help
PARSED=$(getopt --options=$OPTS --longoptions=$LONGOPTS --name "$0" -- "$@")
eval set -- "$PARSED"

while true
do
	case "$1" in
		-l|--load)
			LOAD=true
			;;
		-i|--install)
			INSTALL=true
			NEW_NAME="$2"
			shift
			;;
		-h|--help)
			printf "%s\n" "$USAGE"
			exit 0
			;;
		--)
			shift
			break
			;;
	esac
	shift
done

TEMPDIR=$(mktemp -d)
cd $TEMPDIR

if [ -n "$1" ]; then
	MAP_NAME=${1%.gz}
	MAP_NAME=${1%.map}
	MAP_PATH=$(find "$KEYMAP_DIR" -type f -name "$MAP_NAME.map.gz" -print -quit)
	if [ -z "$MAP_PATH" ]; then
		printf "Couldn't find the specified keymap.\n"
		exit 1
	fi
	cp "$MAP_PATH" ./original.map.gz
	gunzip original.map.gz
else
	dumpkeys > original.map
fi
sed -i -e 's/\(keycode\s\+1\s*=\s*\).*/\1Caps_Lock/' -e 's/\(keycode\s\+58\s*=\s*\).*/\1Escape/' original.map && mv original.map capsesc.map
gzip capsesc.map

if [ -n "$LOAD" ]; then
	sudo loadkeys ./capsesc.map.gz
fi
if [ -n "$INSTALL" ]; then
	sudo mkdir -p "$CUST_KEYMAP_DIR"
	sudo mv capsesc.map.gz "$CUST_KEYMAP_DIR/$NEW_NAME.map.gz"
fi
if [ -z "$LOAD" -a -z "$INSTALL" ]; then
	cd - >/dev/null
	cp $TEMPDIR/capsesc.map.gz ./
fi

rm -rf $TEMPDIR

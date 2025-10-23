#!/bin/bash
set -euo pipefail

# VARIABLES FOR PATH. EASY PEASY CHANGE
UTILS_DIR="/root/utils"
UTILS_SCRIPTS_DIR="$UTILS_DIR/bash-scripts"
DEST_DIR="$(pwd -P)"              # A FRIEND O' MINE SUGGESTED TO USE THE CANNONICAL PATH, INSTEAD OF .
SCRIPTS_DIR="$DEST_DIR/bash-scripts"

# FILE LISTS. YOU CAN CHANGE THEM IF U NEED TO
C_FILES=(main.c master.h)
CPP_FILES=(main.cpp master.h)
SCRIPT_FILES=(compile.sh build.sh run.sh cbr.sh copycbp.sh)

copy_files() {		# MADE EIN FUC. TO DECLUTTER THE CODE.
	for f in "$@"; do
		if [ -e "$DEST_DIR/$f" ]; then
			echo "File { $f } already exists."
		else
			if [ ! -r "$UTILS_DIR/$f" ]; then
				echo "Template missing: $UTILS_DIR/$f" >&2
				exit 1
			fi
			cp "$UTILS_DIR/$f" "$DEST_DIR/"
			echo "Copied { $f } successfully!"
		fi
	done
}

case "${1:-}" in	# THE SAME GUY SUGGESTED I USED {1:-} S.T. IF Y'ALL GIVE NO PARAMETERS, IT DOES NOT PANIC (NO KABOOM)
	-c)
		copy_files "${C_FILES[@]}"
		;;
	-cpp)
		copy_files "${CPP_FILES[@]}"
		;;
	*)
		echo "Usage: mkproj -c | -cpp"
		exit 1
		;;
esac

if [ -d "$SCRIPTS_DIR" ]; then
	echo "Folder { bash-scripts } already exists. Skipping."
else
	mkdir -p "$SCRIPTS_DIR"
	echo "Created folder { bash-scripts } successfully."
fi

for f in "${SCRIPT_FILES[@]}"; do
	if [ -e "$SCRIPTS_DIR/$f" ]; then
		echo "File { $f } already exists. Skipping."
	else
		if [ ! -r "$UTILS_SCRIPTS_DIR/$f" ]; then
			echo "Template missing: $UTILS_SCRIPTS_DIR/$f" >&2
			exit 1
		fi
		cp "$UTILS_SCRIPTS_DIR/$f" "$SCRIPTS_DIR/"
		echo "Copied file { $f } successfully!"
	fi
done


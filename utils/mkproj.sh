#!/bin/bash
set -euo pipefail

# VARIABLES FOR PATH
UTILS_DIR="$HOME/utils"
UTILS_SCRIPTS_DIR="$UTILS_DIR/bash-scripts"
DEST_DIR="$(pwd -P)"
SCRIPTS_DIR="$DEST_DIR/bash-scripts"

# FILES VARIABLES
C_FILES=(main.c master.h)
CPP_FILES=(main.cpp master.h)
SCRIPT_FILES=(compile.sh build.sh run.sh cbr.sh copycbp.sh)

copy_files() {
	for f in "$@"; do
		if [ -e "$DEST_DIR/$f" ]; then
			echo "File { $f } already exists. Skipping."
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

# HERE WE CREATE THE BASE PROJECT
case "${1:-}" in
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

# CHECK BASH-SCRIPTS DIR EXISTS
if [ -d "$SCRIPTS_DIR" ]; then
	echo "Folder { bash-scripts } already exists. Skipping."
else
	mkdir -p "$SCRIPTS_DIR"
	echo "Created folder { bash-scripts } successfully."
fi

# CHECK IF SCRIPTS EXIST. IF NOT, COPY.
for f in "${SCRIPT_FILES[@]}"; do
	if [ -e "$SCRIPTS_DIR/$f" ]; then
		echo "File { $f } already exists. Skipping."
	else
		if [ ! -r "$UTILS_SCRIPTS_DIR/$f" ]; then
			echo "Template missing: $UTILS_SCRIPTS_DIR/$f" >&2
			exit 1
		fi
		cp "$UTILS_SCRIPTS_DIR/$f" "$SCRIPTS_DIR/"
		echo "Copied { $f } successfully!"
	fi
done


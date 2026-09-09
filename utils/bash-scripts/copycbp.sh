#!/bin/bash
set -euo pipefail

# EASY TO CHANGE DIRECTORY. IF THAT MATTERS
UTILS_DIR="$HOME/utils/bash-scripts"
DEST_SCRIPTS_DIR="$(pwd)/bash-scripts"

# CHECK IF DESTINATION FOLDER EXISTS OR CREATE IT
if [ -d "$DEST_SCRIPTS_DIR" ]; then
	echo "Folder { bash-scripts } already exists. Skipping."
else
	mkdir -p "$DEST_SCRIPTS_DIR"
	echo "Created folder { bash-scripts } successfully."
fi

for f in compile.sh build.sh; do
	if [ -e "$DEST_SCRIPTS_DIR/$f" ]; then
		echo "File { $f } already exists. Skipping."
	else
		if [ ! -r "$UTILS_DIR/$f" ]; then
			echo "Template missing: $UTILS_DIR/$f" >&2
			exit 1
		fi
		cp "$UTILS_DIR/$f" "$DEST_SCRIPTS_DIR/"
		echo "Copied { $f } successfully."
	fi
done


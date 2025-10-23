#!/bin/bash
for f in compile.sh build.sh; do
	if [ -e "../bash-scripts/$f" ]; then
		echo "File { $f } already exists. Skipping."
	else
		cp /root/utils/"$f" ../bash-scripts
		echo "Copied { $f } successfully";
	fi
done;

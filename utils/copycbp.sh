#!/bin/bash
for f in compile.sh build.sh; do
	if [ -e "./$f" ]; then
		echo "File { $f } already exists. Skipping."
	else
		cp /root/utils/"$f" .
		echo "Copied { $f } successfully";
	fi
done;

#!/bin/bash
case $1 in
	-c)
		for f in main.c master.h; do
			if [ -e "$f" ]; then
				echo "File { $f } already exists."
			else
				cp /root/utils/"$f" ../
				echo "Copied { $f } successfully!"
			fi
		done
		;;

	-cpp)
		for f in main.cpp master.h; do
			if [ -e "$f" ]; then
				echo "File { $f } already exists."
			else
				cp /root/utils/"$f" ../
				echo "Copied { $f } successfully!"
			fi
		done
		;;

	*)
		echo "Usage: mkproj -c | -cpp"
		;;
esac

	for f in compile.sh build.sh run.sh cbr.sh copycbp.sh; do
		if [ -e "./$f" ]; then
			echo "File { $f } already exists. Skipping."
		else
			cp /root/utils/bash-scripts/"$f" ../bash-scripts
			echo "Copied file { $f } successfully!"
		fi
	done



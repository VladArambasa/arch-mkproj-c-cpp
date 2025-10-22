echo ">>> Root .bashrc loaded successfully!"


copycbp() { 
	for f in compile.sh build.sh; do 
	if [ -e "./$f" ]; then
	       echo "File { $f } already exists. Skipping."
	else
		cp ~/ari/utils/"$f" . && echo "Copied { $f } successfully"; 
	fi 
	done;
}
copyc(){
	for f in main.c master.h; do
	[ -e "$f" ] && echo "{ $f } already exists" || cp /root/ari/utils/"$f" ./
	done	
}
copycpp(){
	for f in main.cpp master.h; do
		[ -e "$f" ] && echo "{ $f } already exists" || cp /root/ari/utils/"$f" ./
	done	
}

mkproj(){
	case "$1" in
		-c)
			for f in main.c master.h; do
				if [ -e "$f" ]; then
				echo "File { $f } already exists"
			else
				cp /root/ari/utils/"$f" ./
				echo "Copied { $f } successfully!"
			fi
			done
			;;

		-cpp)
			for f in main.cpp master.h; do
				if [ -e "$f" ]; then
				echo "File { $f } already exists"
			else
				cp /root/ari/utils/"$f" ./
				echo "Copied { $f } successfully!"
			fi
			done
			;;

		*)
			echo "Usage: mkproj -c | -cpp"
			;;

	esac
	for f in compile.sh build.sh; do
		if [ -e "./$f" ]; then
			echo "File { $f } already exists. Skipping."
		else
			cp /root/ari/utils/"$f" ./
			echo "Copied { $f } successfully!"
		fi
	done
}

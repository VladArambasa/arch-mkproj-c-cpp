echo ">>> Root .bashrc loaded successfully!"

mkprojexe(){
	chmod +x /root/utils/mkproj.sh
	chmod +x /root/utils/copycbp.sh
	chmod +x /root/utils/compile.sh
	chmod +x /root/utils/build.sh
	chmod +x /root/utils/run.sh
	chmod +x /root/utils/cbr.sh
}

copycbp() { 
	chmod +x /root/utils/copycbp.sh
	/bin/bash /root/utils/copycbp.sh
}

mkproj(){
	chmod +x /root/utils/mkproj.sh
	/bin/bash /root/utils/mkproj.sh	$1
}

echo ">>> Root .bashrc loaded successfully!"

mkprojexe(){
	chmod +x /root/utils/mkproj.sh
	chmod +x /root/utils/bash-scripts/copycbp.sh
	chmod +x /root/utils/bash-scripts/compile.sh
	chmod +x /root/utils/bash-scripts/build.sh
	chmod +x /root/utils/bash-scripts/run.sh
	chmod +x /root/utils/bash-scripts/cbr.sh
}

copycbp() { 
	chmod +x /root/utils/bash-scripts/copycbp.sh
	/bin/bash /root/utils/bash-scripts/copycbp.sh
}

mkproj(){
	chmod +x /root/utils/mkproj.sh
	/bin/bash /root/utils/mkproj.sh	$1
}

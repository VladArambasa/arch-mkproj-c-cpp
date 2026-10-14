echo ">>> Root .bashrc loaded successfully!"

mkprojexe(){ #MUST BE RAN (ONE TIME AT LEAST) TO MAKE SHELLS EXECUTABLE; CAN RUN MULTIPLE TIMES. POINTLESS BUT NOT HARMFUL
	chmod +x /root/utils/mkproj.sh
	chmod +x /root/utils/copycbp.sh
	chmod +x /root/utils/compile.sh
	chmod +x /root/utils/build.sh
	chmod +x /root/utils/run.sh
	chmod +x /root/utils/cbr.sh
}

copycbp() { 
	chmod +x /root/utils/copycbp.sh #POINTLESS BUT NOT HARMFUL
	/bin/bash /root/utils/copycbp.sh
}

mkproj(){
	chmod +x /root/utils/mkproj.sh #POINTLESS BUT NOT HARMFUL
	/bin/bash /root/utils/mkproj.sh	$1
}

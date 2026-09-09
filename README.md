Arch Configuration for C/C++ Project Making

This is my Arch Configuration for C/C++ Project making.

I have made a bunch of files which will allow me to easily create C/C++ projects. My Code from the Geany Configuration has been recycled/repurposed/reused in this repository.

My Geany Config: https://github.com/VladArambasa/geany-config

This is what I use in order to have my Geany behave like an IDE.

My Geany Config has been used by students and pupils of mine.

The files which I have reused are:

compile.sh
build.sh
mkproj.sh

I have created a new file, mkproj.sh that will:

Copy: master.h from the folder utils/ (u can change it)
Copy: main.c or main.cpp from the folder utils/ (u can change it)
Copy: compile.sh and build.sh from the folder utils/ (u can change it)
Copy: run.sh from the folder utils/ (u can change it)
Copy: cbr.sh from the folder utils/ (u can change it)

cbr.sh - compile -> build -> run

run.sh - runs program

utils/

Copy the /utils/ folder inside root or wherever u please (just update the paths from .bashrc and mkproj.sh and copycbp.sh) - very fucking important!

.bashrc

Copy the functions from my .bashrc to yours and hit source ~/.bashrc.

(This will keep the commands).

There is an echo as a bonux (as my math theacher GG used to say) s.t. you know

when u log into thy magic machine (Linux) that the bashrc has been loaded.

compile.sh

The compile file clones your folder structure.

In the mirrored/cloned folders, they add the .o files (say math.c is in subfolder src/, then math.o will be in ./build/src).

build.sh

The build file links everything and creates the subfolder release/ and in release you will have the program file you can run via ./program if you're cd-ed in that folder or by using ./release/program if you are in the project folder.

Alternatively, you can type ./run.sh or ./cbr.sh if you're in the project folder.

mkproj

The program only copies the files if they don't exist (the command mkproj).

Usage
mkproj -c


or

mkproj -cpp


It does its magic in the local folder (duh).

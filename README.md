This is my Arch Configuration for C/C++ Project making.
I have made a bunc of files which will allow me to easily create C/C++ projects. My Code from the Geany Cofiguration has been recycled/repurposed/reused in this repository. My Geany Config: https://github.com/VladArambasa/geany-config
This is what I use in order to have my Geany behave like an IDE.

My Geany Config has been used by students and pupils of mine.
                            I HATE GIT
Anyway,
The files which I have reused are:
    
    compile.sh
    
    build.sh


I HAVE CREATED A NEW FILE, mkproj.sh THAT WILL:   

    1. COPY: master.h FROM THE FOLDER utils/ (U CAN CHANGE IT)

    2. COPY: main.c OR main.cpp FROM THE FOLDER utils/ (U CAN CHANGE IT)

    3. COPY: compile.sh AND build.sh FROM THE FOLDER utils/ (U CAN CHANGE IT)

    4. COPY: run.sh FROM THE FOLDER utils/ (U CAN CHANGE IT)

    5. COPY: cbr.sh FROM THE FOLDER utils/ (U CAN CHANGE IT)


cbr.sh - COMPILE -> BUILD -> RUN

run.sh - RUNS PROGRAM

COPY THE /utils/ FOLDER INSIDE ROOT OR WHEREVER U PLEASE (JUST UPDATE THE PATHS FROM .bashrc AND mkproj.sh AND copycbp.sh) - VERY FUCKING IMPORTANT!

COPY THE FUNCTIONS FROM MY .bashrc TO YOURS AND HIT source ~/.bashrc
(THIS WILL KEEP THE COMMANDS).
THERE IS AN ECHO AS A BONUX (AS MY MATH THEACHER GG USED TO SAY) S.T. YOU KNOW
WHEN U LOG INTO THY *MAGIC* MACHINE (LINUX) THAT THE BASHRC HAS BEEN LOADED.

THE COMPILE FILE CLONES YOUR FOLDER STRUCTURE. IN THE MIRRORED/CLONED FOLDERS, THEY ADD THE .o FILES (SAY math.c IS IN SUBFOLDER src/, THEN math.o WILL BE IN ./build/src)

THE BUILD FILE LINKS EVERYTHING AND CREATES THE SUBFOLDER release/ AND IN RELEASE YOU WILL HAVE THE program FILE YOU CAN RUN VIA ./program IF YOU'RE cd-ED IN THAT FOLDER OR BY USING ./release/program IF YOU ARE IN THE PROJECT FOLDER.
ALTERNITIVELY, YOU CAN TYPE ./run.sh OR ./cbr.sh IF YOU'RE IN THE PROJECT FOLDER

THE PROGRAM ONLY COPIES THE FILES IF THEY DON'T EXIST (THE COMMAND MKPROJ)

USAGE: mkproj -c | -cpp

IT DOES ITS MAGIC IN THE LOCAL FOLDER (DUH).

IF YOU DON'T LIKE THE SETUP, KINDLY SOD OFF :D

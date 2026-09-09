# Arch Configuration for C/C++ Project Making

This is my Arch Configuration for C/C++ Project making.

I have made a bunch of files which will allow me to easily create C/C++ projects. My Code from the Geany Configuration has been recycled/repurposed/reused in this repository.

My Geany Config: https://github.com/VladArambasa/geany-config

This is what I use in order to have my Geany behave like an IDE.

My Geany Config has been used by students and pupils of mine.

I hate Git.

Anyway,

The files which I have reused are:

- `compile.sh`
- `build.sh`

## `mkproj.sh`

I have created a new file, `mkproj.sh` that will:

1. **Copy:** `master.h` from the folder `utils/` (u can change it)
2. **Copy:** `main.c` or `main.cpp` from the folder `utils/` (u can change it)
3. **Copy:** `compile.sh` and `build.sh` from the folder `utils/` (u can change it)
4. **Copy:** `run.sh` from the folder `utils/` (u can change it)
5. **Copy:** `cbr.sh` from the folder `utils/` (u can change it)

`cbr.sh` - compile -> build -> run

`run.sh` - runs program

## `utils/`

Copy the `utils/` folder inside root or wherever u please (just update the paths from `.bashrc` and `mkproj.sh` and `copycbp.sh`) - very fucking important!

## `.bashrc`

Copy the functions from my `.bashrc` to yours and hit:

```bash
source ~/.bashrc

#!/bin/bash

# Define project root
PROJECT_ROOT=$(dirname "$(dirname "$(realpath "$0")")")
BUILD_DIR="$PROJECT_ROOT/build"
RELEASE_DIR="$PROJECT_ROOT/release"
OUTPUT_EXE="$RELEASE_DIR/program"

# Ensure release directory exists
if [ ! -d "$RELEASE_DIR" ]; then
    mkdir "$RELEASE_DIR"
fi

# Find all object files in build directory
OBJ_FILES=$(find "$BUILD_DIR" -type f -name "*.o")

# Check for OpenGL and WxWidgets usage
USES_OPENGL=$(grep -rIl --include=\*.{c,cpp,h} '^[^/]*#include <GL/' "$PROJECT_ROOT")
USES_WXWIDGETS=$(grep -rIl --include=\*.{c,cpp,h} '^[^/]*#include <wx/' "$PROJECT_ROOT")

# Set flags
OPENGL_FLAGS=""
WXWIDGETS_FLAGS=""
LIBRARY_FLAGS=""

# Determine if only .c files are used
HAS_CPP=$(find "$PROJECT_ROOT" -name "*.cpp")
LINKER="gcc"
if [ -n "$HAS_CPP" ]; then
    LINKER="g++"
fi


if [ -n "$USES_OPENGL" ]; then
    OPENGL_FLAGS="-lGL -lGLU -lglut"
    echo "OpenGL detected, adding flags: $OPENGL_FLAGS"
fi

if [ -n "$USES_WXWIDGETS" ]; then
    WXWIDGETS_FLAGS=$(wx-config --cxxflags --libs)
    echo "WxWidgets detected, adding flags: $WXWIDGETS_FLAGS"
fi

# Check for libraries that gcc does not link by default
# Arguments: library name, its headers (regex), linker flags to add
check_library() {
    if grep -rIqE --include=\*.{c,cpp,h} "^[^/]*#[[:space:]]*include[[:space:]]*<($2)>" "$PROJECT_ROOT"; then
        LIBRARY_FLAGS="$LIBRARY_FLAGS $3"
        echo "$1 detected, adding flags: $3"
    fi
}

check_library "Math" 'math\.h|complex\.h|tgmath\.h|fenv\.h' "-lm"
check_library "Threads" 'pthread\.h|threads\.h' "-pthread"
check_library "Ncurses" 'ncurses\.h|curses\.h' "-lncurses"
check_library "Readline" 'readline/readline\.h' "-lreadline"
check_library "SDL2" 'SDL2/SDL\.h' "-lSDL2"
check_library "SDL2_image" 'SDL2/SDL_image\.h' "-lSDL2_image"
check_library "SDL2_ttf" 'SDL2/SDL_ttf\.h' "-lSDL2_ttf"
check_library "SDL2_mixer" 'SDL2/SDL_mixer\.h' "-lSDL2_mixer"
check_library "Raylib" 'raylib\.h' "-lraylib -lGL -lm -lpthread -ldl -lrt -lX11"
check_library "GLFW" 'GLFW/glfw3\.h' "-lglfw -lGL"
check_library "GLEW" 'GL/glew\.h' "-lGLEW"
check_library "X11" 'X11/Xlib\.h' "-lX11"
check_library "Zlib" 'zlib\.h' "-lz"
check_library "SQLite" 'sqlite3\.h' "-lsqlite3"
check_library "Curl" 'curl/curl\.h' "-lcurl"
check_library "OpenSSL" 'openssl/[a-z0-9_]+\.h' "-lssl -lcrypto"
check_library "GMP" 'gmp\.h' "-lgmp"
check_library "Dynamic loading" 'dlfcn\.h' "-ldl"
check_library "Realtime" 'mqueue\.h|aio\.h' "-lrt"
check_library "Crypt" 'crypt\.h' "-lcrypt"

# Link object files into final executable
if [ -n "$OBJ_FILES" ]; then
    $LINKER $OBJ_FILES -o "$OUTPUT_EXE" $OPENGL_FLAGS $WXWIDGETS_FLAGS $LIBRARY_FLAGS
    echo "Build completed. Executable created at $OUTPUT_EXE"
else
    echo "No object files found. Compile first."
fi


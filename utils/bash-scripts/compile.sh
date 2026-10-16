#!/bin/bash
set -euo pipefail

PROJECT_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
BUILD_DIR="$PROJECT_ROOT/build"

HAS_CPP=$(find "$PROJECT_ROOT" -name "*.cpp")
ONLY_C=true
if [ -n "$HAS_CPP" ]; then
    ONLY_C=false
fi

if [ ! -d "$BUILD_DIR" ]; then
    mkdir "$BUILD_DIR"
else
    find "$BUILD_DIR" -type f -name "*.o" -delete
fi

find "$PROJECT_ROOT" \( -name "*.h" -o -name "*.c" -o -name "*.cpp" \) -printf "%P\n" | awk -F'/' '{OFS="/"; NF--; print}' | sort -u | while read -r REL_PATH; do
    if [ -n "$REL_PATH" ]; then
        mkdir -p "$BUILD_DIR/$REL_PATH"
    fi
done

USES_OPENGL=$(grep -rIl --include=\*.{c,cpp,h} '^[^/]*#include <GL/' "$PROJECT_ROOT" || true)
USES_WXWIDGETS=$(grep -rIl --include=\*.{c,cpp,h} '^[^/]*#include <wx/' "$PROJECT_ROOT" || true)

OPENGL_FLAGS=""
WXWIDGETS_FLAGS=""
GTK4_CFLAGS=()

if [ -n "$USES_OPENGL" ]; then
    OPENGL_FLAGS=$(pkg-config --cflags --libs glu)
    echo "OpenGL detected, adding flags: $OPENGL_FLAGS"
fi

if [ -n "$USES_WXWIDGETS" ]; then
    WXWIDGETS_FLAGS=$(wx-config --cxxflags --libs)
    echo "WxWidgets detected, adding flags: $WXWIDGETS_FLAGS"
fi

# Detect GTK4 and add its compiler flags (include paths, etc.).
if grep -rIqE --include='*.c' --include='*.cpp' --include='*.h' \
        --exclude-dir=build --exclude-dir=release --exclude-dir=.git \
        '^[[:space:]]*#[[:space:]]*include[[:space:]]*[<"]gtk/[^>"]+[>"]' "$PROJECT_ROOT"; then
    if ! pkg-config --exists gtk4; then
        echo "GTK4 detected, but GTK4 development files are missing." >&2
        echo "Install them with: sudo apt install libgtk-4-dev pkg-config" >&2
        exit 1
    fi
    read -r -a GTK4_CFLAGS <<< "$(pkg-config --cflags gtk4)"
    echo "GTK4 detected, adding compiler flags: ${GTK4_CFLAGS[*]}"
fi

find "$PROJECT_ROOT" \( -name "*.c" -o -name "*.cpp" \) -printf "%P\n" | while read -r FILE; do
    REL_DIR="$(dirname "$FILE")"
    OBJ_FILE="$BUILD_DIR/$REL_DIR/$(basename "$FILE" | sed 's/\.[^.]*$/.o/')"
    mkdir -p "$(dirname "$OBJ_FILE")"

    if [[ "$FILE" == *.c ]]; then
        gcc -c "$PROJECT_ROOT/$FILE" -o "$OBJ_FILE" $OPENGL_FLAGS $WXWIDGETS_FLAGS "${GTK4_CFLAGS[@]}"
    elif [[ "$FILE" == *.cpp ]]; then
        g++ -c "$PROJECT_ROOT/$FILE" -o "$OBJ_FILE" $OPENGL_FLAGS $WXWIDGETS_FLAGS "${GTK4_CFLAGS[@]}"
    fi

    echo "Compiled: $FILE -> $OBJ_FILE"
done

echo "Compilation completed. Object files are stored in the build directory."


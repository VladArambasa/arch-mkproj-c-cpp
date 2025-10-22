#!/bin/bash

# Define project root
PROJECT_ROOT=$(dirname "$(realpath "$0")")
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

# Link object files into final executable
if [ -n "$OBJ_FILES" ]; then
    $LINKER $OBJ_FILES -o "$OUTPUT_EXE" $OPENGL_FLAGS $WXWIDGETS_FLAGS
    echo "Build completed. Executable created at $OUTPUT_EXE"
else
    echo "No object files found. Compile first."
fi


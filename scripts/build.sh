#!/usr/bin/bash

# Configuration
MAIN_FILE=main.py
BUILD_DIR=build

python -m nuitka ${MAIN_FILE} \
    --onefile \
    --output-dir=${BUILD_DIR} \
    --enable-plugin=pyside6 \
    || raise_error "⛔ Failed to compile the app"

# Helper function to raise error
raise_error() {
    echo "$1"
    exit 1
}
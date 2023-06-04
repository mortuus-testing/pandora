#!/usr/bin/bash

# Utility function to get the os type
get_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"; return
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"; return
    elif [[ "$OSTYPE" == "cygwin" ]]; then
        echo "windows"; return
    elif [[ "$OSTYPE" == "msys" ]]; then
        echo "windows"; return
    elif [[ "$OSTYPE" == "msys" ]]; then
        echo "windows"; return
    fi
}

# Helper function to raise an error
raise_error() {
    echo "$1"
    exit 1
}

# Create filename based on os
file_name_based_on_os() {
    if [[ "$1" == "linux" ]]; then
        echo "pandora-linux"; return
    elif [[ "$1" == "macos" ]]; then
        echo "pandora-macos"; return
    elif [[ "$1" == "windows" ]]; then
        echo "pandora-windows.exe"; return
    fi
}

# Create icon config based on os
other_config_based_on_os() {
    if [[ "$1" == "linux" ]]; then
        echo "--linux-icon=$2"; return
    elif [[ "$1" == "macos" ]]; then
        echo "--macos-app-icon=$2 --macos-create-app-bundle"; return
    elif [[ "$1" == "windows" ]]; then
        echo "--windows-icon-from-ico=$2"; return
    fi
}

# Configuration
OS=$(get_os)
MAIN_FILE=./main.py
BUILD_DIR=./build
ICON_PATH=./assets/icon.png
FILENAME=$(file_name_based_on_os "${OS}")
PLATFORM_SPECIFIC_CONFIG=$(other_config_based_on_os "${OS}" "${ICON_PATH}")

echo "🗿 Create build for ${OS}"

python -m nuitka ${MAIN_FILE} \
    --onefile \
    --output-dir=${BUILD_DIR} \
    --enable-plugin=pyside6 \
    --disable-console \
    --output-filename=${FILENAME} \
    ${PLATFORM_SPECIFIC_CONFIG} \
    || raise_error "⛔ Failed to compile the app"

echo "✅ Build complete"
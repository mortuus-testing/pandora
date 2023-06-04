#!/usr/bin/bash
# false || (echo "A" && exit 1)

# Configuration
MAIN_FILE=main.py
BUILD_DIR=build
# VENV_PATH=./venv/bin/activate

# Activate virtual environment
# echo "🐍 Activating virtual env"
# source ${VENV_PATH}

# Helper function to raise error
raise_error() {
    echo "$1"
    exit 1
}

# Install dependencies
echo "📦 Checking dependencies"
INSTALLED=$(pip list --disable-pip-version-check)
while read -r LINE || [ -n "$LINE" ]; do
    PACKAGE_NAME=${LINE%==*}
    if [[ $INSTALLED != *"${PACKAGE_NAME}"* ]]; then
        echo "    - Installing package [${PACKAGE_NAME}]"
        python -m pip install --disable-pip-version-check "${PACKAGE_NAME}" \
        || raise_error "⛔ Failed to install [${PACKAGE_NAME}]"
    fi
done < requirements.txt
echo "📜 Dependencies resolved"

# Compiling program
echo "🔨 Compiling the app"
python -m nuitka ${MAIN_FILE} \
    --onefile \
    --output-dir=${BUILD_DIR} \
    --enable-plugin=pyside6 \
    || raise_error "⛔ Failed to compile the app"
    
echo "🚀 Success"

# deactivate
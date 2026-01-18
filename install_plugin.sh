#!/bin/bash

# Script to install the latest version of the VSCode Extension from the _Releases folder

# name of the Extension to install/uninstall
EXTENSION_ID="mvatter.kontakt-api-tools"

# check if the extension is already installed and uninstall it
if code --list-extensions | grep -q "$EXTENSION_ID"; then
    echo "Uninstalling existing extension $EXTENSION_ID..."
    code --uninstall-extension "$EXTENSION_ID"
else
    echo "No installed extension $EXTENSION_ID found."
fi

# Find the latest .vsix file in the _Releases directory based on version number
LATEST_VSIX=$(find _Releases -name '*.vsix' | sort -V | tail -n 1)

# Check if a .vsix file was found
if [[ -z "$LATEST_VSIX" ]]; then
    echo "No .vsix file found in the _Releases directory."
    exit 1
fi

echo "Installing the extension from $LATEST_VSIX..."
code --install-extension "$LATEST_VSIX"

echo "Installation completed."
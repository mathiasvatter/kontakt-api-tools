#!/bin/bash

# Script to compile and build the VSCode Extension Package as a .vsix file into the _Releases folder

# compile TypeScript files
npm run compile

# define destination directory
DEST_DIR="_Releases"

echo "Creating destination directory $DEST_DIR..."
mkdir -p "$DEST_DIR"

echo "Packaging the extension in the directory $DEST_DIR..."
vsce package

echo "The extension was packaged successfully."

# Move the .vsix package to the _Releases folder, one level up
mv -f *.vsix "$DEST_DIR"

echo "The extension was moved to the _Releases folder."

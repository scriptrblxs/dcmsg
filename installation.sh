#!/bin/bash

URL="https://raw.githubusercontent.com/scriptrblxs/dcmsg/refs/tags/v1.0.0/dcmsg"
FILENAME="$(basename "$URL")"

if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
    DEST="$PROGRAMFILES/dcmsg"
    EXPORT_PATH="/c/Program Files/dcmsg"
    SET_PATH_CMD="setx PATH \"$PATH;$EXPORT_PATH\""
else
    DEST="/usr/local/bin/dcmsg"
    EXPORT_PATH="$DEST"
    SET_PATH_CMD="echo 'export PATH=\"\$PATH:$EXPORT_PATH\"' >> ~/.bashrc"
fi

curl -o "$FILENAME" "$URL"
if [ $? -ne 0 ]; then
    echo "Error: Failed to download file."
    exit 1
fi

if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
    mkdir -p "$DEST"
else
    sudo mkdir -p "$DEST"
fi

if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
    mv "$FILENAME" "$DEST/"
else
    sudo mv "$FILENAME" "$DEST/"
fi

export PATH="$PATH:$EXPORT_PATH"
eval "$SET_PATH_CMD"

if [ $? -eq 0 ]; then
    echo "Successfully installed 'dcmsg'. Restart your terminal to apply PATH changes."
else
    echo "Error: Failed to update PATH."
    exit 1
fi

#!/bin/bash


wget  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip

FONT_ARCHIVE="JetBrainsMono.zip"

# Check if the file exists
if [ ! -f "$FONT_ARCHIVE" ]; then
  echo "Error: File '$FONT_ARCHIVE' not found!"
  exit 1
fi

echo Installing fonts
# Create a temporary directory for extracting the fonts
TEMP_DIR=$(mktemp -d)

# Extract the font archive
unzip -q "$FONT_ARCHIVE" -d "$TEMP_DIR"

# Install fonts by copying them to the Fonts folder
find "$TEMP_DIR" -type f \( -iname "*.ttf" -o -iname "*.otf" \) -exec cp {} ~/Library/Fonts/ \;

# Cleanup
rm -rf "$TEMP_DIR" "$FONT_ARCHIVE"

echo "Fonts installed successfully!"


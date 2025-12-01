#!/bin/bash
# clean_and_rename_pdfs.sh
# Cleans metadata and renames PDFs with website prefix

EXIFTOOL="./exiftool.exe"
PREFIX="FMM_"   # Change this to your website prefix
BASE_DIR=$(pwd)

# Step 1: Clean all PDFs in-place
echo "Cleaning metadata from PDFs..."
find . -type f -iname "*.pdf" | while read -r FILE; do
    "$EXIFTOOL" -all= -overwrite_original "$FILE"
    echo "Cleaned: $FILE"
done

# Step 2: Rename PDFs with prefix
echo "Renaming PDFs with prefix '$PREFIX'..."
find . -type f -iname "*.pdf" | while read -r FILE; do
    DIR=$(dirname "$FILE")
    BASENAME=$(basename "$FILE")
    # Skip if already has prefix
    if [[ "$BASENAME" != "$PREFIX"* ]]; then
        NEWNAME="$DIR/$PREFIX$BASENAME"
        mv "$FILE" "$NEWNAME"
        echo "Renamed: $BASENAME → $PREFIX$BASENAME"
    fi
done

echo "All PDFs cleaned and renamed successfully!"

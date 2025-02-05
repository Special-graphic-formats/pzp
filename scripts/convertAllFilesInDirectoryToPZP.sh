#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"
cd ..


# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_directory> <output_directory>"
    exit 1
fi

INPUT_DIR="$1"
OUTPUT_DIR="$2"

# Ensure output directory exists
mkdir -p "$OUTPUT_DIR"

# Scan for image files
for file in "$INPUT_DIR"/*.{jpg,jpeg,png,bmp,tiff,tif}; do
    # Check if file exists to avoid issues with wildcards
    [ -e "$file" ] || continue
    
    # Extract filename without path and extension
    FILENAME=$(basename -- "$file")
    FILENAME_NO_EXT="${FILENAME%.*}"
    
    # Convert image to temporary PNM format
    convert "$file" temporary.pnm
    
    # Compress using pzp
    ./pzp compress temporary.pnm "$OUTPUT_DIR/$FILENAME_NO_EXT.pzp"
    
    # Remove temporary file
    rm -f temporary.pnm

done

echo "Processing complete."

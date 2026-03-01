#!/bin/bash
# Generate PWA icons from SVG template

cd "$(dirname "$0")"

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
    echo "ImageMagick is not installed. Please install it first:"
    echo "  Ubuntu/Debian: sudo apt-get install imagemagick"
    echo "  macOS: brew install imagemagick"
    exit 1
fi

# Source file
SOURCE="icon-template.svg"

if [ ! -f "$SOURCE" ]; then
    echo "Error: $SOURCE not found"
    exit 1
fi

# Icon sizes needed for PWA
sizes=(72 96 128 144 152 192 384 512)

echo "Generating PWA icons from $SOURCE..."

for size in "${sizes[@]}"; do
    output="icon-${size}x${size}.png"
    echo "Creating $output..."
    convert -background none -resize ${size}x${size} "$SOURCE" "$output"
done

echo "✓ All icons generated successfully!"
echo "Icons created: ${sizes[@]/#/icon-}x${sizes[@]}.png"

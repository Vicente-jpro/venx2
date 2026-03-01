# PWA Icons

This folder contains the icons required for the Progressive Web App (PWA) functionality.

## Required Icon Sizes

The PWA requires icons in the following sizes:
- 72x72
- 96x96
- 128x128
- 144x144
- 152x152
- 192x192
- 384x384
- 512x512

## How to Generate Icons

You can generate all required icon sizes from a single high-resolution image (at least 512x512) using one of these methods:

### Method 1: Using Online Tools
1. Visit https://www.pwabuilder.com/imageGenerator or https://realfavicongenerator.net/
2. Upload your logo/icon (minimum 512x512px, PNG format)
3. Download the generated icons
4. Place them in this folder

### Method 2: Using ImageMagick (Command Line)
If you have a 512x512 source image named `icon.png`:

```bash
convert icon.png -resize 72x72 icon-72x72.png
convert icon.png -resize 96x96 icon-96x96.png
convert icon.png -resize 128x128 icon-128x128.png
convert icon.png -resize 144x144 icon-144x144.png
convert icon.png -resize 152x152 icon-152x152.png
convert icon.png -resize 192x192 icon-192x192.png
convert icon.png -resize 384x384 icon-384x384.png
convert icon.png -resize 512x512 icon-512x512.png
```

### Method 3: Using a Script
Create a bash script to generate all sizes at once:

```bash
#!/bin/bash
sizes=(72 96 128 144 152 192 384 512)
for size in "${sizes[@]}"; do
  convert icon-source.png -resize ${size}x${size} icon-${size}x${size}.png
done
```

## Current Status
⚠️ **Action Required**: Please add your app icons to this folder in the sizes listed above.

Until you add custom icons, the PWA functionality will work but may show placeholder icons or fail silently when installing.

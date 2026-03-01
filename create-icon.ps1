# PowerShell Script to Create Icon for Venx2
# This script helps create an .ico file from a PNG image
# Usage: Right-click → Run with PowerShell

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Venx2 Icon Creator" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if we have a PNG or JPG file to convert
$imageFiles = Get-ChildItem -Path "." -Include @("*.png", "*.jpg", "*.jpeg") -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.FullName -like "*assets*images*" }

if ($imageFiles.Count -eq 0) {
    Write-Host "No PNG or JPG images found in assets/images folder." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "To create an icon for the installer:" -ForegroundColor White
    Write-Host "1. Place a PNG or JPG image in app/assets/images/" -ForegroundColor White
    Write-Host "2. Run this script again" -ForegroundColor White
    Write-Host ""
    Write-Host "Alternatively, create an icon online:" -ForegroundColor White
    Write-Host "- Visit: https://convertio.co/png-ico/" -ForegroundColor Cyan
    Write-Host "- Upload your image" -ForegroundColor White
    Write-Host "- Download the .ico file" -ForegroundColor White
    Write-Host "- Save it as: app/assets/images/icon.ico" -ForegroundColor White
    Write-Host ""
    Write-Host "Or use Windows built-in Paint:" -ForegroundColor White
    Write-Host "1. Open your image in Paint" -ForegroundColor White
    Write-Host "2. Resize to 256x256 pixels (Image → Resize)" -ForegroundColor White
    Write-Host "3. Save As → BMP file" -ForegroundColor White
    Write-Host "4. Rename .bmp to .ico" -ForegroundColor White
    Write-Host "5. Place in app/assets/images/icon.ico" -ForegroundColor White
    Write-Host ""
    Pause
    exit
}

Write-Host "Found the following images:" -ForegroundColor Green
for ($i = 0; $i -lt $imageFiles.Count; $i++) {
    Write-Host "[$i] $($imageFiles[$i].FullName)" -ForegroundColor Yellow
}
Write-Host ""

$selection = Read-Host "Select image number to convert (or press Enter to cancel)"

if ([string]::IsNullOrWhiteSpace($selection)) {
    Write-Host "Cancelled." -ForegroundColor Yellow
    exit
}

$selectedImage = $imageFiles[[int]$selection]

if ($null -eq $selectedImage) {
    Write-Host "Invalid selection." -ForegroundColor Red
    Pause
    exit
}

Write-Host ""
Write-Host "Selected: $($selectedImage.Name)" -ForegroundColor Green
Write-Host ""

# Check if ImageMagick is available
$magickPath = (Get-Command "magick.exe" -ErrorAction SilentlyContinue).Path

if ($null -eq $magickPath) {
    Write-Host "ImageMagick is not installed." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "To convert the image to .ico format, you can:" -ForegroundColor White
    Write-Host ""
    Write-Host "Option 1: Use an online converter (Easiest)" -ForegroundColor Cyan
    Write-Host "- Visit: https://convertio.co/png-ico/" -ForegroundColor White
    Write-Host "- Upload: $($selectedImage.FullName)" -ForegroundColor White
    Write-Host "- Download the .ico file" -ForegroundColor White
    Write-Host "- Save it as: app/assets/images/icon.ico" -ForegroundColor White
    Write-Host ""
    Write-Host "Option 2: Install ImageMagick" -ForegroundColor Cyan
    Write-Host "- Download from: https://imagemagick.org/script/download.php" -ForegroundColor White
    Write-Host "- Install with 'Add to PATH' option" -ForegroundColor White
    Write-Host "- Run this script again" -ForegroundColor White
    Write-Host ""
    Write-Host "Would you like to open the online converter now? (Y/N)" -ForegroundColor Yellow
    $response = Read-Host
    
    if ($response -eq "Y" -or $response -eq "y") {
        Start-Process "https://convertio.co/png-ico/"
        Write-Host "Browser opened. After conversion, save the icon to:" -ForegroundColor Green
        Write-Host "app/assets/images/icon.ico" -ForegroundColor Cyan
    }
    
    Write-Host ""
    Pause
    exit
}

# Create icon using ImageMagick
$outputPath = Join-Path (Split-Path $selectedImage.FullName) "icon.ico"

Write-Host "Converting to icon..." -ForegroundColor Yellow
Write-Host ""

try {
    # Create multi-resolution icon (256, 128, 64, 48, 32, 16)
    & $magickPath convert $selectedImage.FullName -define icon:auto-resize=256,128,64,48,32,16 $outputPath
    
    if (Test-Path $outputPath) {
        Write-Host "Success! Icon created at:" -ForegroundColor Green
        Write-Host $outputPath -ForegroundColor Cyan
        Write-Host ""
        Write-Host "You can now build the installer." -ForegroundColor Green
    } else {
        throw "Icon file was not created"
    }
} catch {
    Write-Host "Error creating icon: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please use the online converter instead:" -ForegroundColor Yellow
    Write-Host "https://convertio.co/png-ico/" -ForegroundColor Cyan
}

Write-Host ""
Pause

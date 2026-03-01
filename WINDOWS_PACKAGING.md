# Creating a Windows Package for Your PWA

This guide explains how to create a standalone Windows installer for your Venx2 PWA.

## Option 1: PWABuilder (Recommended)

### Web Interface
1. Visit https://www.pwabuilder.com/
2. Enter your production URL (must be HTTPS)
3. Click **"Start"**
4. Review the PWA quality score
5. Click **"Package For Stores"**
6. Select **"Windows"**
7. Configure options:
   - Package ID: `com.yourcompany.venx2`
   - Publisher Display Name: Your Company Name
   - Version: `1.0.0.0`
8. Click **"Generate"**
9. Download the Windows package (.msix file)

### Command Line
```bash
# Install PWABuilder CLI
npm install -g @pwabuilder/cli

# Generate Windows package
pwabuilder package https://your-production-url.com \
  --platform windows \
  --output ./windows-package

# The package will be in ./windows-package/windows/
```

## Option 2: Manual Package Creation

### Prerequisites
```bash
npm install -g pwabuilder-windows10-platform
```

### Create Package
```bash
# Navigate to your project root
cd /home/vicente-jpro/rails-projects/venx2

# Create Windows 10 package
pwabuilder-windows10-platform \
  --package \
  --manifest ./public/manifest.json \
  --url https://your-production-url.com
```

## Option 3: Microsoft Store Submission

### Step-by-Step:

1. **Get your package** (from Option 1 or 2)

2. **Create Microsoft Partner account:**
   - Go to https://partner.microsoft.com/dashboard
   - Sign in with Microsoft account
   - Pay one-time $19 registration fee
   - Complete registration

3. **Reserve app name:**
   - Dashboard → "Apps and games"
   - Click "New product" → "App"
   - Reserve name: "Venx2"

4. **Prepare submission:**
   - **App properties:**
     - Category: Business / Productivity
     - Age rating: Everyone
   
   - **Pricing:**
     - Free or set price
   
   - **App listings:**
     - Description (200+ words)
     - Screenshots (at least 1, 1280x720 or larger)
     - Icons (from your PWA manifest)
   
   - **Privacy policy:**
     - URL to your privacy policy (required)

5. **Upload package:**
   - Go to "Packages" section
   - Upload .msix file from PWABuilder
   - Wait for validation

6. **Submit for review:**
   - Review all sections
   - Click "Submit to Store"
   - Certification usually takes 24-48 hours

### Required Assets for Store:

**Screenshots** (PNG or JPEG):
- At least 1 screenshot
- Minimum 1280 x 720 pixels
- Maximum 3840 x 2160 pixels
- Can capture from installed PWA

**App tile icon** (already created in `/public/icons/`):
- 512x512 PNG (you have this!)

**Store listing images** (optional but recommended):
- Hero image: 1920 x 1080
- Promotional images: 2400 x 1200

### Capturing Screenshots:

```bash
# On Windows, with app installed:
# 1. Open the installed Venx2 app
# 2. Press Windows + Shift + S to capture
# 3. Or use Snipping Tool
# 4. Save as PNG, at least 1280x720
```

## Option 4: Electron Wrapper (Alternative)

If you need deeper Windows integration (file system access, system tray, etc.):

```bash
# Install electron-packager
npm install -g electron-packager

# Create main.js for Electron
cat > electron-main.js << 'EOF'
const { app, BrowserWindow } = require('electron')

function createWindow() {
  const win = new BrowserWindow({
    width: 1200,
    height: 800,
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true
    }
  })
  
  // Load your production URL
  win.loadURL('https://your-production-url.com')
}

app.whenReady().then(createWindow)
EOF

# Package for Windows
electron-packager . Venx2 \
  --platform=win32 \
  --arch=x64 \
  --icon=./public/icons/icon-512x512.png \
  --out=./dist-electron

# Create installer with electron-builder
npm install -g electron-builder
electron-builder --windows
```

⚠️ **Note:** Electron creates much larger packages (100+ MB) compared to PWA packages (< 1 MB).

## Testing Your Package

### Test .msix package locally:
1. Enable Developer Mode in Windows Settings
2. Right-click the .msix file
3. Select "Install"
4. Test the installed app

### Before Store submission:
- ✅ Test on Windows 10 and 11
- ✅ Test installation and uninstallation
- ✅ Verify offline functionality
- ✅ Check all features work correctly
- ✅ Ensure HTTPS is working in production
- ✅ Validate manifest.json and service worker

## Troubleshooting

### "Package validation failed"
- Ensure your production site uses HTTPS
- Check manifest.json is accessible
- Verify service worker is registered
- Run PWA audit in Chrome DevTools

### "App doesn't install"
- Check Windows 10 version (needs 1903+)
- Enable Developer Mode
- Try installing from PowerShell:
  ```powershell
  Add-AppxPackage -Path "path\to\your.msix"
  ```

### "Service worker not found"
- Ensure `/service-worker.js` is accessible
- Check Content-Type header is correct
- Verify no caching issues

## Resources

- **PWABuilder**: https://www.pwabuilder.com/
- **Microsoft Partner Center**: https://partner.microsoft.com/
- **PWA Documentation**: https://docs.pwabuilder.com/
- **Windows PWA Guide**: https://docs.microsoft.com/en-us/microsoft-edge/progressive-web-apps-chromium/

## Quick Commands Summary

```bash
# Generate Windows package
npm install -g @pwabuilder/cli
pwabuilder package https://your-app.com --platform windows

# Test package locally on Windows
Add-AppxPackage -Path "your-package.msix"

# Check PWA quality
# Visit: https://www.pwabuilder.com/
```

## Automatic Updates

PWAs in the Microsoft Store automatically update when you:
1. Deploy new version to your server
2. Update the version in manifest.json
3. Service worker detects changes and updates cache

No need to resubmit to Store for app updates! 🎉

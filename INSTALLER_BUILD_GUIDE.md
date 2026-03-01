# Building the Venx2 Windows Installer

This guide explains how to create the Windows installer for Venx2.

## Prerequisites

1. **Inno Setup 6** or later
   - Download from: https://jrsoftware.org/isdl.php
   - Install with default settings
   - Default location: `C:\Program Files (x86)\Inno Setup 6\`

2. **Application Icon** (optional but recommended)
   - Create or obtain an `.ico` file
   - Place it at: `app/assets/images/icon.ico`
   - Recommended size: 256x256 pixels with multiple resolutions
   - Tools to create icons:
     - Online: https://convertio.co/png-ico/
     - Desktop: GIMP, IcoFX, Greenfish Icon Editor Pro

## Building the Installer

### Method 1: Using the Build Script (Easiest)

1. Open the project folder in File Explorer
2. Double-click `build-installer.bat`
3. Wait for the build process to complete
4. The installer will be created in the `installer-output` folder

### Method 2: Using Inno Setup IDE

1. Open Inno Setup Compiler
2. Click `File` → `Open`
3. Select `windows-installer.iss` from the project root
4. Click `Build` → `Compile` (or press F9)
5. The installer will be created in the `installer-output` folder

### Method 3: Command Line

```bash
# Navigate to project directory
cd C:\path\to\venx2

# Compile the installer
"C:\Program Files (x86)\Inno Setup 6\ISCC.exe" windows-installer.iss
```

## Customizing the Installer

Edit `windows-installer.iss` to customize:

### Application Information

```
#define MyAppName "Venx2"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Your Company Name"
#define MyAppURL "https://your-company-website.com"
```

### Installation Directory

```
DefaultDirName={autopf}\{#MyAppName}
```

Change to custom directory:
```
DefaultDirName=C:\MyCustomPath\{#MyAppName}
```

### Application Icon

```
SetupIconFile=app\assets\images\icon.ico
```

### Files to Exclude

```
Excludes: "node_modules,tmp,log,storage\*.sqlite3,coverage,.git,.bundle"
```

Add more exclusions as needed.

## What the Installer Does

1. **Checks for Dependencies**
   - Checks if Ruby and Node.js are installed
   - Shows status during installation

2. **Copies Application Files**
   - Copies all necessary application files
   - Excludes development and temporary files
   - Preserves directory structure

3. **Installs Dependencies** (optional post-install step)
   - Ruby 3.2.1 (if not installed)
   - Node.js LTS (if not installed)
   - Bundler (Ruby package manager)
   - Yarn (JavaScript package manager)

4. **Sets Up the Application** (optional post-install step)
   - Installs Ruby gems (`bundle install`)
   - Installs Node packages (`yarn install`)
   - Creates and migrates database
   - Seeds initial data
   - Builds assets (JavaScript and CSS)

5. **Creates Shortcuts**
   - Desktop shortcut (if selected)
   - Start Menu entry
   - Quick Launch icon (if selected)

6. **Launches Application** (optional)
   - Starts the Rails server
   - Opens the browser

## Testing the Installer

1. **Build the installer** using one of the methods above

2. **Test on a clean Windows machine** or VM:
   - No Ruby installed
   - No Node.js installed
   - Fresh Windows installation

3. **Test install process:**
   - Run the installer
   - Choose to install dependencies
   - Choose to launch the app
   - Verify the app starts correctly

4. **Test the application:**
   - Click the desktop icon
   - Verify the server starts
   - Verify the browser opens
   - Test application functionality

5. **Test uninstallation:**
   - Uninstall using Windows Settings
   - Verify all files are removed
   - Verify shortcuts are removed

## Distributing the Installer

### For Internal Use:

1. **Network Share**
   - Copy installer to shared network drive
   - Email the network path to users

2. **Email Distribution**
   - Zip the installer if needed
   - Send via email with installation instructions

3. **USB Drive**
   - Copy installer to USB drive
   - Distribute physically

### For Public Distribution:

1. **Code Signing** (Recommended)
   - Purchase a code signing certificate
   - Sign the installer to avoid Windows SmartScreen warnings
   - Use SignTool: `signtool sign /f certificate.pfx /p password installer.exe`

2. **Web Download**
   - Host on your company website
   - Provide download link
   - Include SHA-256 checksum for verification

3. **Microsoft Store** (Optional)
   - See `WINDOWS_PACKAGING.md` for PWA Store submission
   - Different approach than this desktop installer

## Troubleshooting Build Issues

### Inno Setup not found:
- Install Inno Setup from: https://jrsoftware.org/isdl.php
- Update `INNO_SETUP_PATH` in `build-installer.bat` if installed elsewhere

### Icon file not found:
- Create `app/assets/images/icon.ico`
- Or remove icon references from `windows-installer.iss`

### Build fails with file not found:
- Check that all files referenced in `.iss` exist
- Verify paths are correct (relative to project root)
- Check for typos in file paths

### Installer is too large:
- Add more exclusions to the `Excludes` parameter
- Remove unnecessary files from the project
- Use compression: `Compression=lzma2/max`

## Updating the Application

To create an installer for a new version:

1. Update version number in `windows-installer.iss`:
   ```
   #define MyAppVersion "1.1.0"
   ```

2. Rebuild the installer

3. Users can install over the existing version (upgrade)
   - Data and settings are preserved
   - Or uninstall first for clean installation

## Advanced Configuration

### Custom Post-Install Actions

Edit the `[Run]` section in `windows-installer.iss`:

```
[Run]
Filename: "{app}\bin\my-custom-script.bat"; Description: "Run custom setup"; Flags: postinstall
```

### Multi-Language Support

Add more languages in the `[Languages]` section:

```
[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
```

### Registry Settings

Add to the `[Registry]` section:

```
[Registry]
Root: HKCU; Subkey: "Software\YourCompany\Venx2"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"
```

## Support

For issues or questions about creating the installer:

1. Check Inno Setup documentation: https://jrsoftware.org/ishelp/
2. Review example scripts in Inno Setup installation folder
3. Contact your system administrator

## License

The installer script is part of the Venx2 application.
See `LICENSE.txt` for details.

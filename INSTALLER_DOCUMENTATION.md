# Venx2 Windows Installer - Complete Documentation

## Overview

This installer system provides a professional, automated installation experience for Venx2 on Windows. When users click the desktop icon after installation, the application starts automatically.

## 🎯 What It Does

**For End Users:**
- ✅ One-click installation of the entire application
- ✅ Automatic installation of all dependencies (Ruby, Node.js)
- ✅ Desktop icon that launches the app automatically
- ✅ Start Menu integration
- ✅ Clean uninstallation

**For Developers:**
- ✅ Professional installer using Inno Setup
- ✅ Fully automated build process
- ✅ Customizable branding and configuration
- ✅ Easy distribution

## 📁 Files Created

### Core Installer Files

| File | Purpose |
|------|---------|
| **windows-installer.iss** | Main Inno Setup configuration script |
| **build-installer.bat** | Automated build script for creating the installer |
| **LICENSE.txt** | Application license shown during installation |

### Application Launcher Files

| File | Purpose |
|------|---------|
| **bin/start-venx2.bat** | Main launcher script (runs when icon is clicked) |
| **bin/install-dependencies.bat** | Installs Ruby, Node.js, Yarn, Bundler |

### Documentation Files

| File | Purpose |
|------|---------|
| **WINDOWS_INSTALL.md** | User installation guide (updated) |
| **INSTALLER_BUILD_GUIDE.md** | Detailed guide for building the installer |
| **INSTALLER_README.md** | Quick reference for developers |
| **SETUP_CHECKLIST.bat** | Interactive setup checklist |

### Helper Files

| File | Purpose |
|------|---------|
| **create-icon.ps1** | PowerShell script to create .ico files |
| **README.md** | Main readme (updated with installer info) |

## 🚀 Quick Start

### For Administrators Building the Installer:

1. **Install Inno Setup**
   ```
   Download from: https://jrsoftware.org/isdl.php
   ```

2. **Create an Icon** (optional)
   ```powershell
   # Right-click and run:
   create-icon.ps1
   ```

3. **Build the Installer**
   ```cmd
   build-installer.bat
   ```

4. **Result**
   ```
   installer-output/Venx2-Setup-1.0.0.exe
   ```

### For End Users Installing:

1. **Run the Installer**
   - Double-click `Venx2-Setup-1.0.0.exe`
   - Follow the wizard

2. **Launch the Application**
   - Double-click the "Venx2" desktop icon
   - Or: Start Menu → Venx2

3. **The App Automatically:**
   - Starts the Rails server
   - Opens your browser
   - Navigates to http://localhost:3000

## 🔧 How It Works

### Installation Process

```
User runs installer
    ↓
Inno Setup extracts files to C:\Program Files\Venx2\
    ↓
Checks for Ruby and Node.js
    ↓
Offers to install missing dependencies
    ↓
Runs bundle install and yarn install
    ↓
Sets up database (db:create, db:migrate, db:seed)
    ↓
Builds assets (yarn build, yarn build:css)
    ↓
Creates desktop and Start Menu shortcuts
    ↓
Installation complete!
```

### Application Launch Process

```
User clicks desktop icon (start-venx2.bat)
    ↓
Checks if Ruby and Node.js are installed
    ↓
Checks if dependencies are installed
    ↓
Installs missing dependencies if needed
    ↓
Sets up database if needed
    ↓
Builds assets
    ↓
Starts Rails server (bundle exec rails server)
    ↓
Waits 5 seconds
    ↓
Opens browser to http://localhost:3000
    ↓
Application running!
```

## 📝 Customization Guide

### Change Application Name

Edit `windows-installer.iss`:
```pascal
#define MyAppName "Your App Name"
```

### Change Version Number

Edit `windows-installer.iss`:
```pascal
#define MyAppVersion "2.0.0"
```

### Change Company Name

Edit `windows-installer.iss`:
```pascal
#define MyAppPublisher "Your Company"
#define MyAppURL "https://yourcompany.com"
```

### Change Installation Directory

Edit `windows-installer.iss`:
```pascal
DefaultDirName=C:\YourPath\{#MyAppName}
```

### Add Your Logo/Icon

1. Create `app/assets/images/icon.ico` (256x256 recommended)
2. Or use `create-icon.ps1` to convert existing images

### Modify Startup Behavior

Edit `bin/start-venx2.bat` to customize:
- Port number (default: 3000)
- Browser to open
- Environment (development/production)
- Additional startup tasks

## 🧪 Testing Procedure

### Minimum Testing

- [ ] Build installer successfully
- [ ] Install on a Windows computer
- [ ] Click desktop icon
- [ ] Verify app starts automatically
- [ ] Test basic app functionality
- [ ] Uninstall and verify cleanup

### Comprehensive Testing

- [ ] Test on clean Windows 10 VM (no Ruby/Node.js)
- [ ] Test on clean Windows 11 VM
- [ ] Test on computer with Ruby already installed
- [ ] Test on computer with Node.js already installed
- [ ] Test upgrade installation (install over existing)
- [ ] Test in different languages (if multi-language)
- [ ] Test with antivirus software enabled
- [ ] Test limited user account (non-admin)
- [ ] Test with firewall enabled
- [ ] Test offline functionality (after initial install)

## 🐛 Troubleshooting

### Build Issues

**Problem:** Inno Setup not found
- **Solution:** Install from https://jrsoftware.org/isdl.php
- Update `INNO_SETUP_PATH` in `build-installer.bat`

**Problem:** Icon file not found
- **Solution:** Create `app/assets/images/icon.ico`
- Or remove icon references from `windows-installer.iss`

**Problem:** Build fails with "file not found"
- **Solution:** Check all file paths in `windows-installer.iss`
- Verify files exist in the project

### Installation Issues

**Problem:** Dependencies won't install
- **Solution:** Run installer as administrator
- Check internet connection
- Manually install from:
  - Ruby: https://rubyinstaller.org/
  - Node.js: https://nodejs.org/

**Problem:** Application won't start
- **Solution:** 
  - Run `bin/install-dependencies.bat` manually
  - Check if port 3000 is available
  - Review logs in `log/development.log`

**Problem:** SmartScreen blocks installer
- **Solution:** Click "More info" → "Run anyway"
- Or: Sign the installer with a code signing certificate

### Runtime Issues

**Problem:** Server starts but browser doesn't open
- **Solution:** Manually open http://localhost:3000
- Check default browser settings

**Problem:** Database errors
- **Solution:** Delete `storage/development.sqlite3`
- Restart the application

**Problem:** Port 3000 already in use
- **Solution:** 
  - Kill existing processes: `netstat -ano | findstr :3000`
  - Or change port in `bin/start-venx2.bat`

## 📦 Distribution Methods

### Internal Distribution

**Network Share:**
```
1. Copy installer to \\server\software\Venx2\
2. Email path to users
3. Users run from network location
```

**Email:**
```
1. Zip the installer if needed
2. Send with WINDOWS_INSTALL.md
3. Users download and install
```

**USB Drive:**
```
1. Copy installer to USB
2. Include printed installation instructions
3. Distribute physically
```

### External Distribution

**Website Download:**
```
1. Host on company website
2. Generate SHA-256 checksum
3. Provide download link
4. Include installation instructions
```

**Code Signed (Recommended):**
```powershell
# Sign the installer
signtool sign /f certificate.pfx /p password Venx2-Setup-1.0.0.exe

# Verify signature
signtool verify /pa Venx2-Setup-1.0.0.exe
```

## 🔒 Security Considerations

### Code Signing

**Why:**
- Prevents Windows SmartScreen warnings
- Verifies installer authenticity
- Professional appearance

**How:**
1. Purchase code signing certificate ($100-$500/year)
2. Sign installer with `signtool`
3. Distribute signed installer

### Checksum Verification

Generate SHA-256 checksum:
```powershell
Get-FileHash Venx2-Setup-1.0.0.exe -Algorithm SHA256
```

Include checksum with download link:
```
Venx2-Setup-1.0.0.exe
SHA-256: abc123def456...
```

### Permissions

The installer requests admin privileges to:
- Install to Program Files
- Install Ruby and Node.js (if needed)
- Create system-wide shortcuts

Users can install without admin by:
- Changing `PrivilegesRequired=lowest` in `windows-installer.iss`
- Installing to user directory

## 📊 File Size Considerations

**Installer Size:**
- Base app: ~50-100 MB
- With Ruby/Node.js embedded: ~500 MB - 1 GB

**Reduce Size:**
- Don't bundle Ruby/Node.js (let install-dependencies.bat download)
- Exclude unnecessary files in `Excludes` parameter
- Use `Compression=lzma2/max`

**Current Configuration:**
- Excludes: `node_modules`, `tmp`, `log`, `.git`, `.bundle`
- Ruby/Node.js downloaded during installation
- Resulting size: ~50-100 MB

## 🔄 Update Strategy

### Version Updates

1. Update version in `windows-installer.iss`:
   ```pascal
   #define MyAppVersion "1.1.0"
   ```

2. Build new installer

3. Users can:
   - Install over existing (upgrade)
   - Or uninstall first (clean install)

### Automatic Updates

Consider implementing:
- Update checker in the application
- Download new installer automatically
- Notify users when updates available

## 📖 Additional Resources

### Inno Setup Documentation
- Official Site: https://jrsoftware.org/ishelp/
- Examples: `C:\Program Files (x86)\Inno Setup 6\Examples\`
- FAQ: https://jrsoftware.org/isfaq.php

### Ruby Installation
- RubyInstaller: https://rubyinstaller.org/
- Ruby Docs: https://www.ruby-lang.org/

### Node.js Installation
- Official Site: https://nodejs.org/
- Docs: https://nodejs.org/docs/

### Icon Creation
- Online: https://convertio.co/png-ico/
- Desktop: GIMP, IcoFX, Greenfish Icon Editor Pro
- Free Icons: https://icons8.com/, https://iconarchive.com/

## 🆘 Support

### Documentation Files
- User Installation: [WINDOWS_INSTALL.md](WINDOWS_INSTALL.md)
- Build Guide: [INSTALLER_BUILD_GUIDE.md](INSTALLER_BUILD_GUIDE.md)
- Quick Reference: [INSTALLER_README.md](INSTALLER_README.md)

### Getting Help
1. Review documentation files
2. Check troubleshooting sections
3. Review Inno Setup examples
4. Contact system administrator

## ✅ Success Criteria

Your installer is ready when:
- [x] Builds without errors
- [x] Installs on clean Windows machine
- [x] Desktop icon appears after installation
- [x] Clicking icon starts application automatically
- [x] Application opens in browser
- [x] All features work correctly
- [x] Uninstallation removes all files
- [x] No errors in logs

## 📈 Next Steps

1. **Test thoroughly** on multiple Windows versions
2. **Gather feedback** from test users
3. **Code sign** the installer for production
4. **Create update mechanism** for future versions
5. **Document any custom modifications**

## 🎉 Congratulations!

You now have a professional Windows installer for Venx2 that:
- ✅ Installs everything automatically
- ✅ Creates a desktop icon
- ✅ Launches with a single click
- ✅ Provides a great user experience

---

**Version:** 1.0.0  
**Created:** March 1, 2026  
**License:** See LICENSE.txt

# Venx2 Windows Installer - Quick Reference

## For End Users

### Installing Venx2

1. Double-click `Venx2-Setup-1.0.0.exe`
2. Follow the installation wizard
3. Click the Venx2 desktop icon to start

The installer automatically:
- ✅ Installs Ruby and Node.js (if needed)
- ✅ Installs all application dependencies
- ✅ Sets up the database
- ✅ Creates desktop and Start Menu shortcuts

### Running Venx2

**From Desktop:**
- Double-click the "Venx2" icon

**From Start Menu:**
- Press Windows key → Type "Venx2" → Press Enter

**What Happens:**
- A terminal window opens (shows server status)
- Your browser opens automatically to Venx2
- The application is available at: http://localhost:3000

### Stopping Venx2

- Close the terminal window, or
- Press Ctrl+C in the terminal window

### Uninstalling

- Settings → Apps → Venx2 → Uninstall

---

## For Developers/Administrators

### Building the Installer

**Quick Build:**
```cmd
double-click build-installer.bat
```

**Output:**
- `installer-output/Venx2-Setup-1.0.0.exe`

**Requirements:**
- Inno Setup 6: https://jrsoftware.org/isdl.php
- Application icon: `app/assets/images/icon.ico` (optional)

### Files Created

| File | Purpose |
|------|---------|
| `windows-installer.iss` | Inno Setup script (main installer configuration) |
| `build-installer.bat` | Build script to compile the installer |
| `bin/start-venx2.bat` | Application launcher (created on user's desktop) |
| `bin/install-dependencies.bat` | Dependency installer (Ruby, Node.js, etc.) |
| `LICENSE.txt` | Application license |

### Customization

Edit `windows-installer.iss`:

```pascal
#define MyAppName "Venx2"              → Application name
#define MyAppVersion "1.0.0"           → Version number
#define MyAppPublisher "Your Company"  → Company name
#define MyAppURL "https://..."         → Website URL
```

### Testing Checklist

- [ ] Build installer successfully
- [ ] Test on clean Windows VM
- [ ] Verify all dependencies install
- [ ] Verify application starts from desktop icon
- [ ] Test application functionality
- [ ] Test uninstallation
- [ ] Verify shortcuts are removed after uninstall

### Distribution

**Internal:**
- Copy to network share
- Email to users
- USB drive

**External:**
- Code sign the installer (recommended)
- Host on website
- Include SHA-256 checksum

### Troubleshooting

**Build Issues:**
- Install Inno Setup
- Check `INNO_SETUP_PATH` in build script
- Verify all files exist

**Runtime Issues:**
- Check Ruby/Node.js installation
- Verify port 3000 is available
- Check firewall settings
- Review logs in `log/` folder

### Quick Commands

```cmd
# Build installer
build-installer.bat

# Install dependencies manually
bin\install-dependencies.bat

# Start application manually
bin\start-venx2.bat

# Check Ruby version
ruby -v

# Check Node.js version
node -v

# Install Ruby gems
bundle install

# Install Node packages
yarn install

# Setup database
bundle exec rake db:create db:migrate db:seed

# Build assets
yarn build && yarn build:css

# Start Rails server
bundle exec rails server
```

### Support Files

- `WINDOWS_INSTALL.md` - User installation guide
- `INSTALLER_BUILD_GUIDE.md` - Detailed build instructions
- `WINDOWS_PACKAGING.md` - PWA packaging guide

---

## Version History

### 1.0.0 (2026-03-01)
- Initial release
- Automatic dependency installation
- Desktop and Start Menu shortcuts
- One-click application launcher
- Clean uninstallation support

---

## Need Help?

- **Build Issues:** See `INSTALLER_BUILD_GUIDE.md`
- **User Installation:** See `WINDOWS_INSTALL.md`
- **PWA Packaging:** See `WINDOWS_PACKAGING.md`
- **Technical Support:** Contact your system administrator

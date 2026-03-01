# Installing Venx2 on Windows

Venx2 is a Progressive Web App that can be installed on your Windows computer. Choose from the installation methods below.

## Installation Methods

### Method 1: Windows Installer (Recommended for Desktop Installation)

**For complete desktop installation with all dependencies:**

1. **Download the Installer**
   - Get `Venx2-Setup-1.0.0.exe` from your administrator or download location

2. **Run the Installer**
   - Double-click the downloaded installer
   - Click "Yes" if Windows asks for permission
   - Follow the installation wizard

3. **Automatic Setup**
   - The installer will automatically:
     - Install Ruby 3.2.1 (if not already installed)
     - Install Node.js LTS (if not already installed)
     - Install all application dependencies
     - Setup the database
     - Create desktop and start menu shortcuts

4. **Launch the Application**
   - Click the "Venx2" icon on your desktop, or
   - Find "Venx2" in your Start Menu

**The application will:**
- Start automatically when you click the icon
- Open in your default web browser
- Run a local server in the background
- Work completely offline

---

### Method 2: Microsoft Edge (For Web-Based Installation)

1. **Open Microsoft Edge** browser
2. Navigate to your Venx2 app URL
3. Look for the **"App available"** notification in the address bar
4. Click **"Install"**
5. The app will install and open in its own window
6. Find it in your Start Menu under "Venx2"

**Or use the menu:**
- Click the **⋯** (three dots) in Edge
- Select **Apps** → **Install this site as an app**
- Click **Install**

### Method 3: Google Chrome

1. **Open Google Chrome** browser
2. Navigate to your Venx2 app URL
3. Look for the **⊕ Install** icon in the address bar
4. Click to install
5. Or: Click **⋮** menu → **Install Venx2**

## After Installation

✅ **Start Menu**: Find Venx2 in your Windows Start Menu  
✅ **Desktop Shortcut**: Pin to desktop from Start Menu  
✅ **Taskbar**: Pin to taskbar for quick access  
✅ **Offline Access**: Works without internet connection  
✅ **Automatic Updates**: App updates automatically when online

## Features

- **Standalone Window**: Runs like a native Windows app
- **No Browser Chrome**: Clean interface without browser toolbars
- **Fast Performance**: Cached resources load instantly
- **Offline Support**: Continue working without internet
- **Native Feel**: Looks and behaves like a desktop app

## Managing the Desktop Installation

### Starting the Application:
- **Desktop Icon**: Double-click the Venx2 icon on your desktop
- **Start Menu**: Click Start → search for "Venx2"
- The application will automatically:
  - Start the Rails server
  - Open your default browser
  - Navigate to the application

### Stopping the Application:
- Close the terminal window that says "Venx2 Server"
- Or press Ctrl+C in that window

### Accessing the Application:
- Once started, the app is available at: http://localhost:3000
- You can bookmark this URL for quick access
- The server must be running to access the application

---

## Uninstalling

### Desktop Installation (Method 1):
1. Open **Settings** → **Apps** → **Installed apps**
2. Find **Venx2**
3. Click **⋮** → **Uninstall**
4. Follow the uninstall wizard
5. Choose whether to keep or remove application data

### Web-Based Installation (Methods 2-3):

**From the App:**
1. Open the Venx2 app
2. Click **⋮** (three dots) in the title bar
3. Select **Uninstall Venx2**

**From Windows Settings:**
1. Open **Settings** → **Apps** → **Installed apps**
2. Find **Venx2**
3. Click **⋮** → **Uninstall**

## System Requirements

### For Desktop Installation (Method 1):
- **Windows 10** version 1903 or later, or **Windows 11**
- **4 GB RAM** minimum (8 GB recommended)
- **500 MB** free disk space for application
- **Administrator privileges** (for initial installation only)
- **Internet connection** (for downloading dependencies during installation)
- Dependencies installed automatically:
  - Ruby 3.2.1
  - Node.js LTS
  - SQLite3
  - Bundler & Yarn

### For Web-Based Installation (Methods 2-3):
- **Windows 10** version 1903 or later, or **Windows 11**
- **Microsoft Edge** (Chromium-based) or **Google Chrome**
- Active internet connection for initial installation

## Troubleshooting

### Desktop Installation Issues:

**Installer won't run:**
- Right-click the installer → "Run as administrator"
- Check Windows SmartScreen → Click "More info" → "Run anyway"
- Temporarily disable antivirus software

**Dependencies fail to install:**
- Check your internet connection
- Run the installer as administrator
- Manually install Ruby from: https://rubyinstaller.org/
- Manually install Node.js from: https://nodejs.org/

**Application won't start:**
- Check if Ruby and Node.js are installed: Open Command Prompt and run:
  ```
  ruby -v
  node -v
  ```
- Reinstall dependencies: Navigate to Venx2 folder → run `bin\install-dependencies.bat`
- Check if port 3000 is available: Run `netstat -ano | findstr :3000`

**Server starts but browser doesn't open:**
- Manually open: http://localhost:3000
- Check your default browser settings
- Try a different browser (Chrome, Edge, Firefox)

**Database errors:**
- Delete the database: `storage\development.sqlite3`
- Restart the application (it will recreate the database)

**Application is slow:**
- Close other applications to free up memory
- Restart your computer
- Check if antivirus is scanning the Venx2 folder (add exception)

---

### Web-Based Installation Issues:

**"Install" button doesn't appear:**
- Make sure you're using Edge or Chrome
- Check that the URL uses HTTPS (or localhost)
- Try refreshing the page

**App won't install:**
- Update your browser to the latest version
- Clear browser cache and try again
- Check Windows updates

**App not in Start Menu:**
- Search for "Venx2" in Windows search
- Check Edge/Chrome apps: `edge://apps` or `chrome://apps`

## Support

For issues or questions, contact your system administrator.

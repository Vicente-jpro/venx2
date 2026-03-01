@echo off
REM Quick Setup Guide for Venx2 Windows Installer
REM This file provides a step-by-step checklist

echo.
echo ================================================================
echo Venx2 Windows Installer - Setup Checklist
echo ================================================================
echo.
echo This guide will help you prepare and build the Windows installer.
echo.
echo ----------------------------------------------------------------
echo STEP 1: Install Inno Setup
echo ----------------------------------------------------------------
echo.
echo [ ] Download Inno Setup 6 from: https://jrsoftware.org/isdl.php
echo [ ] Install with default settings
echo [ ] Note the installation path (usually C:\Program Files (x86)\Inno Setup 6\)
echo.
pause
echo.
echo ----------------------------------------------------------------
echo STEP 2: Create Application Icon (Optional but Recommended)
echo ----------------------------------------------------------------
echo.
echo Option A: Use existing image
echo [ ] Place a PNG/JPG image in app\assets\images\
echo [ ] Run create-icon.ps1 (right-click, Run with PowerShell)
echo [ ] Or convert online at: https://convertio.co/png-ico/
echo.
echo Option B: Use a default icon
echo [ ] Download a free icon from: https://icons8.com/ or https://iconarchive.com/
echo [ ] Convert to .ico format
echo [ ] Save as: app\assets\images\icon.ico
echo.
echo Option C: Skip icon (installer will work without it)
echo [ ] Edit windows-installer.iss and remove icon references
echo.
pause
echo.
echo ----------------------------------------------------------------
echo STEP 3: Customize Application Information
echo ----------------------------------------------------------------
echo.
echo [ ] Open windows-installer.iss in a text editor
echo [ ] Update these values at the top:
echo     - MyAppName (currently "Venx2")
echo     - MyAppVersion (currently "1.0.0")
echo     - MyAppPublisher (your company name)
echo     - MyAppURL (your website)
echo.
echo [ ] Save the file
echo.
pause
echo.
echo ----------------------------------------------------------------
echo STEP 4: Review License
echo ----------------------------------------------------------------
echo.
echo [ ] Open LICENSE.txt
echo [ ] Customize for your organization
echo [ ] Save the file
echo.
pause
echo.
echo ----------------------------------------------------------------
echo STEP 5: Build the Installer
echo ----------------------------------------------------------------
echo.
echo [ ] Double-click build-installer.bat
echo [ ] Wait for the build to complete
echo [ ] Verify the installer was created in installer-output\
echo.
pause
echo.
echo ----------------------------------------------------------------
echo STEP 6: Test the Installer
echo ----------------------------------------------------------------
echo.
echo Recommended: Test on a clean Windows VM or computer
echo.
echo [ ] Copy the installer to the test machine
echo [ ] Run the installer
echo [ ] Choose "Install dependencies" when prompted
echo [ ] Choose "Launch application" when complete
echo [ ] Verify the application starts and works correctly
echo [ ] Test the desktop shortcut
echo [ ] Test the Start Menu entry
echo [ ] Test uninstallation (Settings ^> Apps ^> Venx2 ^> Uninstall)
echo [ ] Verify all files and shortcuts are removed
echo.
pause
echo.
echo ----------------------------------------------------------------
echo STEP 7: Distribute the Installer
echo ----------------------------------------------------------------
echo.
echo For internal use:
echo [ ] Copy to network share
echo [ ] Email to users with WINDOWS_INSTALL.md instructions
echo [ ] Or distribute via USB drive
echo.
echo For external use (recommended):
echo [ ] Sign the installer with a code signing certificate
echo     signtool sign /f certificate.pfx /p password installer.exe
echo [ ] Host on your website
echo [ ] Generate SHA-256 checksum for verification
echo.
pause
echo.
echo ================================================================
echo Setup Checklist Complete!
echo ================================================================
echo.
echo Your installer should now be ready for distribution.
echo Location: installer-output\Venx2-Setup-1.0.0.exe
echo.
echo Documentation:
echo - User Guide: WINDOWS_INSTALL.md
echo - Build Guide: INSTALLER_BUILD_GUIDE.md
echo - Quick Reference: INSTALLER_README.md
echo.
echo Need help? Review the documentation files or contact your admin.
echo.
pause

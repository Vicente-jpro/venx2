@echo off
REM Venx2 Installer Build Script
REM This script builds the Windows installer using Inno Setup

SETLOCAL EnableDelayedExpansion

echo ========================================
echo Building Venx2 Windows Installer
echo ========================================
echo.

REM Check if Inno Setup is installed
SET "INNO_SETUP_PATH=C:\Program Files (x86)\Inno Setup 6\ISCC.exe"

if not exist "%INNO_SETUP_PATH%" (
    echo ERROR: Inno Setup not found at: %INNO_SETUP_PATH%
    echo.
    echo Please install Inno Setup from: https://jrsoftware.org/isdl.php
    echo.
    echo After installation, update INNO_SETUP_PATH in this script if needed.
    pause
    exit /b 1
)

REM Get the directory where this script is located
SET "SCRIPT_DIR=%~dp0"
SET "PROJECT_DIR=%SCRIPT_DIR%"

REM Change to project directory
cd /d "%PROJECT_DIR%"

REM Check if the installer script exists
if not exist "windows-installer.iss" (
    echo ERROR: windows-installer.iss not found
    echo Please make sure you're running this script from the project root.
    pause
    exit /b 1
)

REM Create a default LICENSE.txt if it doesn't exist
if not exist "LICENSE.txt" (
    echo Creating default LICENSE.txt...
    (
        echo Venx2 Application License
        echo.
        echo Copyright ^(c^) 2026 Your Company Name
        echo.
        echo This software is provided for internal use only.
        echo All rights reserved.
    ) > LICENSE.txt
)

REM Create a simple icon if it doesn't exist
if not exist "app\assets\images\icon.ico" (
    echo WARNING: app\assets\images\icon.ico not found
    echo The installer may fail without an icon file.
    echo Please create an icon file or update the installer script.
    echo.
)

REM Create output directory
if not exist "installer-output" mkdir installer-output

echo Building installer...
echo.

REM Build the installer
"%INNO_SETUP_PATH%" "windows-installer.iss"

if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to build installer
    pause
    exit /b 1
)

echo.
echo ========================================
echo Installer Built Successfully!
echo ========================================
echo.
echo The installer has been created in the 'installer-output' folder.
echo.

REM List the created installer
dir /b installer-output\Venx2-Setup-*.exe 2>nul
if %errorlevel% equ 0 (
    echo.
    for %%f in (installer-output\Venx2-Setup-*.exe) do (
        echo Created: %%~nxf
        echo Size: %%~zf bytes
        echo Path: %%~ff
    )
)

echo.
echo You can now distribute this installer to users.
echo.
pause
exit /b 0

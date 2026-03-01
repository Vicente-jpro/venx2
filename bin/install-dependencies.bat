@echo off
REM Venx2 Dependency Installation Script
REM This script checks and installs all required dependencies for Venx2

SETLOCAL EnableDelayedExpansion

echo ========================================
echo Venx2 Dependency Installation
echo ========================================
echo.

REM Create temp directory for downloads
SET "TEMP_DIR=%TEMP%\venx2-installer"
if not exist "%TEMP_DIR%" mkdir "%TEMP_DIR%"

REM ========================================
REM Check and Install Ruby
REM ========================================
echo Checking Ruby installation...
where ruby >nul 2>nul
if %errorlevel% neq 0 (
    echo Ruby is not installed. Installing Ruby 3.2.1...
    echo.
    echo Downloading RubyInstaller...
    
    REM Download Ruby installer
    powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-3.2.1-1/rubyinstaller-devkit-3.2.1-1-x64.exe' -OutFile '%TEMP_DIR%\ruby-installer.exe'}"
    
    if exist "%TEMP_DIR%\ruby-installer.exe" (
        echo Installing Ruby... This may take a few minutes.
        "%TEMP_DIR%\ruby-installer.exe" /verysilent /tasks="assocfiles,modpath"
        
        REM Wait for installation
        timeout /t 10 /nobreak >nul
        
        REM Refresh environment variables
        call :RefreshEnv
        
        echo Ruby installed successfully!
    ) else (
        echo ERROR: Failed to download Ruby installer
        echo Please download and install Ruby manually from: https://rubyinstaller.org/
        pause
        exit /b 1
    )
) else (
    for /f "tokens=*" %%i in ('ruby -v') do set RUBY_VERSION=%%i
    echo Ruby is already installed: !RUBY_VERSION!
)
echo.

REM ========================================
REM Check and Install Node.js
REM ========================================
echo Checking Node.js installation...
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo Node.js is not installed. Installing Node.js LTS...
    echo.
    echo Downloading Node.js...
    
    REM Download Node.js installer
    powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://nodejs.org/dist/v20.11.0/node-v20.11.0-x64.msi' -OutFile '%TEMP_DIR%\nodejs-installer.msi'}"
    
    if exist "%TEMP_DIR%\nodejs-installer.msi" (
        echo Installing Node.js... This may take a few minutes.
        msiexec /i "%TEMP_DIR%\nodejs-installer.msi" /quiet /norestart
        
        REM Wait for installation
        timeout /t 15 /nobreak >nul
        
        REM Refresh environment variables
        call :RefreshEnv
        
        echo Node.js installed successfully!
    ) else (
        echo ERROR: Failed to download Node.js installer
        echo Please download and install Node.js manually from: https://nodejs.org/
        pause
        exit /b 1
    )
) else (
    for /f "tokens=*" %%i in ('node -v') do set NODE_VERSION=%%i
    echo Node.js is already installed: !NODE_VERSION!
)
echo.

REM ========================================
REM Check and Install Yarn
REM ========================================
echo Checking Yarn installation...
where yarn >nul 2>nul
if %errorlevel% neq 0 (
    echo Yarn is not installed. Installing Yarn...
    call npm install -g yarn
    if %errorlevel% neq 0 (
        echo ERROR: Failed to install Yarn
        pause
        exit /b 1
    )
    echo Yarn installed successfully!
) else (
    for /f "tokens=*" %%i in ('yarn -v') do set YARN_VERSION=%%i
    echo Yarn is already installed: !YARN_VERSION!
)
echo.

REM ========================================
REM Install Bundler
REM ========================================
echo Checking Bundler installation...
where bundle >nul 2>nul
if %errorlevel% neq 0 (
    echo Installing Bundler...
    call gem install bundler
    if %errorlevel% neq 0 (
        echo ERROR: Failed to install Bundler
        pause
        exit /b 1
    )
    echo Bundler installed successfully!
) else (
    for /f "tokens=*" %%i in ('bundle -v') do set BUNDLER_VERSION=%%i
    echo Bundler is already installed: !BUNDLER_VERSION!
)
echo.

REM ========================================
REM Clean up temp files
REM ========================================
echo Cleaning up temporary files...
if exist "%TEMP_DIR%" (
    rd /s /q "%TEMP_DIR%" 2>nul
)

echo.
echo ========================================
echo Dependency Installation Complete!
echo ========================================
echo.
echo All required dependencies have been installed.
echo You can now run Venx2 from the desktop shortcut.
echo.
pause
exit /b 0

REM ========================================
REM Function to refresh environment variables
REM ========================================
:RefreshEnv
REM Refresh PATH from registry
for /f "tokens=2*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path 2^>nul') do set "SysPath=%%b"
for /f "tokens=2*" %%a in ('reg query "HKCU\Environment" /v Path 2^>nul') do set "UserPath=%%b"
set "PATH=%UserPath%;%SysPath%"
goto :eof

@echo off
REM Venx2 Application Launcher
REM This script starts the Rails server and opens the application in the default browser

SETLOCAL EnableDelayedExpansion

REM Get the directory where this script is located
SET "SCRIPT_DIR=%~dp0"
SET "APP_DIR=%SCRIPT_DIR%.."

REM Change to app directory
cd /d "%APP_DIR%"

echo ========================================
echo Starting Venx2 Application
echo ========================================
echo.

REM Check if Ruby is installed
where ruby >nul 2>nul
if %errorlevel% neq 0 (
    echo ERROR: Ruby is not installed or not in PATH
    echo Please run the Venx2 installer first.
    echo.
    pause
    exit /b 1
)

REM Check if Node.js is installed
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo ERROR: Node.js is not installed or not in PATH
    echo Please run the Venx2 installer first.
    echo.
    pause
    exit /b 1
)

REM Check if dependencies are installed
if not exist "node_modules" (
    echo Installing Node.js dependencies...
    call yarn install
    if %errorlevel% neq 0 (
        echo ERROR: Failed to install Node.js dependencies
        pause
        exit /b 1
    )
)

if not exist "Gemfile.lock" (
    echo Installing Ruby dependencies...
    call bundle install
    if %errorlevel% neq 0 (
        echo ERROR: Failed to install Ruby dependencies
        pause
        exit /b 1
    )
)

REM Setup database if needed
if not exist "storage\development.sqlite3" (
    echo Setting up database...
    call bundle exec rake db:create db:migrate db:seed
    if %errorlevel% neq 0 (
        echo ERROR: Failed to setup database
        pause
        exit /b 1
    )
)

REM Build assets
echo Building assets...
call yarn build
call yarn build:css

REM Start the Rails server in a new window
echo.
echo Starting Rails server...
start "Venx2 Server" /B cmd /c "bundle exec rails server"

REM Wait a few seconds for server to start
timeout /t 5 /nobreak >nul

REM Open the application in the default browser
echo Opening Venx2 in your browser...
start http://localhost:3000

echo.
echo ========================================
echo Venx2 is now running!
echo ========================================
echo.
echo The application is available at: http://localhost:3000
echo.
echo TO STOP THE SERVER:
echo - Close this window, or
echo - Press Ctrl+C in the server window
echo.
echo Press any key to open the application again...
pause >nul
start http://localhost:3000
exit

@echo off
chcp 65001 >nul
echo ========================================
echo Building APK - Improved Script
echo ========================================
echo.

set FLUTTER_BIN=C:\flutter\bin
set PROJECT_DIR=D:\financial_app

echo Step 1: Checking Flutter installation...
if not exist "%FLUTTER_BIN%\flutter.bat" (
    echo [ERROR] Flutter not found at %FLUTTER_BIN%
    echo.
    echo Please install Flutter first:
    echo 1. Download from: https://flutter.dev/docs/get-started/install/windows
    echo 2. Extract to C:\flutter\
    echo.
    pause
    exit /b 1
)
echo [OK] Flutter found at %FLUTTER_BIN%
echo.

echo Step 2: Checking Flutter version...
%FLUTTER_BIN%\flutter.bat --version
if %errorlevel% neq 0 (
    echo [ERROR] Flutter version check failed
    pause
    exit /b 1
)
echo.

echo Step 3: Changing to project directory...
cd /d "%PROJECT_DIR%"
if %errorlevel% neq 0 (
    echo [ERROR] Cannot change to project directory
    pause
    exit /b 1
)
echo [OK] Working directory: %PROJECT_DIR%
echo.

echo Step 4: Cleaning project...
%FLUTTER_BIN%\flutter.bat clean
if %errorlevel% neq 0 (
    echo [WARNING] Clean failed, continuing anyway
)
echo.

echo Step 5: Installing dependencies...
%FLUTTER_BIN%\flutter.bat pub get
if %errorlevel% neq 0 (
    echo [ERROR] Dependencies installation failed
    echo Please check your internet connection and try again
    pause
    exit /b 1
)
echo [OK] Dependencies installed
echo.

echo Step 6: Building Debug APK...
%FLUTTER_BIN%\flutter.bat build apk --debug
if %errorlevel% neq 0 (
    echo [ERROR] Debug APK build failed
    echo.
    echo Please check the error messages above
    pause
    exit /b 1
)
echo [OK] Debug APK built
echo.

echo Step 7: Building Release APK...
%FLUTTER_BIN%\flutter.bat build apk --release
if %errorlevel% neq 0 (
    echo [ERROR] Release APK build failed
    echo.
    echo Please check the error messages above
    pause
    exit /b 1
)
echo [OK] Release APK built
echo.

echo ========================================
echo Build Successful!
echo ========================================
echo.
echo APK Location:
echo - Debug: %PROJECT_DIR%\build\app\outputs\flutter-apk\app-debug.apk
echo - Release: %PROJECT_DIR%\build\app\outputs\flutter-apk\app-release.apk
echo.

echo Files in build directory:
dir /b "%PROJECT_DIR%\build\app\outputs\flutter-apk\" 2>nul || echo Cannot list files
echo.

echo Next Steps:
echo 1. Open: %PROJECT_DIR%\build\app\outputs\flutter-apk\
echo 2. Copy app-release.apk to your phone
echo 3. Install on your phone
echo 4. Allow "Install from unknown sources" if needed
echo.

pause

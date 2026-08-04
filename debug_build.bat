@echo off
chcp 65001 >nul
echo ========================================
echo Debug Build Process
echo ========================================
echo.

set FLUTTER_BIN=C:\flutter\bin
set PROJECT_DIR=D:\financial_app

echo ========================================
echo Step 1: Flutter Status
echo ========================================
echo.
echo Checking Flutter...
%FLUTTER_BIN%\flutter.bat doctor
echo.
echo.

echo ========================================
echo Step 2: Project Status
echo ========================================
echo.
echo Current directory: %CD%
if not exist "%PROJECT_DIR%" (
    echo Project directory not found
    pause
    exit /b 1
)
echo Project directory found
echo.
echo Files in project:
dir /b "%PROJECT_DIR%" 2>nul
echo.
echo Files in lib folder:
dir /b "%PROJECT_DIR%\lib" 2>nul || echo lib folder not found
echo.
echo.

echo ========================================
echo Step 3: Clean Project
echo ========================================
echo.
echo Running flutter clean...
%FLUTTER_BIN%\flutter.bat clean
if %errorlevel% neq 0 (
    echo Clean failed
    pause
    exit /b 1
)
echo Clean completed
echo.
echo.

echo ========================================
echo Step 4: Install Dependencies
echo ========================================
echo.
echo Running flutter pub get...
%FLUTTER_BIN%\flutter.bat pub get
if %errorlevel% neq 0 (
    echo Dependencies installation failed
    echo Please check internet connection
    pause
    exit /b 1
)
echo Dependencies installed
echo.
echo.

echo ========================================
echo Step 5: Check Android SDK
echo ========================================
echo.
echo Checking Android SDK...
if exist "%USERPROFILE%\AppData\Local\Android\Sdk" (
    echo Android SDK found at: %USERPROFILE%\AppData\Local\Android\Sdk
) else (
    echo Android SDK not found
    echo Installing Android SDK...
    mkdir "%USERPROFILE%\AppData\Local\Android\Sdk" 2>nul
    echo Android SDK directory created
    echo.
    echo IMPORTANT: Install Android SDK manually
    echo 1. Download: https://developer.android.com/studio
    echo 2. Install during setup
    echo 3. Or run: sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"
)
echo.
echo.

echo ========================================
echo Step 6: Build APK
echo ========================================
echo.
echo Building Release APK...
echo This may take 1-3 minutes...
echo.
%FLUTTER_BIN%\flutter.bat build apk --release

if %errorlevel% neq 0 (
    echo.
    echo ========================================
    echo BUILD FAILED
    echo ========================================
    echo.
    echo Please check the error messages above
    echo.
    echo Common issues:
    echo 1. Gradle build failed
    echo 2. Missing dependencies
    echo 3. Network problems
    echo 4. Permission issues
    echo.
    echo Try building debug version:
    echo %FLUTTER_BIN%\flutter.bat build apk --debug
    pause
    exit /b 1
)

echo.
echo ========================================
echo BUILD SUCCESSFUL
echo ========================================
echo.
echo APK Location:
echo %PROJECT_DIR%\build\app\outputs\flutter-apk\app-release.apk
echo.

pause

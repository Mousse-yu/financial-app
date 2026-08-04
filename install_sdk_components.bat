@echo off
chcp 65001 >nul
echo ========================================
echo Install Android SDK Components
echo ========================================
echo.

set ANDROID_SDK_ROOT=C:\Users\xia\AppData\Local\Android\Sdk
set SDK_MANAGER=%ANDROID_SDK_ROOT%\cmdline-tools\latest\bin\sdkmanager.bat

echo Step 1: Check SDK directory...
if not exist "%ANDROID_SDK_ROOT%" (
    echo Creating Android SDK directory...
    mkdir "%ANDROID_SDK_ROOT%"
)

if not exist "%SDK_MANAGER%" (
    echo [ERROR] SDK Manager not found
    echo Please install Android Studio first
    echo Download: https://developer.android.com/studio/index.html
    pause
    exit /b 1
)
echo [OK] SDK Manager found: %SDK_MANAGER%
echo.

echo Step 2: Install Platform Tools...
echo Installing platform-tools...
call "%SDK_MANAGER%" "platform-tools" --yes
if %errorlevel% neq 0 (
    echo [WARNING] Install failed, trying without console...
    echo.
    echo Please run this manually:
    echo "%SDK_MANAGER%" "platform-tools" --yes
    echo.
    goto :skip_step_3
)
echo [OK] Platform tools installed
echo.

:skip_step_3
echo Step 3: Install Android Platform 34...
echo Installing platform 34...
call "%SDK_MANAGER%" "platforms;android-34" --yes
if %errorlevel% neq 0 (
    echo [WARNING] Install failed
    echo Please run manually:
    echo "%SDK_MANAGER%" "platforms;android-34" --yes
    goto :skip_step_4
)
echo [OK] Android Platform 34 installed
echo.

:skip_step_4
echo Step 4: Install Build Tools 34.0.0...
echo Installing build-tools 34.0.0...
call "%SDK_MANAGER%" "build-tools;34.0.0" --yes
if %errorlevel% neq 0 (
    echo [WARNING] Install failed
    echo Please run manually:
    echo "%SDK_MANAGER%" "build-tools;34.0.0" --yes
    goto :skip_step_5
)
echo [OK] Build Tools 34.0.0 installed
echo.

:skip_step_5
echo Step 5: Install Emulator (optional)...
echo Installing emulator...
call "%SDK_MANAGER%" "emulator" --yes
if %errorlevel% neq 0 (
    echo [WARNING] Install failed
    echo Please run manually:
    echo "%SDK_MANAGER%" "emulator" --yes
)
echo [OK] Emulator installation complete
echo.

echo Step 6: Install Platform Images (optional)...
echo This may take 5-10 minutes...
call "%SDK_MANAGER%" "system-images;android-34;google_apis;x86_64" --yes
if %errorlevel% neq 0 (
    echo [WARNING] Install failed
)
echo [OK] Platform images installation complete
echo.

echo ========================================
echo Installation Summary
echo ========================================
echo.
echo Installed components:
dir "%ANDROID_SDK_ROOT%\platforms" 2>nul
dir "%ANDROID_SDK_ROOT%\build-tools" 2>nul
dir "%ANDROID_SDK_ROOT%\platform-tools" 2>nul
dir "%ANDROID_SDK_ROOT%\system-images" 2>nul
echo.

echo Step 7: Configure Flutter to use Android SDK...
call C:\flutter\bin\flutter.bat config --android-sdk "%ANDROID_SDK_ROOT%"
echo.

echo Step 8: Verify installation...
C:\flutter\bin\flutter.bat doctor
echo.

echo ========================================
echo Installation Complete!
echo ========================================
echo.
echo Now you can build APK:
echo cd D:\financial_app
echo debug_build.bat
echo.
echo Or manually:
echo C:\flutter\bin\flutter.bat build apk --release
echo.

pause

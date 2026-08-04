@echo off
chcp 65001 >nul
echo ========================================
echo Setup Android SDK for Flutter
echo ========================================
echo.

set FLUTTER_BIN=C:\flutter\bin
set ANDROID_SDK_ROOT=C:\Users\xia\AppData\Local\Android\Sdk

echo Step 1: Creating Android SDK directory...
if not exist "%ANDROID_SDK_ROOT%" (
    echo Creating: %ANDROID_SDK_ROOT%
    mkdir "%ANDROID_SDK_ROOT%"
) else (
    echo Android SDK directory already exists: %ANDROID_SDK_ROOT%
)
echo.

echo Step 2: Installing Android SDK components...
echo This may take 10-20 minutes...
echo.

echo Installing Android SDK Tools...
call %FLUTTER_BIN%\flutter.bat config --android-sdk "%ANDROID_SDK_ROOT%"

if %errorlevel% neq 0 (
    echo [ERROR] Flutter config failed
    pause
    exit /b 1
)
echo [OK] Android SDK configured
echo.

echo Step 3: Installing required SDK components...
echo.

echo Installing Platform Tools...
"%ANDROID_SDK_ROOT%\cmdline-tools\latest\bin\sdkmanager.bat" "platform-tools" --yes
echo.

echo Installing Android Platform 34...
"%ANDROID_SDK_ROOT%\cmdline-tools\latest\bin\sdkmanager.bat" "platforms;android-34" --yes
echo.

echo Installing Build Tools 34.0.0...
"%ANDROID_SDK_ROOT%\cmdline-tools\latest\bin\sdkmanager.bat" "build-tools;34.0.0" --yes
echo.

echo Installing Android Emulator (optional)...
"%ANDROID_SDK_ROOT%\cmdline-tools\latest\bin\sdkmanager.bat" "emulator" --yes
echo.

echo Step 4: Verifying installation...
call %FLUTTER_BIN%\flutter.bat doctor
echo.

echo ========================================
echo Android SDK Setup Complete!
echo ========================================
echo.
echo Next steps:
echo 1. Run: cd D:\financial_app
echo 2. Run: debug_build.bat
echo 3. Or manually: flutter build apk --release
echo.

pause

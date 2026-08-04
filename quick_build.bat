@echo off
chcp 65001 >nul
echo ========================================
echo Building APK - Full Path Method
echo ========================================
echo.

set FLUTTER_BIN=C:\flutter\bin

echo Step 1: Checking Flutter...
if not exist "%FLUTTER_BIN%\flutter.bat" (
    echo FAIL: Flutter not found at %FLUTTER_BIN%
    echo.
    echo Please install Flutter first:
    echo 1. Download from: https://flutter.dev/docs/get-started/install/windows
    echo 2. Extract to C:\flutter\
    echo 3. Or modify this script with your Flutter path
    pause
    exit /b 1
)
echo OK: Flutter found at %FLUTTER_BIN%
echo.

echo Step 2: Cleaning project...
%FLUTTER_BIN%\flutter.bat clean
if %errorlevel% neq 0 (
    echo FAIL: Clean failed
    pause
    exit /b 1
)
echo OK: Cleaned
echo.

echo Step 3: Installing dependencies...
%FLUTTER_BIN%\flutter.bat pub get
if %errorlevel% neq 0 (
    echo FAIL: Dependencies installation failed
    pause
    exit /b 1
)
echo OK: Dependencies installed
echo.

echo Step 4: Building Release APK...
%FLUTTER_BIN%\flutter.bat build apk --release
if %errorlevel% neq 0 (
    echo FAIL: APK build failed
    pause
    exit /b 1
)
echo OK: APK built
echo.

echo ========================================
echo Build Successful!
echo ========================================
echo.

echo APK Location:
echo D:\financial_app\build\app\outputs\flutter-apk\app-release.apk
echo.

echo Next Steps:
echo 1. Open the APK location: build\app\outputs\flutter-apk\
echo 2. Copy app-release.apk to your phone
echo 3. Install on your phone
echo 4. Allow "Install from unknown sources" if needed
echo.

pause

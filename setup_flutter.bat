@echo off
chcp 65001 >nul
echo ========================================
echo Checking Flutter Setup...
echo ========================================
echo.

echo Step 1: Checking Flutter installation...
where flutter >nul 2>&1
if %errorlevel% neq 0 (
    echo FAIL: Flutter is not installed or not in PATH
    echo.
    echo Please install Flutter first:
    echo 1. Download Flutter SDK from: https://flutter.dev/docs/get-started/install/windows
    echo 2. Extract to a location like: C:\flutter
    echo 3. Add to PATH in System Environment Variables
    echo.
    echo Or use this PATH: C:\flutter\bin
    pause
    exit /b 1
)
echo OK: Flutter found
echo.

echo Step 2: Flutter version:
flutter --version
echo.

echo Step 3: Checking devices:
flutter devices
echo.

echo ========================================
echo Setup Complete!
echo ========================================
echo.
echo If flutter commands still fail, try:
echo 1. Restart your command prompt
echo 2. Or use full path: C:\flutter\bin\flutter.bat
echo.
pause

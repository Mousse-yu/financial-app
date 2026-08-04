@echo off
chcp 65001 >nul
echo ========================================
echo Flutter Installer
echo ========================================
echo.

echo This will download and install Flutter SDK
echo.

set FLUTTER_VERSION=stable
set FLUTTER_DIR=C:\flutter

echo Step 1: Creating Flutter directory...
mkdir "%FLUTTER_DIR%" 2>nul
echo OK: Directory created
echo.

echo Step 2: Downloading Flutter SDK...
echo Download URL: https://storage.googleapis.com/flutter_infra_release/releases/windows/flutter_windows_3.24.5-stable.zip
echo.

set DOWNLOAD_URL=https://storage.googleapis.com/flutter_infra_release/releases/windows/flutter_windows_3.24.5-stable.zip
set ZIP_FILE=flutter_windows_stable.zip

echo Downloading Flutter SDK to: %FLUTTER_DIR%\%ZIP_FILE%
echo.

powershell.exe -Command "& {Invoke-WebRequest -Uri '%DOWNLOAD_URL%' -OutFile '%FLUTTER_DIR%\%ZIP_FILE%'}"

if %errorlevel% neq 0 (
    echo FAIL: Download failed
    echo.
    echo Try alternative download:
    echo 1. Manual download from: https://flutter.dev/docs/get-started/install/windows
    echo 2. Or use this direct link: https://storage.googleapis.com/flutter_infra_release/releases/windows/flutter_windows_3.24.5-stable.zip
    pause
    exit /b 1
)

echo OK: Download completed
echo.

echo Step 3: Extracting Flutter...
echo.

powershell.exe -Command "& {Expand-Archive -Path '%FLUTTER_DIR%\%ZIP_FILE%' -DestinationPath '%FLUTTER_DIR%' -Force}"

if %errorlevel% neq 0 (
    echo FAIL: Extraction failed
    pause
    exit /b 1
)

echo OK: Extraction completed
echo.

echo Step 4: Cleaning up...
if exist "%FLUTTER_DIR%\flutter_windows_stable.zip" (
    del "%FLUTTER_DIR%\flutter_windows_stable.zip"
    echo OK: Cleanup completed
)

echo.

echo ========================================
echo Flutter Installation Complete!
echo ========================================
echo.

echo Flutter installed at: %FLUTTER_DIR%
echo.

echo Step 5: Adding to PATH...
echo.
echo IMPORTANT: You need to add Flutter to your system PATH
echo.

echo Method A - Add to PATH manually:
echo 1. Right-click "This PC" ^> "Properties" ^> "Advanced system settings"
echo 2. Click "Environment Variables"
echo 3. Under "System variables", find "Path"
echo 4. Click "Edit" ^> "New"
echo 5. Add: %FLUTTER_DIR%\bin
echo 6. Click "OK" to save
echo 7. RESTART your command prompt
echo.

echo Method B - Add temporarily for this session:
echo set PATH=%PATH%;%FLUTTER_DIR%\bin
echo.

echo Step 6: Testing Flutter...
set PATH=%PATH%;%FLUTTER_DIR%\bin

%FLUTTER_DIR%\bin\flutter.bat --version

if %errorlevel% neq 0 (
    echo WARNING: Flutter command still not working
    echo Please restart your command prompt after adding to PATH
) else (
    echo OK: Flutter is working!
    echo.
    echo Now you can run:
    echo cd D:\financial_app
    echo quick_build.bat
    echo.
)

echo ========================================
echo Next Steps:
echo ========================================
echo 1. Restart your command prompt (CRITICAL!)
echo 2. Run: flutter doctor to check setup
echo 3. Run: cd D:\financial_app
echo 4. Run: quick_build.bat
echo.

pause

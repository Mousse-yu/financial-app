@echo off
chcp 65001 >nul
echo ========================================
echo System Check
echo ========================================
echo.

echo 1. Checking Flutter installation...
C:\flutter\bin\flutter.bat doctor
echo.
echo.

echo 2. Checking Flutter version...
C:\flutter\bin\flutter.bat --version
echo.
echo.

echo 3. Checking project files...
cd D:\financial_app
if exist "pubspec.yaml" (
    echo [OK] pubspec.yaml found
) else (
    echo [ERROR] pubspec.yaml not found
)
echo.

if exist "lib\main.dart" (
    echo [OK] main.dart found
) else (
    echo [ERROR] main.dart not found
)
echo.

echo 4. Checking network...
ping -n 2 github.com >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Network is working
) else (
    echo [WARNING] Network may be slow or blocked
)
echo.

echo 5. Checking system requirements...
echo Available memory:
wmic OS get TotalVisibleMemorySize /format:list | findstr "TotalVisibleMemorySize"
echo.
echo Available disk space (D drive):
dir D:\ | findstr "bytes free"
echo.

pause

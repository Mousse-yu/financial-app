@echo off
chcp 65001 >nul
echo ========================================
echo Finance Assistant - GitHub Build
echo ========================================
echo.

echo [1/4] Checking Git installation...
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Git not installed
    echo Please install from: https://git-scm.com/download/win
    pause
    exit /b 1
)
echo OK: Git installed
echo.

echo [2/4] Configuring Git...
git config user.name >nul 2>&1
if %errorlevel% neq 0 (
    set /p GIT_USER="Enter Git username: "
    git config user.name "%GIT_USER%"

    set /p GIT_EMAIL="Enter Git email: "
    git config user.email "%GIT_EMAIL%"
)
echo OK: Git configured
echo.

echo [3/4] Initializing repository...
cd /d D:\financial_app
if not exist .git (
    git init
    git add .
    git commit -m "Initial commit"
    echo OK: Repository initialized
) else (
    echo OK: Repository already exists
)

echo.
echo [4/4] Connecting to GitHub...
echo Please choose:
echo   1. Create new repository and push
echo   2. Push to existing repository
echo   3. Cancel
set /p CHOICE="Enter option (1-3): "

if "%CHOICE%"=="1" goto create
if "%CHOICE%"=="2" goto push
goto cancel

:create
echo.
echo [Creating new repository]
set /p REPO_NAME="Enter repository name (e.g., financial-app): "
git remote add origin https://github.com/%GIT_USER%/%REPO_NAME%.git
git branch -M main
git push -u origin main
echo.
echo OK: Code pushed to GitHub!
echo Visit: https://github.com/%GIT_USER%/%REPO_NAME%/actions
goto end

:push
echo.
echo [Pushing to existing repository]
set /p GITHUB_URL="Enter GitHub repo URL (https://github.com/user/repo.git): "
git remote add origin %GITHUB_URL%
git push -u origin main
echo.
echo OK: Code pushed to GitHub!
echo Visit Actions page to see build progress
goto end

:cancel
echo.
echo Cancelled
goto end

:end
echo.
echo ========================================
echo Push Complete!
echo ========================================
echo.
echo Next steps:
echo 1. Visit: https://github.com/your-username/repo/actions
echo 2. Click "Build APK" workflow
echo 3. Click "Run workflow"
echo 4. Select branch, click run
echo 5. Wait for build (2-3 min)
echo 6. Download app-release.apk
echo 7. Install on phone
echo.
pause

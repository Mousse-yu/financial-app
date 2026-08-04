@echo off
chcp 65001 >nul
echo ========================================
echo 理财助手 - GitHub Actions 自动构建
echo ========================================
echo.

echo [1/4] 检查Git安装...
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 错误: Git未安装
    echo 请先安装Git: https://git-scm.com/download/win
    pause
    exit /b 1
)
echo ✅ Git已安装
echo.

echo [2/4] 配置Git用户信息...
git config user.name >nul 2>&1
if %errorlevel% neq 0 (
    echo 请输入Git用户名:
    set /p GIT_USER=
    git config user.name "%GIT_USER%"

    echo 请输入Git邮箱:
    set /p GIT_EMAIL=
    git config user.email "%GIT_EMAIL%"
)
echo ✅ Git配置完成
echo.

echo [3/4] 初始化Git仓库...
cd /d D:\financial_app
if not exist .git (
    git init
    git add .
    git commit -m "Initial commit: 理财助手"
    echo ✅ 仓库初始化完成
) else (
    echo ✅ Git仓库已存在
)
echo.

echo [4/4] 连接到GitHub...
echo 请选择:
echo   1. 创建新仓库并推送
echo   2. 推送到已存在的仓库
echo   3. 取消
set /p CHOICE="请输入选项 (1-3): "

if "%CHOICE%"=="1" goto create_repo
if "%CHOICE%"=="2" goto push_existing
goto cancel

:create_repo
echo.
echo [创建新仓库]
set /p REPO_NAME="请输入仓库名称 (如: financial-app): "
git remote add origin https://github.com/%USER%/%REPO_NAME%.git
git branch -M main
git push -u origin main
echo.
echo ✅ 代码已推送到GitHub！
echo ✅ 请访问 https://github.com/%USER%/%REPO_NAME%/actions 查看构建进度
goto end

:push_existing
echo.
echo [推送到现有仓库]
set /p GITHUB_URL="请输入GitHub仓库URL (https://github.com/用户名/仓库名.git): "
git remote add origin %GITHUB_URL%
git push -u origin main
echo.
echo ✅ 代码已推送到GitHub！
echo ✅ 请访问 Actions 页面查看构建进度
goto end

:cancel
echo.
echo ❌ 已取消
goto end

:end
echo.
echo ========================================
echo 🎉 推送完成！
echo ========================================
echo.
echo 下一步:
echo 1. 访问 https://github.com/你的用户名/仓库名/actions
echo 2. 点击 "Build APK" workflow
echo 3. 点击 "Run workflow"
echo 4. 选择分支，点击运行
echo 5. 等待构建完成（约2-3分钟）
echo 6. 下载 app-release.apk 到手机安装
echo.
pause

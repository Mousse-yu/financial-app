@echo off
chcp 65001 >nul
cd /d D:\financial_app

echo ========================================
echo Final Push Attempt
echo ========================================
echo.

echo [1/4] Checking current Git config...
echo Local user.name: %GIT_USER_NAME%
echo Local user.email: %GIT_USER_EMAIL%
echo.

echo [2/4] Setting repository-level Git identity...
git config user.name "Mousse-yu"
git config user.email "mousse@example.com"

echo [3/4] Verifying Git config...
git config user.name
git config user.email
echo.

echo [4/4] Creating commit and pushing...
git add .
git commit -m "Initial commit: Finance Assistant" --allow-empty
git branch -M main
git remote remove origin 2>nul
git remote add origin https://github.com/Mousse-yu/financial-app.git
git push -u origin main

echo.
echo ========================================
echo Build workflow changed to 'build-apk-simple.yml'
echo Check: https://github.com/Mousse-yu/financial-app/actions
echo ========================================
echo.
pause

echo.
echo ========================================
echo Check: https://github.com/Mousse-yu/financial-app
echo ========================================
echo.
pause

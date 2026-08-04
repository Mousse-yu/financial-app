@echo off
chcp 65001 >nul
cd /d D:\financial_app

echo ========================================
echo Setting Git Identity and Pushing
echo ========================================
echo.

echo [1/3] Setting Git identity...
git config --global user.name "Mousse-yu"
git config --global user.email "mousse@example.com"

echo [2/3] Creating commit...
git add .
git commit -m "Initial commit: Finance Assistant" --allow-empty

echo [3/3] Pushing to GitHub...
git branch -M main
git remote remove origin 2>nul
git remote add origin https://github.com/Mousse-yu/financial-app.git
git push -u origin main

echo.
echo ========================================
echo Push Complete!
echo ========================================
echo.
echo Check: https://github.com/Mousse-yu/financial-app/actions
echo.
pause

@echo off
chcp 65001 >nul
cd /d D:\financial_app

echo ========================================
echo Git Diagnosis and Fix
echo ========================================
echo.

echo [1/5] Checking Git status...
git status
echo.

echo [2/5] Checking commits...
git log --oneline -n 3
echo.

echo [3/5] Checking branches...
git branch -a
echo.

echo [4/5] Creating initial commit...
git add .
git commit -m "Initial commit: Finance Assistant" --allow-empty

echo [5/5] Pushing to GitHub...
git branch -M main
git remote remove origin 2>nul
git remote add origin https://github.com/Mousse-yu/financial-app.git
git push -u origin main

echo.
echo ========================================
echo Process Complete!
echo ========================================
echo.
echo Check: https://github.com/Mousse-yu/financial-app
pause

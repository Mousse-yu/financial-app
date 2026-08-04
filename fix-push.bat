@echo off
chcp 65001 >nul
echo Fixing Git push...
cd /d D:\financial_app

echo [1/3] Removing existing remotes...
git remote remove origin 2>nul

echo [2/3] Setting up new repository...
git remote add origin https://github.com/Mousse-yu/financial-app.git

echo [3/3] Pushing to GitHub...
git branch -M main
git push -u origin main

echo.
echo Done! Check your GitHub repo for the build workflow.
pause

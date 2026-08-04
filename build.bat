@echo off
chcp 65001 >nul
cd /d D:\financial_app
echo Starting PowerShell build script...
powershell.exe -ExecutionPolicy Bypass -File build-with-github.ps1
pause

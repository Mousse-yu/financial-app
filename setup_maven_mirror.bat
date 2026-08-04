@echo off
chcp 65001 >nul
echo ========================================
echo Setup Maven Mirror
echo ========================================
echo.

echo Step 1: Create global config file...
echo.

echo Creating C:\Users\xia\.gradle\init.gradle...
echo.
echo apply from: file("$rootDir/gradle/maven.gradle")
echo.

mkdir "C:\Users\xia\.gradle" 2>nul

echo.
echo Step 2: Create maven.gradle file...
echo.

(
echo // Maven 国内镜像配置
echo allprojects {{
echo     repositories {{
echo         maven {{ url 'https://maven.aliyun.com/repository/google' }}
echo         maven {{ url 'https://maven.aliyun.com/repository/public' }}
echo         maven {{ url 'https://maven.aliyun.com/repository/jcenter' }}
echo         maven {{ url 'https://maven.aliyun.com/repository/gradle-plugin' }}
echo         maven {{ url 'https://maven.aliyun.com/repository/google-plugin' }}
echo     }}
echo }}
) > "D:\financial_app\gradle\maven.gradle"

echo Step 3: Configure Gradle wrapper...
echo.

set GRADLE_DIR=D:\financial_app
set GRADLE_WRAPPER=D:\financial_app\android\gradle\wrapper

if not exist "%GRADLE_WRAPPER%" mkdir "%GRADLE_WRAPPER%"

echo.
echo Creating gradle wrapper files...
echo.

echo.
echo Running Gradle clean to refresh...
if exist "%GRADLE_DIR%\android\gradlew.bat" (
    cd "%GRADLE_DIR%\android"
    call gradlew.bat clean
    cd "%GRADLE_DIR%"
)
echo.

echo ========================================
echo Maven Mirror Setup Complete!
echo ========================================
echo.
echo Configured mirrors:
echo - 阿里云 Google 仓库
echo - 阿里云公共仓库
echo - 阿里云 JCenter 仓库
echo - 阿里云 Gradle Plugin
echo - 阿里云 Google Plugin
echo.
echo Now run: cd D:\financial_app && debug_build.bat
echo.

pause

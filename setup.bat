@echo off
echo ========================================
echo 理财+备考助手 - 环境配置脚本
echo ========================================
echo.

echo [1/5] 检查 Flutter 环境...
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 错误: Flutter 未安装或未添加到 PATH
    echo 请先安装 Flutter SDK 并添加到环境变量
    pause
    exit /b 1
)
echo ✅ Flutter 已安装
echo.

echo [2/5] 清理旧文件...
flutter clean >nul 2>&1
if %errorlevel% neq 0 (
    echo ⚠️  清理失败，继续...
)
echo.

echo [3/5] 获取项目依赖...
flutter pub get
if %errorlevel% neq 0 (
    echo ❌ 错误: 依赖安装失败
    pause
    exit /b 1
)
echo ✅ 依赖安装完成
echo.

echo [4/5] 生成应用图标...
flutter pub global activate flutter_launcher_icons >nul 2>&1
if %errorlevel% neq 0 (
    echo ⚠️  flutter_launcher_icons 激活失败
) else (
    flutter pub global run flutter_launcher_icons >nul 2>&1
    echo ✅ 图标生成完成
)
echo.

echo [5/5] 检查设备...
flutter devices
echo.

echo ========================================
echo ✅ 环境配置完成！
echo ========================================
echo.
echo 下一步:
echo 1. 确保已连接 Android 设备或启动模拟器
echo 2. 运行: flutter run
echo.
echo 如需修改配置，请编辑:
echo - flutter_launcher_icons.yaml (图标配置)
echo - android/app/src/main/res/values/strings.xml (应用名称)
echo.
pause

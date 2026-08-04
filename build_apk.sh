#!/bin/bash

echo "========================================"
echo "理财+备考助手 - APK 构建脚本"
echo "========================================"
echo ""

echo "[1/4] 清理旧文件..."
flutter clean
echo "✅ 清理完成"
echo ""

echo "[2/4] 安装依赖..."
flutter pub get
echo "✅ 依赖安装完成"
echo ""

echo "[3/4] 构建 APK (Debug)..."
flutter build apk --debug
echo "✅ Debug APK 构建完成"
echo ""

echo "[4/4] 构建 APK (Release)..."
flutter build apk --release
echo "✅ Release APK 构建完成"
echo ""

echo "========================================"
echo "✅ APK 构建完成！"
echo "========================================"
echo ""
echo "APK 位置:"
echo "- Debug: build/app/outputs/flutter-apk/app-debug.apk"
echo "- Release: build/app/outputs/flutter-apk/app-release.apk"
echo ""
echo "请手动查找并复制 APK 文件："
echo "1. 打开: $(pwd)/build/app/outputs/flutter-apk/"
echo "2. 找到 app-release.apk"
echo "3. 可以发送到手机安装"
echo ""

# 添加执行权限
chmod +x build_apk.sh

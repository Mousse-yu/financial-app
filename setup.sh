#!/bin/bash

echo "========================================"
echo "理财+备考助手 - 环境配置脚本"
echo "========================================"
echo ""

echo "[1/5] 检查 Flutter 环境..."
if ! command -v flutter &> /dev/null; then
    echo "❌ 错误: Flutter 未安装或未添加到 PATH"
    echo "请先安装 Flutter SDK 并添加到环境变量"
    exit 1
fi
echo "✅ Flutter 已安装"
echo ""

echo "[2/5] 清理旧文件..."
flutter clean > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "⚠️  清理失败，继续..."
fi
echo ""

echo "[3/5] 获取项目依赖..."
flutter pub get
if [ $? -ne 0 ]; then
    echo "❌ 错误: 依赖安装失败"
    exit 1
fi
echo "✅ 依赖安装完成"
echo ""

echo "[4/5] 生成应用图标..."
if command -v flutter_launcher_icons &> /dev/null; then
    flutter pub global activate flutter_launcher_icons > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        flutter pub global run flutter_launcher_icons > /dev/null 2>&1
        echo "✅ 图标生成完成"
    else
        echo "⚠️  flutter_launcher_icons 激活失败"
    fi
else
    echo "⚠️  flutter_launcher_icons 未安装"
fi
echo ""

echo "[5/5] 检查设备..."
flutter devices
echo ""

echo "========================================"
echo "✅ 环境配置完成！"
echo "========================================"
echo ""
echo "下一步:"
echo "1. 确保已连接 Android 设备或启动模拟器"
echo "2. 运行: flutter run"
echo ""
echo "如需修改配置，请编辑:"
echo "- flutter_launcher_icons.yaml (图标配置)"
echo "- android/app/src/main/res/values/strings.xml (应用名称)"
echo ""

# 给脚本添加执行权限（如果还没有）
chmod +x setup.sh

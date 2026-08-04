# 快速启动指南

## 🚀 5分钟快速运行

### 1. 安装 Flutter SDK
```bash
# 如果还没安装 Flutter
git clone https://github.com/flutter/flutter.git -b stable
cd flutter
export PATH="$PATH:$PWD/bin"

# 验证安装
flutter --version
```

### 2. 克隆项目
```bash
cd D:\tools
git clone <repository-url> financial_app
cd financial_app
```

### 3. 获取依赖
```bash
flutter pub get
```

### 4. 运行应用
```bash
# 连接安卓设备或启动模拟器
flutter devices

# 运行应用
flutter run
```

## 📱 运行步骤详解

### 步骤 1：验证环境
```bash
flutter doctor
```

确保以下项都显示绿色：
- ✅ Flutter
- ✅ Dart
- ✅ Android SDK
- ✅ Android Studio / VS Code

### 步骤 2：创建项目（如果还没创建）
```bash
# 如果还没创建，从 git clone 或创建新项目
flutter create financial_app
cd financial_app
```

### 步骤 3：安装依赖
```bash
flutter pub get
```

这将安装：
- provider (状态管理)
- hive + hive_flutter (本地数据库)
- fl_chart (图表库)
- flutter_local_notifications (通知)
- permission_handler (权限管理)
- image_picker (图片选择)
- share_plus (分享功能)

### 步骤 4：配置 Android
```bash
# 确保 Android SDK 已配置
echo $ANDROID_SDK_ROOT

# 运行应用
flutter run
```

### 步骤 5：等待编译
首次运行会下载依赖，可能需要 5-10 分钟。

## 🎯 快速测试

### 测试 1：运行应用
```bash
flutter run
```

你应该看到：
- Android 模拟器启动
- 应用安装并运行
- 首页仪表盘显示

### 测试 2：记账功能
1. 点击右下角浮动按钮
2. 输入金额（如：50.00）
3. 选择分类（如：餐饮）
4. 输入备注（可选）
5. 点击保存

你应该看到：
- 记账成功提示
- 仪表盘更新
- 交易列表更新

### 测试 3：切换 Tab
1. 点击底部导航栏的"记账"
2. 测试记账功能
3. 点击"备考"标签
4. 点击"计划"标签
5. 返回首页

## 🐛 常见问题

### 问题 1：Flutter 命令找不到
```bash
# 添加 Flutter 到 PATH
export PATH="$PATH:$HOME/flutter/bin"

# 或者使用完整路径
~\flutter\bin\flutter run
```

### 问题 2：Android SDK 未配置
```bash
# Windows
set ANDROID_SDK_ROOT=C:\Users\YourName\AppData\Local\Android\Sdk

# Linux/Mac
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
```

### 问题 3：依赖下载失败
```bash
# 清除缓存
flutter clean
flutter pub get

# 使用国内镜像
flutter pub get --proxy http://your-proxy:port
```

### 问题 4：编译失败
```bash
# 清理并重新编译
flutter clean
flutter pub get
flutter run
```

### 问题 5：应用闪退
1. 查看日志：
```bash
flutter logs
```

2. 检查错误信息

3. 确保依赖安装完整

## 📊 查看运行状态

### 查看已安装的设备
```bash
flutter devices
```

### 查看应用状态
```bash
# 实时日志
flutter logs

# 停止应用
flutter stop

# 热重载
flutter hot reload

# 热重启
flutter hot restart
```

## 🎨 自定义配置

### 修改应用名称
编辑 `android/app/src/main/res/values/strings.xml`：
```xml
<string name="app_name">理财+备考助手</string>
```

### 修改主题颜色
编辑 `lib/app.dart`：
```dart
primaryColor: Color(0xFF635bff)  // 修改这里的颜色
```

### 修改图标
参考 `ICON_GUIDE.md` 文档

## 📦 构建应用

### 构建 APK (Debug)
```bash
flutter build apk
```

### 构建 APK (Release)
```bash
flutter build apk --release
```

### 构建 APK (App Bundle)
```bash
flutter build appbundle
```

### 查看构建结果
```bash
# APK 位置
build/app/outputs/flutter-apk/app-release.apk

# AAB 位置
build/app/outputs/bundle/release/app-release.aab
```

## 🔄 更新代码

### 修改代码后热重载
```bash
# 保存文件后，应用自动更新
# 或手动触发
flutter hot reload
```

### 完全重新编译
```bash
flutter run --release
```

## 🗑️ 清理项目

### 清理构建缓存
```bash
flutter clean
flutter pub get
```

### 删除所有依赖
```bash
rm -rf .dart_tool
rm -rf pubspec.lock
```

## 📱 下一步

### 1. 添加图标
```bash
flutter pub global activate flutter_launcher_icons
flutter_launcher_icons
```

### 2. 配置图标
编辑 `flutter_launcher_icons.yaml`：
```yaml
flutter_launcher_icons:
  image_path: "assets/icon.png"
  adaptive_icon_background: "#635bff"
```

### 3. 运行图标生成
```bash
flutter pub global run flutter_launcher_icons
```

### 4. 测试应用
- 记录几笔交易
- 查看仪表盘
- 测试各个 Tab

## 💡 开发提示

### 修改代码后
1. 保存文件
2. 等待热重载
3. 测试新功能

### 添加新页面
1. 在 `lib/pages/` 创建新文件
2. 在 `home_page.dart` 添加导航
3. 测试页面跳转

### 添加新功能
1. 在 `lib/models/` 添加模型
2. 在 `lib/providers/` 添加 Provider
3. 在页面中使用

## 🎯 快速验证

### 验证项目结构
```bash
tree lib -L 2
```

### 验证依赖安装
```bash
flutter pub deps
```

### 验证 Flutter 环境
```bash
flutter doctor -v
```

---

**准备好了吗？开始开发吧！** 🚀

# Flutter 安装和配置指南

## 🚀 快速安装

### 方法 1：使用自动安装脚本（推荐）

**运行这个命令：**
```bash
cd D:\financial_app
install_flutter.bat
```

这个脚本会自动：
- ✅ 下载 Flutter SDK
- ✅ 解压到 `C:\flutter\`
- ✅ 配置 PATH（临时）

### 方法 2：手动安装

#### 下载 Flutter

1. **访问官网：**
   ```
   https://flutter.dev/docs/get-started/install/windows
   ```

2. **下载 SDK：**
   - 选择 Windows x64
   - 下载 Flutter SDK（约 1GB）
   - 文件名：`flutter_windows_3.24.5-stable.zip`

3. **解压文件：**
   ```
   将文件解压到：C:\flutter\
   ```

#### 配置 PATH

**方法 A - 系统环境变量（推荐）：**
1. 右键"此电脑" → "属性" → "高级系统设置" → "环境变量"
2. 在"系统变量"中找到"Path"
3. 点击"编辑" → "新建"
4. 添加：`C:\flutter\bin`
5. 点击"确定"保存所有设置
6. **重启命令提示符**（必须！）

**方法 B - 临时添加（当前会话有效）：**
在命令提示符中运行：
```bash
set PATH=%PATH%;C:\flutter\bin
```

#### 验证安装

```bash
flutter --version
flutter doctor
```

## 📋 详细步骤

### 1. 下载 Flutter

**下载地址：**
```
https://storage.googleapis.com/flutter_infra_release/releases/windows/flutter_windows_3.24.5-stable.zip
```

或从官网：
```
https://flutter.dev/docs/get-started/install/windows
```

### 2. 解压文件

**解压位置：** `C:\flutter\`

确保目录结构类似：
```
C:\flutter\
├── bin\
├── cache\
├── dev\
├── packages\
├── pubspec.yaml
└── README.md
```

### 3. 配置环境变量

**步骤：**
1. Win + R → 输入 `sysdm.cpl` → 回车
2. 点击"高级"标签 → "环境变量"
3. 在"系统变量"下方，找到"Path"
4. 点击"编辑" → "新建"
5. 添加：`C:\flutter\bin`
6. **重要：** 点击"确定"保存所有更改
7. **重启命令提示符**

### 4. 验证安装

```bash
# 重启命令提示符后运行
flutter --version
```

应该看到类似：
```
Flutter 3.24.5 • stable • windows-x64
```

### 5. 安装 Android SDK（如需要）

Flutter 需要安装 Android SDK 才能构建 APK：

**方法 A - Android Studio（推荐）：**
1. 下载并安装 Android Studio：https://developer.android.com/studio
2. 安装期间选择"Android SDK"
3. 下载 Android SDK Platform 34

**方法 B - 命令行：**
```bash
# 创建 SDK 目录
mkdir C:\Android\SDK
set ANDROID_SDK_ROOT=C:\Android\SDK
set PATH=%PATH%;C:\Android\SDK\platform-tools

# 下载 SDK
cd %USERPROFILE%\AppData\Local\Android\Sdk
sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"
```

## 🔧 完整配置步骤

### 步骤 1：安装 Flutter

```bash
cd D:\financial_app
install_flutter.bat
```

### 步骤 2：重启命令提示符

**必须重启！** 新的 PATH 环境变量才能生效。

### 步骤 3：验证 Flutter

```bash
flutter --version
```

如果成功，继续下一步。

### 步骤 4：检查状态

```bash
flutter doctor
```

所有项目应该显示 `✅`（绿色勾选）。

### 步骤 5：安装 Android SDK

```bash
# 创建 SDK 目录
mkdir C:\Android\SDK

# 安装必要工具
sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0" "emulator" "system-images;android-34;google_apis;x86_64"
```

### 步骤 6：构建 APK

```bash
cd D:\financial_app
flutter clean
flutter pub get
flutter build apk --release
```

## 📊 验证安装

### 运行这些命令验证：

```bash
flutter --version
```
预期输出：
```
Flutter 3.24.5 • stable • windows-x64
```

```bash
flutter doctor
```
预期输出：
```
[✓] Flutter (Channel stable, 3.24.5, on Microsoft Windows 10, locale en)
[✓] Android SDK (platforms 34, build-tools 34.0.0)
[✓] Android Studio (version 2024.1.1)
```

## 🎯 快速开始

完成安装后，运行：

```bash
# 1. 切换到项目目录
cd D:\financial_app

# 2. 运行构建脚本
quick_build.bat
```

## 🔍 故障排除

### 问题 1：Flutter 下载失败

**解决方案：**
使用国内镜像下载：

```bash
# 创建配置文件
echo PUB_HOSTED_URL=https://pub.flutter-io.cn > %USERPROFILE%\.flutter_settings.bat
echo FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn >> %USERPROFILE%\.flutter_settings.bat

# 运行脚本
install_flutter.bat
```

### 问题 2：环境变量不生效

**解决方案：**
1. **重启命令提示符**
2. 检查 PATH 是否正确添加
3. 尝试使用完整路径：
   ```bash
   C:\flutter\bin\flutter.bat --version
   ```

### 问题 3：构建失败

```bash
# 清理并重新构建
flutter clean
flutter pub get
flutter build apk --release
```

### 问题 4：缺少 Android SDK

```bash
# 安装 Android SDK
sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"
```

## 📱 完成后构建 APK

```bash
cd D:\financial_app

# 使用完整路径（推荐）
C:\flutter\bin\flutter.bat clean
C:\flutter\bin\flutter.bat pub get
C:\flutter\bin\flutter.bat build apk --release

# 查看位置
echo APK Location: build\app\outputs\flutter-apk\app-release.apk
```

或运行 `quick_build.bat`

## 🎉 完成！

安装完成后：

1. ✅ Flutter 已安装
2. ✅ PATH 已配置
3. ✅ 可以构建 APK
4. ✅ 应用已准备好安装到手机

**现在可以构建你的理财+备考助手应用了！** 🚀

运行 `quick_build.bat` 开始构建！

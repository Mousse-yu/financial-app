# Android SDK 安装和配置完整指南

## 🚨 问题诊断

从 `flutter doctor` 输出看到：
```
[X] Android toolchain - develop for Android devices
    X Unable to locate Android SDK.
    Install Android Studio from: https://developer.android.com/studio/index.html
```

**原因：Android SDK 未安装**

## 🔧 解决方案

### 方法 1：使用 Android Studio 安装（推荐）

#### 步骤 1：下载 Android Studio

**下载地址：**
```
https://developer.android.com/studio/index.html
```

**文件大小：** 约 1.5 GB

#### 步骤 2：安装 Android Studio

1. 运行安装程序
2. **重要：** 在安装过程中，确保勾选：
   - ✅ **Android SDK**
   - ✅ **Android SDK Platform**
   - ✅ **Android SDK Build-Tools**
   - ✅ **Android Emulator**

3. 完成安装

#### 步骤 3：启动 Android Studio

1. 启动 Android Studio
2. 会自动提示安装 SDK 组件
3. 点击 **"OK"** 等待安装完成

#### 步骤 4：配置 Flutter

安装完成后，Flutter 会自动找到 Android SDK。

或者手动配置：
```bash
flutter config --android-sdk "C:\Users\xia\AppData\Local\Android\Sdk"
```

### 方法 2：仅安装 Android SDK（不安装整个 Studio）

#### 步骤 1：下载命令行工具

**下载地址：**
```
https://developer.android.com/studio/index.html
```
选择 **"Command Line Tools"**

#### 步骤 2：安装命令行工具

1. 下载并解压到：`C:\flutter\cmdline-tools\latest`
2. 创建目录结构：
   ```
   C:\flutter\cmdline-tools\latest\
   ├── bin\ (Android SDK 命令)
   ├── lib\
   ├── NOTICE.txt
   └── source.properties
   ```

#### 步骤 3：安装必要组件

```bash
cd C:\flutter\cmdline-tools\latest\bin

# 安装 Platform Tools
sdkmanager.bat "platform-tools"

# 安装 Android Platform 34
sdkmanager.bat "platforms;android-34"

# 安装 Build Tools 34.0.0
sdkmanager.bat "build-tools;34.0.0"

# 安装 Emulator（可选）
sdkmanager.bat "emulator"

# 安装 Platform Images（可选）
sdkmanager.bat "system-images;android-34;google_apis;x86_64"
```

#### 步骤 4：配置 Flutter

```bash
flutter config --android-sdk "C:\Users\xia\AppData\Local\Android\Sdk"
```

### 方法 3：使用环境变量

创建 `~\.flutter_settings.bat`：

```batch
@echo off
set PUB_HOSTED_URL=https://pub.flutter-io.cn
set FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
```

## 📋 快速安装脚本

**运行这个脚本（方法 2）：**

```bash
cd D:\financial_app
setup_android_sdk.bat
```

这会自动：
- ✅ 创建 Android SDK 目录
- ✅ 配置 Flutter
- ✅ 安装必要组件

## ✅ 验证安装

安装完成后，运行：

```bash
flutter doctor
```

应该看到：
```
[√] Android toolchain - develop for Android devices
    Android SDK is installed
    Android SDK location: C:\Users\xia\AppData\Local\Android\Sdk
    Android SDK Version: 34.0.0
    Android SDK Build Tools Version: 34.0.0
    Android NDK Version: (not set)
```

## 🎯 下一步

### 1. 运行诊断

```bash
cd D:\financial_app
check_setup.bat
```

### 2. 手动构建

```bash
cd D:\financial_app

# 清理
C:\flutter\bin\flutter.bat clean

# 安装依赖
C:\flutter\bin\flutter.bat pub get

# 构建 APK
C:\flutter\bin\flutter.bat build apk --release
```

### 3. 查看构建结果

```
D:\financial_app\build\app\outputs\flutter-apk\app-release.apk
```

## 🔍 详细诊断步骤

### 步骤 1：检查 Android SDK 目录

```bash
dir "C:\Users\xia\AppData\Local\Android\Sdk"
```

应该看到：
- `cmdline-tools\`
- `platforms\`
- `build-tools\`
- `platform-tools\`

### 步骤 2：检查 SDK Manager

```bash
"C:\Users\xia\AppData\Local\Android\Sdk\cmdline-tools\latest\bin\sdkmanager.bat" --list
```

应该看到：
- `Android SDK Build-Tools 34.0.0`
- `Android SDK Platform 34`
- `Android SDK Platform-Tools 34`

### 步骤 3：如果 SDK 未安装

使用命令行安装：

```bash
cd C:\Users\xia\AppData\Local\Android\Sdk\cmdline-tools\latest\bin

sdkmanager.bat "platform-tools" --yes
sdkmanager.bat "platforms;android-34" --yes
sdkmanager.bat "build-tools;34.0.0" --yes
```

## 🎓 详细教程

### 推荐资源：

1. **Android Studio 安装教程：**
   ```
   https://developer.android.com/studio/install
   ```

2. **Flutter Android 配置：**
   ```
   https://flutter.dev/to/windows-android-setup
   ```

3. **安装后检查：**
   ```
   flutter doctor -v
   ```

## ⚠️ 注意事项

1. **下载速度：** Android SDK 安装包较大，需要耐心等待
2. **网络要求：** 需要稳定的网络连接下载组件
3. **磁盘空间：** 需要至少 2GB 可用空间

## 🎊 安装完成后的步骤

1. **确认安装成功：**
   ```bash
   flutter doctor
   ```

2. **构建 APK：**
   ```bash
   cd D:\financial_app
   debug_build.bat
   ```

3. **查看 APK：**
   ```
   D:\financial_app\build\app\outputs\flutter-apk\app-release.apk
   ```

---

**推荐先运行 `setup_android_sdk.bat` 自动安装！** 🚀

安装需要 5-10 分钟，安装完成后就可以构建 APK 了。

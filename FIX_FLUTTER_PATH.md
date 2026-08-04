# Flutter 配置问题修复指南

## ❌ 错误原因
`'flutter' 不是内部或外部命令` - Flutter 没有添加到系统 PATH

## 🔧 解决方案

### 步骤 1：检查 Flutter 是否安装

运行以下命令：
```bash
flutter --version
```

### 步骤 2：如果 Flutter 未安装

**下载并安装 Flutter SDK：**

1. 访问：https://flutter.dev/docs/get-started/install/windows

2. 下载 Flutter SDK（zip 文件）

3. 解压到合适的位置：
   ```
   C:\flutter\
   或
   D:\flutter\
   ```

4. **重要：添加到系统 PATH**

   **方法 A - 系统环境变量（推荐）：**
   1. 右键"此电脑" → "属性" → "高级系统设置" → "环境变量"
   2. 在"系统变量"中找到"Path"
   3. 点击"编辑" → "新建"
   4. 添加以下路径（根据你的实际安装位置）：
      ```
      C:\flutter\bin
      ```
   5. 点击"确定"保存所有设置
   6. **重启命令提示符**

   **方法 B - 用户环境变量：**
   1. 同上，但在"用户变量"中添加
   2. 这样不会影响系统

### 步骤 3：配置 Flutter（如果使用国内镜像）

编辑 `%USERPROFILE%\.flutter_settings.bat`：

```bat
set PUB_HOSTED_URL=https://pub.flutter-io.cn
set FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
```

### 步骤 4：验证安装

```bash
# 关闭并重新打开命令提示符
flutter --version
flutter doctor
```

## 🚀 快速验证

### 使用完整路径运行（临时解决方案）

如果不想配置 PATH，可以使用完整路径：

```bash
cd D:\financial_app

# 使用完整路径
C:\flutter\bin\flutter.bat clean
C:\flutter\bin\flutter.bat pub get
C:\flutter\bin\flutter.bat build apk --release
```

### 或者创建快捷命令

创建文件 `quick_build.bat`：

```bat
@echo off
cd D:\financial_app

echo Building with Flutter from: C:\flutter\bin
echo.

C:\flutter\bin\flutter.bat clean
C:\flutter\bin\flutter.bat pub get
C:\flutter\bin\flutter.bat build apk --release

echo.
echo APK located in: build\app\outputs\flutter-apk\
pause
```

然后运行 `quick_build.bat`

## 📋 完整构建步骤

### 使用完整路径（最简单）

```bash
cd D:\financial_app

# 清理
C:\flutter\bin\flutter.bat clean

# 安装依赖
C:\flutter\bin\flutter.bat pub get

# 构建 Release APK
C:\flutter\bin\flutter.bat build apk --release

# 查看 APK 位置
echo APK Location: D:\financial_app\build\app\outputs\flutter-apk\app-release.apk
```

### 如果使用 D:\flutter\bin

```bash
cd D:\financial_app

C:\flutter\bin\flutter.bat clean
C:\flutter\bin\flutter.bat pub get
C:\flutter\bin\flutter.bat build apk --release
```

## 🎯 推荐流程

### 1. 先运行诊断脚本
```bash
setup_flutter.bat
```

### 2. 如果 Flutter 安装了但没有 PATH

**重新打开命令提示符**（必须！）

### 3. 如果仍然不行，使用完整路径构建

运行 `quick_build.bat`（我已为你创建）

## 📝 故障排除

### 如果 `flutter doctor` 显示问题

```bash
flutter doctor -v
```

查看需要修复的问题并逐一解决。

### 如果 Gradle 构建失败

```bash
# 清理 Gradle 缓存
cd android
.\gradlew clean
cd ..

# 重新构建
flutter clean
flutter pub get
flutter build apk --release
```

## ✅ 成功标志

当一切配置正确时，你应该看到：

```
Flutter 3.x.x • stable • windows-x64
```

然后运行 `flutter doctor` 应该显示所有勾选（✅）

---

**推荐使用完整路径方法快速构建！** 🚀

使用 `quick_build.bat` 可以跳过 PATH 配置，直接构建 APK。

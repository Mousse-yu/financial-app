# 🚀 GitHub Actions 自动构建APK指南

## 📋 简介

本项目已配置 **GitHub Actions** 自动构建APK服务。你可以通过以下步骤一键生成APK文件并下载到手机。

---

## 🎯 使用方法

### 方法1：使用 GitHub 网页界面（推荐）

#### 步骤1：推送到GitHub

1. **创建GitHub仓库**
   - 访问 https://github.com/new
   - 仓库名称：`financial-app` 或任意名称
   - 选择 **Public**（公开）
   - **不要**初始化README.md、.gitignore或license
   - 点击 **Create repository**

2. **连接本地仓库到GitHub**
   ```bash
   cd D:\financial_app
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/你的用户名/仓库名.git
   git push -u origin main
   ```

3. **触发构建**
   - 访问你的GitHub仓库页面
   - 点击 **Actions** 标签
   - 在左侧选择 **Build APK**
   - 点击 **Run workflow** 按钮
   - 选择分支（main/master）并点击 **Run workflow**

4. **下载APK**
   - 等待构建完成（约2-3分钟）
   - 在Actions页面找到"Upload Release APK"
   - 点击查看详情
   - 下载 `app-release.apk` 文件

---

### 方法2：使用 GitHub CLI (gh) 命令行

如果你安装了GitHub CLI：

```bash
# 1. 登录GitHub
gh auth login

# 2. 创建仓库（如果还没有）
gh repo create financial-app --public --source=. --remote=origin

# 3. 推送代码
git add .
git commit -m "Initial commit"
git push -u origin main

# 4. 触发构建
gh workflow run build-apk.yml

# 5. 查看构建状态
gh run list

# 6. 下载APK（构建完成后）
gh run view --log
```

---

## 📱 安装APK到手机

### 方法1：直接传输

1. 将下载的 `app-release.apk` 发送到手机
2. 在手机上点击APK文件
3. 点击"安装"
4. 如果提示"未知来源"，在设置中允许安装未知应用

### 方法2：使用ADB（需要USB调试）

```bash
# 连接手机后
adb install build/app/outputs/flutter-apk/app-release.apk
```

---

## 📦 APK文件说明

| 文件名 | 用途 | 大小 |
|--------|------|------|
| `app-release.apk` | 正式版本APK | ~50-60MB |
| `app-debug.apk` | 调试版本APK | ~30-40MB |

**推荐使用：** `app-release.apk`

---

## 🔧 自定义构建

### 修改应用信息

编辑 `android/app/src/main/res/values/strings.xml`：

```xml
<resources>
    <string name="app_name">理财助手</string>
</resources>
```

### 修改版本号

编辑 `D:\financial_app\local.properties`：

```properties
flutter.versionCode=2
flutter.versionName=1.0.1
```

---

## ⚙️ 构建配置

当前配置：
- **Flutter版本：** 3.24.0 (stable)
- **Java版本：** 17
- **构建类型：** Release + Debug
- **缓存：** 启用（加速后续构建）

### 修改构建配置

编辑 `.github/workflows/build-apk.yml`：

```yaml
# 修改Flutter版本
flutter-version: '3.24.0'

# 修改Java版本
java-version: '17'

# 添加额外步骤
- name: Build APK (Specific Config)
  run: flutter build apk --release --obfuscate --split-debug-info=build/app/symbols
```

---

## 📊 查看构建状态

### 在GitHub上

1. 访问仓库 **Actions** 页面
2. 查看最新的workflow运行
3. 点击运行ID查看详细日志
4. 查看每个步骤的状态

### 命令行查看

```bash
# 列出所有运行
gh run list

# 查看最新运行详情
gh run view

# 查看日志
gh run view --log

# 等待构建完成
gh run watch
```

---

## ❓ 常见问题

### Q1: 构建失败怎么办？

**检查日志：**
1. 访问GitHub Actions页面
2. 点击失败的workflow
3. 查看详细的错误信息

**常见原因：**
- Flutter版本不兼容
- 代码语法错误
- 依赖包下载失败
- 网络问题

### Q2: 如何下载历史版本？

1. 访问Actions页面
2. 点击历史workflow运行
3. 在"Artifacts"部分下载APK

### Q3: 构建需要多长时间？

- 首次构建：2-3分钟
- 后续构建（有缓存）：30秒-1分钟

### Q4: APK无法安装到手机？

**检查：**
1. Android版本是否低于APK的minSdk
2. 是否在手机设置中允许安装未知应用
3. 是否下载了正确的APK文件（不是source code）

---

## 🎉 优势

使用GitHub Actions构建的优势：

✅ **无需配置Java环境** - 云端自动配置
✅ **跨平台** - Windows/Mac/Linux通用
✅ **自动缓存** - 加速构建速度
✅ **版本管理** - 自动保存历史版本
✅ **持续集成** - 每次push自动触发
✅ **免费使用** - GitHub免费提供Actions

---

## 📚 相关链接

- [GitHub Actions文档](https://docs.github.com/en/actions)
- [Flutter构建文档](https://docs.flutter.dev/deployment/android)
- [GitHub仓库创建](https://github.com/new)

---

## 🆘 获取帮助

如果遇到问题：

1. 查看本指南的常见问题部分
2. 访问 [Flutter GitHub Issues](https://github.com/flutter/flutter/issues)
3. 提交Issue到你的GitHub仓库

---

**祝构建顺利！** 🚀📱

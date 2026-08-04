# APK 构建和安装指南

## 🚀 快速构建 APK

### 方法 1：使用构建脚本（推荐）

**Windows 用户：**
```bash
cd D:\financial_app
build_apk.bat
```

**Linux/Mac 用户：**
```bash
chmod +x build_apk.sh
./build_apk.sh
```

### 方法 2：手动构建

```bash
# 进入项目目录
cd D:\financial_app

# 清理旧文件
flutter clean

# 安装依赖
flutter pub get

# 构建 Debug APK
flutter build apk --debug

# 构建 Release APK（推荐用于正式发布）
flutter build apk --release
```

## 📱 构建时间

- **首次构建**：5-10分钟（需要下载依赖）
- **后续构建**：1-2分钟

## 📁 APK 文件位置

构建完成后，APK 文件会在以下位置：

```
D:\financial_app\build\app\outputs\flutter-apk\
├── app-debug.apk      # 调试版 APK（体积小，适合测试）
└── app-release.apk    # 发布版 APK（体积大，适合正式使用）
```

## 📲 安装到 Android 手机

### 方法 1：通过 USB 传输
1. 连接手机到电脑
2. 启用 USB 调试
3. 将 APK 复制到手机
4. 在手机上打开 APK 安装

### 方法 2：通过文件管理器
1. 打开手机的文件管理器
2. 找到复制的 APK 文件
3. 点击安装

### 方法 3：通过邮件发送
1. 将 APK 文件发送到手机邮箱
2. 在手机上打开邮件附件
3. 点击安装

### 方法 4：通过云存储
1. 上传 APK 到云存储（百度网盘、Google Drive等）
2. 在手机上下载
3. 点击安装

### 方法 5：通过局域网
1. 启动 Python 服务器：`python -m http.server 8000`
2. 手机和电脑在同一网络
3. 在手机浏览器访问：`http://电脑IP:8000/app-release.apk`
4. 下载并安装

## 🔒 安装权限

### 如果遇到"未知来源"限制
1. 打开手机的"设置"
2. 找到"安全"或"应用管理"
3. 启用"允许安装未知来源应用"
4. 或在安装时选择"设置为危险"

### 安装时选择
- ✅ **始终允许**（推荐，只需安装一次）
- ❌ 只允许本次

## 🎯 版本选择

| 版本 | 特点 | 推荐用途 |
|------|------|----------|
| **Debug APK** | 体积小，调试信息，功能完整 | 测试、个人使用 |
| **Release APK** | 体积大，优化过，功能完整 | 正式发布 |

**建议：个人使用选择 Debug APK 即可**

## 🔍 验证安装

### 安装后测试

1. **启动应用**
   - 在手机上找到"理财+备考助手"
   - 点击打开

2. **测试记账功能**
   - 点击右下角"+"按钮
   - 输入金额和分类
   - 保存并查看

3. **测试其他功能**
   - 切换底部 Tab
   - 查看不同页面
   - 测试各个功能

### 检查应用信息

在手机上：
- **设置** → **应用管理** → **理财+备考助手**
- **版本**：查看是否为 1.0.0
- **权限**：确保所有必要权限已授权

## 📱 兼容性

### 最低要求
- Android 5.0 (API 21)
- 512MB RAM
- 50MB 存储空间

### 推荐配置
- Android 8.0+ (API 26)
- 2GB RAM 或更多
- 100MB 存储空间

### 测试设备
```bash
# 查看已连接的设备
flutter devices
```

## 🐛 构建失败解决

### 问题 1：flutter 命令找不到
```bash
# 添加 Flutter 到 PATH
set PATH=%PATH%;C:\flutter\bin
```

### 问题 2：依赖安装失败
```bash
flutter clean
flutter pub get
```

### 问题 3：构建超时
```bash
# 增加超时时间
flutter build apk --release --timeout 600
```

### 问题 4：签名错误
```bash
# 使用 debug 签名（测试用）
flutter build apk --debug
```

## 📊 构建信息

### Debug APK 特点
- 体积：~15-20 MB
- 包含调试信息
- 性能略低
- 每次构建可能需要重新签名
- 适合开发测试

### Release APK 特点
- 体积：~25-30 MB
- 无调试信息
- 性能优化
- 正式签名
- 可以发布到应用商店

## 🔄 重新构建

### 修改代码后
```bash
flutter clean
flutter pub get
flutter build apk --release
```

### 只修改配置
```bash
flutter build apk --release
```

### 强制重新构建
```bash
flutter clean
flutter pub get
flutter build apk --release --no-tree-shake-icons --obfuscate
```

## 🎊 安装成功

安装成功后，你应该看到：

```
✅ 应用图标：理财+备考助手
✅ 应用名称：理财+备考助手
✅ 版本号：1.0.0+1
✅ 开发者：Xia
```

## 📞 问题反馈

如果遇到问题，请检查：
1. Android SDK 是否正确配置
2. Gradle 版本是否匹配
3. 项目依赖是否完整
4. 系统权限是否足够

---

**祝你构建成功！** 🚀

APK 文件会在 `D:\financial_app\build\app\outputs\flutter-apk\` 目录中生成。

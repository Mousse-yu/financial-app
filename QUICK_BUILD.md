# 🚀 快速构建APK指南

## 📱 5步获取APK到手机

### 第1步：推送代码到GitHub（1分钟）

双击运行：
```
D:\financial_app\build-with-github.bat
```

按提示操作即可！

### 第2步：访问Actions页面（30秒）

打开浏览器访问：
```
https://github.com/你的用户名/仓库名/actions
```

### 第3步：触发构建（10秒）

1. 点击左侧 **Build APK**
2. 点击右上角 **Run workflow**
3. 选择 **main** 分支
4. 点击 **Run workflow**

### 第4步：等待构建（2-3分钟）

查看构建进度，等待完成！

### 第5步：下载APK（10秒）

1. 在Actions页面找到 **Upload Release APK**
2. 点击查看详情
3. 下载 `app-release.apk`

### 第6步：安装到手机（5秒）

1. 将APK发送到手机
2. 点击安装
3. 完成！

---

## 💡 小贴士

- **首次推送**：需要输入GitHub用户名和邮箱
- **后续推送**：自动触发构建，无需手动操作
- **构建速度**：首次2-3分钟，后续30秒
- **APK位置**：`build/app/outputs/flutter-apk/app-release.apk`

---

## 🆘 遇到问题？

查看详细指南：
```
BUILD_WITH_GITHUB.md
```

或访问：
- [GitHub Actions文档](https://docs.github.com/en/actions)
- [Flutter构建文档](https://docs.flutter.dev/deployment/android)

---

## ✨ 优势

✅ **无需配置Java环境** - 云端自动处理
✅ **免费使用** - GitHub免费提供
✅ **快速构建** - 每次推送自动构建
✅ **版本管理** - 自动保存历史版本
✅ **跨平台** - Windows/Mac/Linux通用

---

**准备好了吗？运行 `build-with-github.bat` 开始吧！** 🚀

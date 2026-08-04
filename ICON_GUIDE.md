# 图标配置指南

## 应用图标

### Android 图标
需要在 `android/app/src/main/res/` 下创建以下尺寸的图标：

```
mipmap-hdpi/
  - ic_launcher.png (48x48)
  - ic_launcher_round.png (48x48)

mipmap-mdpi/
  - ic_launcher.png (48x48)
  - ic_launcher_round.png (48x48)

mipmap-xhdpi/
  - ic_launcher.png (96x96)
  - ic_launcher_round.png (96x96)

mipmap-xxhdpi/
  - ic_launcher.png (192x192)
  - ic_launcher_round.png (192x192)

mipmap-xxxhdpi/
  - ic_launcher.png (256x256)
  - ic_launcher_round.png (256x256)
```

### 生成图标

#### 使用 Flutter 命令
```bash
flutter pub global activate flutter_launcher_icons
flutter_launcher_icons
```

创建配置文件 `flutter_launcher_icons.yaml`：
```yaml
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icon.png"
  adaptive_icon_background: "#635bff"
  adaptive_icon_foreground: "assets/icon.png"
```

#### 使用在线工具
- [App Icon Generator](https://www.appicon.co/)
- [Android Asset Studio](https://romannurik.github.io/AndroidAssetStudio/icons-launcher.html)

## 应用名称

### Android (strings.xml)
```xml
<string name="app_name">理财+备考助手</string>
```

路径：`android/app/src/main/res/values/strings.xml`

### iOS (Info.plist)
```xml
<key>CFBundleName</key>
<string>理财+备考助手</string>
```

路径：`ios/Runner/Info.plist`

## 设计建议

1. **尺寸**：建议使用 1024x1024 像素作为主图标
2. **背景色**：紫色 (#635bff)
3. **图标元素**：
   - 可以使用货币符号 (¥、$、€)
   - 可以使用书籍/试卷图标（备考）
   - 可以使用钱包图标（理财）
   - 建议简洁、清晰的图标

## 预览效果

```
┌─────────────────┐
│  💳📚           │  <- 货币 + 书本图标
│                 │
│    理财备考     │  <- 应用名称
│     助手        │
└─────────────────┘
```

## 快速生成

使用 Python 脚本生成：
```python
import cairosvg
import io

# 将 SVG 转换为 PNG
svg_code = """
<svg width="1024" height="1024" xmlns="http://www.w3.org/2000/svg">
  <rect width="1024" height="1024" fill="#635bff"/>
  <circle cx="512" cy="512" r="400" fill="white"/>
  <text x="512" y="512" font-size="800" text-anchor="middle" dominant-baseline="middle" fill="#635bff" font-weight="bold">¥📚</text>
</svg>
"""

cairosvg.svg2png(bytestring=svg_code.encode(), write_to='assets/icon.png', output_width=1024, output_height=1024)
```

然后运行：
```bash
flutter pub global activate flutter_launcher_icons
flutter_launcher_icons
```

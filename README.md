# 理财+备考助手

一个精简、高效的安卓个人理财与备考管理应用。

## ✨ 功能特性

### 💰 理财功能
- ⚡ **快速记账** - 3步完成记账，支持语音和拍照记账
- 📊 **财务仪表盘** - 实时查看总资产、收支统计、预算进度
- 🎯 **预算管理** - 各分类预算设置，超支自动提醒
- 💡 **消费分析** - 详细的消费统计和习惯分析

### 🎓 备考功能
- 📚 **考试管理** - 添加和管理多个考试
- 📊 **学习进度** - 科目分数追踪，进度可视化
- ⏰ **学习计划** - 智能生成学习计划
- 📅 **学习打卡** - 每日学习记录，习惯养成

### ✅ 每日计划
- 📝 **待办事项** - 支持三级优先级分类
- 🎯 **任务管理** - 待办、完成、逾期状态追踪
- 🔄 **习惯追踪** - 连续打卡记录
- 💪 **完成提醒** - 个性化任务提醒

## 🏗️ 技术栈

- **框架**: Flutter 3.16+
- **语言**: Dart 3.2+
- **状态管理**: Provider
- **本地数据库**: Hive
- **图表库**: fl_chart
- **设计风格**: Stripe 专业金融风格（Material Design 3）

## 📱 页面结构

```
┌─────────────────────────────────────┐
│  📝 记账  💰 财务  📚 备考  ✅ 计划  ⚙️ 设置 │
└─────────────────────────────────────┘
```

- **首页**: 综合仪表盘（理财+学习+计划）
- **记账页**: 快速记账界面
- **备考页**: 考试管理、科目管理
- **计划页**: 待办事项、习惯追踪
- **设置页**: 待开发

## 🚀 快速开始

### 前置要求
- Flutter SDK 3.16+
- Dart SDK 3.2+
- Android Studio / VS Code
- Android SDK (API 21+)

### 安装步骤

1. **克隆项目**
```bash
git clone <repository-url>
cd financial_app
```

2. **获取依赖**
```bash
flutter pub get
```

3. **运行项目**
```bash
# Android 设备/模拟器
flutter run

# 构建 APK
flutter build apk --release
```

### 运行

```bash
# 热重载开发
flutter run

# 获取设备列表
flutter devices

# 清理构建缓存
flutter clean
flutter pub get
```

## 📂 项目结构

```
financial_app/
├── lib/
│   ├── main.dart
│   ├── app.dart
│   ├── models/
│   │   ├── transaction.dart
│   │   ├── exam.dart
│   │   ├── subject.dart
│   │   └── todo.dart
│   ├── providers/
│   │   ├── transaction_provider.dart
│   │   ├── finance_provider.dart
│   │   ├── exam_provider.dart
│   │   ├── subject_provider.dart
│   │   └── todo_provider.dart
│   ├── pages/
│   │   ├── home_page.dart
│   │   ├── accounting_page.dart
│   │   ├── exam_page.dart
│   │   └── todo_page.dart
│   └── widgets/
│       ├── financial_card.dart
│       ├── study_card.dart
│       ├── todo_card.dart
│       └── recent_transactions.dart
├── android/
│   └── app/src/main/
│       └── AndroidManifest.xml
├── pubspec.yaml
└── README.md
```

## 🎨 设计规范

### Stripe 风格主题
- 主色调：紫色 (#635bff)
- 辅助色：紫色渐变
- 卡片圆角：16px
- 间距规范：16px 基础间距
- 字体：系统字体 + 自定义图标

## 📊 数据模型

### 交易记录
```dart
Transaction {
  id: String
  amount: double
  type: 'income' | 'expense'
  category: String
  title: String
  note: String?
  date: DateTime
}
```

### 考试记录
```dart
Exam {
  id: String
  title: String
  type: 'graduate-exam' | 'professional-exam' | 'others'
  startDate: DateTime
  endDate: DateTime
  status: 'active' | 'completed' | 'paused' | 'pending'
  totalDays: int
  currentDay: int
  targetScore: int
  currentScore: int
}
```

### 待办事项
```dart
TodoItem {
  id: String
  title: String
  category: 'study' | 'daily' | 'other'
  priority: 'high' | 'medium' | 'low'
  status: 'pending' | 'completed' | 'overdue'
  estimatedTime: String
  createdAt: DateTime
  completedAt: DateTime?
}
```

## 🎯 开发计划

### 已完成 ✅
- [x] 项目基础框架
- [x] Stripe 设计主题
- [x] 首页仪表盘
- [x] 快速记账功能
- [x] 备考页面
- [x] 每日计划页面
- [x] 核心数据模型
- [x] 状态管理

### 进行中 🔄
- [ ] 添加考试功能
- [ ] 科目管理
- [ ] 智能学习计划生成
- [ ] 语音记账
- [ ] 拍照记账
- [ ] 数据持久化

### 计划中 📋
- [ ] 财务分析详情页
- [ ] 图表统计页面
- [ ] 习惯追踪详情
- [ ] 数据导出功能
- [ ] 离线同步

## 💡 待实现功能

### 智能功能
- 🎤 语音识别记账
- 📸 小票拍照识别
- 🤖 AI 智能分类
- 📊 智能学习计划生成
- 💡 个性化理财建议

### 高级功能
- 📊 多维度统计分析
- 📈 收支趋势预测
- 🎯 财务目标追踪
- 📅 周期性任务
- 🔔 智能提醒系统

## 🔧 开发指南

### 添加新页面
```dart
// 在 lib/pages/ 下创建新文件
// 在 home_page.dart 中添加导航
```

### 添加新模型
```dart
// 在 lib/models/ 下创建新文件
// 在 provider 中添加逻辑
```

### 修改主题
```dart
// 在 lib/app.dart 中修改 AppTheme
```

## 📝 注意事项

- 本地数据存储，无需云端同步
- 所有数据存储在手机本地
- 支持离线使用
- 暂不支持云端备份

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License

## 👨‍💻 作者

Xia

## 📮 联系方式

如有问题或建议，请提交 Issue。

import 'package:flutter/foundation.dart';

class FinanceProvider with ChangeNotifier {
  // 总资产（简化版，实际应从多个账户汇总）
  double get totalAssets => 12345.67;

  // 月度收入
  double get monthlyIncome => 8500.00;

  // 月度支出
  double get monthlyExpense => 6230.45;

  // 本月结余
  double get monthlyBalance => monthlyIncome - monthlyExpense;

  // 预算进度
  double get budgetProgress {
    // 假设每月预算为 8000
    const monthlyBudget = 8000.0;
    final progress = monthlyExpense / monthlyBudget;
    return progress.clamp(0.0, 1.0);
  }

  // 预算使用状态
  String get budgetStatus {
    if (budgetProgress >= 1.0) return '超支';
    if (budgetProgress >= 0.8) return '警告';
    if (budgetProgress >= 0.6) return '正常';
    return '良好';
  }

  // 预算状态颜色
  Color get budgetColor {
    switch (budgetStatus) {
      case '超支':
        return Colors.red;
      case '警告':
        return Colors.orange;
      case '正常':
        return Colors.blue;
      default:
        return Colors.green;
    }
  }

  // 获取每日支出统计
  Map<String, double> get dailyExpense {
    final now = DateTime.now();
    final stats = <String, double>{};
    final balanceTransactions = _getBalanceTransactions();

    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final dateStr = '${date.month}-${date.day}';
      final dayExpense = balanceTransactions
              .where((t) =>
                  t.date.year == date.year &&
                  t.date.month == date.month &&
                  t.date.day == date.day)
              .fold(0.0, (sum, t) => sum - t.amount);
      stats[dateStr] = dayExpense;
    }

    return stats;
  }

  List<Transaction> _getBalanceTransactions() {
    final now = DateTime.now();
    return _transactions.where((t) {
      return t.type == 'expense' &&
          t.date.year == now.year &&
          t.date.month == now.month;
    }).toList();
  }

  // 分类支出统计
  Map<String, double> getCategoryExpense() {
    final stats = <String, double>{};
    final monthTransactions = _getBalanceTransactions();

    for (final tx in monthTransactions) {
      stats[tx.category] = (stats[tx.category] ?? 0.0) + tx.amount;
    }

    return stats;
  }

  // 获取支出最多的分类
  MapEntry<String, double>? get topCategory {
    final stats = getCategoryExpense();
    return stats.entries
        .reduce((a, b) => a.value > b.value ? a : b);
  }
}

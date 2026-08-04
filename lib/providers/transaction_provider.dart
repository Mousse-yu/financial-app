import 'package:flutter/foundation.dart';
import '../models/transaction.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  double get totalBalance {
    return _transactions
        .where((t) => t.type == 'expense')
        .fold(0.0, (sum, t) => sum - t.amount);
  }

  double get monthlyExpense {
    final now = DateTime.now();
    final monthTransactions = _transactions.where((t) {
      return t.type == 'expense' &&
          t.date.year == now.year &&
          t.date.month == now.month;
    });
    return monthTransactions.fold(0.0, (sum, t) => sum - t.amount);
  }

  // 获取最近的交易
  List<Transaction> get recentTransactions {
    return _transactions.take(5).toList();
  }

  // 添加交易
  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    _transactions.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  // 删除交易
  void deleteTransaction(String id) {
    _transactions.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  // 清空所有交易
  void clearTransactions() {
    _transactions.clear();
    notifyListeners();
  }

  // 从列表初始化
  void initializeFromList(List<Transaction> transactions) {
    _transactions = transactions;
    _transactions.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }
}

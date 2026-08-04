import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, transactions, _) {
        if (transactions.recentTransactions.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.history,
                          color: Color(0xFF635bff), size: 24),
                      SizedBox(width: 8),
                      Text(
                        '最近交易',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: 查看所有交易
                    },
                    child: const Text('查看全部'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: transactions.recentTransactions.length,
              separatorBuilder: (context, index) =>
                  const Divider(height: 1),
              itemBuilder: (context, index) {
                final transaction = transactions.recentTransactions[index];
                return _TransactionItem(transaction: transaction);
              },
            ),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final transaction;

  const _TransactionItem({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isExpense = transaction.type == 'expense';
    final iconData = _getIconForCategory(transaction.category);

    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isExpense
              ? Colors.red.withOpacity(0.1)
              : Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          iconData,
          color: isExpense ? Colors.red : Colors.green,
        ),
      ),
      title: Text(
        transaction.title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        _formatDate(transaction.date),
        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
      ),
      trailing: Text(
        '${isExpense ? '-' : '+'}¥${transaction.amount.toStringAsFixed(2)}',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isExpense ? Colors.red : Colors.green,
        ),
      ),
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'dining':
        return Icons.restaurant;
      case 'shopping':
        return Icons.shopping_bag;
      case 'transport':
        return Icons.directions_car;
      case 'entertainment':
        return Icons.movie;
      case 'education':
        return Icons.school;
      default:
        return Icons.receipt;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month) {
      return '${date.day}日';
    } else {
      return '${date.month}/${date.day}';
    }
  }
}

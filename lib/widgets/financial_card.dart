import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/finance_provider.dart';

class FinancialCard extends StatelessWidget {
  const FinancialCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FinanceProvider>(
      builder: (context, finance, _) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.account_balance_wallet,
                        color: Color(0xFF635bff), size: 24),
                    SizedBox(width: 8),
                    Text(
                      '总资产',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  '¥${finance.totalAssets.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _StatRow(
                        icon: Icons.arrow_upward,
                        label: '本月收入',
                        value: '+¥${finance.monthlyIncome.toStringAsFixed(2)}',
                        valueColor: Colors.green,
                      ),
                    ),
                    Expanded(
                      child: _StatRow(
                        icon: Icons.arrow_downward,
                        label: '本月支出',
                        value: '-¥${finance.monthlyExpense.toStringAsFixed(2)}',
                        valueColor: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _StatRow(
                        icon: Icons.trending_up,
                        label: '本月结余',
                        value: '+¥${finance.monthlyBalance.toStringAsFixed(2)}',
                        valueColor: Colors.blue,
                      ),
                    ),
                    Expanded(
                      child: _BudgetProgress(
                        progress: finance.budgetProgress,
                        status: finance.budgetStatus,
                        color: finance.budgetColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StatRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color valueColor;

  const _StatRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: valueColor),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }
}

class _BudgetProgress extends StatelessWidget {
  final double progress;
  final String status;
  final Color color;

  const _BudgetProgress({
    required this.progress,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '预算进度',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          status,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

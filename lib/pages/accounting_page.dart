import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../models/transaction.dart';

class AccountingPage extends StatefulWidget {
  const AccountingPage({super.key});

  @override
  State<AccountingPage> createState() => _AccountingPageState();
}

class _AccountingPageState extends State<AccountingPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  double? _selectedAmount;
  String? _selectedCategory;
  String? _selectedNote;

  // 分类列表
  final List<Map<String, dynamic>> _categories = [
    {'name': '餐饮', 'icon': '🍔', 'color': Colors.orange},
    {'name': '购物', 'icon': '🛒', 'color': Colors.purple},
    {'name': '交通', 'icon': '🚗', 'color': Colors.blue},
    {'name': '娱乐', 'icon': '🎮', 'color': Colors.pink},
    {'name': '教育', 'icon': '📚', 'color': Colors.green},
    {'name': '医疗', 'icon': '💊', 'color': Colors.red},
    {'name': '住房', 'icon': '🏠', 'color': Colors.indigo},
    {'name': '其他', 'icon': '💡', 'color': Colors.grey},
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void _saveTransaction() {
    if (_selectedAmount == null || _selectedAmount! <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入有效的金额')),
      );
      return;
    }

    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请选择分类')),
      );
      return;
    }

    final categoryInfo = _categories.firstWhere(
      (c) => c['name'] == _selectedCategory,
    );

    final transaction = Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: _selectedAmount!,
      type: 'expense',
      category: categoryInfo['name'],
      title: _titleController.text.isNotEmpty
          ? _titleController.text
          : '${categoryInfo['name']}支出',
      note: _selectedNote,
      date: DateTime.now(),
    );

    context.read<TransactionProvider>().addTransaction(transaction);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('记账成功！'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );

    // 清空表单
    _clearForm();
  }

  void _clearForm() {
    _amountController.clear();
    _titleController.clear();
    _selectedAmount = null;
    _selectedCategory = null;
    _selectedNote = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('快速记账'),
        actions: [
          TextButton.icon(
            onPressed: () => _saveTransaction(),
            icon: const Icon(Icons.save),
            label: const Text('保存'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF635bff),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 金额输入
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF635bff), Color(0xFFa855f7)],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    '输入金额',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '¥',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '0.00',
                            hintStyle: TextStyle(
                              fontSize: 48,
                              color: Colors.white70,
                            ),
                          ),
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            _selectedAmount = double.tryParse(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // 分类选择
                    const Text(
                      '选择分类',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: _categories.map((category) {
                        final isSelected =
                            _selectedCategory == category['name'];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category['name'];
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? category['color']
                                  : Colors.grey[100],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? category['color']
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  category['icon'],
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  category['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    // 备注
                    const Text(
                      '备注（可选）',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: '例如：星巴克咖啡',
                        prefixIcon: const Icon(Icons.edit),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        _selectedNote = value;
                      },
                    ),
                    const SizedBox(height: 24),
                    // 预览卡片
                    if (_selectedAmount != null && _selectedCategory != null)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '预览',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _selectedCategory!,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '¥${_selectedAmount!.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .error,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

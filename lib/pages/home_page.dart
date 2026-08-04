import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/finance_provider.dart';
import '../providers/transaction_provider.dart';
import '../providers/exam_provider.dart';
import '../providers/todo_provider.dart';
import 'accounting_page.dart';
import 'exam_page.dart';
import 'todo_page.dart';
import '../widgets/financial_card.dart';
import '../widgets/study_card.dart';
import '../widgets/todo_card.dart';
import '../widgets/recent_transactions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // 用户欢迎
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(
                        'https://api.dicebear.com/7.x/avataaars/svg?seed=Felix',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '你好，小明',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '今天也要加油哦！',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // 通知图标
                    IconButton(
                      icon: const Icon(Icons.notifications_outlined),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),

            // 综合仪表盘卡片
            SliverToBoxAdapter(
              child: Consumer<FinanceProvider>(
                builder: (context, finance, _) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        // 财务卡片
                        const FinancialCard(),
                        const SizedBox(height: 16),
                        // 学习进度卡片
                        const StudyCard(),
                        const SizedBox(height: 16),
                        // 待办事项卡片
                        const TodoCard(),
                        const SizedBox(height: 16),
                        // 最近交易
                        const RecentTransactions(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // 底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (index) {
          // TODO: 实现页面切换
          switch (index) {
            case 0: // 记账
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountingPage(),
                ),
              );
              break;
            case 1: // 财务
              // TODO: 跳转到财务页面
              break;
            case 2: // 备考
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExamPage(),
                ),
              );
              break;
            case 3: // 计划
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TodoPage(),
                ),
              );
              break;
            case 4: // 设置
              // TODO: 跳转到设置页面
              break;
          }
        },
        selectedItemColor: const Color(0xFF635bff),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note_outlined),
            label: '记账',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: '财务',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            label: '备考',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: '计划',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: '设置',
          ),
        ],
      ),

      // 悬浮记账按钮
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AccountingPage(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('快速记账'),
      ),
    );
  }
}

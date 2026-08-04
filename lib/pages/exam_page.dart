import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/exam_provider.dart';
import '../providers/subject_provider.dart';

class ExamPage extends StatefulWidget {
  const ExamPage({super.key});

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('备考中心'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: 添加考试
              _showAddExamDialog();
            },
          ),
        ],
      ),
      body: Consumer<ExamProvider>(
        builder: (context, exams, _) {
          if (exams.activeExams.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.school_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '暂无进行中的考试',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '点击右上角添加考试',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => _showAddExamDialog(),
                    icon: const Icon(Icons.add),
                    label: const Text('添加考试'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: exams.activeExams.length,
            itemBuilder: (context, index) {
              final exam = exams.activeExams[index];
              return _ExamCard(exam: exam);
            },
          );
        },
      ),
    );
  }

  void _showAddExamDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('添加考试'),
        content: const Text('考试添加功能开发中...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('考试添加功能开发中...')),
              );
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}

class _ExamCard extends StatelessWidget {
  final exam;

  const _ExamCard({required this.exam});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.assessment, color: Color(0xFF635bff)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    exam.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(exam.status),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _getStatusText(exam.status),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // 倒计时和分数
            Row(
              children: [
                Expanded(
                  child: _InfoRow(
                    icon: Icons.event,
                    label: '倒计时',
                    value: '${exam.remainingDays} 天',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _InfoRow(
                    icon: Icons.bar_chart,
                    label: '分数',
                    value: '${exam.currentScore}/${exam.targetScore}',
                    color: _getProgressColor(exam.progress),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // 进度条
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: exam.progress,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getProgressColor(exam.progress),
                ),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '进度：${(exam.progress * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  '已用 ${exam.currentDay}/${exam.totalDays} 天',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // 科目管理
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                Chip(label: Text('英语')),
                Chip(label: Text('数学')),
                Chip(label: Text('政治')),
                Chip(label: Text('专业课')),
                Chip(
                  label: Text('查看更多 +'),
                  backgroundColor: Colors.grey[100],
                  onDeleted: null,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    // TODO: 查看详情
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('查看详情'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'active':
        return '进行中';
      default:
        return '其他';
    }
  }

  Color _getProgressColor(double progress) {
    if (progress >= 1.0) return Colors.green;
    if (progress >= 0.8) return Colors.orange;
    return const Color(0xFF635bff);
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? color;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

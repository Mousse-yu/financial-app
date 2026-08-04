import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todos, _) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.check_circle,
                            color: Color(0xFF635bff), size: 24),
                        SizedBox(width: 8),
                        Text(
                          '待办事项',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${todos.completedCount}/${todos.pendingCount + todos.completedCount}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (todos.pendingCount > 0) ...[
                  // 高优先级待办
                  _TodoSection(
                    title: '高优先级',
                    priority: 'high',
                    todos: todos.todosByPriority('high'),
                    isOverdue: todos.overdueCount > 0,
                  ),
                  const SizedBox(height: 8),
                  // 中优先级待办
                  _TodoSection(
                    title: '中优先级',
                    priority: 'medium',
                    todos: todos.todosByPriority('medium'),
                  ),
                  const SizedBox(height: 8),
                  // 低优先级待办
                  _TodoSection(
                    title: '低优先级',
                    priority: 'low',
                    todos: todos.todosByPriority('low'),
                  ),
                ] else ...[
                  Text(
                    '暂无待办事项',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TodoSection extends StatelessWidget {
  final String title;
  final String priority;
  final List todos;
  final bool isOverdue;

  const _TodoSection({
    required this.title,
    required this.priority,
    required this.todos,
    this.isOverdue = false,
  });

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                _PriorityIndicator(priority),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isOverdue) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      '逾期',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          ...todos.take(3).map((todo) {
            final todoItem = todo as dynamic;
            return _TodoItem(
              title: todoItem.title,
              isCompleted: todoItem.status == 'completed',
              isOverdue: isOverdue,
              onTap: () {
                // TODO: 完成待办
              },
            );
          }).toList(),
          if (todos.length > 3)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                '还有 ${todos.length - 3} 项...',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PriorityIndicator extends StatelessWidget {
  final String priority;

  const _PriorityIndicator(this.priority);

  @override
  Widget build(BuildContext context) {
    final color = priority == 'high'
        ? Colors.red
        : priority == 'medium'
            ? Colors.orange
            : Colors.green;

    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _TodoItem extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final bool isOverdue;
  final VoidCallback onTap;

  const _TodoItem({
    required this.title,
    required this.isCompleted,
    required this.isOverdue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: isCompleted
          ? const Icon(Icons.check_circle, color: Colors.green)
          : isOverdue
              ? const Icon(Icons.error, color: Colors.red)
              : const Icon(Icons.circle_outline),
      title: Text(
        title,
        style: TextStyle(
          decoration: isCompleted
              ? TextDecoration.lineThrough
              : TextDecoration.none,
          color: isCompleted
              ? Colors.grey
              : isOverdue
                  ? Colors.red
                  : null,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../models/todo.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('每日计划'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '全部'),
            Tab(text: '待办'),
            Tab(text: '已完成'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddTodoDialog(),
          ),
        ],
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todos, _) {
          final tab = _tabController?.index ?? 0;
          final filteredTodos = _getFilteredTodos(todos, tab);

          if (filteredTodos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.task_alt_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    tab == 0 ? '暂无待办事项' : '没有${tab == 1 ? '待办' : '已完成'}事项',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredTodos.length,
            itemBuilder: (context, index) {
              final todo = filteredTodos[index];
              return _TodoItemWidget(todo: todo);
            },
          );
        },
      ),
    );
  }

  List<TodoItem> _getFilteredTodos(TodoProvider todos, int tab) {
    switch (tab) {
      case 0:
        return todos.todos;
      case 1:
        return todos.todosByStatus('pending');
      case 2:
        return todos.todosByStatus('completed');
      default:
        return todos.todos;
    }
  }

  void _showAddTodoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('添加待办'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: '任务标题',
                  hintText: '例如：背英语单词',
                ),
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: 'medium',
                decoration: const InputDecoration(
                  labelText: '优先级',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'high',
                    child: Text('高优先级', style: TextStyle(color: Colors.red)),
                  ),
                  DropdownMenuItem(
                    value: 'medium',
                    child: Text('中优先级', style: TextStyle(color: Colors.orange)),
                  ),
                  DropdownMenuItem(
                    value: 'low',
                    child: Text('低优先级', style: TextStyle(color: Colors.green)),
                  ),
                ],
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: 'study',
                decoration: const InputDecoration(
                  labelText: '分类',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'study',
                    child: Text('学习'),
                  ),
                  DropdownMenuItem(
                    value: 'daily',
                    child: Text('日常'),
                  ),
                  DropdownMenuItem(
                    value: 'other',
                    child: Text('其他'),
                  ),
                ],
                onChanged: (value) {},
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('待办添加功能开发中...')),
              );
            },
            child: const Text('添加'),
          ),
        ],
      ),
    );
  }
}

class _TodoItemWidget extends StatelessWidget {
  final todo;

  const _TodoItemWidget({required this.todo});

  @override
  Widget build(BuildContext context) {
    final isCompleted = todo.status == 'completed';
    final isOverdue = todo.isOverdue;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: isCompleted
            ? const Icon(Icons.check_circle, color: Colors.green)
            : isOverdue
                ? const Icon(Icons.error, color: Colors.red)
                : const Icon(Icons.circle_outline),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: isCompleted ? TextDecoration.lineThrough : null,
            color: isCompleted ? Colors.grey : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  '${todo.estimatedTime} · ${_getPriorityText(todo.priority)}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        trailing: _PriorityIndicator(todo.priority),
        onTap: () {
          // TODO: 完成待办
        },
      ),
    );
  }

  String _getPriorityText(String priority) {
    switch (priority) {
      case 'high':
        return '高优先级';
      case 'medium':
        return '中优先级';
      default:
        return '低优先级';
    }
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
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

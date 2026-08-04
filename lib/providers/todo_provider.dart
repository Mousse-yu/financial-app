import 'package:flutter/foundation.dart';
import '../models/todo.dart';

class TodoProvider with ChangeNotifier {
  List<TodoItem> _todos = [];

  List<TodoItem> get todos => _todos;

  // 添加待办事项
  void addTodo(TodoItem todo) {
    _todos.add(todo);
    _todos.sort((a, b) {
      // 优先级排序：高 > 中 > 低
      const priorityOrder = {'high': 1, 'medium': 2, 'low': 3};
      return priorityOrder[a.priority]!.compareTo(priorityOrder[b.priority]!);
    });
    notifyListeners();
  }

  // 完成待办事项
  void completeTodo(String id) {
    final todo = _todos.firstWhere((t) => t.id == id);
    todo.status = 'completed';
    todo.completedAt = DateTime.now();
    notifyListeners();
  }

  // 删除待办事项
  void deleteTodo(String id) {
    _todos.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  // 清空所有待办
  void clearTodos() {
    _todos.clear();
    notifyListeners();
  }

  // 根据状态筛选
  List<TodoItem> getTodosByStatus(String status) {
    if (status == 'all') return _todos;
    return _todos.where((t) => t.status == status).toList();
  }

  // 待办事项统计
  int get pendingCount => _todos.where((t) => t.status == 'pending').length;
  int get completedCount => _todos.where((t) => t.status == 'completed').length;
  int get overdueCount => _todos.where((t) => t.isOverdue).length;

  // 完成率
  double get completionRate {
    if (_todos.isEmpty) return 0.0;
    return completedCount / _todos.length;
  }

  // 按分类统计
  Map<String, int> get categoryStats {
    final stats = <String, int>{};
    for (final todo in _todos) {
      stats[todo.category] = (stats[todo.category] ?? 0) + 1;
    }
    return stats;
  }

  // 按优先级统计
  Map<String, int> get priorityStats {
    final stats = <String, int>{};
    for (final todo in _todos) {
      stats[todo.priority] = (stats[todo.priority] ?? 0) + 1;
    }
    return stats;
  }

  // 根据分类筛选
  List<TodoItem> getTodosByCategory(String category) {
    if (category == 'all') return _todos;
    return _todos.where((t) => t.category == category).toList();
  }
}

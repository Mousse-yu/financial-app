class TodoItem {
  final String id;
  final String title;
  final String category; // 'study', 'daily', 'other'
  final String priority; // 'high', 'medium', 'low'
  final String status; // 'pending', 'completed', 'overdue'
  final String estimatedTime;
  final DateTime createdAt;
  final DateTime? completedAt;

  TodoItem({
    required this.id,
    required this.title,
    required this.category,
    required this.priority,
    required this.status,
    required this.estimatedTime,
    required this.createdAt,
    this.completedAt,
  });

  bool get isCompleted => status == 'completed';
  bool get isOverdue {
    return status == 'pending' && DateTime.now().isAfter(_dueDate);
  }

  DateTime get _dueDate {
    return createdAt.add(Duration(hours: 8)); // 8小时后逾期
  }

  int get timeSpent {
    if (completedAt == null) return 0;
    return estimatedTime.contains('小时')
        ? int.parse(estimatedTime.replaceAll('小时', '').trim())
        : 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'priority': priority,
      'status': status,
      'estimatedTime': estimatedTime,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      priority: json['priority'] as String,
      status: json['status'] as String,
      estimatedTime: json['estimatedTime'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }
}

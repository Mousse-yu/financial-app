class Exam {
  final String id;
  final String title;
  final String type; // 'graduate-exam', 'professional-exam', 'others'
  final DateTime startDate;
  final DateTime endDate;
  final String status; // 'active', 'completed', 'paused', 'pending'
  final int totalDays;
  final int currentDay; // 已用天数
  final int targetScore; // 目标分数
  final int currentScore; // 当前分数

  Exam({
    required this.id,
    required this.title,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.totalDays,
    required this.currentDay,
    required this.targetScore,
    required this.currentScore,
  });

  // 计算进度百分比
  double get progress {
    return currentScore / targetScore;
  }

  // 计算剩余天数
  int get remainingDays {
    return endDate.difference(DateTime.now()).inDays;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'status': status,
      'totalDays': totalDays,
      'currentDay': currentDay,
      'targetScore': targetScore,
      'currentScore': currentScore,
    };
  }

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      id: json['id'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      status: json['status'] as String,
      totalDays: json['totalDays'] as int,
      currentDay: json['currentDay'] as int,
      targetScore: json['targetScore'] as int,
      currentScore: json['currentScore'] as int,
    );
  }
}

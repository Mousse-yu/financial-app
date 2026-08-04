class Subject {
  final String id;
  final String examId; // 所属考试ID
  final String name;
  final String icon;
  final int targetScore; // 目标分数
  final int currentScore; // 当前分数
  final List<String> tasks; // 任务列表

  Subject({
    required this.id,
    required this.examId,
    required this.name,
    required this.icon,
    required this.targetScore,
    required this.currentScore,
    required this.tasks,
  });

  double get progress {
    return currentScore / targetScore;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'examId': examId,
      'name': name,
      'icon': icon,
      'targetScore': targetScore,
      'currentScore': currentScore,
      'tasks': tasks,
    };
  }

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'] as String,
      examId: json['examId'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      targetScore: json['targetScore'] as int,
      currentScore: json['currentScore'] as int,
      tasks: (json['tasks'] as List).map((e) => e as String).toList(),
    );
  }
}

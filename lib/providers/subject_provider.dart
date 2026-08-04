import 'package:flutter/foundation.dart';
import '../models/subject.dart';

class SubjectProvider with ChangeNotifier {
  List<Subject> _subjects = [];

  List<Subject> get subjects => _subjects;

  // 添加科目
  void addSubject(Subject subject) {
    _subjects.add(subject);
    notifyListeners();
  }

  // 更新科目分数
  void updateSubjectScore(String id, int score) {
    final subject = _subjects.firstWhere((s) => s.id == id);
    subject.currentScore = score;
    notifyListeners();
  }

  // 添加任务
  void addTask(String id, String task) {
    final subject = _subjects.firstWhere((s) => s.id == id);
    subject.tasks.add(task);
    notifyListeners();
  }

  // 删除任务
  void removeTask(String id, String task) {
    final subject = _subjects.firstWhere((s) => s.id == id);
    subject.tasks.remove(task);
    notifyListeners();
  }

  // 根据考试ID获取科目
  List<Subject> getSubjectsByExam(String examId) {
    return _subjects.where((s) => s.examId == examId).toList();
  }

  // 获取所有科目（按考试分组）
  Map<String, List<Subject>> getSubjectsByExamGrouped() {
    final grouped = <String, List<Subject>>{};
    for (final subject in _subjects) {
      if (!grouped.containsKey(subject.examId)) {
        grouped[subject.examId] = [];
      }
      grouped[subject.examId]!.add(subject);
    }
    return grouped;
  }
}

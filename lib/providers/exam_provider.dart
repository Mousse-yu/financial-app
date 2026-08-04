import 'package:flutter/foundation.dart';
import '../models/exam.dart';
import '../models/subject.dart';

class ExamProvider with ChangeNotifier {
  List<Exam> _exams = [];

  List<Exam> get exams => _exams;

  // 获取进行中的考试
  List<Exam> get activeExams {
    return _exams.where((e) => e.status == 'active').toList();
  }

  // 获取即将开始的考试（30天内）
  List<Exam> get upcomingExams {
    final now = DateTime.now();
    return _exams
        .where((e) {
          return e.status == 'active' &&
              e.endDate.isAfter(now) &&
              e.endDate.difference(now).inDays <= 30;
        })
        .toList();
  }

  // 获取已完成/待开始的考试
  List<Exam> get completedOrPendingExams {
    return _exams.where((e) => e.status != 'active').toList();
  }

  // 添加考试
  void addExam(Exam exam) {
    _exams.add(exam);
    _exams.sort((a, b) => a.endDate.compareTo(b.endDate));
    notifyListeners();
  }

  // 更新考试状态
  void updateExamStatus(String id, String status) {
    final exam = _exams.firstWhere((e) => e.id == id);
    exam.status = status;
    notifyListeners();
  }

  // 添加科目
  void addSubject(Subject subject) {
    final exam = _exams.firstWhere((e) => e.id == subject.examId);
    exam.tasks.add(subject.name);
    notifyListeners();
  }

  // 初始化数据
  void initializeData() {
    _exams = [
      Exam(
        id: 'exam_1',
        title: '考研',
        type: 'graduate-exam',
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2025, 12, 21),
        status: 'active',
        totalDays: 365,
        currentDay: 120,
        targetScore: 400,
        currentScore: 350,
      ),
      Exam(
        id: 'exam_2',
        title: 'CPA',
        type: 'professional-exam',
        startDate: DateTime(2024, 6, 1),
        endDate: DateTime(2025, 11, 15),
        status: 'pending',
        totalDays: 518,
        currentDay: 0,
        targetScore: 600,
        currentScore: 0,
      ),
    ];
    notifyListeners();
  }
}

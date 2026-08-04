import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/transaction.dart';
import '../models/exam.dart';
import '../models/subject.dart';
import '../models/todo.dart';

class HiveService {
  static const String _boxNameTransaction = 'transactions';
  static const String _boxNameExam = 'exams';
  static const String _boxNameSubject = 'subjects';
  static const String _boxNameTodo = 'todos';

  /// 初始化 Hive
  static Future<void> init() async {
    // 初始化 Flutter Hive
    await Hive.initFlutter();

    // 注册适配器
    Hive.registerAdapter(TransactionAdapter());
    Hive.registerAdapter(ExamAdapter());
    Hive.registerAdapter(SubjectAdapter());
    Hive.registerAdapter(TodoItemAdapter());

    // 打开 Box
    await Hive.openBox(_boxNameTransaction);
    await Hive.openBox(_boxNameExam);
    await Hive.openBox(_boxNameSubject);
    await Hive.openBox(_boxNameTodo);

    if (kDebugMode) {
      print('✅ Hive 初始化成功');
    }
  }

  /// 获取交易记录 Box
  static Box<Transaction> getTransactionBox() {
    return Hive.box(_boxNameTransaction);
  }

  /// 获取考试记录 Box
  static Box<Exam> getExamBox() {
    return Hive.box(_boxNameExam);
  }

  /// 获取科目记录 Box
  static Box<Subject> getSubjectBox() {
    return Hive.box(_boxNameSubject);
  }

  /// 获取待办事项 Box
  static Box<TodoItem> getTodoBox() {
    return Hive.box(_boxNameTodo);
  }

  /// 保存交易记录
  static Future<void> saveTransaction(Transaction transaction) async {
    final box = getTransactionBox();
    await box.put(transaction.id, transaction);
  }

  /// 获取所有交易记录
  static List<Transaction> getAllTransactions() {
    final box = getTransactionBox();
    return box.values.toList();
  }

  /// 删除交易记录
  static Future<void> deleteTransaction(String id) async {
    final box = getTransactionBox();
    await box.delete(id);
  }

  /// 清空所有交易记录
  static Future<void> clearTransactions() async {
    final box = getTransactionBox();
    await box.clear();
  }

  /// 保存考试记录
  static Future<void> saveExam(Exam exam) async {
    final box = getExamBox();
    await box.put(exam.id, exam);
  }

  /// 获取所有考试记录
  static List<Exam> getAllExams() {
    final box = getExamBox();
    return box.values.toList();
  }

  /// 删除考试记录
  static Future<void> deleteExam(String id) async {
    final box = getExamBox();
    await box.delete(id);
  }

  /// 保存科目记录
  static Future<void> saveSubject(Subject subject) async {
    final box = getSubjectBox();
    await box.put(subject.id, subject);
  }

  /// 获取所有科目记录
  static List<Subject> getAllSubjects() {
    final box = getSubjectBox();
    return box.values.toList();
  }

  /// 删除科目记录
  static Future<void> deleteSubject(String id) async {
    final box = getSubjectBox();
    await box.delete(id);
  }

  /// 保存待办事项
  static Future<void> saveTodo(TodoItem todo) async {
    final box = getTodoBox();
    await box.put(todo.id, todo);
  }

  /// 获取所有待办事项
  static List<TodoItem> getAllTodos() {
    final box = getTodoBox();
    return box.values.toList();
  }

  /// 删除待办事项
  static Future<void> deleteTodo(String id) async {
    final box = getTodoBox();
    await box.delete(id);
  }

  /// 清空所有数据
  static Future<void> clearAll() async {
    await Hive.box<Transaction>(_boxNameTransaction).clear();
    await Hive.box<Exam>(_boxNameExam).clear();
    await Hive.box<Subject>(_boxNameSubject).clear();
    await Hive.box<TodoItem>(_boxNameTodo).clear();
  }

  /// 获取数据库大小
  static Future<int> getDatabaseSize() async {
    final totalSize = await Future.wait([
      _getBoxSize(_boxNameTransaction),
      _getBoxSize(_boxNameExam),
      _getBoxSize(_boxNameSubject),
      _getBoxSize(_boxNameTodo),
    ]);

    return totalSize.reduce((a, b) => a + b);
  }

  static Future<int> _getBoxSize(String boxName) async {
    final box = await Hive.openBox(boxName);
    int size = 0;
    for (final key in box.keys) {
      final value = box.get(key);
      if (value != null) {
        final stringData = value.toString();
        size += stringData.length * 2; // UTF-16
      }
    }
    return size;
  }

  /// 关闭所有 Box
  static Future<void> close() async {
    await Hive.close();
  }
}

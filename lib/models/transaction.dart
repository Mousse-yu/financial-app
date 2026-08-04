class Transaction {
  final String id;
  final double amount;
  final String type; // 'income' or 'expense'
  final String category;
  final String title;
  final String? note;
  final DateTime date;

  Transaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.category,
    required this.title,
    this.note,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'type': type,
      'category': category,
      'title': title,
      'note': note,
      'date': date.toIso8601String(),
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] as String,
      category: json['category'] as String,
      title: json['title'] as String,
      note: json['note'] as String?,
      date: DateTime.parse(json['date'] as String),
    );
  }
}

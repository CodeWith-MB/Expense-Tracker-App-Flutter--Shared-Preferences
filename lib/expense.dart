class Expense {
  String title;
  String amount;
  String category;

  Expense({required this.title, required this.amount, required this.category});

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "amount": amount,
      "category": category,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      title: map["title"],
      amount: map["amount"],
      category: map["category"],
    );
  }
}

import 'package:flutter/material.dart';
import 'expense.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  final VoidCallback onDelete;

  const ExpenseTile({super.key, required this.expense, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(expense.title),
      subtitle: Text("Category: ${expense.category} | \$${expense.amount}"),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: onDelete,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'expense.dart';

class AddExpenseScreen extends StatefulWidget {
  @override
  State<AddExpenseScreen> createState() => AddExpenseScreenState();
}

class AddExpenseScreenState extends State<AddExpenseScreen> {
  var titleController = TextEditingController();
  var amountController = TextEditingController();
  var categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black87, Colors.grey], // grey-black gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Text(
                  "➕ Add Expense",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Keep track of your spending 📝",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 30),

                // Card container for form
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Title
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          labelText: "Title",
                          prefixIcon: const Icon(Icons.title, color: Colors.black),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Amount
                      TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Amount",
                          prefixIcon: const Icon(Icons.attach_money, color: Colors.black),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Category
                      TextField(
                        controller: categoryController,
                        decoration: InputDecoration(
                          labelText: "Category",
                          prefixIcon: const Icon(Icons.category, color: Colors.black),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Save button
                      ElevatedButton.icon(
                        onPressed: () {
                          if (titleController.text.isNotEmpty &&
                              amountController.text.isNotEmpty &&
                              categoryController.text.isNotEmpty) {
                            Navigator.pop(
                              context,
                              Expense(
                                title: titleController.text,
                                amount: amountController.text,
                                category: categoryController.text,
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.check_circle, color: Colors.white), // black icon
                        label: const Text(
                          "Save Expense",
                          style: TextStyle(color: Colors.white), // black text
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black, // white button
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                          textStyle: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

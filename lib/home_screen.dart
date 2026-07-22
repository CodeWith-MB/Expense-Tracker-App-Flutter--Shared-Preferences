import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'expense.dart';
import 'expense_tile.dart';
import 'add_expense_screen.dart';
import 'login_screen.dart';
import 'settings_screen.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Expense> expenses = [];
  static const String KEYEXPENSES = "expenses";

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  // Load saved expenses
  void loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(KEYEXPENSES);

    if (data != null) {
      List decoded = json.decode(data);
      setState(() {
        expenses = decoded.map((e) => Expense.fromMap(e)).toList();
      });
    }
  }

  // Save expenses
  void saveExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    List data = expenses.map((e) => e.toMap()).toList();
    prefs.setString(KEYEXPENSES, json.encode(data));
  }

  // Add expense
  void addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
    saveExpenses();
  }

  // Delete expense
  void deleteExpense(int index) {
    setState(() {
      expenses.removeAt(index);
    });
    saveExpenses();
  }

  @override
  Widget build(BuildContext context) {
    double total = expenses.fold(0, (sum, item) => sum + double.parse(item.amount));

    return Scaffold(
      backgroundColor: Colors.grey, // background of page
      appBar: AppBar(
        backgroundColor: Colors.grey[700], // grey bar
        title: const Text(
          "Expense Tracker",
          style: TextStyle(color: Colors.white), // white text
        ),
        iconTheme: const IconThemeData(color: Colors.white), // white icons
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SettingsScreen()),
              );
            },
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool(SplashPageState.KEYLOGIN, false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),

      body: Column(
        children: [
          // Total amount card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Text(
              "Total: \$${total.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Expense list
          Expanded(
            child: expenses.isEmpty
                ? const Center(
              child: Text(
                "No expenses yet.",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
                : ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                return ExpenseTile(
                  expense: expenses[index],
                  onDelete: () => deleteExpense(index),
                );
              },
            ),
          ),
        ],
      ),

      // Add button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          final newExpense = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddExpenseScreen()),
          );
          if (newExpense != null) {
            addExpense(newExpense);
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

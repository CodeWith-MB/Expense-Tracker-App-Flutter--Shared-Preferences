import 'package:expense_tracker/add_expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final NameController = TextEditingController();
  final PassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF485563), // Dark background
      body: Center(
          child: Container(
              width: 300,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF304352),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 25,
                    spreadRadius: 4,
                  ),
                ],
                border: Border.all(
                  color: Colors.white.withOpacity(0.7),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Sign In",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  SizedBox(height: 20),

                  // Username
                  TextField(
                    controller: NameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Username",
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.white, width: 2)),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Password
                  TextField(
                    controller: PassController,
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.white, width: 2)),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Forgot + SignUp
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Forgot Password?",
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                      Text("Sign Up",
                          style:
                          TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Login Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 8,
                      shadowColor: Colors.black,
                    ),
                    onPressed: () async {
                      if (NameController.text.isNotEmpty &&
                          PassController.text.isNotEmpty) {
                        var pref = await SharedPreferences.getInstance();
                        pref.setBool(SplashPageState.KEYLOGIN, true);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => AddExpenseScreen()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                            Text("⚠ Please enter username and password"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: Text("Login",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ],
              ),
            ),
        ),
    );
  }
}
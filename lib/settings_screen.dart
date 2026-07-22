import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  bool isDark = false;
  static const String KEYDARK = "darkMode";

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  void loadTheme() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      isDark = prefs.getBool(KEYDARK) ?? false;
    });
  }

  void saveTheme(bool value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(KEYDARK, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListTile(
        title: const Text("Dark Mode"),
        trailing: Switch(
          value: isDark,
          onChanged: (val) {
            setState(() {
              isDark = val;
            });
            saveTheme(val);
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.grey[200],
  scaffoldBackgroundColor: Colors.white70,
  iconTheme: IconThemeData(color: Colors.black87),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xFF1f1f1f),
  scaffoldBackgroundColor: Color(0xFF1f1f1f),
  iconTheme: IconThemeData(color: Colors.white70),
);

class ThemeSwitcher extends ChangeNotifier {
  bool lightThemeBool;
  SharedPreferences prefs;
  final String key = "lightTheme";

  ThemeSwitcher() {
    lightThemeBool = true;
    _loadFromPrefs();
  }

  _loadFromPrefs() async {
    prefs = await SharedPreferences.getInstance();
    lightThemeBool = prefs.getBool(key) ?? true;
    notifyListeners();
  }

  ThemeData getTheme() => lightThemeBool ? lightTheme : darkTheme;

  bool getThemeBool() => lightThemeBool;

  changeTheme() {
    lightThemeBool = !lightThemeBool;
    prefs.setBool('lightTheme', lightThemeBool);
    notifyListeners();
  }
}

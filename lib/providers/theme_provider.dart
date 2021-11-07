import 'package:flutter/material.dart';
import 'package:gamer_street/services/storage.dart';

class ThemeProvider extends ChangeNotifier {
  SecureStorage secureStorage = SecureStorage();
  ThemeData themeData = ThemeData.light();
  ThemeData getTheme() => themeData;
  ThemeProvider() {
    secureStorage.readSecureData('theme').then((value) {
      if (value == 'dark') {
        themeData = ThemeData.dark();
      } else {
        themeData = ThemeData.light();
      }
    });
    secureStorage.readSecureData('theme').then((value) {
      if (value == 'light') {
        themeData = ThemeData.light();
        notifyListeners();
      } else {
        themeData = ThemeData.dark();
        notifyListeners();
      }
    });
  }

  // bool get isDarkMode => themeData == ThemeData.dark();
  void toggleTheme(String isOn) {
    if (isOn == 'light') {
      secureStorage.writeSecureData('theme', 'light');
      themeData = ThemeData.light();
      notifyListeners();
    } else {
      secureStorage.writeSecureData('theme', 'dark');
      themeData = ThemeData.dark();
      notifyListeners();
    }
    notifyListeners();
  }
}

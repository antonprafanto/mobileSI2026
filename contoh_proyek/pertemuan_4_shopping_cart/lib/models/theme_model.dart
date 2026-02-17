// lib/models/theme_model.dart
import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
    debugPrint('🎨 Theme toggled to: ${_isDark ? "Dark" : "Light"}');
  }
}

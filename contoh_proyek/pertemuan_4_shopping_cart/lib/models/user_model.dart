// lib/models/user_model.dart
import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  String _username = 'Guest';
  int _points = 0;

  String get username => _username;
  int get points => _points;
  bool get isLoggedIn => _username != 'Guest';

  void login(String name) {
    _username = name;
    _points = 100; // Welcome bonus
    notifyListeners();
    debugPrint('👤 User logged in: $name');
  }

  void addPoints(int amount) {
    _points += amount;
    notifyListeners();
    debugPrint('⭐ Added $amount points');
  }

  void logout() {
    _username = 'Guest';
    _points = 0;
    notifyListeners();
    debugPrint('👋 User logged out');
  }
}

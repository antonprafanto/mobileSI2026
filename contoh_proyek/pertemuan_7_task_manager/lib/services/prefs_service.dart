import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get darkMode => _prefs?.getBool('darkMode') ?? false;

  static Future<bool> setDarkMode(bool value) async {
    return await _prefs?.setBool('darkMode', value) ?? false;
  }
}

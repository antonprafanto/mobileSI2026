import 'package:shared_preferences/shared_preferences.dart';

/// Demo 04: SharedPreferences Service Pattern
/// Singleton service untuk manage preferences

class PrefsService {
  static SharedPreferences? _prefs;

  // Keys
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyUsername = 'username';
  static const String _keyUserId = 'userId';
  static const String _keyEmail = 'email';
  static const String _keyToken = 'token';
  static const String _keyDarkMode = 'darkMode';
  static const String _keyNotifications = 'notificationsEnabled';
  static const String _keyLanguage = 'language';
  static const String _keyOnboardingDone = 'onboardingDone';
  static const String _keyLastSync = 'lastSyncTime';

  // Initialize (call in main.dart before runApp)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ==================== USER SESSION ====================

  static bool get isLoggedIn => _prefs?.getBool(_keyIsLoggedIn) ?? false;
  static String get username => _prefs?.getString(_keyUsername) ?? '';
  static int? get userId => _prefs?.getInt(_keyUserId);
  static String get email => _prefs?.getString(_keyEmail) ?? '';
  static String get token => _prefs?.getString(_keyToken) ?? '';

  static Future<bool> setLoggedIn(bool value) async {
    return await _prefs?.setBool(_keyIsLoggedIn, value) ?? false;
  }

  static Future<bool> setUsername(String value) async {
    return await _prefs?.setString(_keyUsername, value) ?? false;
  }

  static Future<bool> setUserId(int value) async {
    return await _prefs?.setInt(_keyUserId, value) ?? false;
  }

  static Future<bool> setEmail(String value) async {
    return await _prefs?.setString(_keyEmail, value) ?? false;
  }

  static Future<bool> setToken(String value) async {
    return await _prefs?.setString(_keyToken, value) ?? false;
  }

  static Future<void> saveUserSession({
    required int userId,
    required String username,
    required String email,
    required String token,
  }) async {
    await Future.wait([
      setLoggedIn(true),
      setUserId(userId),
      setUsername(username),
      setEmail(email),
      setToken(token),
    ]);
  }

  static Future<void> clearUserSession() async {
    await Future.wait([
      setLoggedIn(false),
      _prefs?.remove(_keyUserId) ?? Future.value(false),
      _prefs?.remove(_keyUsername) ?? Future.value(false),
      _prefs?.remove(_keyEmail) ?? Future.value(false),
      _prefs?.remove(_keyToken) ?? Future.value(false),
    ]);
  }

  // ==================== APP SETTINGS ====================

  static bool get darkMode => _prefs?.getBool(_keyDarkMode) ?? false;
  static bool get notificationsEnabled =>
      _prefs?.getBool(_keyNotifications) ?? true;
  static String get language => _prefs?.getString(_keyLanguage) ?? 'id';
  static bool get onboardingDone =>
      _prefs?.getBool(_keyOnboardingDone) ?? false;
  static int? get lastSyncTime => _prefs?.getInt(_keyLastSync);

  static Future<bool> setDarkMode(bool value) async {
    return await _prefs?.setBool(_keyDarkMode, value) ?? false;
  }

  static Future<bool> setNotificationsEnabled(bool value) async {
    return await _prefs?.setBool(_keyNotifications, value) ?? false;
  }

  static Future<bool> setLanguage(String value) async {
    return await _prefs?.setString(_keyLanguage, value) ?? false;
  }

  static Future<bool> setOnboardingDone(bool value) async {
    return await _prefs?.setBool(_keyOnboardingDone, value) ?? false;
  }

  static Future<bool> setLastSyncTime(int timestamp) async {
    return await _prefs?.setInt(_keyLastSync, timestamp) ?? false;
  }

  // ==================== UTILITY ====================

  static bool hasKey(String key) => _prefs?.containsKey(key) ?? false;

  static Future<bool> remove(String key) async {
    return await _prefs?.remove(key) ?? false;
  }

  static Future<bool> clear() async {
    return await _prefs?.clear() ?? false;
  }

  static Set<String> get keys => _prefs?.getKeys() ?? {};

  // Get value with default
  static T? get<T>(String key, {T? defaultValue}) {
    final value = _prefs?.get(key);
    return value as T? ?? defaultValue;
  }

  // Generic setter
  static Future<bool> set<T>(String key, T value) async {
    if (value is String) {
      return await _prefs?.setString(key, value) ?? false;
    } else if (value is int) {
      return await _prefs?.setInt(key, value) ?? false;
    } else if (value is double) {
      return await _prefs?.setDouble(key, value) ?? false;
    } else if (value is bool) {
      return await _prefs?.setBool(key, value) ?? false;
    } else if (value is List<String>) {
      return await _prefs?.setStringList(key, value) ?? false;
    }
    throw ArgumentError('Unsupported type: ${value.runtimeType}');
  }
}

// ==================== USAGE IN MAIN.DART ====================

/*
import 'package:flutter/material.dart';
import 'services/prefs_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: PrefsService.darkMode ? ThemeMode.dark : ThemeMode.light,
      home: PrefsService.isLoggedIn ? const HomePage() : const LoginPage(),
    );
  }
}
*/

// ==================== USAGE EXAMPLES ====================

/*
// Save settings
await PrefsService.setDarkMode(true);
await PrefsService.setLanguage('en');

// Save user session after login
await PrefsService.saveUserSession(
  userId: 1,
  username: 'anton',
  email: 'anton@email.com',
  token: 'jwt_token_here',
);

// Read values
print(PrefsService.username);  // anton
print(PrefsService.isLoggedIn);  // true
print(PrefsService.darkMode);  // true

// Clear on logout
await PrefsService.clearUserSession();
*/

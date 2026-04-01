# 📝 Task Manager App

Aplikasi manajemen task lengkap dengan penyimpanan lokal SQLite dan SharedPreferences.

## ✨ Fitur

- ✅ CRUD tasks (Create, Read, Update, Delete)
- ✅ Mark task as complete/incomplete
- ✅ Search tasks
- ✅ Dark mode toggle (SharedPreferences)
- ✅ Data persist setelah app restart

## 🏗️ Struktur Project

```
lib/
├── main.dart
├── models/
│   └── task.dart
├── services/
│   ├── database_helper.dart
│   └── prefs_service.dart
├── providers/
│   └── task_provider.dart
└── pages/
    ├── task_list_page.dart
    └── settings_page.dart
```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.3.0
  shared_preferences: ^2.2.2
  provider: ^6.1.1
  path: ^1.8.3
```

## 🚀 Cara Menjalankan

```bash
flutter pub get
flutter run
```

## 📱 Build APK

```bash
flutter build apk --release
```

APK akan tersimpan di: `build/app/outputs/flutter-apk/app-release.apk`

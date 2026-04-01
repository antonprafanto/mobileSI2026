# Contoh Kode Pertemuan 7

Folder ini berisi contoh kode untuk pertemuan 7: **Penyimpanan Lokal, Build APK & Project Akhir**.

## 📁 Daftar File

| File | Deskripsi |
|------|-----------|
| `01_shared_prefs_demo.dart` | Demo SharedPreferences sederhana |
| `02_sqflite_basics_demo.dart` | Demo SQLite CRUD operations |
| `03_database_helper.dart` | Pattern Database Helper (singleton) |
| `04_prefs_service.dart` | Pattern SharedPreferences Service |

## 🚀 Cara Menjalankan

Setiap file adalah standalone app. Jalankan dengan:

```bash
flutter run lib/01_shared_prefs_demo.dart
```

## 📦 Dependencies

Tambahkan di `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.2
  sqflite: ^2.3.0
  path: ^1.8.3
  provider: ^6.1.1
```

## 📚 Referensi

- [SharedPreferences](https://pub.dev/packages/shared_preferences)
- [sqflite](https://pub.dev/packages/sqflite)

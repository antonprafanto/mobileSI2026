# Contoh Kode Pertemuan 9

Folder ini berisi contoh kode untuk pertemuan 9: **Firebase Authentication**.

## 📁 Daftar File

| File | Deskripsi |
|------|-----------|
| `01_firebase_setup.dart` | Konfigurasi Firebase di Flutter |
| `02_email_auth_demo.dart` | Login & Register dengan Email/Password |
| `03_auth_state_management.dart` | StreamBuilder untuk auth state |
| `04_auth_service.dart` | Pattern Auth Service dengan Provider |

## 🚀 Cara Menjalankan

Setiap file adalah standalone app. Jalankan dengan:

```bash
flutter run lib/01_firebase_setup.dart
```

## 📦 Dependencies

Tambahkan di `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.24.2
  firebase_auth: ^4.16.0
  provider: ^6.1.1
  fluttertoast: ^8.2.4
```

## ⚙️ Setup Firebase

1. Buat project di [Firebase Console](https://console.firebase.google.com/)
2. Tambahkan Android app dengan package name `com.example.auth_app`
3. Download `google-services.json` dan taruh di `android/app/`
4. Enable Email/Password authentication di Firebase Console

## 📚 Referensi

- [Firebase Auth Flutter](https://firebase.flutter.dev/docs/auth/overview/)
- [Firebase Console](https://console.firebase.google.com/)

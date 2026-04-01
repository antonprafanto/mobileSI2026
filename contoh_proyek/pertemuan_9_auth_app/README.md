# 🔐 Firebase Auth Demo App

Aplikasi lengkap demonstrasi Firebase Authentication dengan Flutter.

## ✨ Fitur

- ✅ Login dengan email & password
- ✅ Registrasi user baru
- ✅ Email verification
- ✅ Forgot password
- ✅ Auth state management (StreamBuilder)
- ✅ Protected routes
- ✅ Logout functionality

## 📁 Struktur Project

```
lib/
├── main.dart                    # Entry point dengan Firebase init
├── auth_wrapper.dart            # Auth state listener
├── pages/
│   ├── login_page.dart          # Login form
│   ├── register_page.dart       # Registration form
│   ├── home_page.dart           # Protected home screen
│   └── forgot_password_page.dart # Password reset
└── services/
    └── auth_service.dart        # Firebase Auth helper
```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.24.2
  firebase_auth: ^4.16.0
  fluttertoast: ^8.2.4
```

## ⚙️ Setup Firebase

1. Buat project di [Firebase Console](https://console.firebase.google.com/)
2. Tambahkan Android app dengan package name `com.example.auth_app`
3. Download `google-services.json` dan letakkan di `android/app/`
4. Enable **Email/Password** di Authentication → Sign-in method
5. Jalankan:

```bash
flutter pub get
flutter run
```

## 🔒 Security Notes

- Jangan commit `google-services.json` ke public repo (sudah di .gitignore)
- Gunakan Firebase Security Rules untuk database
- Enable App Check untuk production

---

**Selamat belajar Firebase Auth! 🔥**

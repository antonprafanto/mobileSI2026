# 📱 PERTEMUAN 9

## Firebase Authentication

---

## 🎯 Tujuan Pembelajaran

Setelah mengikuti pertemuan ini, Anda diharapkan mampu:

1. ✅ Memahami konsep autentikasi di aplikasi mobile
2. ✅ Mengintegrasikan Firebase dengan project Flutter
3. ✅ Mengimplementasikan login dengan email & password
4. ✅ Mengimplementasikan registrasi user baru
5. ✅ Mengelola state autentikasi dengan Firebase Auth
6. ✅ Mengimplementasikan logout dan session management
7. ✅ Memahami konsep OTP (One-Time Password) untuk verifikasi
8. ✅ Mengamankan route dengan authentication guard

---

## ⏱️ TIMELINE SESI (Total: 150 menit)

| Durasi   | Topik  | Aktivitas                                       |
| -------- | ------ | ----------------------------------------------- |
| 10 menit | Part 0 | Review & Warm Up                                |
| 20 menit | Part 1 | Konsep Autentikasi & Firebase Setup             |
| 25 menit | Part 2 | Firebase Auth — Login dengan Email & Password    |
| 25 menit | Part 3 | Firebase Auth — Registrasi & Verifikasi Email   |
| 30 menit | Part 4 | Auth App — Hands-On (MAIN PROJECT)             |
| 15 menit | Part 5 | Auth State Management & Route Guard             |
| 15 menit | Part 6 | OTP dengan Firebase (Optional)                  |
| 10 menit | Part 7 | Best Practices & Troubleshooting                |

---

## 📂 RESOURCES

> 💡 **File demo tersedia di folder `contoh_kode/pertemuan_9/`**

| File                              | Deskripsi                                              |
| --------------------------------- | ------------------------------------------------------ |
| `01_firebase_setup.dart`          | Contoh konfigurasi Firebase di Flutter                 |
| `02_email_auth_demo.dart`         | Login & Register dengan Email/Password                 |
| `03_auth_state_management.dart`   | StreamBuilder untuk auth state                          |
| `04_auth_guard.dart`              | Route guard untuk protected routes                     |
| `contoh_proyek/pertemuan_9_auth_app/` | Auth App lengkap dengan Firebase + Provider |

---

## 📋 PERSIAPAN SEBELUM MEMULAI

- ✅ Flutter SDK terinstall
- ✅ Akun Google untuk Firebase Console
- ✅ Editor (VS Code / Android Studio) ready
- ✅ Device / emulator running
- ✅ Review materi Pertemuan 7 (State Management)
- ✅ Install dependencies:

```bash
flutter pub add firebase_core
flutter pub add firebase_auth
flutter pub add provider
flutter pub add fluttertoast
```

---

## 🔄 PART 0: Review & Warm Up (10 menit)

### Quick Quiz (5 menit)

**Jawab pertanyaan berikut untuk check understanding:**

1. **Apa bedanya SQLite dan SharedPreferences?**
2. **Bagaimana pattern singleton diimplementasikan di DatabaseHelper?**
3. **Apa fungsi Provider dalam state management?**
4. **Bagaimana cara build APK release di Flutter?**
5. **Kenapa perlu penyimpanan lokal di aplikasi mobile?**

> 💡 **JANGAN LANJUT** sebelum yakin paham materi P7!

### Today's Challenge: Siapa yang Login? 🤔 (5 menit)

**Scenario:**

> Kamu sudah membuat aplikasi Task Manager yang keren di P7. Tapi ada masalah:
>
> ❌ Siapa pun yang buka app bisa lihat semua task
> ❌ Tidak ada personalisasi data per user
> ❌ Data task semua user tercampur
> ❌ Tidak bisa sync data antar device
>
> **Pertanyaan**: Bagaimana Instagram, Twitter, atau Gmail bisa:
> - Memastikan hanya user yang login bisa akses data mereka?
> - Menyimpan data per user terpisah?
> - Mempertahankan session login meski app ditutup?

**Jawaban**: Mereka menggunakan **Firebase Authentication**! 🔐

```
┌─────────────────────────────────────────────────────────────┐
│                    SISTEM AUTENTIKASI                         │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  📱 App Flutter                    🔥 Firebase Auth          │
│  ┌──────────────┐                 ┌──────────────────┐     │
│  │              │  1. Login       │                  │     │
│  │  Login Form  │ ──────────────> │  Email/Password  │     │
│  │              │                 │  Google Sign-In  │     │
│  │  Password    │ <──────────────│  Anonymous       │     │
│  │              │  2. Token/User  │                  │     │
│  └──────────────┘                 └──────────────────┘     │
│         │                              │                    │
│         │  3. Simpan Token               │                    │
│         ▼                              │                    │
│  ┌──────────────┐                       │                    │
│  │  SharedPrefs │                       │                    │
│  │  SQLite      │                       │                    │
│  └──────────────┘                       │                    │
│                                         │                    │
│  ┌──────────────┐  4. Request Data    │                    │
│  │  Protected   │ ──────────────────> │  Firestore/RTDB   │    │
│  │  Screen      │                     │  (user-specific) │    │
│  │              │ <────────────────── │                   │    │
│  └──────────────┘  5. Data User Only  │                   │    │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

> 💡 **Bridge dari P7**: Di Pertemuan 7, kita menyimpan data lokal. Sekarang kita belajar **mengidentifikasi user** supaya data bisa di-sync ke cloud dan terpisah per user!

---

## 🔥 PART 1: Konsep Autentikasi & Firebase Setup (20 menit)

### Apa itu Firebase?

**Firebase** adalah platform pengembangan aplikasi dari Google yang menyediakan backend-as-a-service (BaaS).

```
┌─────────────────────────────────────────────────────────────┐
│                      FIREBASE SUITE                         │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  🔐 Authentication      🔥 Cloud Firestore                  │
│  ├── Email/Password   ├── Real-time NoSQL Database         │
│  ├── Google Sign-In   └── Real-time sync                   │
│  ├── Anonymous                                             │
│  └── Phone (OTP)      📤 Firebase Storage                  │
│                         └── Upload/Download files          │
│  🔔 Cloud Messaging                                          │
│  └── Push notifications   📊 Analytics                      │
│                             └── User behavior               │
│                                                             │
│  🗂️ Crashlytics      🚀 App Distribution                   │
│  └── Error reporting  └── Beta testing                    │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Kenapa Firebase Auth?

| Fitur | Keuntungan |
|-------|-----------|
| **Backendless** | Tidak perlu bikin server sendiri |
| **Secure** | Enkripsi dan keamanan handled oleh Google |
| **Scalable** | Otomatis scale dari 10 ke 10 juta user |
| **Multi-platform** | Web, iOS, Android, Flutter |
| **Free Tier** | 10,000 user aktif/bulan gratis |
| **Social Login** | Google, Facebook, Twitter, Apple |

### 💡 ANALOGI: Firebase Auth = Satpam Gedung 🏢

> **Firebase Auth** = **Satpam di lobby gedung**
> - Cek KTP/ID (email/password)
> - Cek keaslian ID (verifikasi email)
> - Kasih kartu akses (token/session)
> - Cek kartu akses di setiap lantai (route guard)
> - Bisa cabut akses kapan saja (logout/revoke)

### Langkah 1: Buat Project Firebase (5 menit)

1. Buka [Firebase Console](https://console.firebase.google.com/)
2. Klik **"Create a project"**
3. Beri nama project: `flutter-auth-tutorial`
4. Disable Google Analytics (untuk tutorial ini)
5. Klik **"Create project"**

```
Firebase Console
┌────────────────────────────────────────────┐
│  🔥 flutter-auth-tutorial                  │
│  Project ID: flutter-auth-tutorial-12345   │
│                                            │
│  [+ Add app]                               │
│                                            │
│  Apps:                                     │
│  📱 Android                                │
│  🍎 iOS                                    │
│  🌐 Web                                    │
└────────────────────────────────────────────┘
```

### Langkah 2: Register Android App (5 menit)

Di Firebase Console:
1. Klik ikon **Android (📱)** untuk tambah app
2. **Android package name**: `com.example.auth_app`
   (sesuaikan dengan `applicationId` di `android/app/build.gradle`)
3. **App nickname**: `Auth App`
4. **Debug signing certificate SHA-1** (opsional tapi recommended):

```bash
# Generate SHA-1 untuk development
cd android
./gradlew signingReport

# Atau pakai keytool:
keytool -list -v -alias androiddebugkey -keystore %USERPROFILE%\.android\debug.keystore
# Password: android
```

5. Download `google-services.json`
6. Pindahkan ke: `android/app/google-services.json`

### Langkah 3: Konfigurasi Android (3 menit)

**Edit**: `android/build.gradle` (project level)

```gradle
buildscript {
    dependencies {
        // ... dependencies lain
        classpath 'com.google.gms:google-services:4.3.15'
    }
}
```

**Edit**: `android/app/build.gradle` (app level)

```gradle
plugins {
    id "com.android.application"
    id "kotlin-android"
    id "com.google.gms.google-services" // Tambah ini
}

android {
    // ... konfigurasi lain
    
    defaultConfig {
        applicationId "com.example.auth_app"
        // ...
    }
}

dependencies {
    implementation platform('com.google.firebase:firebase-bom:32.7.0')
    implementation 'com.google.firebase:firebase-auth'
}
```

### Langkah 4: Inisialisasi Firebase di Flutter (2 menit)

**Edit**: `lib/main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}
```

### Langkah 5: Enable Authentication Method (5 menit)

Di Firebase Console:
1. Pergi ke **Authentication** → **Sign-in method**
2. Enable **Email/Password**
3. (Optional) Enable **Google** untuk Google Sign-In

```
Firebase Console
┌────────────────────────────────────────────┐
│  Authentication → Sign-in method          │
│                                            │
│  [✅] Email/Password                       │
│  [ ] Google                               │
│  [ ] Facebook                             │
│  [ ] Phone                                │
│  [ ] Anonymous                            │
└────────────────────────────────────────────┘
```

> ⚠️ **TROUBLESHOOTING — Setup Firebase**:
>
> **Problem**: "FirebaseApp with name [DEFAULT] doesn't exist"
>
> - **Cause**: `google-services.json` tidak ditemukan
> - **Fix**: Pastikan file di `android/app/` (bukan di subfolder)
>
> **Problem**: "Duplicate class com.google..."
>
> - **Cause**: Konflik versi Firebase
> - **Fix**: Gunakan `firebase-bom` untuk version management
>
> **Problem**: SHA-1 fingerprint tidak valid
>
> - **Cause**: Debug vs Release keystore berbeda
> - **Fix**: Generate SHA-1 dari keystore yang benar

---

## 🔐 PART 2: Firebase Auth — Email & Password (25 menit)

### Firebase Auth Instance

```dart
import 'package:firebase_auth/firebase_auth.dart';

// Singleton instance
final FirebaseAuth _auth = FirebaseAuth.instance;

// Get current user
User? currentUser = _auth.currentUser;

// Stream untuk listen auth state changes
Stream<User?> authStateChanges = _auth.authStateChanges();
```

### 🎯 EKSPERIMEN 1: Login dengan Email/Password (10 menit)

```dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() => _isLoading = true);

    try {
      // SIGN IN dengan email & password
      final credential = await _auth.signInWithEmailAndPassword(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text,
      );

      // Sukses login!
      final user = credential.user;
      Fluttertoast.showToast(
        msg: "Welcome ${user?.email}!",
        backgroundColor: Colors.green,
      );

      // Navigate ke home
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } on FirebaseAuthException catch (e) {
      // Handle error spesifik Firebase
      String message = 'Login failed';
      
      if (e.code == 'user-not-found') {
        message = 'No user found with this email';
      } else if (e.code == 'wrong-password') {
        message = 'Incorrect password';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email format';
      } else if (e.code == 'user-disabled') {
        message = 'Account has been disabled';
      }

      Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.red,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: $e",
        backgroundColor: Colors.red,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🔐 Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailCtrl,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordCtrl,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _login,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('LOGIN'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Firebase Auth Error Codes

| Error Code | Arti | Solusi |
|------------|------|--------|
| `user-not-found` | Email tidak terdaftar | Register dulu |
| `wrong-password` | Password salah | Cek caps lock, reset password |
| `invalid-email` | Format email invalid | Validasi input |
| `user-disabled` | Account dinonaktifkan | Contact admin |
| `too-many-requests` | Terlalu banyak percobaan | Tunggu beberapa saat |
| `network-request-failed` | Tidak ada internet | Check koneksi |
| `email-already-in-use` | Email sudah dipakai | Gunakan email lain |
| `weak-password` | Password terlalu lemah | Minimal 6 karakter |

---

## 📝 PART 3: Firebase Auth — Registrasi (25 menit)

### 🎯 EKSPERIMEN 2: Register User Baru (10 menit)

```dart
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  Future<void> _register() async {
    // Validasi password match
    if (_passwordCtrl.text != _confirmCtrl.text) {
      Fluttertoast.showToast(
        msg: "Passwords don't match",
        backgroundColor: Colors.red,
      );
      return;
    }

    // Validasi password strength
    if (_passwordCtrl.text.length < 6) {
      Fluttertoast.showToast(
        msg: "Password must be at least 6 characters",
        backgroundColor: Colors.red,
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // CREATE USER dengan email & password
      final credential = await _auth.createUserWithEmailAndPassword(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text,
      );

      // Kirim email verifikasi
      await credential.user?.sendEmailVerification();

      Fluttertoast.showToast(
        msg: "Registration successful! Please verify your email",
        backgroundColor: Colors.green,
      );

      if (mounted) {
        Navigator.pop(context); // Kembali ke login
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Registration failed';
      
      if (e.code == 'email-already-in-use') {
        message = 'Email is already registered';
      } else if (e.code == 'weak-password') {
        message = 'Password is too weak';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email format';
      }

      Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.red,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📝 Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailCtrl,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordCtrl,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _confirmCtrl,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                prefixIcon: Icon(Icons.lock_outline),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _register,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('REGISTER'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Verifikasi Email (Optional tapi Recommended)

```dart
// Cek apakah email sudah diverifikasi
User? user = FirebaseAuth.instance.currentUser;

if (user != null && !user.emailVerified) {
  // Kirim ulang email verifikasi
  await user.sendEmailVerification();
  
  // Tampilkan warning
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Email Not Verified'),
      content: const Text('Please check your email and verify your account'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
```

### Reset Password (Forgot Password)

```dart
Future<void> _resetPassword() async {
  try {
    await _auth.sendPasswordResetEmail(
      email: _emailCtrl.text.trim(),
    );
    
    Fluttertoast.showToast(
      msg: "Password reset email sent!",
      backgroundColor: Colors.green,
    );
  } on FirebaseAuthException catch (e) {
    Fluttertoast.showToast(
      msg: e.message ?? "Failed to send reset email",
      backgroundColor: Colors.red,
    );
  }
}
```

---

## 🚀 PART 4: Auth App — Hands-On (30 menit)

### Apa yang Akan Kita Bangun?

Aplikasi **Auth Demo** lengkap dengan:
- ✅ Login Page
- ✅ Register Page
- ✅ Home Page (protected)
- ✅ Auth State Management
- ✅ Logout functionality
- ✅ Route Guard

```
┌─────────────────────────────────────────────┐
│              Auth Demo App                  │
├─────────────────────────────────────────────┤
│                                             │
│  🔄 Auth State Stream                       │
│  ┌─────────────────────────────────────┐    │
│  │                                     │    │
│  │  User Logged In? ─────┬─── Yes ───┼───>│───> HomePage
│  │                       │           │    │
│  │  ┌────────────────────┘           │    │
│  │  No                               │    │
│  │  │                                │    │
│  │  ▼                                │    │
│  │  LoginPage <── RegisterPage      │    │
│  │  │                                │    │
│  │  └───> Forgot Password            │    │
│  │                                     │    │
│  └─────────────────────────────────────┘    │
│                                             │
└─────────────────────────────────────────────┘
```

### Step 1: Setup Project (3 menit)

```bash
flutter create firebase_auth_demo
cd firebase_auth_demo
flutter pub add firebase_core firebase_auth provider fluttertoast
```

### Step 2: Firebase Initialization (2 menit)

**main.dart**:

```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthWrapper(), // Auth state listener
    );
  }
}
```

### Step 3: Auth Wrapper — State Management (5 menit)

**auth_wrapper.dart**:

```dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'login_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen ke auth state changes
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // User logged in?
        if (snapshot.hasData && snapshot.data != null) {
          // Check email verification (optional)
          if (!snapshot.data!.emailVerified) {
            return const VerificationPage();
          }
          return const HomePage();
        }

        // Not logged in
        return const LoginPage();
      },
    );
  }
}

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.email, size: 80, color: Colors.orange),
            const SizedBox(height: 16),
            const Text(
              'Please verify your email',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.currentUser?.sendEmailVerification();
              },
              child: const Text('Resend Verification Email'),
            ),
            TextButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Step 4: Home Page dengan Logout (5 menit)

**home_page.dart**:

```dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Fluttertoast.showToast(
        msg: "Logged out successfully",
        backgroundColor: Colors.green,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Logout failed: $e",
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('🏠 Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.verified_user, size: 100, color: Colors.green),
            const SizedBox(height: 24),
            const Text(
              'Welcome!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              user?.email ?? 'Unknown User',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Chip(
              label: Text(
                user?.emailVerified == true ? 'Verified' : 'Not Verified',
              ),
              backgroundColor: user?.emailVerified == true
                  ? Colors.green.shade100
                  : Colors.orange.shade100,
            ),
            const SizedBox(height: 32),
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'User Info',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('UID: ${user?.uid ?? 'N/A'}'),
                    Text('Display Name: ${user?.displayName ?? 'N/A'}'),
                    Text('Created: ${user?.metadata.creationTime ?? 'N/A'}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Step 5: Login Page Lengkap (10 menit)

Gabungkan dari Eksperimen 1 + navigasi ke register:

```dart
// Tambah di bagian bawah LoginPage build method:
TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RegisterPage()),
    );
  },
  child: const Text('Don\'t have an account? Register'),
),

TextButton(
  onPressed: () => _resetPassword(),
  child: const Text('Forgot Password?'),
),
```

**Test sekarang!** 🎉

---

## 🛡️ PART 5: Auth State Management (15 menit)

### Pattern: Auth Service dengan Provider

```dart
// services/auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Stream auth state
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in
  Future<User?> signIn(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  // Sign up
  Future<User?> signUp(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // Update profile
  Future<void> updateProfile({String? displayName, String? photoURL}) async {
    await _auth.currentUser?.updateDisplayName(displayName);
    await _auth.currentUser?.updatePhotoURL(photoURL);
  }
}
```

### Provider Setup

```dart
// main.dart dengan Provider

import 'package:provider/provider.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(
    Provider<AuthService>(
      create: (_) => AuthService(),
      child: const MyApp(),
    ),
  );
}
```

---

## 📱 PART 6: OTP dengan Firebase (15 menit - Optional)

### Konsep OTP (One-Time Password)

```
Proses OTP Phone Authentication:

1. User input nomor HP
   ↓
2. Firebase kirim SMS dengan kode 6 digit
   ↓
3. User input kode
   ↓
4. Verifikasi kode → Login berhasil
```

### Implementasi Phone Auth

```dart
class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final _phoneCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();
  String? _verificationId;

  Future<void> _sendCode() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+62${_phoneCtrl.text}', // Format internasional
      verificationCompleted: (credential) async {
        // Auto-verification (Android only)
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        Fluttertoast.showToast(msg: e.message ?? 'Verification failed');
      },
      codeSent: (verificationId, resendToken) {
        setState(() => _verificationId = verificationId);
        Fluttertoast.showToast(msg: 'Code sent!');
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  Future<void> _verifyCode() async {
    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: _codeCtrl.text,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📱 Phone Auth')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _phoneCtrl,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                prefixText: '+62 ',
                hintText: '8123456789',
              ),
              keyboardType: TextInputType.phone,
            ),
            ElevatedButton(
              onPressed: _sendCode,
              child: const Text('SEND CODE'),
            ),
            if (_verificationId != null) ...[
              TextField(
                controller: _codeCtrl,
                decoration: const InputDecoration(
                  labelText: 'Verification Code',
                ),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: _verifyCode,
                child: const Text('VERIFY'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
```

> ⚠️ **Note**: Phone Auth memerlukan SHA-1 fingerprint yang valid dan testing di real device (bisa juga emulator dengan number testing di Firebase Console).

---

## 🔧 PART 7: Best Practices & Troubleshooting (10 menit)

### Security Best Practices

1. **Jangan simpan password di local storage**
   ```dart
   // ❌ Jangan lakukan ini
   await prefs.setString('password', password);
   
   // ✅ Firebase sudah handle session securely
   ```

2. **Validasi input sebelum submit**
   ```dart
   if (email.isEmpty || !email.contains('@')) {
     // Show error
     return;
   }
   ```

3. **Gunakan HTTPS untuk semua network calls**
   - Firebase SDK sudah default HTTPS ✅

4. **Handle auth state properly**
   ```dart
   // Selalu listen ke auth state changes
   StreamBuilder<User?>(
     stream: FirebaseAuth.instance.authStateChanges(),
     builder: ...
   )
   ```

### Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| "API key not valid" | Check `google-services.json` placement |
| "App not authorized" | Add SHA-1 fingerprint in Firebase Console |
| Slow OTP delivery | Use Firebase test numbers for development |
| "This operation is not allowed" | Enable auth method in Firebase Console |
| Email link not working | Check email template configuration |

---

## 📚 LATIHAN & TUGAS

### Latihan In-Class (20 menit)

1. **Tambahkan fitur Update Profile:**
   - Display name
   - Photo URL

2. **Implementasikan Change Password:**
   - Current password verification
   - New password confirmation

3. **Tambahkan Social Login:**
   - Google Sign-In (optional)

### Tugas Praktikum (Deadline: H+7)

**Buat aplikasi dengan requirement:**
- ✅ Login dengan email/password
- ✅ Register dengan email verification
- ✅ Forgot password
- ✅ Protected home page dengan user info
- ✅ Logout functionality
- ✅ Splash screen dengan auth check
- ✅ UI yang menarik (gunakan Material 3)

**Bonus:**
- ⭐ Phone OTP authentication (+20 poin)
- ⭐ Google Sign-In (+15 poin)
- ⭐ Profile picture upload (+10 poin)

---

## 🔗 REFERENSI

### Dokumentasi
- [Firebase Auth Flutter](https://firebase.flutter.dev/docs/auth/overview/)
- [Firebase Console](https://console.firebase.google.com/)
- [Flutter Firebase Codelab](https://firebase.google.com/codelabs/firebase-get-to-know-flutter)

### Packages
- [firebase_core](https://pub.dev/packages/firebase_core)
- [firebase_auth](https://pub.dev/packages/firebase_auth)
- [google_sign_in](https://pub.dev/packages/google_sign_in) (for Google auth)

---

## ✅ SUMMARY

**Hari ini kita pelajari:**

| Topik | Key Takeaway |
|-------|-------------|
| Firebase Setup | `google-services.json`, SHA-1 fingerprint |
| Email/Password Auth | `signInWithEmailAndPassword()`, `createUserWithEmailAndPassword()` |
| Auth State | `authStateChanges()` stream, `StreamBuilder` |
| Route Guard | Redirect berdasarkan auth state |
| OTP | `verifyPhoneNumber()` untuk SMS code |

**Selanjutnya:** Pertemuan 10 — Cloud Firestore untuk database real-time! 🚀

---

> _"Authentication is the front door of your application. Make it secure but user-friendly."_ — Firebase Team

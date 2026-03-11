# 📂 Demo Code — Pertemuan 6: Networking dan API

File-file demo untuk mendukung pembelajaran di Pertemuan 6.

## 📋 Daftar File

| No | File | Topik | Dependencies |
|----|------|-------|-------------|
| 1 | `01_async_future_demo.dart` | async/await, Future.wait, Stream basics | — |
| 2 | `02_http_basic_demo.dart` | HTTP GET, POST, PUT, DELETE dengan `http` | `http` |
| 3 | `03_json_model_demo.dart` | JSON parsing, fromJson/toJson, model class | `http` |
| 4 | `04_future_builder_demo.dart` | FutureBuilder & StreamBuilder states | `http` |
| 5 | `05_news_app_complete.dart` | Post Explorer app lengkap (solusi praktikum) | `http`, `provider` |
| 6 | `06_dio_advanced_demo.dart` | Dio: interceptors, cancel token, timeout | `dio` |
| 7 | `07_error_retry_demo.dart` | Error handling, retry, exponential backoff | `http` |

## 🚀 Cara Menjalankan

```bash
# 1. Buat project baru
flutter create demo_app
cd demo_app

# 2. Install dependencies (sesuai file yang ingin dicoba)
flutter pub add http         # Untuk file 02, 03, 04, 05, 07
flutter pub add provider     # Untuk file 05
flutter pub add dio          # Untuk file 06

# 3. Copy-paste isi file ke lib/main.dart

# 4. (Android) Pastikan internet permission ada:
#    Buka android/app/src/main/AndroidManifest.xml
#    Tambahkan: <uses-permission android:name="android.permission.INTERNET"/>

# 5. Run!
flutter run
```

## 📚 Urutan Belajar (Recommended)

1. **`01_async_future_demo.dart`** — Pahami async/await/Future dulu
2. **`02_http_basic_demo.dart`** — Belajar HTTP GET/POST
3. **`03_json_model_demo.dart`** — Parsing JSON dengan model class
4. **`04_future_builder_demo.dart`** — FutureBuilder untuk menampilkan data
5. **`05_news_app_complete.dart`** — Lihat app lengkap yang menggabungkan semua
6. **`07_error_retry_demo.dart`** — Pola error handling yang proper
7. **`06_dio_advanced_demo.dart`** — Alternatif (opsional)

## 🌐 API yang Dipakai

Semua demo menggunakan **JSONPlaceholder** (`https://jsonplaceholder.typicode.com`):

- `GET /posts` — 100 posts
- `GET /posts/1` — Single post
- `POST /posts` — Create post (fake)
- `PUT /posts/1` — Update post (fake)
- `DELETE /posts/1` — Delete post (fake)
- `GET /users` — 10 users
- `GET /posts/1/comments` — Comments

> ⚠️ POST/PUT/DELETE pada JSONPlaceholder bersifat **fake** — response sukses tapi data tidak benar-benar tersimpan.

## 📖 Referensi

- [http package](https://pub.dev/packages/http)
- [dio package](https://pub.dev/packages/dio)
- [JSONPlaceholder](https://jsonplaceholder.typicode.com/)
- [Dart JSON](https://dart.dev/guides/json)
- [FutureBuilder docs](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html)

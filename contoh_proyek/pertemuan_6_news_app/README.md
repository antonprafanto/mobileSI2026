# 📱 Post Explorer — Contoh Proyek Pertemuan 6

Aplikasi Flutter yang mengkonsumsi REST API (JSONPlaceholder) untuk operasi CRUD pada posts.

## ✅ Fitur

- **List Posts** — Fetch dan tampilkan 100 posts dari API
- **Detail Post** — Lihat post lengkap + komentar
- **Create Post** — Buat post baru (POST)
- **Edit Post** — Update post existing (PUT)
- **Delete Post** — Hapus post (DELETE)
- **Pull-to-Refresh** — Swipe ke bawah untuk refresh
- **State Management** — Provider pattern
- **Error Handling** — Loading, error, dan empty states

## 📂 Struktur

```
lib/
├── main.dart                        # Entry point + Provider setup
├── models/
│   └── post.dart                    # Post model (fromJson, toJson, copyWith)
├── services/
│   └── api_service.dart             # HTTP calls (CRUD)
├── providers/
│   └── post_provider.dart           # State management (ChangeNotifier)
└── pages/
    ├── post_list_page.dart          # Home — list all posts
    ├── post_detail_page.dart        # Detail + comments
    └── post_form_page.dart          # Create / Edit form
```

## 🚀 Cara Menjalankan

```bash
# 1. Install dependencies
flutter pub get

# 2. Pastikan internet permission (Android)
#    Cek android/app/src/main/AndroidManifest.xml:
#    <uses-permission android:name="android.permission.INTERNET"/>

# 3. Run
flutter run
```

## 🌐 API

Menggunakan [JSONPlaceholder](https://jsonplaceholder.typicode.com):

| Endpoint | Method | Fungsi |
|----------|--------|--------|
| `/posts` | GET | List semua posts |
| `/posts/{id}` | GET | Detail post |
| `/posts` | POST | Buat post baru |
| `/posts/{id}` | PUT | Update post |
| `/posts/{id}` | DELETE | Hapus post |
| `/posts/{id}/comments` | GET | Komentar post |

> ⚠️ JSONPlaceholder adalah fake API — POST/PUT/DELETE return sukses tapi tidak menyimpan data.

## 📦 Dependencies

- `http` — HTTP client
- `provider` — State management

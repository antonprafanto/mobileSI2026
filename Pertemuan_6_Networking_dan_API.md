# 📱 PERTEMUAN 6

## Integrasi REST API & JSON

---

## 🎯 Tujuan Pembelajaran

Setelah mengikuti pertemuan ini, Anda diharapkan mampu:

1. ✅ Memahami konsep REST API, HTTP Methods, dan Status Codes
2. ✅ Menggunakan `async`, `await`, dan `Future` untuk operasi asynchronous
3. ✅ Melakukan HTTP request (GET, POST, PUT, DELETE) dengan package `http`
4. ✅ Parsing JSON ke Dart object dengan model class (`fromJson`/`toJson`)
5. ✅ Menggunakan `FutureBuilder` untuk menampilkan data dari API
6. ✅ Menampilkan data API dengan loading, error, dan empty state
7. ✅ Menerapkan error handling untuk operasi network
8. ✅ Mengenal package `Dio` sebagai alternatif HTTP client

---

## ⏱️ TIMELINE SESI (Total: 150 menit)

| Durasi   | Topik  | Aktivitas                                    |
| -------- | ------ | -------------------------------------------- |
| 10 menit | Part 0 | Review & Warm Up                             |
| 10 menit | Part 1 | Konsep REST API & HTTP                       |
| 15 menit | Part 2 | async, await, Future & Stream                |
| 15 menit | Part 3 | Package `http` — GET, POST, PUT, DELETE      |
| 15 menit | Part 4 | JSON Parsing & Model Class                   |
| 10 menit | Part 5 | FutureBuilder & StreamBuilder                |
| 50 menit | Part 6 | Post Explorer App Hands-On (MAIN PROJECT)    |
| 15 menit | Part 7 | Error Handling, Dio & Best Practices         |
| 10 menit | Part 8 | Latihan & Tugas Praktikum                    |

---

## 📂 RESOURCES

> 💡 **File demo tersedia di folder `contoh_kode/pertemuan_6/`**

| File                             | Deskripsi                                        |
| -------------------------------- | ------------------------------------------------ |
| `01_async_future_demo.dart`      | async/await, Future, Future.wait, Stream basics  |
| `02_http_basic_demo.dart`        | HTTP GET/POST dasar dengan package `http`        |
| `03_json_model_demo.dart`        | JSON parsing, fromJson, toJson, model class      |
| `04_future_builder_demo.dart`    | FutureBuilder & StreamBuilder dengan states      |
| `05_news_app_complete.dart`      | Post Explorer app lengkap (praktikum solution)   |
| `06_dio_advanced_demo.dart`      | Package Dio, interceptors, timeout               |
| `07_error_retry_demo.dart`       | Error handling patterns, retry logic             |

---

## 📋 PERSIAPAN SEBELUM MEMULAI

- ✅ Flutter SDK terinstall
- ✅ Editor (VS Code / Android Studio) ready
- ✅ Device / emulator running
- ✅ **🌐 Koneksi internet stabil** (KRITIS — pertemuan ini butuh akses internet!)
- ✅ Review materi Pertemuan 5 (Form, Provider)
- ✅ Install dependencies:

```bash
flutter pub add http
flutter pub add provider
```

- ✅ **Android**: Pastikan Internet Permission ada di `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- Tambahkan baris ini SEBELUM tag <application> -->
    <uses-permission android:name="android.permission.INTERNET"/>

    <application
        ...
    </application>
</manifest>
```

- ✅ **Test koneksi**: Buka `https://jsonplaceholder.typicode.com/posts/1` di browser — harus muncul data JSON

> ⚠️ **PENTING**: Tanpa Internet Permission, app Android akan **crash** atau **timeout** saat melakukan HTTP request! Ini error paling umum di pertemuan ini.

---

## 🔄 PART 0: Review & Warm Up (10 menit)

### Quick Quiz (5 menit)

**Jawab pertanyaan berikut untuk check understanding:**

1. **Apa fungsi `GlobalKey<FormState>` di Form widget?**
2. **Bagaimana cara validate semua field sekaligus?**
3. **Apa itu `ChangeNotifier` dan `notifyListeners()`?**
4. **Bedanya `context.read` dan `context.watch`?**
5. **Kenapa harus `dispose()` TextEditingController?**

> 💡 **JANGAN LANJUT** sebelum yakin paham Form dan Provider dari Pertemuan 5!

### Today's Challenge: Data dari Internet! (5 menit)

**Scenario:**

> Sampai sekarang, semua data di app kita **hardcoded** (statis):
>
> - List produk? Array di dalam kode.
> - Data pendaftar? Disimpan di Provider (memory).
> - Tutup app? Data hilang! 😱
>
> **Pertanyaan**: Bagaimana cara app seperti Instagram, Tokopedia, atau Gojek mendapatkan data yang selalu **update real-time**? 🤔

**Jawaban**: Mereka mengambil data dari **server** melalui **API**!

> 💡 **Bridge dari P5**: Ingat form pendaftaran di Pertemuan 5? Data disimpan di Provider (memory saja — tutup app, hilang!). Sekarang kita belajar **mengirim** data form itu ke server via API — supaya data **persistent** dan bisa diakses dari mana saja!

```
📱 App Flutter                    🖥️ Server
┌──────────────┐                 ┌──────────────┐
│              │  "Minta data"   │              │
│  Tampilkan   │ ───────────────>│  Database     │
│  data ke     │                 │  + Logic      │
│  user        │ <───────────────│              │
│              │  "Ini datanya"  │              │
└──────────────┘   (JSON)        └──────────────┘
```

Hari ini kita belajar **BAGAIMANA** app Flutter berkomunikasi dengan server! 🚀

---

## 🌐 PART 1: Konsep REST API & HTTP (10 menit)

### Apa itu API?

**API** (Application Programming Interface) = **cara 2 program berkomunikasi**.

### 💡 ANALOGI: REST API = Pelayan Restoran 🍽️

> **Kamu** = App Flutter (client)
> **Pelayan** = API
> **Dapur** = Server/Database
>
> 1. Kamu **pesan** makanan ke pelayan → **Request**
> 2. Pelayan **bawa pesanan** ke dapur → API forwards ke server
> 3. Dapur **masak** dan kasih ke pelayan → Server proses data
> 4. Pelayan **bawa makanan** ke meja kamu → **Response**
>
> Kamu **tidak perlu tahu** cara masak → App **tidak perlu tahu** cara server bekerja!

### REST (Representational State Transfer)

REST adalah **arsitektur** untuk komunikasi client-server. Aturannya:

1. **Stateless** — Setiap request independen (server tidak ingat request sebelumnya)
2. **Resource-based** — Setiap data punya URL unik (endpoint)
3. **HTTP Methods** — Pakai GET/POST/PUT/DELETE untuk operasi CRUD

### HTTP Methods = Menu Operasi

```
┌──────────┬────────────┬───────────────────────────────┐
│ Method   │ CRUD       │ Analogi Restoran              │
├──────────┼────────────┼───────────────────────────────┤
│ GET      │ Read       │ "Saya mau LIHAT menu"         │
│ POST     │ Create     │ "Saya mau PESAN makanan baru" │
│ PUT      │ Update     │ "Saya mau GANTI pesanan"      │
│ DELETE   │ Delete     │ "Saya mau BATALKAN pesanan"   │
└──────────┴────────────┴───────────────────────────────┘
```

### HTTP Status Codes = Jawaban dari Server

```
┌───────┬────────────────────┬──────────────────────────────┐
│ Code  │ Kategori           │ Artinya                      │
├───────┼────────────────────┼──────────────────────────────┤
│ 200   │ ✅ OK              │ Berhasil                     │
│ 201   │ ✅ Created         │ Data baru berhasil dibuat    │
│ 204   │ ✅ No Content      │ Berhasil, tidak ada data     │
│ 400   │ ❌ Bad Request     │ Request kamu salah           │
│ 401   │ 🔒 Unauthorized   │ Belum login / token expired  │
│ 403   │ 🚫 Forbidden      │ Tidak punya akses            │
│ 404   │ ❓ Not Found       │ Data tidak ditemukan         │
│ 500   │ 💥 Server Error   │ Server bermasalah            │
└───────┴────────────────────┴──────────────────────────────┘
```

> 💡 **Tips mengingat**: 2xx = ✅ sukses, 4xx = ❌ salah client, 5xx = 💥 salah server

### Anatomi URL API

```
https://jsonplaceholder.typicode.com/posts?userId=1&_limit=5
└─────────────┬──────────────┘ └──┬──┘ └───────┬────────┘
          Base URL             Endpoint    Query Parameters
```

| Bagian           | Contoh                                   | Fungsi                    |
| ---------------- | ---------------------------------------- | ------------------------- |
| **Base URL**     | `https://jsonplaceholder.typicode.com`   | Alamat server             |
| **Endpoint**     | `/posts`, `/users`, `/comments`          | Resource yang diminta      |
| **Query Params** | `?userId=1&_limit=5`                     | Filter/opsi tambahan      |

### API yang Kita Pakai: JSONPlaceholder

**JSONPlaceholder** = API publik gratis untuk belajar & prototyping.

| Endpoint              | Method | Response                      |
| --------------------- | ------ | ----------------------------- |
| `/posts`              | GET    | 100 posts                     |
| `/posts/1`            | GET    | 1 post (id=1)                 |
| `/posts`              | POST   | Buat post baru                |
| `/posts/1`            | PUT    | Update post id=1              |
| `/posts/1`            | DELETE | Hapus post id=1               |
| `/posts/1/comments`   | GET    | Komentar untuk post id=1      |
| `/users`              | GET    | 10 users                      |

> 🌐 **Coba sekarang**: Buka browser, ketik `https://jsonplaceholder.typicode.com/posts/1`. Lihat hasilnya!

---

## ⏳ PART 2: async, await, Future & Stream (15 menit)

### Kenapa Butuh Async?

HTTP request ke server **butuh waktu** (100ms - beberapa detik). Kalau kita **tunggu** tanpa async, app akan **freeze** (not responding)!

```
❌ SYNCHRONOUS (tanpa async):
┌────────────────────────────────────────────┐
│ 1. Tampil UI          ████                 │
│ 2. Fetch data         ░░░░░░░░░░ (FREEZE!) │
│ 3. Tampilkan data          ████            │
│                                            │
│ User: "Kok app-nya hang ya?" 😤            │
└────────────────────────────────────────────┘

✅ ASYNCHRONOUS (dengan async):
┌────────────────────────────────────────────┐
│ 1. Tampil UI          ████████████████     │
│ 2. Fetch data (bg)    ░░░░░░░░░░           │
│ 3. Update UI               ████████       │
│                                            │
│ User: "Wah loading-nya smooth!" 😊         │
└────────────────────────────────────────────┘
```

### 💡 ANALOGI: Future = Struk Pesanan Kopi ☕

> Saat kamu pesan kopi di kafe:
>
> 1. Kamu **pesan** dan dapat **struk/nomor** → `Future<Kopi>`
> 2. Kamu **duduk dan ngerjain tugas** sambil menunggu → App tetap responsif
> 3. Barista **panggil nomor** kamu → Future selesai (complete)
> 4. Kamu **ambil kopi** → Dapat datanya!
>
> **Future** = Janji bahwa data **AKAN** tersedia di masa depan.
> Bisa **berhasil** (dapat kopi ☕) atau **gagal** (kopi habis ❌).

### Future di Dart

```dart
// Future<T> = "Janji" yang akan menghasilkan nilai bertipe T
Future<String> ambilKopi() {
  // Simulasi menunggu 2 detik
  return Future.delayed(
    const Duration(seconds: 2),
    () => 'Kopi Latte ☕',
  );
}
```

**Future** punya 3 state:

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│  Uncompleted │ ──> │  Completed   │  OR │  Error       │
│  (menunggu)  │     │  (berhasil)  │     │  (gagal)     │
└──────────────┘     └──────────────┘     └──────────────┘
```

### async & await

**`async`** = Menandai fungsi sebagai asynchronous.
**`await`** = "Tunggu sampai Future ini selesai, baru lanjut."

```dart
// CARA 1: Pakai .then() (callback — kurang readable)
void pesanKopi() {
  ambilKopi().then((kopi) {
    print('Dapat: $kopi');
  }).catchError((error) {
    print('Error: $error');
  });
}

// CARA 2: Pakai async/await (RECOMMENDED! ✅)
Future<void> pesanKopi() async {
  try {
    String kopi = await ambilKopi(); // Tunggu sampai selesai
    print('Dapat: $kopi');
  } catch (e) {
    print('Error: $e');
  }
}
```

> ⚠️ **ATURAN**: 
> - `await` hanya boleh dipakai di dalam fungsi `async`
> - Fungsi `async` selalu return `Future`
> - `await` **TIDAK** memblokir UI — hanya memblokir **alur kode** di fungsi itu saja

### 🎯 EKSPERIMEN 1: async/await Basics (5 menit)

Buat file baru atau coba di DartPad:

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: AsyncDemoPage(),
));

class AsyncDemoPage extends StatefulWidget {
  const AsyncDemoPage({super.key});

  @override
  State<AsyncDemoPage> createState() => _AsyncDemoPageState();
}

class _AsyncDemoPageState extends State<AsyncDemoPage> {
  String _status = 'Belum pesan';
  bool _isLoading = false;

  // Simulasi fetch data (butuh waktu 2 detik)
  Future<String> _fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
    return '📦 Data dari server berhasil diambil!';
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _status = '⏳ Mengambil data...';
    });

    try {
      String result = await _fetchData();
      if (mounted) {
        setState(() {
          _status = result;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _status = '❌ Error: $e';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('async/await Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              const CircularProgressIndicator()
            else
              const Icon(Icons.cloud_download, size: 64),
            const SizedBox(height: 24),
            Text(
              _status,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _loadData,
              icon: const Icon(Icons.download),
              label: Text(_isLoading ? 'Loading...' : 'Ambil Data'),
            ),
          ],
        ),
      ),
    );
  }
}
```

**Hot Reload!** Klik tombol dan perhatikan:

1. Tombol disabled saat loading
2. Loading indicator muncul selama 2 detik
3. Setelah selesai, data ditampilkan

**💡 YANG TERJADI**:

1. `_loadData()` dipanggil → set loading = true
2. `await _fetchData()` → tunggu 2 detik (UI tetap responsif!)
3. Setelah selesai → set status + loading = false
4. `try-catch` menangkap error jika ada

### Future Utilities

```dart
// Future.wait — jalankan beberapa Future PARALEL
final results = await Future.wait([
  fetchPosts(),    // Mulai bersamaan
  fetchUsers(),    // Mulai bersamaan
  fetchComments(), // Mulai bersamaan
]);
// Semua selesai baru lanjut!

// Future.delayed — tunda eksekusi
await Future.delayed(const Duration(seconds: 1));
print('Ini muncul setelah 1 detik');
```

### Stream (Pengenalan Singkat)

**Future** = Satu data di masa depan (one-shot).
**Stream** = Aliran data bertubi-tubi (continuous).

```
Future<Kopi>  = Pesan 1 kopi     → Dapat 1 kopi
Stream<Kopi>  = Langganan kopi   → Dapat kopi tiap pagi ☕☕☕
```

```dart
// Contoh Stream sederhana
Stream<int> hitungMundur() async* {
  for (int i = 5; i >= 0; i--) {
    await Future.delayed(const Duration(seconds: 1));
    yield i; // "kirim" nilai ke listener
  }
}

// Listen stream
hitungMundur().listen((angka) {
  print('Countdown: $angka');
});
```

> 💡 Untuk pertemuan ini, kita fokus ke **Future** (karena HTTP request itu one-shot). **Stream** akan lebih terpakai di Pertemuan 9-10 (Firebase).

> ⚠️ **TROUBLESHOOTING — async/await**:
>
> **Problem**: "Fungsi async tidak menunggu"
>
> - **Cause**: Lupa pakai `await` di depan Future
> - **Fix**: Tambahkan `await` — `await fetchData()` bukan `fetchData()`
>
> **Problem**: "`await` hanya boleh di fungsi `async`"
>
> - **Cause**: Fungsi tidak ditandai `async`
> - **Fix**: Tambah `async` setelah parameter — `void foo() async { ... }`
>
> **Problem**: "setState() called after dispose()"
>
> - **Cause**: Widget sudah di-dispose tapi async masih jalan
> - **Fix**: Check `if (mounted)` sebelum `setState()`
>
> ```dart
> if (mounted) {
>   setState(() { ... });
> }
> ```

---

## 📡 PART 3: Package `http` — GET, POST, PUT, DELETE (15 menit)

### Setup Package `http`

```bash
# Install package
flutter pub add http
```

Setelah install, import dengan **alias**:

```dart
import 'package:http/http.dart' as http;
```

> 💡 **Kenapa pakai `as http`?** Package `http` punya banyak fungsi (get, post, dll). Dengan alias, kita tulis `http.get()` supaya jelas bahwa ini dari package http, bukan fungsi kita sendiri. Ini **pattern baru** — di Pertemuan 1-5 kita belum pakai import alias.

### 🎯 EKSPERIMEN 2: HTTP GET — Ambil Data (7 menit)

```dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Untuk jsonDecode

void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: HttpDemoPage(),
));

class HttpDemoPage extends StatefulWidget {
  const HttpDemoPage({super.key});

  @override
  State<HttpDemoPage> createState() => _HttpDemoPageState();
}

class _HttpDemoPageState extends State<HttpDemoPage> {
  String _result = 'Belum fetch data';
  bool _isLoading = false;

  // GET — Ambil 1 post
  Future<void> _fetchPost() async {
    setState(() => _isLoading = true);

    try {
      // 1. Kirim HTTP GET request
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
      );

      // 2. Check status code
      if (response.statusCode == 200) {
        // 3. Parse JSON string → Map
        final data = jsonDecode(response.body);
        setState(() {
          _result = 'Title: ${data['title']}\n\nBody: ${data['body']}';
        });
      } else {
        setState(() {
          _result = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _result = 'Exception: $e';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // POST — Kirim data baru
  Future<void> _createPost() async {
    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'title': 'Post dari Flutter!',
          'body': 'Ini post pertama saya dari app Flutter.',
          'userId': 1,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        setState(() {
          _result = '✅ Created!\nID: ${data['id']}\nTitle: ${data['title']}';
        });
      }
    } catch (e) {
      setState(() {
        _result = 'Exception: $e';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HTTP Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _fetchPost,
                    icon: const Icon(Icons.download),
                    label: const Text('GET Post'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _createPost,
                    icon: const Icon(Icons.upload),
                    label: const Text('POST New'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Text(_result, style: const TextStyle(fontSize: 16)),
                    ),
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

**Hot Reload!** Coba klik GET Post, lalu POST New.

**💡 YANG TERJADI**:

1. `http.get(Uri.parse(...))` → kirim GET request, return `Future<Response>`
2. `response.statusCode` → cek apakah berhasil (200 = OK)
3. `response.body` → String JSON dari server
4. `jsonDecode(response.body)` → konversi JSON String → Dart Map/List
5. `http.post(...)` → kirim data baru, butuh `headers` dan `body`

### HTTP Methods Lengkap

> 💡 Setiap contoh di bawah adalah **snippet terpisah** — jalankan satu per satu.

```dart
// GET — Ambil data
final getResponse = await http.get(Uri.parse('$baseUrl/posts'));
```

```dart
// POST — Buat data baru
final postResponse = await http.post(
  Uri.parse('$baseUrl/posts'),
  headers: {'Content-Type': 'application/json; charset=UTF-8'},
  body: jsonEncode({'title': 'New', 'body': 'Content', 'userId': 1}),
);
```

```dart
// PUT — Update data (replace seluruh object)
final putResponse = await http.put(
  Uri.parse('$baseUrl/posts/1'),
  headers: {'Content-Type': 'application/json; charset=UTF-8'},
  body: jsonEncode({'id': 1, 'title': 'Updated', 'body': 'New content', 'userId': 1}),
);
```

```dart
// PATCH — Update sebagian data
final patchResponse = await http.patch(
  Uri.parse('$baseUrl/posts/1'),
  headers: {'Content-Type': 'application/json; charset=UTF-8'},
  body: jsonEncode({'title': 'Only title changed'}),
);
```

```dart
// DELETE — Hapus data
final deleteResponse = await http.delete(Uri.parse('$baseUrl/posts/1'));
```

### 💡 Tips & Best Practices — HTTP

| Do ✅ | Don't ❌ |
| --- | --- |
| Selalu check `statusCode` | Langsung pakai `response.body` tanpa cek |
| Pakai `try-catch` untuk network error | Biarkan exception uncaught |
| Set `Content-Type` header di POST/PUT | Lupa header → server reject |
| Pakai `Uri.parse()` untuk URL | String URL langsung (deprecated) |

> ⚠️ **TROUBLESHOOTING — HTTP**:
>
> **Problem**: "SocketException: Failed host lookup"
>
> - **Cause 1**: Tidak ada internet
> - **Cause 2**: URL typo
> - **Fix**: Cek koneksi + cek URL di browser
>
> **Problem**: "XMLHttpRequest error" (di Chrome/Web)
>
> - **Cause**: CORS policy — browser blokir request ke domain lain
> - **Fix**: Test di **emulator Android** atau **physical device**, bukan Chrome. Untuk web, server harus allow CORS.
>
> **Problem**: "Connection refused" (di Android emulator)
>
> - **Cause**: Emulator pakai IP berbeda dari `localhost`
> - **Fix**: Untuk lokal server, ganti `localhost` dengan `10.0.2.2` di Android emulator

---

## 🔄 PART 4: JSON Parsing & Model Class (15 menit)

### Apa itu JSON?

**JSON** (JavaScript Object Notation) = format data yang paling umum dipakai API.

```json
{
  "userId": 1,
  "id": 1,
  "title": "Belajar Flutter",
  "body": "Flutter itu seru banget!"
}
```

### 💡 ANALOGI: JSON = Bahasa Universal 🌍

> **App Flutter** bicara Dart, **Server** bicara Python/Java/Go/dll.
>
> Mereka butuh **bahasa yang sama** untuk komunikasi → **JSON**!
>
> Seperti orang Indonesia dan Jepang yang pakai **bahasa Inggris** untuk berkomunikasi.

### JSON di Dart: `dart:convert`

```dart
import 'dart:convert';

// JSON String → Dart Map (decode)
String jsonString = '{"name": "Anton", "age": 25}';
Map<String, dynamic> map = jsonDecode(jsonString);
print(map['name']); // Anton

// Dart Map → JSON String (encode)
Map<String, dynamic> data = {'name': 'Anton', 'age': 25};
String json = jsonEncode(data);
print(json); // {"name":"Anton","age":25}
```

### Masalah: Akses Data via Map 😱

```dart
// Tanpa model class — RAWAN ERROR!
final data = jsonDecode(response.body);
print(data['titl']); // TYPO! null, no error ❌
print(data['title'] as int); // WRONG TYPE! crash ❌
// Tidak ada autocomplete, tidak ada type checking 😭
```

### Solusi: Model Class! 🎉

### 💡 ANALOGI: Model Class = Cetakan Kue 🧁

> **JSON** = adonan kue (data mentah, tidak berbentuk)
> **Model Class** = cetakan kue (memberikan bentuk dan aturan)
> **Object** = kue yang sudah jadi (data yang rapi dan typed)
>
> Tanpa cetakan: adonan berantakan → data tidak terstruktur
> Dengan cetakan: kue berbentuk rapi → data terorganisir dengan type safety

### 🎯 EKSPERIMEN 3: Membuat Model Class (8 menit)

```dart
// lib/models/post.dart

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  // Constructor
  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  // Factory constructor: JSON Map → Post object
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  // Post object → JSON Map
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  @override
  String toString() => 'Post(id: $id, title: $title)';
}
```

**Sekarang pakai model class:**

```dart
// SEBELUM (tanpa model) — BAHAYA! 😱
final data = jsonDecode(response.body);
print(data['title']); // No type safety

// SESUDAH (dengan model) — AMAN! ✅
final post = Post.fromJson(jsonDecode(response.body));
print(post.title); // Autocomplete + type checking!
```

### Parsing List of Objects

API sering return **array** of objects:

```json
[
  {"userId": 1, "id": 1, "title": "Post 1", "body": "..."},
  {"userId": 1, "id": 2, "title": "Post 2", "body": "..."}
]
```

Cara parse:

```dart
Future<List<Post>> fetchPosts() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
  );

  if (response.statusCode == 200) {
    // 1. Decode JSON string → List<dynamic>
    final List<dynamic> jsonList = jsonDecode(response.body);

    // 2. Map setiap item ke Post object
    return jsonList.map((json) => Post.fromJson(json)).toList();
  } else {
    throw Exception('Gagal memuat posts');
  }
}
```

### `json_serializable` (Opsional — Code Generation)

Menulis `fromJson` dan `toJson` manual itu **repetitif**. Package `json_serializable` bisa **generate otomatis**:

```bash
flutter pub add json_annotation
flutter pub add --dev json_serializable build_runner
```

```dart
import 'package:json_annotation/json_annotation.dart';
part 'post.g.dart'; // File generated

@JsonSerializable()
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({required this.userId, required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
```

```bash
# Generate code
dart run build_runner build
```

> 💡 Untuk pertemuan ini, kita pakai **manual** `fromJson`/`toJson` supaya paham prosesnya. `json_serializable` lebih cocok untuk project besar dengan banyak model.

> ⚠️ **TROUBLESHOOTING — JSON**:
>
> **Problem**: "type 'int' is not a subtype of type 'String'"
>
> - **Cause**: Tipe data di JSON tidak sesuai dengan di model
> - **Fix**: Check tipe data di JSON response, sesuaikan model class
>
> **Problem**: "FormatException: Unexpected character"
>
> - **Cause**: `response.body` bukan valid JSON
> - **Fix**: Print `response.body` untuk debug, cek API response
>
> **Problem**: "Null check operator used on a null value"
>
> - **Cause**: Field di JSON bernilai `null` tapi model expect non-null
> - **Fix**: Gunakan nullable type `String?` atau berikan default value

---

## 🏗️ PART 5: FutureBuilder & StreamBuilder (10 menit)

### Kenapa Butuh FutureBuilder?

Sampai sekarang, kita **manual** manage loading state:

```dart
// Manual — banyak setState! 😫
bool _isLoading = false;
String _data = '';

Future<void> _loadData() async {
  setState(() => _isLoading = true);     // setState #1
  try {
    final result = await fetchData();
    setState(() => _data = result);       // setState #2
  } catch (e) {
    setState(() => _data = 'Error');      // setState #3
  } finally {
    setState(() => _isLoading = false);   // setState #4
  }
}
```

**FutureBuilder** = Flutter widget yang **otomatis** handle semua state ini!

### 💡 ANALOGI: FutureBuilder = Status Pengiriman Paket 📦

> Saat kamu beli online:
>
> 1. **Waiting** → "Pesanan diproses" (loading spinner)
> 2. **Done** → "Paket sampai!" (tampilkan data) ✅
> 3. **Error** → "Pengiriman gagal" (tampilkan error) ❌
>
> **FutureBuilder** otomatis track status ini dan rebuild UI!

### 🎯 EKSPERIMEN 4: FutureBuilder (5 menit)

```dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: FutureBuilderDemoPage(),
));

class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}

class FutureBuilderDemoPage extends StatefulWidget {
  const FutureBuilderDemoPage({super.key});

  @override
  State<FutureBuilderDemoPage> createState() => _FutureBuilderDemoPageState();
}

class _FutureBuilderDemoPageState extends State<FutureBuilderDemoPage> {
  // PENTING: Future disimpan di variable, BUKAN langsung di FutureBuilder!
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = _fetchPosts();
  }

  Future<List<Post>> _fetchPosts() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=10'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat data (${response.statusCode})');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureBuilder Demo'),
        actions: [
          // Refresh button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _postsFuture = _fetchPosts(); // Re-fetch!
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Post>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          // STATE 1: Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // STATE 2: Error
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() => _postsFuture = _fetchPosts());
                    },
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          // STATE 3: Empty
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Tidak ada data', style: TextStyle(fontSize: 18)),
            );
          }

          // STATE 4: Success — tampilkan data!
          final posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(child: Text('${post.id}')),
                  title: Text(
                    post.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    post.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
```

**💡 YANG TERJADI**:

1. `initState()` → set `_postsFuture` SEKALI
2. `FutureBuilder` otomatis listen Future tersebut
3. `snapshot.connectionState` → track status: waiting, done
4. `snapshot.hasError` → ada error? tampilkan pesan
5. `snapshot.hasData` → ada data? tampilkan list!
6. Refresh → `setState()` dengan Future baru

> ⚠️ **PENTING**: Simpan Future di **variable** (bukan langsung di `future:` parameter)! Kalau langsung, Future akan dipanggil ulang **setiap rebuild** → infinite loop fetch!

```dart
// ❌ SALAH — fetch ulang setiap rebuild
FutureBuilder(
  future: _fetchPosts(), // Dipanggil ulang terus!
  ...
)

// ✅ BENAR — fetch sekali, simpan di variable
late Future<List<Post>> _postsFuture;

@override
void initState() {
  super.initState();
  _postsFuture = _fetchPosts(); // Sekali saja
}

FutureBuilder(
  future: _postsFuture, // Reference ke Future yang sama
  ...
)
```

### FutureBuilder ConnectionState

| State                | Artinya                              | UI yang tepat             |
| -------------------- | ------------------------------------ | ------------------------- |
| `none`               | Tidak ada Future                     | Tampilkan placeholder     |
| `waiting`            | Future belum selesai                 | Loading indicator ⏳      |
| `active`             | Stream punya data (StreamBuilder)    | Update data               |
| `done`               | Future selesai (berhasil/error)      | Data atau error message   |

### StreamBuilder — Untuk Data Continuous

```dart
// StreamBuilder — mirip FutureBuilder tapi untuk Stream
StreamBuilder<int>(
  stream: hitungMundur(), // Stream, bukan Future
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return Text('Countdown: ${snapshot.data}');
    }
    return const CircularProgressIndicator();
  },
)
```

**Kapan pakai mana?**

```
┌──────────────────┬─────────────────────────────────┐
│ FutureBuilder    │ StreamBuilder                   │
├──────────────────┼─────────────────────────────────┤
│ Data sekali saja │ Data terus-menerus              │
│ HTTP request     │ WebSocket, Firebase Realtime    │
│ Load config      │ Location updates, sensor data   │
│ One-shot query   │ Chat messages, live data        │
└──────────────────┴─────────────────────────────────┘
```

> 💡 Untuk REST API (Pertemuan ini), kita pakai **FutureBuilder**. **StreamBuilder** akan lebih terpakai di Pertemuan 9-10 (Firebase) yang punya realtime data.

---

## 🚀 PART 6: Post Explorer App — Hands-On (50 menit)

### Apa yang Akan Kita Bangun?

Aplikasi **Post Explorer** yang lengkap:

- ✅ List posts dari API (GET)
- ✅ Detail post + comments (GET)
- ✅ Buat post baru (POST)
- ✅ Edit post (PUT)
- ✅ Hapus post (DELETE)
- ✅ Loading, error, empty states
- ✅ Provider untuk state management
- ✅ Proper model classes

```
┌─────────────────┐     ┌──────────────────┐     ┌──────────────────┐
│ Post List Page  │ ──> │ Post Detail Page  │     │ Post Form Page   │
│                 │     │                   │     │ (Create / Edit)  │
│ • List semua    │     │ • Title, body     │     │                  │
│   posts         │     │ • Comments        │     │ • Title field    │
│ • FAB: + New    │     │ • Edit / Delete   │     │ • Body field     │
│ • Pull refresh  │     │                   │     │ • Submit         │
└─────────────────┘     └──────────────────┘     └──────────────────┘
```

API: `https://jsonplaceholder.typicode.com`

### Step 1: Create Project & Setup (5 menit)

```bash
flutter create post_explorer
cd post_explorer
flutter pub add http
flutter pub add provider
```

**Pastikan Internet Permission** sudah ada di `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

**Struktur folder:**

```
lib/
├── main.dart
├── models/
│   └── post.dart
├── services/
│   └── api_service.dart
├── providers/
│   └── post_provider.dart
└── pages/
    ├── post_list_page.dart
    ├── post_detail_page.dart
    └── post_form_page.dart
```

### Step 2: Create Post Model (5 menit)

**Create**: `lib/models/post.dart`

```dart
// lib/models/post.dart

class Post {
  final int? id;
  final int userId;
  final String title;
  final String body;

  Post({
    this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  // JSON → Post
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int?,
      userId: json['userId'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  // Post → JSON
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }

  // Untuk copy dengan modifikasi
  Post copyWith({
    int? id,
    int? userId,
    String? title,
    String? body,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }
}
```

**💡 YANG BARU**:

- `id` nullable (`int?`) — karena saat create post baru, id belum ada
- `copyWith()` — pattern untuk membuat salinan object dengan perubahan
- `toJson()` hanya include `id` jika bukan null

### Step 3: Create API Service (10 menit)

**Create**: `lib/services/api_service.dart`

```dart
// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class ApiService {
  // Base URL — disimpan sebagai constant
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // GET — Ambil semua posts
  Future<List<Post>> getPosts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat posts (${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // GET — Ambil 1 post by ID
  Future<Post> getPost(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts/$id'),
      );

      if (response.statusCode == 200) {
        return Post.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Post tidak ditemukan');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // POST — Buat post baru
  Future<Post> createPost(Post post) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(post.toJson()),
      );

      if (response.statusCode == 201) {
        return Post.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Gagal membuat post');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // PUT — Update post
  Future<Post> updatePost(Post post) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/posts/${post.id}'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(post.toJson()),
      );

      if (response.statusCode == 200) {
        return Post.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Gagal mengupdate post');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // DELETE — Hapus post
  Future<bool> deletePost(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/posts/$id'),
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // GET — Ambil comments untuk post
  Future<List<Map<String, dynamic>>> getComments(int postId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts/$postId/comments'),
      );

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(jsonDecode(response.body));
      } else {
        throw Exception('Gagal memuat komentar');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
```

**💡 PATTERN yang dipakai**:

1. **Base URL sebagai constant** — mudah diganti jika API berubah
2. **try-catch di setiap method** — handle network errors
3. **Status code checking** — pastikan response valid
4. **Throw exception** — biarkan caller (Provider) yang handle error

### Step 4: Create Post Provider (5 menit)

**Create**: `lib/providers/post_provider.dart`

```dart
// lib/providers/post_provider.dart
import 'package:flutter/foundation.dart';
import '../models/post.dart';
import '../services/api_service.dart';

class PostProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Post> _posts = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch all posts
  Future<void> fetchPosts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _posts = await _apiService.getPosts();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Create post
  Future<bool> createPost(String title, String body) async {
    try {
      final newPost = Post(userId: 1, title: title, body: body);
      final created = await _apiService.createPost(newPost);

      // Tambahkan ke list lokal (di awal)
      _posts.insert(0, created);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Update post
  Future<bool> updatePost(Post post) async {
    try {
      final updated = await _apiService.updatePost(post);

      // Update di list lokal
      final index = _posts.indexWhere((p) => p.id == post.id);
      if (index != -1) {
        _posts[index] = updated;
        notifyListeners();
      }
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Delete post
  Future<bool> deletePost(int id) async {
    try {
      await _apiService.deletePost(id);

      // Hapus dari list lokal
      _posts.removeWhere((p) => p.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
```

**💡 YANG TERJADI**:

- Provider sebagai **penghubung** antara UI dan API Service
- `_isLoading` dan `_errorMessage` untuk UI state
- Setiap operasi: loading → call API → update list lokal → notify UI
- Return `bool` untuk create/update/delete supaya UI tahu berhasil atau tidak

### Step 5: Create Post List Page (10 menit)

**Create**: `lib/pages/post_list_page.dart`

```dart
// lib/pages/post_list_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/post_provider.dart';
import 'post_detail_page.dart';
import 'post_form_page.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  @override
  void initState() {
    super.initState();
    // Fetch posts saat halaman pertama dibuka
    Future.microtask(() {
      context.read<PostProvider>().fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📱 Post Explorer'),
        actions: [
          // Refresh button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<PostProvider>().fetchPosts();
            },
          ),
        ],
      ),
      body: Consumer<PostProvider>(
        builder: (context, provider, child) {
          // STATE 1: Loading
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // STATE 2: Error
          if (provider.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wifi_off, size: 80, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      provider.errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () => provider.fetchPosts(),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          // STATE 3: Empty
          if (provider.posts.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.article_outlined, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('Belum ada post', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Tap + untuk membuat post baru',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          // STATE 4: Success — tampilkan list!
          return RefreshIndicator(
            onRefresh: () => provider.fetchPosts(),
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: provider.posts.length,
              itemBuilder: (context, index) {
                final post = provider.posts[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Text('${post.id ?? "?"}'),
                    ),
                    title: Text(
                      post.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      post.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PostDetailPage(post: post),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
      // FAB untuk membuat post baru
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PostFormPage()),
          );
          if (result == true && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('✅ Post berhasil dibuat!'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

**💡 Design Patterns**:

- **4 states** ditangani: loading, error, empty, success
- **RefreshIndicator** — pull-to-refresh (swipe ke bawah)
- **Consumer** — rebuild otomatis saat Provider berubah
- **Future.microtask** di initState — safe way untuk call Provider

### Step 6: Create Detail Page (5 menit)

**Create**: `lib/pages/post_detail_page.dart`

```dart
// lib/pages/post_detail_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post.dart';
import '../providers/post_provider.dart';
import '../services/api_service.dart';
import 'post_form_page.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;

  const PostDetailPage({super.key, required this.post});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  late Future<List<Map<String, dynamic>>> _commentsFuture;

  @override
  void initState() {
    super.initState();
    // PENTING: Simpan Future di variable, bukan langsung di FutureBuilder!
    _commentsFuture = ApiService().getComments(widget.post.id!);
  }

  // Shortcut supaya bisa pakai 'post' langsung (tanpa 'widget.')
  Post get post => widget.post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post #${post.id}'),
        actions: [
          // Edit button
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PostFormPage(post: post),
                ),
              );
              if (result == true && context.mounted) {
                Navigator.pop(context);
              }
            },
          ),
          // Delete button
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              post.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'oleh User #${post.userId}',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const Divider(height: 32),

            // Body
            Text(
              post.body,
              style: const TextStyle(fontSize: 16, height: 1.6),
            ),
            const Divider(height: 32),

            // Comments Section
            const Text(
              '💬 Komentar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildComments(),
          ],
        ),
      ),
    );
  }

  Widget _buildComments() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _commentsFuture, // Disimpan di initState, bukan panggil baru!
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Text('Gagal memuat komentar: ${snapshot.error}');
        }

        final comments = snapshot.data ?? [];
        if (comments.isEmpty) {
          return const Text('Belum ada komentar');
        }

        return Column(
          children: comments.map((comment) {
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          child: Text(
                            comment['name'][0].toUpperCase(),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                comment['email'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(comment['body'], style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Post?'),
        content: Text('Yakin ingin menghapus "${post.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx); // Close dialog
              final success = await context.read<PostProvider>().deletePost(post.id!);
              if (context.mounted) {
                Navigator.pop(context); // Back to list
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(success ? '🗑️ Post dihapus' : '❌ Gagal menghapus'),
                    backgroundColor: success ? Colors.green : Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
```

> 💡 **Latihan**: Comments di atas masih pakai `Map<String, dynamic>`. Coba buat model class `Comment` sendiri dengan `fromJson()` untuk menggantikannya! Ini akan memperkuat pemahaman kamu tentang model class.

### Step 7: Create Post Form Page & main.dart (10 menit)

**Create**: `lib/pages/post_form_page.dart`

```dart
// lib/pages/post_form_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post.dart';
import '../providers/post_provider.dart';

class PostFormPage extends StatefulWidget {
  final Post? post; // null = create, non-null = edit

  const PostFormPage({super.key, this.post});

  @override
  State<PostFormPage> createState() => _PostFormPageState();
}

class _PostFormPageState extends State<PostFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  bool _isSubmitting = false;

  bool get isEditing => widget.post != null;

  @override
  void initState() {
    super.initState();
    // Jika edit, isi form dengan data existing
    if (isEditing) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final provider = context.read<PostProvider>();
      bool success;

      if (isEditing) {
        // Update existing post
        final updatedPost = widget.post!.copyWith(
          title: _titleController.text.trim(),
          body: _bodyController.text.trim(),
        );
        success = await provider.updatePost(updatedPost);
      } else {
        // Create new post
        success = await provider.createPost(
          _titleController.text.trim(),
          _bodyController.text.trim(),
        );
      }

      if (mounted) {
        if (success) {
          Navigator.pop(context, true); // Return true = berhasil
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('❌ Gagal ${isEditing ? "mengupdate" : "membuat"} post'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Post' : 'Buat Post Baru'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title field
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Judul Post *',
                  hintText: 'Masukkan judul post',
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(),
                ),
                maxLength: 100,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Judul wajib diisi';
                  }
                  if (value.trim().length < 5) {
                    return 'Judul minimal 5 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Body field
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(
                  labelText: 'Isi Post *',
                  hintText: 'Tulis isi post di sini...',
                  prefixIcon: Icon(Icons.article),
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 8,
                maxLength: 500,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Isi post wajib diisi';
                  }
                  if (value.trim().length < 10) {
                    return 'Isi post minimal 10 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Submit button
              ElevatedButton.icon(
                onPressed: _isSubmitting ? null : _submitForm,
                icon: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(isEditing ? Icons.save : Icons.send),
                label: Text(
                  _isSubmitting
                      ? 'Mengirim...'
                      : (isEditing ? 'UPDATE POST' : 'KIRIM POST'),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

**Update**: `lib/main.dart`

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/post_provider.dart';
import 'pages/post_list_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => PostProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const PostListPage(),
    );
  }
}
```

**Run!** `flutter run`

Coba:

1. ✅ Lihat list posts (otomatis fetch saat buka)
2. ✅ Tap post → detail + komentar
3. ✅ Tap + → buat post baru
4. ✅ Edit post dari detail page
5. ✅ Delete post dari detail page
6. ✅ Pull-to-refresh di list page

> ⚠️ **CATATAN JSONPlaceholder**: POST/PUT/DELETE tidak benar-benar menyimpan data di server (fake API). Data yang dibuat akan tetap return response sukses, tapi tidak persistent. Ini normal untuk API testing!

---

## 🛡️ PART 7: Error Handling, Dio & Best Practices (15 menit)

### Network Error Handling Patterns

Saat bekerja dengan API, **banyak hal bisa gagal**:

```
┌────────────────────────────────────────────────────┐
│ Kemungkinan Error                                  │
├────────────────────────────────────────────────────┤
│ 🌐 Tidak ada internet (SocketException)            │
│ ⏱️ Request terlalu lama (TimeoutException)         │
│ 🔒 Unauthorized / token expired (401)              │
│ 🚫 Forbidden / no access (403)                     │
│ ❓ Endpoint tidak ada (404)                         │
│ 💥 Server error (500)                              │
│ 📄 Response bukan JSON valid (FormatException)      │
│ 🔌 Connection reset / dropped                      │
└────────────────────────────────────────────────────┘
```

### Proper Error Handling Pattern

```dart
import 'dart:async'; // Untuk TimeoutException
import 'dart:io';    // Untuk SocketException

Future<List<Post>> fetchPosts() async {
  try {
    final response = await http.get(
      Uri.parse('$baseUrl/posts'),
    ).timeout(const Duration(seconds: 10)); // Timeout!

    switch (response.statusCode) {
      case 200:
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Post.fromJson(json)).toList();
      case 401:
        throw Exception('Sesi habis, silakan login ulang');
      case 404:
        throw Exception('Data tidak ditemukan');
      case 500:
        throw Exception('Server sedang bermasalah');
      default:
        throw Exception('Error (${response.statusCode})');
    }
  } on TimeoutException {
    throw Exception('Koneksi timeout, cek internet Anda');
  } on SocketException {
    throw Exception('Tidak ada koneksi internet');
  } on FormatException {
    throw Exception('Data dari server tidak valid');
  } catch (e) {
    throw Exception('Terjadi kesalahan: $e');
  }
}
```

> 💡 **Tips**: Import `dart:async` untuk `TimeoutException` dan `dart:io` untuk `SocketException`.

### Retry Pattern

```dart
Future<http.Response> _fetchWithRetry(
  String url, {int maxRetries = 3}
) async {
  int attempt = 0;
  while (attempt < maxRetries) {
    try {
      final response = await http.get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) return response;
      throw Exception('Status: ${response.statusCode}');
    } catch (e) {
      attempt++;
      if (attempt >= maxRetries) rethrow;
      // Tunggu sebelum retry (exponential backoff)
      await Future.delayed(Duration(seconds: attempt * 2));
    }
  }
  throw Exception('Max retries reached');
}
```

### Package Dio — Alternatif `http` yang Lebih Powerful

**Dio** = HTTP client untuk Dart dengan fitur lebih lengkap.

```bash
flutter pub add dio
```

```dart
import 'package:dio/dio.dart';

final dio = Dio(BaseOptions(
  baseUrl: 'https://jsonplaceholder.typicode.com',
  connectTimeout: const Duration(seconds: 10),
  receiveTimeout: const Duration(seconds: 10),
  headers: {'Content-Type': 'application/json'},
));

// GET
final getResponse = await dio.get('/posts');
List<dynamic> posts = getResponse.data; // Sudah di-decode!

// POST
final postResponse = await dio.post('/posts', data: {
  'title': 'New Post',
  'body': 'Content',
  'userId': 1,
});

// Interceptors — jalankan kode sebelum/sesudah request
dio.interceptors.add(InterceptorsWrapper(
  onRequest: (options, handler) {
    print('→ ${options.method} ${options.uri}');
    handler.next(options); // Lanjutkan request
  },
  onResponse: (response, handler) {
    print('← ${response.statusCode}');
    handler.next(response);
  },
  onError: (error, handler) {
    print('✖ Error: ${error.message}');
    handler.next(error);
  },
));
```

**Perbandingan `http` vs `Dio`:**

```
┌──────────────────┬─────────────────────────────────┐
│ http             │ Dio                             │
├──────────────────┼─────────────────────────────────┤
│ Ringan, simple   │ Fitur lengkap                   │
│ Manual JSON      │ Auto decode JSON                │
│ No interceptors  │ Interceptors built-in           │
│ No cancel        │ Cancel token support            │
│ Basic timeout    │ Connect + receive timeout       │
│ Cocok: app kecil │ Cocok: app production           │
└──────────────────┴─────────────────────────────────┘
```

> 💡 Untuk belajar, `http` sudah cukup. Untuk production app, pertimbangkan `Dio`.

### ✅ Best Practices Checklist

1. **Selalu handle error** — `try-catch` di setiap HTTP call
2. **Set timeout** — jangan biarkan user menunggu selamanya
3. **Pakai model class** — type safety, autocomplete
4. **Simpan base URL** sebagai constant — mudah maintenance
5. **Pisahkan concern** — Model, Service, Provider, UI (4 layer)
6. **Loading dan error state** — UX yang baik
7. **Jangan fetch di `build()`** — pakai `initState` atau trigger manual
8. **Check `mounted`** sebelum `setState` setelah `await`
9. **`dispose()` resources** — controllers, subscriptions
10. **Internet permission** — Android `AndroidManifest.xml`

### ✅ Yang Sudah Dipelajari

1. **REST API & HTTP** — konsep, methods, status codes
2. **async/await/Future** — asynchronous programming di Dart
3. **Package `http`** — GET, POST, PUT, DELETE requests
4. **JSON Parsing** — jsonDecode/jsonEncode, model class, fromJson/toJson
5. **FutureBuilder** — otomatis handle loading/error/success states
6. **Post Explorer App** — CRUD operations lengkap dengan Provider
7. **Error Handling** — timeout, retry, proper error messages
8. **Dio** — alternatif HTTP client untuk production

### 🏆 Achievement Unlocked

- ✅ Bisa fetch data dari internet dan tampilkan di app
- ✅ Bisa parsing JSON ke Dart object dengan model class
- ✅ Bisa CRUD operations (Create, Read, Update, Delete) via API
- ✅ Bisa handle loading, error, dan empty states
- ✅ Bisa gunakan FutureBuilder untuk data async
- ✅ Working Post Explorer app! 📱🌐

---

## 📝 PART 8: Latihan & Tugas Praktikum (10 menit)

### Latihan 1: Fetch & Display

**Buat app sederhana** yang:

- Fetch daftar **users** dari `https://jsonplaceholder.typicode.com/users`
- Tampilkan di `ListView` dengan nama, email, dan kota
- Handle loading dan error state
- Buat `User` model class dengan `fromJson()`

### Latihan 2: CRUD App

**Buat app CRUD** untuk posts:

- List semua posts (GET)
- Buat post baru (POST) — form dengan title dan body
- Update post (PUT)
- Delete post (DELETE)
- Tampilkan snackbar feedback (berhasil/gagal)
- Pakai Provider untuk state management

### Latihan 3: Multi-API Dashboard (Bonus)

**Buat dashboard** yang menampilkan data dari 3 endpoint:

- Posts (jumlah dan 5 post terbaru)
- Users (jumlah dan daftar lengkap)
- Comments dari post pertama
- Pakai `Future.wait()` untuk parallel fetch
- TabBar/BottomNavigationBar untuk navigasi

### 📋 Tugas Praktikum (Deadline: H+7)

**Buat Aplikasi yang Mengkonsumsi API Publik** dengan spesifikasi:

**Wajib:**

1. ✅ Fetch data dari API publik (JSONPlaceholder, atau API lain pilihan sendiri)
2. ✅ Minimal 2 model class dengan `fromJson()` dan `toJson()`
3. ✅ Minimal 2 halaman (list + detail)
4. ✅ FutureBuilder atau manual state management
5. ✅ Loading, error, dan empty state yang proper
6. ✅ Provider untuk state management
7. ✅ Error handling dengan `try-catch`

**Bonus (+20):**

- CRUD operations lengkap: Create, Update, Delete (+10)
- Search/filter data (+5)
- Pull-to-refresh (+5)

**API Publik yang Bisa Dipakai:**

| API               | URL                                          | Butuh Key? |
| ----------------- | -------------------------------------------- | ---------- |
| JSONPlaceholder   | `jsonplaceholder.typicode.com`               | ❌ Tidak   |
| DummyJSON         | `dummyjson.com`                              | ❌ Tidak   |
| REST Countries    | `restcountries.com/v3.1`                     | ❌ Tidak   |
| TMDB (Film)       | `api.themoviedb.org/3`                       | ✅ Gratis  |
| OpenWeather       | `api.openweathermap.org/data/2.5`            | ✅ Gratis  |
| NewsAPI           | `newsapi.org/v2`                             | ✅ Gratis  |

**Format Pengumpulan:**

- GitHub repository
- Screenshot: list page, detail page, loading state, error state
- Penamaan: `NIM_NamaLengkap_Tugas6`

---

## ❓ FAQ (Frequently Asked Questions)

### Q1: Bedanya `http` dan `Dio`?

**A**: `http` itu package ringan dan simple — cocok untuk belajar dan app kecil. `Dio` lebih lengkap: auto JSON decode, interceptors, cancel request, upload progress. Untuk tugas ini, `http` sudah cukup.

### Q2: Kenapa harus pakai `as http` saat import?

**A**: Package `http` punya fungsi `get()`, `post()`, dll yang namanya generik. Dengan alias `as http`, kita tulis `http.get()` supaya jelas bahwa ini dari package http. Tanpa alias, bisa bentrok dengan nama fungsi kita sendiri.

### Q3: Kenapa `fromJson` pakai `factory` constructor?

**A**: `factory` constructor bisa return instance yang sudah ada atau instance baru. Pada `fromJson`, kita pakai factory karena logikanya membuat object baru dari data external (JSON). Ini juga memungkinkan validasi sebelum membuat object.

### Q4: JSONPlaceholder POST tidak nyimpan data?

**A**: Benar! JSONPlaceholder adalah **fake API** untuk testing. POST/PUT/DELETE akan return response sukses (seolah-olah berhasil), tapi data sebenarnya **tidak disimpan** di server. Untuk production app, kamu perlu backend sungguhan (Firebase, Node.js, dll).

### Q5: Gimana kalau butuh authentication (Bearer token)?

**A**: Tambahkan di `headers`:

```dart
final response = await http.get(
  Uri.parse('$baseUrl/posts'),
  headers: {
    'Authorization': 'Bearer your_token_here',
    'Content-Type': 'application/json',
  },
);
```

### Q6: App crash saat internet mati, gimana?

**A**: Selalu wrap HTTP calls dengan `try-catch` dan handle `SocketException`:

```dart
try {
  final response = await http.get(Uri.parse(url));
  // Process response
} on SocketException {
  // Tampilkan pesan "Tidak ada internet"
} catch (e) {
  // Handle error lain
}
```

Untuk UX yang baik, tampilkan **error state** dengan tombol "Coba Lagi" supaya user bisa retry tanpa restart app.

---

## 👨‍🏫 FOR INSTRUCTORS ONLY

> 📌 Instruksi untuk Dosen/Instruktur

### Persiapan Sebelum Kelas (30 menit)

1. **Test Koneksi & API**
   - Pastikan WiFi kelas **stabil dan cepat**
   - Coba buka `jsonplaceholder.typicode.com` di browser
   - Run Post Explorer demo di emulator
   - Test CRUD operations

2. **Backup Plan (WiFi Mati!)**
   - Siapkan **mock data** sebagai fallback
   - Screenshot/screen recording API responses
   - Pre-download dependencies (`http`, `provider`)
   - Bisa ajarkan konsep tanpa live API (pakai `Future.delayed` + hardcoded JSON)

3. **Setup Classroom**
   - Projector tested
   - Sample app running
   - WiFi stable
   - Students sudah install `http` package SEBELUM kelas

### Timeline Management (STRICT 150 min)

**Cannot skip**:

- Part 0: 10 min (review essential)
- Part 2: 15 min (async/await — FUNDAMENTAL!)
- Part 3: 15 min (http GET/POST — CORE!)
- Part 6: 50 min (main project)

**Can adjust**:

- Part 1: 10 min → 7 min (REST concept brief saja)
- Part 4: 15 min → 10 min (model class basics saja, skip json_serializable)
- Part 5: 10 min → 7 min (FutureBuilder saja, skip StreamBuilder)
- Part 7: 15 min → 10 min (error handling saja, skip Dio detail)

**If running late**: Skip Part 7 Dio, incorporate error handling into Part 6 project.

### Common Student Mistakes

1. **Lupa Internet Permission** — PALING UMUM!
   - Symptom: SocketException, connection refused
   - Fix: Tambah `<uses-permission android:name="android.permission.INTERNET"/>` di AndroidManifest.xml

2. **Lupa `await`**
   - Symptom: `Instance of 'Future<Response>'` di print
   - Fix: Tambahkan `await` dan `async`

3. **`import ... as http` lupa alias**
   - Symptom: `get()` / `post()` unresolved
   - Fix: Import dengan `as http`, panggil `http.get()`

4. **Future langsung di FutureBuilder**
   - Symptom: Infinite loop fetch, app hang
   - Fix: Simpan Future di variable via `initState`

5. **Lupa `dart:convert` import**
   - Symptom: `jsonDecode` not found
   - Fix: `import 'dart:convert';`

6. **JSON type mismatch**
   - Symptom: type 'int' is not subtype of 'String'
   - Fix: Check JSON structure, sesuaikan model class types

7. **`setState` after dispose**
   - Symptom: Error saat navigate away sebelum Future selesai
   - Fix: Check `if (mounted)` sebelum `setState`

### Grading Praktikum (100 points)

| Kriteria               | Weight | Details                                         |
| ---------------------- | ------ | ----------------------------------------------- |
| **API Integration**    | 25%    | Fetch data berhasil, status code handling       |
| **Model Class**        | 20%    | fromJson/toJson, proper types, min 2 models     |
| **UI & States**        | 25%    | Loading, error, empty, success states proper    |
| **Provider**           | 15%    | State management pattern benar                  |
| **Error Handling**     | 15%    | try-catch, proper messages, retry option         |

**Bonus** (+20):

- CRUD operations (+10)
- Search/filter (+5)
- Pull-to-refresh (+5)

### Discussion Prompts

- "Kenapa Instagram bisa muncul foto baru tanpa refresh manual?"
- "Apa yang terjadi kalau 1 juta user fetch data bersamaan?"
- "Bedanya API publik dan private — apa bahayanya pakai API tanpa key?"
- "Kenapa loading spinner penting? Coba bayangkan app tanpa loading indicator."

### Differentiation

**Fast learners**:

- Implementasi search/filter posts
- Caching data lokal (simpan last fetch)
- Custom error widget dengan animasi
- Pakai Dio dengan interceptors

**Struggling students**:

- Fokus GET saja (skip POST/PUT/DELETE)
- Pakai skeleton code yang sudah ada
- Model class 1 saja (Post)
- Copy-paste ApiService, fokus di UI

---

**🎉 Pertemuan 6 Complete!**

**Next**: Pertemuan 7 - Penyimpanan Lokal (SharedPreferences & SQLite)

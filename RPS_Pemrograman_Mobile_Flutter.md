# RENCANA PEMBELAJARAN SEMESTER (RPS)

## Mata Kuliah: Pemrograman Mobile dengan Flutter

---

## 📋 IDENTITAS MATA KULIAH

| Komponen               | Keterangan                              |
| ---------------------- | --------------------------------------- |
| **Nama Mata Kuliah**   | Pemrograman Mobile dengan Flutter       |
| **Kode Mata Kuliah**   | IF3XXX                                  |
| **SKS**                | 3 SKS (1 Teori, 2 Praktikum)            |
| **Semester**           | Ganjil/Genap                            |
| **Program Studi**      | Teknik Informatika / Sistem Informasi   |
| **Fakultas**           | Fakultas Teknik / FMIPA                 |
| **Prasyarat**          | Pemrograman Berorientasi Objek (IF2XXX) |
| **Dosen Pengampu**     | [Nama Dosen], S.Kom., M.Cs.             |
| **Email**              | [email@university.ac.id]                |
| **Tanggal Penyusunan** | Januari 2026                            |
| **Revisi**             | Versi 1.0                               |

---

## 🎯 DESKRIPSI MATA KULIAH

Mata kuliah ini membahas pengembangan aplikasi mobile lintas platform (cross-platform) menggunakan framework Flutter dengan bahasa pemrograman Dart. Mahasiswa akan mempelajari konsep dasar Flutter, manajemen state, navigasi, integrasi API, penyimpanan lokal, hingga proses build dan release aplikasi Android/iOS. Perkuliahan menggunakan pendekatan **Project-Based Learning** dengan penekanan pada praktik langsung.

---

## 📜 KONTRAK PERKULIAHAN

### Aturan Umum:

1. **Kehadiran** minimal **75%** dari total pertemuan
2. **Keterlambatan** maksimal **15 menit** dari jadwal kuliah
3. **Penggunaan laptop/PC** wajib untuk setiap pertemuan praktikum
4. **Handphone** dalam mode silent selama perkuliahan

### Tugas & Pengumpulan:

5. Tugas dikumpulkan melalui **GitHub Classroom** atau **LMS**
6. **Format penamaan**: `NIM_NamaLengkap_TugasX`
7. **Keterlambatan** pengumpulan: -10% per hari, maksimal 5 hari
8. **Plagiarisme** akan diberi nilai **0** dan dilaporkan ke fakultas

### Komunikasi:

9. Konsultasi melalui **email/WhatsApp** pada jam kerja (08.00-17.00)
10. Response time maksimal **1x24 jam** di hari kerja

### Sanksi:

11. Kehadiran <75%: **Tidak dapat mengikuti UAS**
12. Ketidakjujuran akademik: **Nilai E**

---

## 🏆 CAPAIAN PEMBELAJARAN LULUSAN (CPL)

| Kode        | Capaian Pembelajaran Lulusan                                                            |
| ----------- | --------------------------------------------------------------------------------------- |
| **CPL-S9**  | Menunjukkan sikap bertanggung jawab atas pekerjaan di bidang keahliannya secara mandiri |
| **CPL-KU1** | Mampu menerapkan pemikiran logis, kritis, sistematis, dan inovatif                      |
| **CPL-KU2** | Mampu menunjukkan kinerja mandiri, bermutu, dan terukur                                 |
| **CPL-KK3** | Mampu merancang dan mengimplementasikan solusi berbasis teknologi informasi             |
| **CPL-P1**  | Menguasai konsep teoretis dan praktis pengembangan perangkat lunak                      |

---

## 📚 CAPAIAN PEMBELAJARAN MATA KULIAH (CPMK)

| Kode       | Capaian Pembelajaran Mata Kuliah                                              | CPL             |
| ---------- | ----------------------------------------------------------------------------- | --------------- |
| **CPMK-1** | Mampu menjelaskan arsitektur Flutter dan menulis kode Dart dengan null safety | CPL-P1          |
| **CPMK-2** | Mampu membangun UI responsif menggunakan widget dan layout Flutter            | CPL-KK3         |
| **CPMK-3** | Mampu mengimplementasikan navigasi dan state management dengan Provider       | CPL-KK3         |
| **CPMK-4** | Mampu membuat form dengan validasi dan melakukan debugging aplikasi           | CPL-KU1         |
| **CPMK-5** | Mampu mengintegrasikan aplikasi dengan REST API dan parsing JSON              | CPL-KK3         |
| **CPMK-6** | Mampu mengimplementasikan penyimpanan data lokal (SQLite/SharedPreferences)   | CPL-KK3         |
| **CPMK-7** | Mampu membangun, menguji, dan merilis aplikasi mobile yang fungsional         | CPL-KU2, CPL-S9 |

---

## 🎓 METODE PEMBELAJARAN

| Metode                     | Keterangan                                       |
| -------------------------- | ------------------------------------------------ |
| **Ceramah Interaktif**     | Penyampaian teori dengan tanya jawab aktif       |
| **Live Coding**            | Demonstrasi langsung penulisan kode oleh dosen   |
| **Praktikum Terbimbing**   | Latihan coding dengan bimbingan asisten          |
| **Problem-Based Learning** | Menyelesaikan masalah nyata melalui kode         |
| **Project-Based Learning** | Pengembangan aplikasi utuh sebagai project akhir |
| **Peer Review**            | Mahasiswa saling mereview kode teman             |

---

## 🖥️ MEDIA & BAHAN PEMBELAJARAN

| Media                | Platform/Link                                                    |
| -------------------- | ---------------------------------------------------------------- |
| **Slide Presentasi** | Google Slides / PowerPoint (LMS)                                 |
| **Video Tutorial**   | YouTube Playlist (akan dibagikan)                                |
| **Repository Kode**  | GitHub Classroom                                                 |
| **Live Coding IDE**  | VS Code / Android Studio                                         |
| **Online IDE**       | [DartPad](https://dartpad.dev)                                   |
| **Dokumentasi**      | [flutter.dev](https://flutter.dev), [dart.dev](https://dart.dev) |
| **LMS**              | Google Classroom / Moodle                                        |

---

## 📅 RENCANA PEMBELAJARAN MINGGUAN

### Pertemuan 1: Pengenalan Flutter & Dart Fundamentals

| Komponen               | Detail                                                                                                                                                                                                                                                             |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Sub-CPMK**           | CPMK-1                                                                                                                                                                                                                                                             |
| **Bobot**              | 10% dari total materi                                                                                                                                                                                                                                              |
| **Durasi**             | 150 menit (50' teori + 100' praktikum)                                                                                                                                                                                                                             |
| **Indikator**          | ✓ Menjelaskan arsitektur Flutter<br>✓ Menginstal Flutter SDK<br>✓ Menulis kode Dart dengan variabel, fungsi, class<br>✓ Menerapkan null safety                                                                                                                     |
| **Bahan Kajian**       | • Sejarah & arsitektur Flutter (widget tree, rendering)<br>• Instalasi Flutter SDK, Android Studio, VS Code<br>• Dart: variabel, tipe data, operator, fungsi<br>• OOP: class, constructor, inheritance, mixin<br>• Null Safety: `?`, `!`, `??`, `late`, `required` |
| **Pengalaman Belajar** | Mahasiswa menginstal environment, membuat project pertama, dan bereksperimen dengan syntax Dart di DartPad                                                                                                                                                         |
| **Metode**             | Ceramah, demonstrasi, praktikum mandiri                                                                                                                                                                                                                            |
| **Tugas**              | Latihan Dart: 10 soal variabel, fungsi, OOP (Deadline: H+7)                                                                                                                                                                                                        |
| **Referensi**          | Dart Language Tour, Flutter Installation Guide                                                                                                                                                                                                                     |

---

### Pertemuan 2: Widget Dasar, Layout & Theming

| Komponen               | Detail                                                                                                                                                                                                                                                                                                                                                                |
| ---------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Sub-CPMK**           | CPMK-2                                                                                                                                                                                                                                                                                                                                                                |
| **Bobot**              | 15% dari total materi                                                                                                                                                                                                                                                                                                                                                 |
| **Durasi**             | 150 menit (50' teori + 100' praktikum)                                                                                                                                                                                                                                                                                                                                |
| **Indikator**          | ✓ Membedakan StatelessWidget dan StatefulWidget<br>✓ Menggunakan widget dasar dan layout<br>✓ Menambahkan assets dan custom theme                                                                                                                                                                                                                                     |
| **Bahan Kajian**       | • Konsep "Everything is a Widget"<br>• StatelessWidget vs StatefulWidget<br>• Widget: `Text`, `Container`, `Image`, `Icon`, `ElevatedButton`, `Card`<br>• Layout: `Row`, `Column`, `Stack`, `Wrap`, `Expanded`, `Flexible`<br>• Spacing: `Padding`, `SizedBox`, `Spacer`<br>• Assets: gambar, font di `pubspec.yaml`<br>• `ThemeData`, `ColorScheme`, dark/light mode |
| **Pengalaman Belajar** | Mahasiswa membangun halaman profil lengkap dengan foto, informasi, dan styling custom                                                                                                                                                                                                                                                                                 |
| **Metode**             | Ceramah, live coding, praktikum terbimbing                                                                                                                                                                                                                                                                                                                            |
| **Tugas**              | Membuat kartu biodata diri dengan theme custom (Deadline: H+7)                                                                                                                                                                                                                                                                                                        |
| **Referensi**          | Flutter Widget Catalog, Material Design Guidelines                                                                                                                                                                                                                                                                                                                    |

---

### Pertemuan 3: ListView, GridView & Navigasi

| Komponen               | Detail                                                                                                                                                                                                                                                                                   |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Sub-CPMK**           | CPMK-2, CPMK-3                                                                                                                                                                                                                                                                           |
| **Bobot**              | 15% dari total materi                                                                                                                                                                                                                                                                    |
| **Durasi**             | 150 menit (50' teori + 100' praktikum)                                                                                                                                                                                                                                                   |
| **Indikator**          | ✓ Menampilkan data dalam ListView/GridView<br>✓ Mengimplementasikan navigasi antar halaman<br>✓ Mengirim dan menerima data antar halaman                                                                                                                                                 |
| **Bahan Kajian**       | • `ListView`, `ListView.builder`, `ListView.separated`<br>• `GridView`, `GridView.builder`, `GridView.count`<br>• `ListTile`, custom list item<br>• `Navigator.push()`, `Navigator.pop()`<br>• Named routes, `onGenerateRoute`<br>• Passing data: constructor, `arguments`, return value |
| **Pengalaman Belajar** | Mahasiswa membangun aplikasi katalog produk dengan navigasi ke halaman detail                                                                                                                                                                                                            |
| **Metode**             | Ceramah, live coding, praktikum terbimbing                                                                                                                                                                                                                                               |
| **Tugas**              | Aplikasi daftar kontak dengan detail (Deadline: H+7)                                                                                                                                                                                                                                     |
| **Referensi**          | Flutter Cookbook: Lists, Navigation                                                                                                                                                                                                                                                      |

---

### Pertemuan 4: State Management dengan Provider

| Komponen               | Detail                                                                                                                                                                                                                                                                                                     |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Sub-CPMK**           | CPMK-3                                                                                                                                                                                                                                                                                                     |
| **Bobot**              | 20% dari total materi                                                                                                                                                                                                                                                                                      |
| **Durasi**             | 150 menit (50' teori + 100' praktikum)                                                                                                                                                                                                                                                                     |
| **Indikator**          | ✓ Menjelaskan perbedaan ephemeral dan app state<br>✓ Menggunakan setState untuk state lokal<br>✓ Mengimplementasikan Provider untuk app state                                                                                                                                                              |
| **Bahan Kajian**       | • Konsep State: ephemeral state vs app state<br>• `setState()` dan keterbatasannya<br>• Lifting state up<br>• Package `provider`<br>• `ChangeNotifier`, `notifyListeners()`<br>• `ChangeNotifierProvider`, `MultiProvider`<br>• `Consumer`, `Selector`<br>• `Provider.of`, `context.watch`, `context.read` |
| **Pengalaman Belajar** | Mahasiswa membangun shopping cart dengan state management menggunakan Provider                                                                                                                                                                                                                             |
| **Metode**             | Ceramah, live coding, praktikum terbimbing, diskusi                                                                                                                                                                                                                                                        |
| **Tugas**              | Shopping cart dengan tambah/hapus/update quantity (Deadline: H+7)                                                                                                                                                                                                                                          |
| **Referensi**          | Provider Package Documentation, Flutter State Management                                                                                                                                                                                                                                                   |

---

### Pertemuan 5: Form, Validasi & Debugging

| Komponen               | Detail                                                                                                                                                                                                                                                                                                                                                                                                        |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Sub-CPMK**           | CPMK-4                                                                                                                                                                                                                                                                                                                                                                                                        |
| **Bobot**              | 15% dari total materi                                                                                                                                                                                                                                                                                                                                                                                         |
| **Durasi**             | 150 menit (50' teori + 100' praktikum)                                                                                                                                                                                                                                                                                                                                                                        |
| **Indikator**          | ✓ Membuat form dengan berbagai input widget<br>✓ Mengimplementasikan validasi form<br>✓ Menggunakan Flutter DevTools untuk debugging                                                                                                                                                                                                                                                                          |
| **Bahan Kajian**       | • `TextField`, `TextFormField`, `TextEditingController`<br>• `Checkbox`, `Radio`, `Switch`, `Slider`<br>• `DropdownButton`, `DropdownButtonFormField`<br>• `DatePicker`, `TimePicker`<br>• `Form`, `GlobalKey<FormState>`<br>• Validasi: `validator`, `autovalidateMode`<br>• `FocusNode`, keyboard handling<br>• Error handling: `try-catch`, `rethrow`<br>• Flutter DevTools: widget inspector, performance |
| **Pengalaman Belajar** | Mahasiswa membangun form registrasi lengkap dengan validasi real-time                                                                                                                                                                                                                                                                                                                                         |
| **Metode**             | Ceramah, live coding, praktikum terbimbing                                                                                                                                                                                                                                                                                                                                                                    |
| **Tugas**              | Form pendaftaran event dengan berbagai input (Deadline: H+7)                                                                                                                                                                                                                                                                                                                                                  |
| **Referensi**          | Flutter Forms Cookbook, Flutter DevTools Guide                                                                                                                                                                                                                                                                                                                                                                |

---

### Pertemuan 6: Integrasi REST API & JSON

| Komponen               | Detail                                                                                                                                                                                                                                                                                                                                       |
| ---------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Sub-CPMK**           | CPMK-5                                                                                                                                                                                                                                                                                                                                       |
| **Bobot**              | 15% dari total materi                                                                                                                                                                                                                                                                                                                        |
| **Durasi**             | 150 menit (50' teori + 100' praktikum)                                                                                                                                                                                                                                                                                                       |
| **Indikator**          | ✓ Melakukan HTTP request (GET, POST, PUT, DELETE)<br>✓ Parsing JSON ke Dart object dengan model class<br>✓ Menampilkan data API dengan loading dan error state                                                                                                                                                                               |
| **Bahan Kajian**       | • Konsep REST API, HTTP methods, status codes<br>• Package `http` dan `dio`<br>• `async`, `await`, `Future`, `Stream`<br>• JSON: `jsonEncode`, `jsonDecode`<br>• Model class: `fromJson()`, `toJson()`<br>• Code generation: `json_serializable` (opsional)<br>• `FutureBuilder`, `StreamBuilder`<br>• State: loading, success, error, empty |
| **Pengalaman Belajar** | Mahasiswa mengkonsumsi API publik dan menampilkan data dalam aplikasi                                                                                                                                                                                                                                                                        |
| **Metode**             | Ceramah, live coding, praktikum terbimbing                                                                                                                                                                                                                                                                                                   |
| **Tugas**              | Aplikasi berita/film/cuaca dari API publik (Deadline: H+7)                                                                                                                                                                                                                                                                                   |
| **API Publik**         | JSONPlaceholder, TMDB, OpenWeather, NewsAPI                                                                                                                                                                                                                                                                                                  |
| **Referensi**          | Flutter Networking Cookbook, Dart HTTP Package                                                                                                                                                                                                                                                                                               |

---

### Pertemuan 7: Penyimpanan Lokal, Build & Project Akhir

| Komponen               | Detail                                                                                                                                                                                                                                                                                                                       |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Sub-CPMK**           | CPMK-6, CPMK-7                                                                                                                                                                                                                                                                                                               |
| **Bobot**              | 10% materi + 20% project akhir                                                                                                                                                                                                                                                                                               |
| **Durasi**             | 150 menit (40' teori + 60' praktikum + 50' presentasi)                                                                                                                                                                                                                                                                       |
| **Indikator**          | ✓ Menyimpan data sederhana dengan SharedPreferences<br>✓ Melakukan CRUD dengan SQLite<br>✓ Build dan generate file APK                                                                                                                                                                                                       |
| **Bahan Kajian**       | • `SharedPreferences`: key-value storage<br>• Use case: settings, token, onboarding flag<br>• Package `sqflite`: database lokal<br>• CRUD operations dengan SQLite<br>• Database helper pattern, singleton<br>• Build: `flutter build apk --release`<br>• App signing, keystore<br>• Build variants: debug, profile, release |
| **Pengalaman Belajar** | Mahasiswa membangun aplikasi To-Do/Notes dengan penyimpanan lokal dan mempresentasikan project akhir                                                                                                                                                                                                                         |
| **Metode**             | Ceramah, live coding, presentasi project                                                                                                                                                                                                                                                                                     |
| **Tugas**              | Presentasi Project Akhir                                                                                                                                                                                                                                                                                                     |
| **Referensi**          | Flutter Persistence Cookbook, SQLite Documentation                                                                                                                                                                                                                                                                           |

---

## 📊 KOMPONEN PENILAIAN

| Komponen                    | Bobot    | Keterangan                   |
| --------------------------- | -------- | ---------------------------- |
| **Kehadiran & Partisipasi** | 5%       | Keaktifan di kelas, diskusi  |
| **Tugas Praktikum**         | 25%      | 6 tugas mingguan             |
| **Quiz**                    | 10%      | 2-3 quiz (di awal pertemuan) |
| **UTS**                     | 20%      | Materi pertemuan 1-3         |
| **UAS**                     | 20%      | Materi pertemuan 4-7         |
| **Project Akhir**           | 20%      | Aplikasi mobile lengkap      |
| **TOTAL**                   | **100%** |                              |

### Konversi Nilai:

| Rentang | Huruf | Bobot |
| ------- | ----- | ----- |
| 85-100  | A     | 4.00  |
| 80-84   | A-    | 3.75  |
| 75-79   | B+    | 3.50  |
| 70-74   | B     | 3.00  |
| 65-69   | B-    | 2.75  |
| 60-64   | C+    | 2.50  |
| 55-59   | C     | 2.00  |
| 50-54   | D     | 1.00  |
| 0-49    | E     | 0.00  |

---

## 📋 RUBRIK PENILAIAN

### Rubrik Tugas Praktikum (Per Tugas: 100 poin)

| Kriteria            | Bobot | Sangat Baik (4)                             | Baik (3)                                       | Cukup (2)                        | Kurang (1)                     |
| ------------------- | ----- | ------------------------------------------- | ---------------------------------------------- | -------------------------------- | ------------------------------ |
| **Fungsionalitas**  | 40%   | Semua fitur berjalan sempurna tanpa bug     | Sebagian besar fitur berjalan dengan bug minor | Beberapa fitur berjalan, ada bug | Banyak fitur error/crash       |
| **Kualitas Kode**   | 25%   | Clean code, well-documented, best practices | Cukup rapi, ada komentar                       | Kurang rapi tapi berjalan        | Berantakan, tidak readable     |
| **UI/UX**           | 20%   | Modern, menarik, responsif, user-friendly   | Cukup menarik dan fungsional                   | Standar/sederhana                | Tidak menarik, sulit digunakan |
| **Ketepatan Waktu** | 15%   | Tepat waktu                                 | Terlambat 1-2 hari (-10%)                      | Terlambat 3-5 hari (-30%)        | Terlambat >5 hari (-50%)       |

### Rubrik Project Akhir (Total: 100 poin)

| Kriteria                 | Bobot | Indikator                                                               |
| ------------------------ | ----- | ----------------------------------------------------------------------- |
| **Kompleksitas & Fitur** | 25%   | Minimal: 4 screen, navigasi, state management, API/local storage        |
| **Kualitas Kode**        | 20%   | Clean code, struktur folder terorganisir, reusable widgets, dokumentasi |
| **UI/UX Design**         | 20%   | Desain modern, konsisten, responsif, accessibility                      |
| **Fungsionalitas**       | 25%   | Aplikasi berjalan stabil tanpa crash, semua fitur bekerja               |
| **Presentasi & Demo**    | 10%   | Kemampuan menjelaskan arsitektur, demo lancar, menjawab pertanyaan      |

---

## 🎯 SPESIFIKASI PROJECT AKHIR

### Persyaratan Minimum:

| No  | Requirement                                                             | Poin |
| --- | ----------------------------------------------------------------------- | ---- |
| 1   | Minimal **4 halaman/screen** yang berbeda                               | ✓    |
| 2   | Implementasi **navigasi** (push, pop, named routes)                     | ✓    |
| 3   | **State management** dengan Provider                                    | ✓    |
| 4   | Minimal 1 **form dengan validasi**                                      | ✓    |
| 5   | **Integrasi API** ATAU **penyimpanan lokal** (SQLite/SharedPreferences) | ✓    |
| 6   | UI **menarik dan responsif**                                            | ✓    |
| 7   | **File APK** yang dapat diinstal                                        | ✓    |
| 8   | **README.md** dengan dokumentasi                                        | ✓    |

### Deliverables:

- 📁 Source code di GitHub repository
- 📱 File APK release
- 📄 README.md (deskripsi, screenshot, cara install)
- 🎥 Video demo (2-3 menit)
- 📊 Slide presentasi

### Timeline Project:

| Minggu | Aktivitas                                 |
| ------ | ----------------------------------------- |
| 4      | Pengumuman project, brainstorming ide     |
| 5      | Proposal project (1 paragraf + wireframe) |
| 6      | Progress check 1 (UI skeleton)            |
| 7      | Presentasi final + demo                   |

### Contoh Ide Project:

| Kategori      | Ide Aplikasi                                |
| ------------- | ------------------------------------------- |
| Produktivitas | 📝 Notes, To-Do List, Habit Tracker         |
| E-Commerce    | 🛒 Katalog Produk, Wishlist, Cart           |
| Informasi     | 📰 News Reader, Blog, Wiki                  |
| Lifestyle     | 🍽️ Resep Makanan, 💰 Finance Tracker        |
| Hiburan       | 🎬 Movie Catalog (TMDB), 🎵 Music Player UI |
| Utilitas      | ☁️ Weather App, 📍 Location Notes           |

---

## 📖 DAFTAR PUSTAKA

### Referensi Utama:

1. Flutter Team. (2024). _Flutter Documentation_. Google. https://flutter.dev/docs
2. Dart Team. (2024). _Dart Language Tour_. Google. https://dart.dev/guides/language/language-tour
3. Flutter Team. (2024). _Flutter Cookbook_. Google. https://docs.flutter.dev/cookbook

### Referensi Pendukung:

4. Windmill, E. (2020). _Flutter in Action_. Manning Publications. ISBN: 978-1617296147
5. Napoli, M. (2019). _Beginning Flutter: A Hands-On Guide to App Development_. Wiley. ISBN: 978-1119550822
6. Biessek, A. (2019). _Flutter for Beginners_. Packt Publishing. ISBN: 978-1788996082
7. Zammetti, F. (2019). _Practical Flutter_. Apress. ISBN: 978-1484249710

### Sumber Online:

| Sumber             | URL                                                |
| ------------------ | -------------------------------------------------- |
| Flutter YouTube    | https://youtube.com/flutterdev                     |
| Pub.dev (Packages) | https://pub.dev                                    |
| DartPad            | https://dartpad.dev                                |
| Flutter Gallery    | https://gallery.flutter.dev                        |
| Medium Flutter     | https://medium.com/flutter                         |
| Stack Overflow     | https://stackoverflow.com/questions/tagged/flutter |

---

## 🛠️ PERANGKAT & SOFTWARE

### Spesifikasi Minimum:

| Komponen      | Requirement                              |
| ------------- | ---------------------------------------- |
| **Processor** | Intel i5 / AMD Ryzen 5 atau lebih tinggi |
| **RAM**       | 8 GB (16 GB recommended)                 |
| **Storage**   | SSD 256 GB (50 GB free space)            |
| **OS**        | Windows 10/11, macOS 10.14+, Linux       |

### Software yang Diperlukan:

| Software       | Versi               | Keterangan                   |
| -------------- | ------------------- | ---------------------------- |
| Flutter SDK    | Stable (latest)     | Framework utama              |
| Dart SDK       | Included in Flutter | Bahasa pemrograman           |
| Android Studio | Latest              | IDE + Android SDK            |
| VS Code        | Latest              | IDE alternatif (recommended) |
| Git            | Latest              | Version control              |
| Chrome         | Latest              | Web debugging                |

### VS Code Extensions:

- Flutter
- Dart
- Awesome Flutter Snippets
- Flutter Widget Snippets
- Bracket Pair Colorizer
- GitLens

---

## ✅ RIWAYAT REVISI

| Versi | Tanggal      | Perubahan    | Oleh         |
| ----- | ------------ | ------------ | ------------ |
| 1.0   | Januari 2026 | Dokumen awal | [Nama Dosen] |

---

## 📝 LEMBAR PENGESAHAN

| Jabatan        | Nama               | Tanda Tangan       | Tanggal      |
| -------------- | ------------------ | ------------------ | ------------ |
| Dosen Pengampu | ********\_******** | ********\_******** | **_/_**/2026 |
| Koordinator MK | ********\_******** | ********\_******** | **_/_**/2026 |
| Ketua Prodi    | ********\_******** | ********\_******** | **_/_**/2026 |

---

> **Catatan**: Dokumen RPS ini dapat direvisi sesuai kebutuhan pembelajaran dan perkembangan teknologi.
>
> _Disusun berdasarkan Panduan Penyusunan Kurikulum Pendidikan Tinggi (KPT) dan Kerangka Kualifikasi Nasional Indonesia (KKNI)._

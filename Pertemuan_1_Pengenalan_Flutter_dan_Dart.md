# 📱 PERTEMUAN 1

## Pengenalan Flutter & Dasar-Dasar Dart

---

## 🎯 Tujuan Pembelajaran

Setelah mengikuti pertemuan ini, mahasiswa diharapkan mampu:

1. ✅ Menjelaskan apa itu Flutter dan kelebihannya
2. ✅ Menginstal Flutter SDK dan IDE dengan benar
3. ✅ Menulis program Dart sederhana
4. ✅ Memahami variabel, tipe data, dan fungsi di Dart
5. ✅ Memahami dasar OOP (Class dan Object) di Dart
6. ✅ Membuat project Flutter pertama

---

## ⏱️ ESTIMASI DURASI (Total: 150 menit)

| Bagian | Topik                   | Durasi   | Keterangan                      |
| ------ | ----------------------- | -------- | ------------------------------- |
| 1      | Mengenal Flutter        | 10 menit | Teori, bisa dipercepat          |
| 2      | Instalasi Flutter       | 15 menit | Demo + troubleshooting          |
| 2.5    | Setup Emulator/Device   | 10 menit | Praktik mandiri                 |
| 3      | Mengenal Bahasa Dart    | 5 menit  | Pengantar singkat               |
| 4      | Dasar-Dasar Dart        | 40 menit | **Inti materi**, pelan-pelan    |
| 5      | OOP Dasar               | 25 menit | Class, constructor, inheritance |
| 6      | Null Safety             | 10 menit | Konsep penting                  |
| 7      | Exception Handling      | 5 menit  | Pengenalan saja                 |
| 8      | Project Flutter Pertama | 20 menit | **Praktik bersama**             |
| 9      | Error Umum              | 5 menit  | Referensi, baca mandiri         |
| -      | Latihan & Tanya Jawab   | 5 menit  | Penutup                         |

> 💡 **Tips untuk Dosen**:
>
> - Bagian 4 (Dart) dan Bagian 8 (Flutter Project) adalah **inti pertemuan**
> - Jika waktu terbatas, Bagian 5-7 bisa dijadikan **tugas baca mandiri**
> - Siapkan laptop cadangan untuk demo jika terjadi masalah teknis

---

## 📚 BAGIAN 1: Mengenal Flutter

### 🤔 Apa itu Flutter?

**Flutter** adalah framework open-source buatan Google untuk membuat aplikasi **cross-platform** dari satu codebase.

```
Satu Kode → Banyak Platform
     ↓
┌─────────────────────────────────────┐
│  Flutter Code (Dart)                │
├─────────────────────────────────────┤
│     ↓           ↓           ↓       │
│  Android      iOS        Web        │
│    📱          🍎         🌐         │
└─────────────────────────────────────┘
```

### 🌟 Mengapa Memilih Flutter?

| Keunggulan                 | Penjelasan                                                |
| -------------------------- | --------------------------------------------------------- |
| 🚀 **Hot Reload**          | Lihat perubahan kode secara instan tanpa restart aplikasi |
| 🎨 **UI Keren**            | Widget yang indah dan customizable                        |
| 📱 **Cross-Platform**      | Satu kode untuk Android, iOS, Web, Desktop                |
| 🏃 **Performa Tinggi**     | Mendekati native performance                              |
| 📚 **Dokumentasi Lengkap** | Tutorial dan contoh yang banyak                           |
| 👥 **Komunitas Besar**     | Banyak package dan support                                |

### 🏗️ Arsitektur Flutter (Sederhana)

```
┌─────────────────────────────────────┐
│          Aplikasi Kamu              │
│      (Widget, Logic, UI)            │
├─────────────────────────────────────┤
│         Flutter Framework           │
│    (Material, Cupertino, dll)       │
├─────────────────────────────────────┤
│          Flutter Engine             │
│     (Skia, Dart VM, Platform)       │
├─────────────────────────────────────┤
│      Android / iOS / Web / dll      │
└─────────────────────────────────────┘
```

**Penjelasan Sederhana:**

- **Aplikasi Kamu**: Kode yang kamu tulis
- **Flutter Framework**: Komponen siap pakai (tombol, teks, dll)
- **Flutter Engine**: "Mesin" yang menggambar UI
- **Platform**: Sistem operasi tujuan

---

## 💻 BAGIAN 2: Instalasi Flutter

### 📋 Persyaratan Sistem

| Komponen | Minimum                    |
| -------- | -------------------------- |
| OS       | Windows 10 atau lebih baru |
| RAM      | 8 GB                       |
| Disk     | 10 GB ruang kosong         |
| Tools    | Git, Android Studio        |

### 📥 Langkah Instalasi (Windows)

#### Langkah 1: Download Flutter SDK

1. Buka website resmi: **https://flutter.dev/docs/get-started/install/windows**
2. Klik tombol **"Download Flutter SDK"**
3. Extract file zip ke folder yang **TIDAK** memerlukan admin
   - ✅ Contoh baik: `C:\flutter`
   - ❌ Hindari: `C:\Program Files\`

#### Langkah 2: Tambahkan ke PATH

1. Tekan `Win + R`, ketik `sysdm.cpl`, tekan Enter
2. Klik tab **Advanced** → **Environment Variables**
3. Di bagian "User variables", cari **Path** → **Edit**
4. Klik **New** → Tambahkan: `C:\flutter\bin`
5. Klik **OK** di semua window

#### Langkah 3: Install Android Studio

1. Download dari: **https://developer.android.com/studio**
2. Install seperti biasa (Next → Next → Finish)
3. Buka Android Studio → **More Actions** → **SDK Manager**
4. Pastikan **Android SDK** terinstall

#### Langkah 4: Install Flutter & Dart Plugin di Android Studio

1. Buka Android Studio
2. **File** → **Settings** → **Plugins**
3. Cari dan install: **Flutter** (Dart akan ikut terinstall)
4. Restart Android Studio

#### Langkah 5: Verifikasi Instalasi

Buka Command Prompt (CMD) atau PowerShell, ketik:

```bash
flutter doctor
```

**Output yang diharapkan:**

```
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.x.x)
[✓] Windows Version
[✓] Android toolchain - develop for Android devices
[✓] Android Studio
[✓] VS Code (opsional)
[✓] Connected device
```

> 💡 **Tips**: Jika ada tanda ❌, ikuti instruksi yang diberikan untuk memperbaikinya.

---

## 📱 BAGIAN 2.5: Setup Emulator & Device

### 🤖 Cara Membuat Android Emulator

Emulator adalah HP virtual di komputer kamu. Begini cara membuatnya:

#### Langkah 1: Buka Device Manager

1. Buka **Android Studio**
2. Klik **More Actions** → **Virtual Device Manager**
   (atau dari menu: **Tools** → **Device Manager**)

#### Langkah 2: Buat Virtual Device Baru

1. Klik tombol **Create Device** (+ icon)
2. Pilih tipe HP (rekomendasi: **Pixel 6** atau **Pixel 4**)
3. Klik **Next**

#### Langkah 3: Pilih System Image

1. Pilih versi Android (rekomendasi: **API 33** atau **34** = Android 13/14)
2. Jika ada tombol **Download**, klik untuk mengunduh image
3. Tunggu sampai selesai download
4. Pilih image yang sudah didownload → **Next**

#### Langkah 4: Konfigurasi & Selesai

1. Beri nama emulator (opsional)
2. Klik **Finish**
3. Klik tombol **Play ▶️** untuk menjalankan emulator

```
📦 Tips Emulator Lancar:
├── RAM laptop minimal 8GB (lebih baik 16GB)
├── Enable Virtualization di BIOS (VT-x / AMD-V)
├── Pilih x86_64 image (lebih cepat dari ARM)
└── Gunakan SSD untuk penyimpanan
```

### 📲 Cara Pakai HP Asli (USB Debugging)

Menggunakan HP asli **JAUH lebih cepat** daripada emulator!

#### Langkah 1: Aktifkan Developer Options di HP

1. Buka **Settings** → **About Phone**
2. Cari **Build Number**
3. **Ketuk 7 kali** sampai muncul "You are now a developer!"

#### Langkah 2: Aktifkan USB Debugging

1. Masuk ke **Settings** → **Developer Options**
2. Nyalakan **USB Debugging**
3. (Opsional) Nyalakan **Install via USB** jika ada

#### Langkah 3: Hubungkan ke Komputer

1. Hubungkan HP dengan kabel USB
2. Jika muncul popup "Allow USB debugging?", centang **Always allow** → **OK**
3. Cek di terminal:

```bash
flutter devices
```

**Output yang diharapkan:**

```
2 connected devices:

SM G990B (mobile) • RFXXXXXXXX • android-arm64 • Android 13
Chrome (web)      • chrome      • web-javascript • Google Chrome
```

> 🎉 HP kamu sudah siap digunakan untuk testing!

#### Troubleshooting USB Debugging:

| Masalah             | Solusi                                                    |
| ------------------- | --------------------------------------------------------- |
| HP tidak terdeteksi | Ganti kabel USB (pakai yang asli/berkualitas)             |
| Tidak muncul popup  | Cabut → colok lagi, atau restart HP                       |
| "Unauthorized"      | Cabut kabel, matikan USB debugging, nyalakan lagi         |
| Driver tidak ada    | Install USB driver dari website HP (Samsung, Xiaomi, dll) |

---

## 🎮 BAGIAN 3: Mengenal Bahasa Dart

### 🤔 Apa itu Dart?

**Dart** adalah bahasa pemrograman yang digunakan untuk menulis aplikasi Flutter.

```
Flutter → Framework (kerangka kerja)
Dart    → Bahasa pemrograman
```

Analoginya:

- **Flutter** = Bengkel mobil dengan semua peralatan
- **Dart** = Bahasa yang kamu gunakan untuk berkomunikasi di bengkel

### 🖥️ Mencoba Dart Online

Sebelum coding di Flutter, mari belajar Dart dulu di browser:

1. Buka **https://dartpad.dev**
2. Ini adalah playground untuk belajar Dart tanpa install apapun!

---

## 📝 BAGIAN 4: Dasar-Dasar Dart

### 4.1 Komentar di Dart

Komentar adalah catatan untuk programmer, **tidak akan dieksekusi** oleh program.

```dart
void main() {
  // Ini komentar satu baris (single-line comment)
  // Diawali dengan dua garis miring

  /*
   * Ini komentar banyak baris (multi-line comment)
   * Bisa untuk menjelaskan kode yang panjang
   * Diawali /* dan diakhiri */
   */

  /// Ini documentation comment
  /// Biasanya untuk menjelaskan fungsi/class
  /// Akan muncul di IDE saat hover

  print('Hello!'); // Komentar juga bisa di akhir baris
}
```

> 💡 **Tips**: Biasakan menulis komentar untuk menjelaskan kode yang kompleks. Ini akan membantu kamu (dan orang lain) memahami kode di masa depan!

### 4.2 Aturan Penamaan (Naming Conventions)

Di Dart, ada aturan penamaan yang **wajib** diikuti:

```dart
// ✅ BENAR
void main() {
  // Variabel & Fungsi: camelCase (huruf kecil, kapital di kata ke-2)
  String namaMahasiswa = 'Budi';
  int jumlahMahasiswa = 30;

  void hitungNilaiAkhir() { }
  void tampilkanData() { }

  // Class: PascalCase (setiap kata diawali huruf kapital)
  // class MahasiswaBaru { }
  // class DataPengguna { }

  // Konstanta: camelCase atau SCREAMING_CAPS
  const pi = 3.14159;
  const MAX_SIZE = 100;
}
```

**Ringkasan:**

| Jenis     | Style          | Contoh                                |
| --------- | -------------- | ------------------------------------- |
| Variabel  | camelCase      | `namaLengkap`, `jumlahItem`           |
| Fungsi    | camelCase      | `hitungTotal()`, `ambilData()`        |
| Class     | PascalCase     | `Mahasiswa`, `DataPengguna`           |
| Konstanta | camelCase/CAPS | `maxValue`, `MAX_SIZE`                |
| File      | snake_case     | `main_screen.dart`, `user_model.dart` |

### 4.3 Program Pertama: Hello World

```dart
void main() {
  print('Hello, World!');
  print('Selamat datang di Flutter!');
}
```

**Penjelasan:**

- `void main()` → Fungsi utama, titik awal program
- `print()` → Menampilkan teks ke console
- Setiap perintah diakhiri dengan `;` (titik koma)

### 4.4 Variabel dan Tipe Data

**Variabel** adalah tempat menyimpan data. Bayangkan seperti kotak berlabel.

```dart
void main() {
  // Cara 1: Menentukan tipe data secara eksplisit
  String nama = 'Budi';        // Teks
  int umur = 20;               // Bilangan bulat
  double tinggi = 175.5;       // Bilangan desimal
  bool aktif = true;           // Benar/Salah

  // Cara 2: Dart otomatis menebak tipe (type inference)
  var kota = 'Samarinda';      // Dart tahu ini String
  var semester = 5;            // Dart tahu ini int

  // Menampilkan variabel dengan String Interpolation
  print('Nama: $nama');
  print('Umur: $umur tahun');
  print('Tinggi: $tinggi cm');
  print('Status aktif: $aktif');
  print('Kota: $kota');

  // Untuk ekspresi kompleks, gunakan ${}
  print('Tahun depan umur: ${umur + 1} tahun');
}
```

**Output:**

```
Nama: Budi
Umur: 20 tahun
Tinggi: 175.5 cm
Status aktif: true
Kota: Samarinda
Tahun depan umur: 21 tahun
```

**Tabel Tipe Data Utama:**

| Tipe Data | Kegunaan           | Contoh               |
| --------- | ------------------ | -------------------- |
| `String`  | Teks/kata          | `'Hello'`, `"Dunia"` |
| `int`     | Bilangan bulat     | `10`, `-5`, `2024`   |
| `double`  | Bilangan desimal   | `3.14`, `99.9`       |
| `bool`    | Benar/Salah        | `true`, `false`      |
| `List`    | Kumpulan data      | `[1, 2, 3]`          |
| `Map`     | Pasangan key-value | `{'nama': 'Budi'}`   |

### 4.5 Konstanta (Nilai Tetap)

```dart
void main() {
  // final → nilai tetap, ditentukan saat runtime
  final waktuSekarang = DateTime.now();

  // const → nilai tetap, sudah diketahui saat compile
  const pi = 3.14159;
  const namaApp = 'Flutter App';

  print('Pi: $pi');
  print('Waktu: $waktuSekarang');
}
```

> 💡 **Kapan pakai apa?**
>
> - `var` → nilai bisa berubah
> - `final` → nilai tidak bisa berubah, ditentukan saat program jalan
> - `const` → nilai tidak bisa berubah, sudah pasti dari awal

### 4.6 Operator

```dart
void main() {
  // Operator Aritmatika
  int a = 10;
  int b = 3;

  print('=== Operator Aritmatika ===');
  print('Penjumlahan: ${a + b}');      // 13
  print('Pengurangan: ${a - b}');      // 7
  print('Perkalian: ${a * b}');        // 30
  print('Pembagian: ${a / b}');        // 3.333...
  print('Pembagian bulat: ${a ~/ b}'); // 3
  print('Sisa bagi (modulo): ${a % b}'); // 1

  // Operator Perbandingan
  print('\n=== Operator Perbandingan ===');
  print('a == b: ${a == b}');  // false (sama dengan)
  print('a != b: ${a != b}');  // true (tidak sama dengan)
  print('a > b: ${a > b}');    // true (lebih besar)
  print('a < b: ${a < b}');    // false (lebih kecil)
  print('a >= b: ${a >= b}');  // true (lebih besar sama dengan)
  print('a <= b: ${a <= b}');  // false (lebih kecil sama dengan)

  // Operator Logika
  print('\n=== Operator Logika ===');
  bool x = true;
  bool y = false;
  print('x && y: ${x && y}');  // false (AND - keduanya harus true)
  print('x || y: ${x || y}');  // true (OR - salah satu true saja)
  print('!x: ${!x}');          // false (NOT - kebalikan)
}
```

### 4.7 Percabangan (If-Else)

```dart
void main() {
  int nilai = 85;

  // If-Else sederhana
  print('=== Cek Nilai ===');
  if (nilai >= 80) {
    print('Selamat! Nilai kamu A');
  } else if (nilai >= 70) {
    print('Nilai kamu B');
  } else if (nilai >= 60) {
    print('Nilai kamu C');
  } else {
    print('Perlu belajar lebih giat!');
  }

  // Ternary operator (if-else singkat dalam 1 baris)
  String status = nilai >= 60 ? 'LULUS' : 'TIDAK LULUS';
  print('Status: $status');

  // Switch-Case (untuk banyak pilihan)
  print('\n=== Switch Case ===');
  String hari = 'Senin';

  switch (hari) {
    case 'Senin':
      print('Hari kerja - semangat!');
      break;
    case 'Sabtu':
    case 'Minggu':
      print('Akhir pekan - istirahat!');
      break;
    default:
      print('Hari biasa');
  }
}
```

### 4.8 Perulangan (Loop)

```dart
void main() {
  // FOR LOOP - digunakan jika TAHU jumlah perulangan
  print('=== For Loop ===');
  for (int i = 1; i <= 5; i++) {
    print('Perulangan ke-$i');
  }

  // WHILE LOOP - digunakan jika TIDAK TAHU jumlah perulangan
  print('\n=== While Loop ===');
  int counter = 1;
  while (counter <= 3) {
    print('Counter: $counter');
    counter++; // counter = counter + 1
  }

  // DO-WHILE LOOP - minimal jalan 1 kali
  print('\n=== Do-While Loop ===');
  int angka = 1;
  do {
    print('Angka: $angka');
    angka++;
  } while (angka <= 3);

  // FOR-IN LOOP - untuk mengakses elemen list
  print('\n=== For-in Loop ===');
  List<String> buah = ['Apel', 'Jeruk', 'Mangga'];
  for (String item in buah) {
    print('Buah: $item');
  }

  // FOREACH dengan arrow function
  print('\n=== ForEach ===');
  buah.forEach((item) => print('Saya suka $item'));
}
```

### 4.9 Fungsi (Function)

```dart
// Fungsi tanpa return value (void)
void sapaPagi() {
  print('Selamat pagi!');
}

// Fungsi dengan return value
int tambah(int a, int b) {
  return a + b;
}

// Fungsi dengan parameter opsional (positional)
void perkenalan(String nama, [int? umur]) {
  print('Nama saya $nama');
  if (umur != null) {
    print('Umur saya $umur tahun');
  }
}

// Fungsi dengan named parameter
void buatAkun({required String email, String? username}) {
  print('Email: $email');
  if (username != null) {
    print('Username: $username');
  }
}

// Fungsi dengan default value
void sapa(String nama, {String sapaan = 'Halo'}) {
  print('$sapaan, $nama!');
}

// Arrow function (fungsi singkat 1 baris)
int kuadrat(int x) => x * x;
String formatNama(String nama) => nama.toUpperCase();

void main() {
  sapaPagi();

  int hasil = tambah(5, 3);
  print('5 + 3 = $hasil');

  perkenalan('Andi');
  perkenalan('Budi', 21);

  buatAkun(email: 'test@mail.com');
  buatAkun(email: 'user@mail.com', username: 'user123');

  sapa('Budi'); // Output: Halo, Budi!
  sapa('Citra', sapaan: 'Hai'); // Output: Hai, Citra!

  print('Kuadrat dari 4: ${kuadrat(4)}');
  print('Format nama: ${formatNama("budi")}');
}
```

### 4.10 List (Array)

```dart
void main() {
  // Membuat list
  List<String> mahasiswa = ['Andi', 'Budi', 'Citra'];
  List<int> nilai = [85, 90, 78];

  // Akses elemen (index mulai dari 0)
  print('Mahasiswa pertama: ${mahasiswa[0]}');         // Andi
  print('Mahasiswa kedua: ${mahasiswa[1]}');           // Budi
  print('Mahasiswa terakhir: ${mahasiswa[mahasiswa.length - 1]}'); // Citra

  // Menambah elemen
  mahasiswa.add('Doni');          // Tambah di akhir
  mahasiswa.insert(0, 'Eka');     // Tambah di index 0
  print('Setelah ditambah: $mahasiswa');

  // Menghapus elemen
  mahasiswa.remove('Budi');       // Hapus by value
  mahasiswa.removeAt(0);          // Hapus by index
  print('Setelah dihapus: $mahasiswa');

  // Method berguna lainnya
  print('Jumlah mahasiswa: ${mahasiswa.length}');
  print('Apakah kosong: ${mahasiswa.isEmpty}');
  print('Apakah ada Andi: ${mahasiswa.contains("Andi")}');
  print('Index Citra: ${mahasiswa.indexOf("Citra")}');

  // Membuat list dari range
  List<int> angka = List.generate(5, (index) => index + 1);
  print('List angka: $angka'); // [1, 2, 3, 4, 5]
}
```

### 4.11 Map (Dictionary)

```dart
void main() {
  // Membuat map
  Map<String, dynamic> mahasiswa = {
    'nama': 'Andi',
    'nim': '2209106001',
    'umur': 20,
    'aktif': true,
  };

  // Akses nilai
  print('Nama: ${mahasiswa['nama']}');
  print('NIM: ${mahasiswa['nim']}');

  // Menambah/mengubah nilai
  mahasiswa['email'] = 'andi@mail.com';  // Tambah key baru
  mahasiswa['umur'] = 21;                 // Update nilai

  // Hapus key
  mahasiswa.remove('aktif');

  print('Data lengkap: $mahasiswa');

  // Cek key dan value
  print('Ada key email: ${mahasiswa.containsKey('email')}');
  print('Ada value 21: ${mahasiswa.containsValue(21)}');

  // Mengambil semua keys dan values
  print('Keys: ${mahasiswa.keys.toList()}');
  print('Values: ${mahasiswa.values.toList()}');

  // Iterasi map
  mahasiswa.forEach((key, value) {
    print('$key: $value');
  });
}
```

---

## 🏛️ BAGIAN 5: Object-Oriented Programming (OOP)

### 5.1 Apa itu OOP?

**OOP** adalah cara memprogram dengan membuat "objek" yang memiliki **data** (properties) dan **aksi** (methods).

Analoginya:

- **Class** = Blueprint/cetakan (misal: blueprint mobil)
- **Object** = Hasil dari cetakan (misal: mobil Honda, mobil Toyota)

```
Class Mahasiswa (Blueprint)
├── Properties (Data):
│   ├── nama
│   ├── nim
│   └── umur
└── Methods (Aksi):
    ├── belajar()
    ├── tidur()
    └── perkenalan()


Objects (Instance):
├── mahasiswa1 = Mahasiswa('Budi', '123', 20)
└── mahasiswa2 = Mahasiswa('Citra', '456', 21)
```

### 5.2 Membuat Class Pertama

```dart
// Mendefinisikan class
class Mahasiswa {
  // Properties (atribut/data)
  String nama;
  String nim;
  int umur;

  // Constructor - cara membuat object baru
  Mahasiswa(this.nama, this.nim, this.umur);

  // Method (fungsi dalam class)
  void perkenalan() {
    print('Halo! Nama saya $nama');
    print('NIM: $nim');
    print('Umur: $umur tahun');
  }

  void belajar(String mataKuliah) {
    print('$nama sedang belajar $mataKuliah');
  }
}

void main() {
  // Membuat object dari class
  Mahasiswa mhs1 = Mahasiswa('Budi', '2209106001', 20);
  Mahasiswa mhs2 = Mahasiswa('Citra', '2209106002', 21);

  // Menggunakan method
  mhs1.perkenalan();
  print('---');
  mhs2.perkenalan();

  print('---');
  mhs1.belajar('Flutter');
  mhs2.belajar('Database');

  // Mengakses property
  print('Nama mahasiswa 1: ${mhs1.nama}');
}
```

**Output:**

```
Halo! Nama saya Budi
NIM: 2209106001
Umur: 20 tahun
---
Halo! Nama saya Citra
NIM: 2209106002
Umur: 21 tahun
---
Budi sedang belajar Flutter
Citra sedang belajar Database
Nama mahasiswa 1: Budi
```

### 5.3 Constructor Variations

```dart
class Produk {
  String nama;
  double harga;
  int stok;

  // Constructor biasa
  Produk(this.nama, this.harga, this.stok);

  // Named constructor
  Produk.gratis(this.nama)
      : harga = 0,
        stok = 999;

  // Constructor dengan named parameters
  // Produk({required this.nama, required this.harga, this.stok = 0});

  void info() {
    print('$nama - Rp$harga (Stok: $stok)');
  }
}

void main() {
  // Pakai constructor biasa
  var laptop = Produk('Laptop', 5000000, 10);
  laptop.info(); // Laptop - Rp5000000.0 (Stok: 10)

  // Pakai named constructor
  var sample = Produk.gratis('Sample Produk');
  sample.info(); // Sample Produk - Rp0.0 (Stok: 999)
}
```

### 5.4 Getter dan Setter

```dart
class Rekening {
  String _pemilik;  // _ artinya private (konvensi)
  double _saldo;

  Rekening(this._pemilik, this._saldo);

  // Getter - untuk mengakses nilai
  String get pemilik => _pemilik;
  double get saldo => _saldo;

  // Setter - untuk mengubah nilai dengan validasi
  set saldo(double nilai) {
    if (nilai >= 0) {
      _saldo = nilai;
    } else {
      print('Error: Saldo tidak boleh negatif!');
    }
  }

  void tarik(double jumlah) {
    if (jumlah <= _saldo) {
      _saldo -= jumlah;
      print('Berhasil tarik Rp$jumlah. Sisa: Rp$_saldo');
    } else {
      print('Saldo tidak cukup!');
    }
  }
}

void main() {
  var rek = Rekening('Budi', 1000000);

  print('Pemilik: ${rek.pemilik}');
  print('Saldo: Rp${rek.saldo}');

  rek.tarik(500000);
  print('Saldo sekarang: Rp${rek.saldo}');

  rek.saldo = -100; // Error: Saldo tidak boleh negatif!
}
```

### 5.5 Inheritance (Pewarisan)

```dart
// Parent class / Super class
class Hewan {
  String nama;
  int umur;

  Hewan(this.nama, this.umur);

  void makan() {
    print('$nama sedang makan');
  }

  void tidur() {
    print('$nama sedang tidur');
  }
}

// Child class - mewarisi dari Hewan
class Kucing extends Hewan {
  String warnaBulu;

  // Panggil constructor parent dengan super
  Kucing(String nama, int umur, this.warnaBulu) : super(nama, umur);

  // Method tambahan khusus Kucing
  void meong() {
    print('$nama: Meooong!');
  }

  // Override method dari parent
  @override
  void makan() {
    print('$nama sedang makan ikan');
  }
}

// Child class lain
class Anjing extends Hewan {
  String ras;

  Anjing(String nama, int umur, this.ras) : super(nama, umur);

  void gonggong() {
    print('$nama: Guk guk guk!');
  }

  @override
  void makan() {
    print('$nama sedang makan tulang');
  }
}

void main() {
  var kucing = Kucing('Kitty', 2, 'Orange');
  var anjing = Anjing('Buddy', 3, 'Golden Retriever');

  print('=== Kucing ===');
  kucing.makan();   // Override: makan ikan
  kucing.tidur();   // Dari parent
  kucing.meong();   // Khusus kucing

  print('\n=== Anjing ===');
  anjing.makan();     // Override: makan tulang
  anjing.tidur();     // Dari parent
  anjing.gonggong();  // Khusus anjing
}
```

**Output:**

```
=== Kucing ===
Kitty sedang makan ikan
Kitty sedang tidur
Kitty: Meooong!

=== Anjing ===
Buddy sedang makan tulang
Buddy sedang tidur
Buddy: Guk guk guk!
```

---

## 🛡️ BAGIAN 6: Null Safety di Dart

### 🤔 Apa itu Null Safety?

**Null Safety** membantu mencegah error karena nilai `null` (kosong). Dart akan memperingatkan kamu jika ada kemungkinan null.

```dart
void main() {
  // Variabel yang PASTI punya nilai (non-nullable)
  String nama = 'Andi';  // Tidak boleh null

  // Variabel yang MUNGKIN null (nullable) → tambahkan ?
  String? kota;  // Boleh null
  kota = 'Jakarta';

  // Menggunakan nullable variable
  if (kota != null) {
    print('Panjang nama kota: ${kota.length}');
  }

  // Atau dengan null-aware operator
  print('Kota: ${kota ?? "Tidak diketahui"}');
}
```

**Operator Null Safety:**

| Operator | Nama                  | Kegunaan                                        | Contoh              |
| -------- | --------------------- | ----------------------------------------------- | ------------------- |
| `?`      | Nullable              | Menandakan variabel boleh null                  | `String? nama;`     |
| `!`      | Bang/Not-null         | Menjamin developer bahwa nilai pasti tidak null | `nama!.length`      |
| `??`     | Null coalescing       | Memberikan nilai default jika null              | `nama ?? 'default'` |
| `?.`     | Null-aware access     | Akses property hanya jika tidak null            | `nama?.length`      |
| `??=`    | Null-aware assignment | Assign nilai jika variabel null                 | `nama ??= 'Budi'`   |

```dart
void main() {
  String? teks;

  // Null coalescing (??)
  String hasil = teks ?? 'default';
  print(hasil);  // Output: default

  // Null-aware access (?.)
  int? panjang = teks?.length;
  print(panjang);  // Output: null

  // Null-aware assignment (??=)
  teks ??= 'Hello';  // Assign 'Hello' karena teks null
  print(teks);  // Output: Hello

  panjang = teks?.length;
  print(panjang);  // Output: 5
}
```

---

## 🚨 BAGIAN 7: Exception Handling (Menangani Error)

### Apa itu Exception?

**Exception** adalah error yang terjadi saat program berjalan. Kita perlu "menangkap" error ini agar program tidak crash.

```dart
void main() {
  // TANPA exception handling → Program crash!
  // int hasil = 10 ~/ 0;  // Error: IntegerDivisionByZeroException

  // DENGAN exception handling → Program tetap jalan
  try {
    int hasil = 10 ~/ 0;  // Ini akan error
    print('Hasil: $hasil');
  } catch (e) {
    print('Terjadi error: $e');
  }

  print('Program tetap lanjut!');
}
```

### Try-Catch-Finally

```dart
void main() {
  print('=== Contoh Exception Handling ===\n');

  // Contoh 1: Pembagian dengan nol
  try {
    int a = 10;
    int b = 0;
    int hasil = a ~/ b;
    print('Hasil: $hasil');
  } on IntegerDivisionByZeroException {
    print('Error: Tidak bisa membagi dengan nol!');
  }

  print('---');

  // Contoh 2: Akses index yang tidak ada
  try {
    List<String> buah = ['Apel', 'Jeruk'];
    print(buah[5]);  // Index 5 tidak ada
  } on RangeError catch (e) {
    print('Error: Index di luar jangkauan!');
    print('Detail: $e');
  }

  print('---');

  // Contoh 3: Try-Catch-Finally
  try {
    print('Mencoba membaca file...');
    // Simulasi error
    throw Exception('File tidak ditemukan!');
  } catch (e) {
    print('Error: $e');
  } finally {
    // Finally SELALU dijalankan, error atau tidak
    print('Proses selesai (finally block)');
  }

  print('\nProgram selesai dengan aman!');
}
```

**Output:**

```
=== Contoh Exception Handling ===

Error: Tidak bisa membagi dengan nol!
---
Error: Index di luar jangkauan!
Detail: RangeError (index): Invalid value: Not in inclusive range 0..1: 5
---
Mencoba membaca file...
Error: Exception: File tidak ditemukan!
Proses selesai (finally block)

Program selesai dengan aman!
```

---

## 🎨 BAGIAN 8: Project Flutter Pertama

### Langkah 1: Buat Project Baru

**Via Command Line:**

```bash
cd C:\Projects
flutter create hello_flutter
cd hello_flutter
```

**Via Android Studio:**

1. File → New → New Flutter Project
2. Pilih **Flutter** → klik Next
3. Project name: `hello_flutter`
4. Pilih lokasi → klik Create

### Langkah 2: Struktur Folder Project

```
hello_flutter/
├── android/          ← File khusus Android
├── ios/              ← File khusus iOS
├── lib/              ← KODE UTAMA KAMU DI SINI
│   └── main.dart     ← File utama aplikasi
├── test/             ← File untuk testing
├── pubspec.yaml      ← Konfigurasi project & dependencies
└── README.md         ← Dokumentasi project
```

> 💡 **Fokus utama**: Folder `lib/` adalah tempat kamu menulis kode Flutter!

### Langkah 3: Jalankan Aplikasi

```bash
flutter run
```

Atau tekan tombol **Run** (▶️) di Android Studio.

### Langkah 4: Memahami Kode Default (main.dart)

Sebelum memodifikasi, mari pahami struktur kode Flutter:

```dart
// Import package Material (komponen UI)
import 'package:flutter/material.dart';

// Fungsi utama - titik awal aplikasi
void main() {
  runApp(const MyApp());  // Jalankan widget MyApp
}

// Widget utama aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp = wrapper untuk aplikasi Material Design
    return MaterialApp(
      title: 'Nama Aplikasi',
      home: Scaffold(  // Scaffold = struktur dasar halaman
        appBar: AppBar(
          title: Text('Judul di AppBar'),
        ),
        body: Center(
          child: Text('Konten di sini'),
        ),
      ),
    );
  }
}
```

**Penjelasan:**

```
main()
  └── runApp(MyApp)
        └── MaterialApp          ← Wrapper utama
              └── Scaffold       ← Struktur halaman
                    ├── appBar   ← Bar atas
                    └── body     ← Konten utama
                          └── Widget-widget lainnya
```

### Langkah 5: Modifikasi main.dart

Buka file `lib/main.dart` dan ganti dengan kode berikut:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Pertamaku',
      debugShowCheckedModeBanner: false,  // Hilangkan banner DEBUG
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HalamanUtama(),
    );
  }
}

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello Flutter! 👋'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Flutter
            const Icon(
              Icons.flutter_dash,
              size: 100,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),

            // Judul
            const Text(
              'Selamat Datang di Flutter!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Subjudul
            const Text(
              'Ini adalah aplikasi pertamaku 🎉',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),

            // Tombol
            ElevatedButton.icon(
              onPressed: () {
                // Aksi ketika tombol ditekan
                print('Tombol ditekan!');
              },
              icon: const Icon(Icons.favorite),
              label: const Text('Tekan Saya!'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
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

### Langkah 6: Hot Reload

Setelah mengubah kode, tekan:

- **r** di terminal untuk Hot Reload
- **R** untuk Hot Restart

> 🔥 **Hot Reload** = Perubahan langsung terlihat tanpa kehilangan state
>
> 🔄 **Hot Restart** = Aplikasi restart dari awal

### 📱 Hasil Akhir Aplikasi

Setelah menjalankan kode di atas, kamu akan melihat:

```
┌─────────────────────────────────┐
│  Hello Flutter! 👋              │  ← AppBar (biru)
├─────────────────────────────────┤
│                                 │
│                                 │
│         🐦 (icon besar)         │
│                                 │
│   Selamat Datang di Flutter!    │  ← Text tebal
│   Ini adalah aplikasi pertamaku │  ← Text abu-abu
│                                 │
│      [ ❤️ Tekan Saya! ]          │  ← Button
│                                 │
│                                 │
└─────────────────────────────────┘
```

---

## 🧩 Penjelasan Widget Dasar

```
MaterialApp        → Wrapper utama aplikasi Material Design
    ↓
Scaffold           → Struktur dasar halaman (AppBar, Body, dll)
    ↓
Column             → Menyusun widget secara vertikal
    ↓
Text, Icon, Button → Widget untuk tampilan
```

**Widget yang digunakan:**

| Widget           | Fungsi                                            |
| ---------------- | ------------------------------------------------- |
| `MaterialApp`    | Membungkus aplikasi dengan tema Material Design   |
| `Scaffold`       | Menyediakan struktur halaman (app bar, body, dll) |
| `AppBar`         | Bar di atas layar                                 |
| `Center`         | Menempatkan child di tengah                       |
| `Column`         | Menyusun children secara vertikal                 |
| `Icon`           | Menampilkan ikon                                  |
| `Text`           | Menampilkan teks                                  |
| `SizedBox`       | Memberikan jarak/spacing                          |
| `ElevatedButton` | Tombol dengan efek elevasi                        |

---

## 🚫 BAGIAN 9: Error Umum & Solusinya

### Error Saat Instalasi

| Error                          | Penyebab                              | Solusi                                              |
| ------------------------------ | ------------------------------------- | --------------------------------------------------- |
| `'flutter' is not recognized`  | PATH belum diset                      | Tambahkan `C:\flutter\bin` ke Environment Variables |
| `Dart SDK not found`           | Flutter belum diextract dengan benar  | Extract ulang ke folder tanpa spasi                 |
| `Unable to find git`           | Git belum terinstall                  | Install Git dari https://git-scm.com                |
| `Android SDK not found`        | Android SDK belum diinstall           | Buka Android Studio → SDK Manager → Install SDK     |
| `JAVA_HOME not set`            | Java tidak terinstall atau PATH salah | Install JDK atau set JAVA_HOME                      |
| `Android license not accepted` | Lisensi belum disetujui               | Jalankan: `flutter doctor --android-licenses`       |

### Error Saat Menjalankan Aplikasi

| Error                        | Penyebab                          | Solusi                                              |
| ---------------------------- | --------------------------------- | --------------------------------------------------- |
| `No connected devices`       | Tidak ada emulator/HP terhubung   | Buat emulator atau hubungkan HP via USB             |
| `Waiting for connection`     | Emulator lambat start             | Tunggu atau gunakan HP fisik                        |
| `Gradle build failed`        | Masalah koneksi internet/cache    | Jalankan: `flutter clean` lalu `flutter run`        |
| `Could not find a generator` | Ekstensi Flutter belum terinstall | Install Flutter extension di VS Code/Android Studio |

### Error Saat Coding

| Error                                     | Penyebab                   | Solusi                                |
| ----------------------------------------- | -------------------------- | ------------------------------------- |
| `The method 'X' isn't defined`            | Typo atau method tidak ada | Cek nama method, gunakan autocomplete |
| `Expected ';' after this`                 | Lupa titik koma            | Tambahkan `;` di akhir statement      |
| `Expected ')' or ','`                     | Kurung tidak lengkap       | Cek pasangan kurung buka-tutup        |
| `A value of type 'X' can't be assigned`   | Tipe data tidak cocok      | Sesuaikan tipe data variabel          |
| `The argument type 'X' can't be assigned` | Parameter salah tipe       | Cek tipe parameter yang dibutuhkan    |

### Tips Debugging

```dart
void main() {
  // 1. Gunakan print untuk debug
  print('Debug: Masuk fungsi main');

  // 2. Gunakan debugPrint untuk output panjang
  debugPrint('Data: ' + data.toString());

  // 3. Gunakan breakpoint di IDE
  // Klik di sebelah kiri nomor baris untuk menambah breakpoint

  // 4. Flutter DevTools
  // Terminal: flutter pub global activate devtools
  // Kemudian: devtools
}
```

---

## 📝 LATIHAN PRAKTIKUM

### Latihan 1: Dart Dasar (DartPad)

Buka https://dartpad.dev dan kerjakan:

```dart
// TODO: Lengkapi kode berikut

void main() {
  // 1. Buat variabel nama (String) berisi nama kamu

  // 2. Buat variabel umur (int) berisi umur kamu

  // 3. Buat variabel ipk (double) berisi IPK kamu

  // 4. Tampilkan semua data dengan format:
  //    "Nama: [nama], Umur: [umur], IPK: [ipk]"

  // 5. Buat kondisi: jika IPK >= 3.5 print "Cumlaude!"
  //    jika tidak, print "Tetap semangat!"
}
```

### Latihan 2: Fungsi

```dart
// TODO: Buat fungsi-fungsi berikut

// 1. Fungsi hitungLuasPersegiPanjang(panjang, lebar)
//    yang mengembalikan hasil perkalian

// 2. Fungsi cekGanjilGenap(angka) yang menampilkan
//    "Ganjil" atau "Genap"

// 3. Fungsi tampilkanGrade(nilai) yang menampilkan:
//    A (>=80), B (>=70), C (>=60), D (<60)

void main() {
  // Test fungsi-fungsi kamu di sini
}
```

### Latihan 3: List dan Loop

```dart
void main() {
  // Diberikan list mahasiswa
  List<String> mahasiswa = ['Andi', 'Budi', 'Citra', 'Doni', 'Eka'];

  // TODO:
  // 1. Tampilkan semua nama dengan format: "1. Andi", "2. Budi", dst

  // 2. Tambahkan nama "Fani" ke list

  // 3. Hapus nama "Citra" dari list

  // 4. Tampilkan jumlah mahasiswa sekarang
}
```

### Latihan 4: Class dan OOP

```dart
// TODO: Buat class Buku dengan:
// - Properties: judul, penulis, tahun, harga
// - Constructor
// - Method info() yang menampilkan semua data buku
// - Method diskon(persen) yang mengembalikan harga setelah diskon

void main() {
  // Buat 2 object buku dan tampilkan infonya
  // Hitung harga setelah diskon 20%
}
```

### Latihan 5: Modifikasi Flutter App

Modifikasi aplikasi Flutter dari Langkah 5 untuk:

1. Ganti warna AppBar menjadi warna favoritmu
2. Ganti teks menjadi data tentang dirimu (nama, NIM, hobi)
3. Tambahkan 2 tombol lagi dengan fungsi berbeda
4. Coba ganti icon dengan icon lain dari `Icons.xxx`

---

## 📚 TUGAS MINGGU INI

### Tugas Individu (Deadline: Pertemuan 2)

**Bagian A: Quiz Dart (30 poin)**

- Kerjakan 10 soal di Google Form (akan diberikan link)

**Bagian B: Praktik Dart (40 poin)**
Buat program Dart yang:

1. Meminta input nama, NIM, dan nilai UAS
2. Menghitung grade berdasarkan nilai:
   - A: 85-100
   - B: 70-84
   - C: 55-69
   - D: 40-54
   - E: <40
3. Menampilkan hasil dengan format yang rapi

**Bagian C: Flutter Project (30 poin)**
Buat aplikasi Flutter sederhana berisi:

1. Kartu profil dengan nama dan NIM kamu
2. Minimal menggunakan widget: `AppBar`, `Column`, `Text`, `Icon`, `Container`

**Pengumpulan:**

- Upload ke GitHub Classroom
- Format folder: `NIM_NamaLengkap_Tugas1`

---

## 📖 REFERENSI & SUMBER BELAJAR

### Dokumentasi Resmi:

- 🌐 [Flutter.dev](https://flutter.dev/docs) - Dokumentasi Flutter
- 🎯 [Dart.dev](https://dart.dev/guides) - Dokumentasi Dart
- 🎮 [DartPad](https://dartpad.dev) - Latihan coding online

### Video Tutorial:

- 🎥 [Flutter YouTube Channel](https://youtube.com/flutterdev)
- 🎥 [Erico Darmawan - Flutter Indonesia](https://youtube.com/@EricoDarmawanHandoyo)

### Artikel:

- 📝 [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- 📝 [Dart Language Tour](https://dart.dev/guides/language/language-tour)

---

## ❓ FAQ (Pertanyaan Umum)

**Q: Lebih baik Android Studio atau VS Code?**

> A: Keduanya bagus! VS Code lebih ringan, Android Studio lebih lengkap. Pilih sesuai spesifikasi laptop.

**Q: Apakah harus punya iPhone untuk develop iOS?**

> A: Untuk build ke iOS memerlukan macOS. Tapi kamu tetap bisa coding dan test di Android/Emulator.

**Q: Error "flutter not recognized", kenapa?**

> A: PATH belum diset dengan benar. Pastikan `C:\flutter\bin` ada di Environment Variables.

**Q: Emulator lambat, bagaimana solusinya?**

> A: Gunakan device fisik via USB debugging, atau enable Hardware Acceleration di BIOS.

**Q: Apa bedanya StatelessWidget dan StatefulWidget?**

> A: StatelessWidget untuk tampilan statis (tidak berubah). StatefulWidget untuk tampilan dinamis (bisa berubah saat interaksi). Akan dibahas detail di pertemuan 2!

---

## 🎯 CHECKLIST SEBELUM PERTEMUAN 2

- [ ] Flutter terinstall (`flutter doctor` tidak ada error)
- [ ] Bisa menjalankan emulator ATAU menghubungkan HP via USB
- [ ] Bisa membuat project Flutter baru
- [ ] Memahami variabel dan tipe data di Dart
- [ ] Memahami fungsi dan percabangan
- [ ] Memahami dasar OOP (class dan object)
- [ ] Sudah mencoba menjalankan aplikasi Flutter pertama
- [ ] Mengumpulkan tugas tepat waktu

---

> 💬 **Pertanyaan?**
>
> Hubungi dosen/asisten via email atau WhatsApp group.
>
> **Selamat belajar! 🚀**

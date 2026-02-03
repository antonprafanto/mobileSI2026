# 📱 PERTEMUAN 2

## Widget Dasar, Layout & Theming

---

## 📂 RESOURCES & DEMO FILES

> 💡 **Untuk memudahkan pembelajaran, tersedia file demo yang bisa langsung dijalankan!**

### File Demo (Copy ke `main.dart`):

| File                                                                                       | Topik                                |
| ------------------------------------------------------------------------------------------ | ------------------------------------ |
| [`01_counter_demo.dart`](contoh_kode/pertemuan_2/01_counter_demo.dart)                     | StatelessWidget vs StatefulWidget    |
| [`02_widget_dasar_demo.dart`](contoh_kode/pertemuan_2/02_widget_dasar_demo.dart)           | Text, Container, Image, Icon, Button |
| [`03_layout_demo.dart`](contoh_kode/pertemuan_2/03_layout_demo.dart)                       | Row, Column, Stack                   |
| [`04_spacing_alignment_demo.dart`](contoh_kode/pertemuan_2/04_spacing_alignment_demo.dart) | Padding, SizedBox, Expanded          |
| [`05_theme_demo.dart`](contoh_kode/pertemuan_2/05_theme_demo.dart)                         | ThemeData, Dark/Light Mode           |
| [`06_profil_page_lengkap.dart`](contoh_kode/pertemuan_2/06_profil_page_lengkap.dart)       | Contoh Jawaban Praktikum             |

### Proyek Flutter Lengkap:

📁 [`contoh_proyek/pertemuan_2_demo/`](contoh_proyek/pertemuan_2_demo/) - Proyek Flutter dengan navigasi antar demo

### Untuk Pengajar:

📝 [`Pertemuan_2_Live_Coding_Scenario.md`](Pertemuan_2_Live_Coding_Scenario.md) - Panduan live coding di kelas

---

## 🎯 Tujuan Pembelajaran

Setelah mengikuti pertemuan ini, mahasiswa diharapkan mampu:

1. ✅ Memahami perbedaan StatelessWidget dan StatefulWidget
2. ✅ Menggunakan widget dasar Flutter (Text, Container, Image, Icon, Button)
3. ✅ Mengatur layout dengan Row, Column, Stack
4. ✅ Menambahkan assets (gambar dan font custom)
5. ✅ Menerapkan theming pada aplikasi

---

## ⏱️ ESTIMASI DURASI (Total: 150 menit)

| Bagian | Topik                             | Durasi   | Keterangan                           |
| ------ | --------------------------------- | -------- | ------------------------------------ |
| 1      | Review Pertemuan 1                | 10 menit | Recap + tanya jawab                  |
| 2      | StatelessWidget vs StatefulWidget | 15 menit | Konsep penting                       |
| 3      | Widget Dasar                      | 25 menit | Text, Container, Image, Icon         |
| 4      | Layout Widgets                    | 30 menit | **Inti materi** - Row, Column, Stack |
| 5      | Spacing & Alignment               | 15 menit | Padding, SizedBox, MainAxis          |
| 6      | Assets (Gambar & Font)            | 15 menit | pubspec.yaml, Image.asset            |
| 7      | Theming                           | 20 menit | ThemeData, ColorScheme               |
| 8      | Praktikum                         | 15 menit | Membuat halaman profil               |
| -      | Tanya Jawab & Penutup             | 5 menit  |                                      |

---

## 📚 BAGIAN 1: Review Pertemuan 1

### Quiz Singkat (5 menit)

Jawab pertanyaan berikut sebelum lanjut:

1. Apa fungsi `void main()` di Dart?
2. Sebutkan 4 tipe data dasar di Dart!
3. Apa perbedaan `final` dan `const`?
4. Apa itu class dan object?
5. Widget apa yang digunakan untuk membungkus aplikasi Flutter?

> 💡 Jika belum bisa menjawab, review materi Pertemuan 1!

---

## 🧩 BAGIAN 2: StatelessWidget vs StatefulWidget

### 2.1 Apa itu Widget?

Di Flutter, **SEMUA yang terlihat di layar adalah Widget**.

```
Tombol    → Widget
Teks      → Widget
Gambar    → Widget
Halaman   → Widget (kumpulan widget)
Aplikasi  → Widget (MaterialApp)
```

Widget adalah "building blocks" untuk membangun UI di Flutter.

### 2.2 Dua Jenis Widget Utama

```
┌─────────────────────────────────────────────────────────────┐
│                       WIDGET                                 │
├──────────────────────────┬──────────────────────────────────┤
│    StatelessWidget       │       StatefulWidget             │
│    (Tanpa State)         │       (Dengan State)             │
├──────────────────────────┼──────────────────────────────────┤
│ • Tampilan TIDAK berubah │ • Tampilan BISA berubah          │
│ • Tidak ada interaksi    │ • Ada interaksi user             │
│ • Lebih sederhana        │ • Lebih kompleks                 │
│ • Performa lebih baik    │ • Perlu manage state             │
├──────────────────────────┼──────────────────────────────────┤
│ Contoh:                  │ Contoh:                          │
│ • Text statis            │ • Counter (angka berubah)        │
│ • Icon                   │ • Form input                     │
│ • Halaman About          │ • Checkbox, Switch               │
│ • Logo                   │ • Tab navigation                 │
└──────────────────────────┴──────────────────────────────────┘
```

### 2.3 Contoh StatelessWidget

```dart
import 'package:flutter/material.dart';

// StatelessWidget - tampilan tidak berubah
class KartuProfil extends StatelessWidget {
  final String nama;
  final String pekerjaan;

  // Constructor
  const KartuProfil({
    super.key,
    required this.nama,
    required this.pekerjaan,
  });

  @override
  Widget build(BuildContext context) {
    // build() dipanggil SEKALI saja
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              nama,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(pekerjaan),
          ],
        ),
      ),
    );
  }
}

// Penggunaan:
// KartuProfil(nama: 'Budi', pekerjaan: 'Flutter Developer')
```

### 2.4 Contoh StatefulWidget

```dart
import 'package:flutter/material.dart';

// StatefulWidget - tampilan bisa berubah
class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  // State = data yang bisa berubah
  int _counter = 0;

  void _increment() {
    // setState() memberitahu Flutter untuk rebuild UI
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      if (_counter > 0) _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    // build() dipanggil SETIAP KALI setState()
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Counter: $_counter',
          style: const TextStyle(fontSize: 32),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _decrement,
              child: const Icon(Icons.remove),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: _increment,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
```

### 2.5 Kapan Pakai Apa?

```
Pertanyaan: "Apakah tampilan widget ini akan BERUBAH
             setelah pertama kali ditampilkan?"

         │
         ▼
    ┌────────┐
    │  YA?   │
    └────────┘
     /      \
   YA        TIDAK
    │          │
    ▼          ▼
┌──────────┐ ┌──────────┐
│ Stateful │ │ Stateless│
│  Widget  │ │  Widget  │
└──────────┘ └──────────┘
```

**Aturan sederhana:**

- Mulai dengan **StatelessWidget**
- Ubah ke **StatefulWidget** jika perlu `setState()`

---

## 🎨 BAGIAN 3: Widget Dasar

### 3.1 Text Widget

```dart
// Text sederhana
Text('Hello World')

// Text dengan styling
Text(
  'Flutter Keren!',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
    letterSpacing: 2.0,
    fontStyle: FontStyle.italic,
  ),
)

// Text dengan alignment
Text(
  'Teks ini di tengah',
  textAlign: TextAlign.center,
)

// Text dengan jumlah baris terbatas
Text(
  'Ini teks yang sangat panjang sekali dan mungkin tidak muat dalam satu baris...',
  maxLines: 2,
  overflow: TextOverflow.ellipsis, // Tambah ... jika terpotong
)
```

**Properti TextStyle yang sering dipakai:**

| Property        | Fungsi            | Contoh                     |
| --------------- | ----------------- | -------------------------- |
| `fontSize`      | Ukuran font       | `24.0`                     |
| `fontWeight`    | Ketebalan         | `FontWeight.bold`          |
| `color`         | Warna teks        | `Colors.red`               |
| `fontStyle`     | Gaya font         | `FontStyle.italic`         |
| `letterSpacing` | Jarak antar huruf | `2.0`                      |
| `wordSpacing`   | Jarak antar kata  | `5.0`                      |
| `decoration`    | Dekorasi          | `TextDecoration.underline` |

### 3.2 Container Widget

Container adalah widget **serbaguna** untuk styling dan layout.

```dart
// Container sederhana
Container(
  width: 200,
  height: 100,
  color: Colors.blue,
  child: Text('Hello'),
)

// Container dengan decoration (lebih fleksibel)
Container(
  width: 200,
  height: 100,
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(16), // Sudut melengkung
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
    border: Border.all(
      color: Colors.white,
      width: 2,
    ),
  ),
  child: Center(
    child: Text(
      'Styled Box',
      style: TextStyle(color: Colors.white),
    ),
  ),
)

// Container dengan padding dan margin
Container(
  margin: EdgeInsets.all(16),      // Jarak keluar
  padding: EdgeInsets.all(20),     // Jarak ke dalam
  decoration: BoxDecoration(
    color: Colors.amber,
    borderRadius: BorderRadius.circular(8),
  ),
  child: Text('Content'),
)
```

**Visualisasi Margin vs Padding:**

```
┌─────────────────────────────┐
│         MARGIN              │  ← Jarak ke LUAR (dari widget lain)
│  ┌───────────────────────┐  │
│  │       BORDER          │  │
│  │  ┌─────────────────┐  │  │
│  │  │    PADDING      │  │  │  ← Jarak ke DALAM (dari content)
│  │  │  ┌───────────┐  │  │  │
│  │  │  │  CONTENT  │  │  │  │
│  │  │  └───────────┘  │  │  │
│  │  └─────────────────┘  │  │
│  └───────────────────────┘  │
└─────────────────────────────┘
```

### 3.3 Image Widget

```dart
// Image dari internet
Image.network(
  'https://picsum.photos/200/300',
  width: 200,
  height: 150,
  fit: BoxFit.cover,
)

// Image dari asset (file lokal)
Image.asset(
  'assets/images/logo.png',
  width: 100,
  height: 100,
)

// Image dengan placeholder loading
Image.network(
  'https://example.com/image.jpg',
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return Center(child: CircularProgressIndicator());
  },
  errorBuilder: (context, error, stackTrace) {
    return Icon(Icons.error, color: Colors.red);
  },
)

// Image berbentuk lingkaran
ClipOval(
  child: Image.network(
    'https://picsum.photos/100/100',
    width: 100,
    height: 100,
    fit: BoxFit.cover,
  ),
)

// Image dengan border radius
ClipRRect(
  borderRadius: BorderRadius.circular(16),
  child: Image.network(
    'https://picsum.photos/200/150',
    fit: BoxFit.cover,
  ),
)
```

**BoxFit Options:**

| BoxFit      | Deskripsi                            |
| ----------- | ------------------------------------ |
| `cover`     | Isi container, potong jika perlu     |
| `contain`   | Muat semua, mungkin ada ruang kosong |
| `fill`      | Isi container, stretch jika perlu    |
| `fitWidth`  | Sesuaikan lebar                      |
| `fitHeight` | Sesuaikan tinggi                     |

### 3.4 Icon Widget

```dart
// Icon sederhana
Icon(Icons.home)

// Icon dengan styling
Icon(
  Icons.favorite,
  size: 48,
  color: Colors.red,
)

// Icon dalam tombol
IconButton(
  icon: Icon(Icons.settings),
  iconSize: 32,
  color: Colors.blue,
  onPressed: () {
    print('Settings ditekan');
  },
)

// Daftar icon populer
Icon(Icons.home)           // Rumah
Icon(Icons.person)         // Orang
Icon(Icons.settings)       // Pengaturan
Icon(Icons.search)         // Cari
Icon(Icons.favorite)       // Hati
Icon(Icons.star)           // Bintang
Icon(Icons.shopping_cart)  // Keranjang
Icon(Icons.notifications)  // Notifikasi
Icon(Icons.menu)           // Menu
Icon(Icons.close)          // Tutup
Icon(Icons.add)            // Tambah
Icon(Icons.remove)         // Kurang
Icon(Icons.edit)           // Edit
Icon(Icons.delete)         // Hapus
```

> 💡 **Tips**: Lihat semua icon di https://fonts.google.com/icons

### 3.5 Button Widgets

```dart
// ElevatedButton (tombol dengan elevasi/bayangan)
ElevatedButton(
  onPressed: () {
    print('Tombol ditekan!');
  },
  child: Text('Klik Saya'),
)

// ElevatedButton dengan icon
ElevatedButton.icon(
  onPressed: () {},
  icon: Icon(Icons.send),
  label: Text('Kirim'),
)

// ElevatedButton dengan custom style
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.purple,
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  child: Text('Custom Button'),
)

// TextButton (tombol tanpa background)
TextButton(
  onPressed: () {},
  child: Text('Text Button'),
)

// OutlinedButton (tombol dengan border)
OutlinedButton(
  onPressed: () {},
  child: Text('Outlined Button'),
)

// IconButton (tombol hanya icon)
IconButton(
  onPressed: () {},
  icon: Icon(Icons.favorite),
  color: Colors.red,
)

// FloatingActionButton (tombol mengambang)
FloatingActionButton(
  onPressed: () {},
  child: Icon(Icons.add),
)

// Tombol disabled (null onPressed)
ElevatedButton(
  onPressed: null, // Tombol tidak aktif
  child: Text('Disabled'),
)
```

**Perbandingan Button:**

| Button Type            | Tampilan          | Use Case            |
| ---------------------- | ----------------- | ------------------- |
| `ElevatedButton`       | Dengan bayangan   | Aksi utama          |
| `TextButton`           | Teks saja         | Aksi sekunder       |
| `OutlinedButton`       | Dengan border     | Aksi alternatif     |
| `IconButton`           | Icon saja         | Toolbar, action bar |
| `FloatingActionButton` | Bulat, mengambang | Aksi utama halaman  |

### 3.6 Card & ListTile

**Card** adalah container dengan efek elevasi (bayangan) untuk mengelompokkan informasi.

```dart
// Card sederhana
Card(
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Text('Ini adalah Card'),
  ),
)

// Card dengan styling
Card(
  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  color: Colors.white,
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        Text('Judul Card', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('Isi konten card'),
      ],
    ),
  ),
)

// Card dengan ListTile (kombinasi yang sering dipakai)
Card(
  child: ListTile(
    leading: Icon(Icons.person),       // Widget di kiri
    title: Text('Judul'),              // Teks utama
    subtitle: Text('Sub judul'),       // Teks sekunder
    trailing: Icon(Icons.arrow_forward), // Widget di kanan
    onTap: () {
      print('Card ditekan!');
    },
  ),
)
```

**Visualisasi ListTile:**

```
┌────────────────────────────────────────┐
│ [Leading]  Title              [Trailing]│
│            Subtitle                     │
└────────────────────────────────────────┘
```

### 3.7 CircleAvatar

**CircleAvatar** adalah widget lingkaran yang biasa dipakai untuk foto profil.

```dart
// CircleAvatar dengan icon
CircleAvatar(
  radius: 40,
  backgroundColor: Colors.blue,
  child: Icon(Icons.person, size: 40, color: Colors.white),
)

// CircleAvatar dengan gambar dari internet
CircleAvatar(
  radius: 50,
  backgroundImage: NetworkImage('https://picsum.photos/100/100'),
)

// CircleAvatar dengan gambar dari asset
CircleAvatar(
  radius: 50,
  backgroundImage: AssetImage('assets/images/profile.png'),
)

// CircleAvatar dengan teks (inisial)
CircleAvatar(
  radius: 30,
  backgroundColor: Colors.purple,
  child: Text(
    'BS',
    style: TextStyle(color: Colors.white, fontSize: 20),
  ),
)
```

### 3.8 SingleChildScrollView

**SingleChildScrollView** membuat konten bisa di-scroll ketika tidak muat di layar.

```dart
// TANPA scroll → Jika konten terlalu panjang, akan OVERFLOW (error kuning-hitam)
Scaffold(
  body: Column(
    children: [
      // Banyak widget...
      // Error jika tidak muat!
    ],
  ),
)

// DENGAN scroll → Konten bisa di-scroll
Scaffold(
  body: SingleChildScrollView(
    child: Column(
      children: [
        // Banyak widget...
        // Aman! Bisa scroll
      ],
    ),
  ),
)

// Dengan padding
SingleChildScrollView(
  padding: EdgeInsets.all(16),
  child: Column(
    children: [
      // konten...
    ],
  ),
)
```

> 💡 **Kapan pakai SingleChildScrollView?**
>
> - Ketika konten **mungkin** lebih panjang dari layar
> - Untuk halaman form, profil, detail produk, dll
> - Bungkus Column/Row di dalam SingleChildScrollView

### 3.9 Kapan Pakai `const`?

Di Flutter, `const` digunakan untuk **optimasi performa**.

```dart
// ✅ BENAR - Pakai const untuk widget yang nilainya tidak berubah
const Text('Hello World')
const Icon(Icons.home)
const SizedBox(height: 20)
const EdgeInsets.all(16)

// ❌ TIDAK BISA - Jika ada nilai dinamis
Text(namaUser)  // namaUser bisa berubah
Icon(iconDinamis)  // icon dari variabel

// ✅ Di constructor widget
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});  // Tambahkan const di constructor

  @override
  Widget build(BuildContext context) {
    return const Text('Static text');  // const di child
  }
}
```

**Aturan sederhana:**

- Jika IDE menunjukkan **garis biru** di bawah widget → tambahkan `const`
- Jika nilai **pasti tidak berubah** → pakai `const`
- Jika **ragu**, biarkan saja (program tetap jalan)

---

## 📐 BAGIAN 4: Layout Widgets

### 4.1 Column (Vertikal)

Column menyusun children **dari atas ke bawah**.

```dart
Column(
  children: [
    Text('Item 1'),
    Text('Item 2'),
    Text('Item 3'),
  ],
)
```

**Visualisasi:**

```
┌─────────────┐
│   Item 1    │
│   Item 2    │
│   Item 3    │
└─────────────┘
```

**Column dengan properties:**

```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,    // Vertikal
  crossAxisAlignment: CrossAxisAlignment.start,   // Horizontal
  mainAxisSize: MainAxisSize.min,                 // Ukuran
  children: [
    Text('Item 1'),
    Text('Item 2 Panjang'),
    Text('Item 3'),
  ],
)
```

### 4.2 Row (Horizontal)

Row menyusun children **dari kiri ke kanan**.

```dart
Row(
  children: [
    Icon(Icons.star),
    Icon(Icons.star),
    Icon(Icons.star),
  ],
)
```

**Visualisasi:**

```
┌─────────────────────┐
│  ⭐   ⭐   ⭐        │
└─────────────────────┘
```

**Row dengan properties:**

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Horizontal
  crossAxisAlignment: CrossAxisAlignment.center,     // Vertikal
  children: [
    Icon(Icons.home),
    Icon(Icons.search),
    Icon(Icons.person),
  ],
)
```

### 4.3 MainAxisAlignment Options

```
MainAxisAlignment.start        MainAxisAlignment.center
┌─────────────────────┐        ┌─────────────────────┐
│ [1][2][3]           │        │      [1][2][3]      │
└─────────────────────┘        └─────────────────────┘

MainAxisAlignment.end          MainAxisAlignment.spaceBetween
┌─────────────────────┐        ┌─────────────────────┐
│           [1][2][3] │        │ [1]     [2]     [3] │
└─────────────────────┘        └─────────────────────┘

MainAxisAlignment.spaceAround  MainAxisAlignment.spaceEvenly
┌─────────────────────┐        ┌─────────────────────┐
│  [1]   [2]   [3]    │        │   [1]   [2]   [3]   │
└─────────────────────┘        └─────────────────────┘
```

### 4.4 CrossAxisAlignment Options

Untuk Column (arah horizontal):

```
CrossAxisAlignment.start    .center    .end
┌───────────────┐    ┌───────────────┐    ┌───────────────┐
│ [Item 1]      │    │    [Item 1]   │    │      [Item 1] │
│ [Item 2]      │    │    [Item 2]   │    │      [Item 2] │
│ [Item 3]      │    │    [Item 3]   │    │      [Item 3] │
└───────────────┘    └───────────────┘    └───────────────┘
```

### 4.5 Stack (Tumpukan)

Stack menyusun children **bertumpuk** (layer).

```dart
Stack(
  children: [
    // Layer 1 (paling bawah)
    Container(
      width: 200,
      height: 200,
      color: Colors.blue,
    ),
    // Layer 2 (di atas layer 1)
    Container(
      width: 150,
      height: 150,
      color: Colors.red,
    ),
    // Layer 3 (paling atas)
    Container(
      width: 100,
      height: 100,
      color: Colors.yellow,
    ),
  ],
)
```

**Visualisasi:**

```
┌────────────────────┐
│  Blue              │
│   ┌──────────────┐ │
│   │ Red          │ │
│   │  ┌────────┐  │ │
│   │  │ Yellow │  │ │
│   │  └────────┘  │ │
│   └──────────────┘ │
└────────────────────┘
```

**Stack dengan Positioned:**

```dart
Stack(
  children: [
    // Background
    Container(
      width: 300,
      height: 200,
      color: Colors.grey[300],
    ),
    // Positioned widget
    Positioned(
      top: 10,
      right: 10,
      child: Icon(Icons.favorite, color: Colors.red),
    ),
    Positioned(
      bottom: 10,
      left: 10,
      child: Text('Bottom Left'),
    ),
    // Center
    Center(
      child: Text('Center'),
    ),
  ],
)
```

### 4.6 Expanded & Flexible

**Expanded** membagi ruang yang tersisa.

```dart
Row(
  children: [
    Container(width: 50, height: 50, color: Colors.red),
    Expanded(
      child: Container(height: 50, color: Colors.blue),
    ),
    Container(width: 50, height: 50, color: Colors.green),
  ],
)
```

**Visualisasi:**

```
┌────┬──────────────────────────────┬────┐
│Red │           Blue               │Green│
└────┴──────────────────────────────┴────┘
  50          expands                 50
```

**Expanded dengan flex:**

```dart
Row(
  children: [
    Expanded(
      flex: 1, // 1 bagian
      child: Container(height: 50, color: Colors.red),
    ),
    Expanded(
      flex: 2, // 2 bagian
      child: Container(height: 50, color: Colors.blue),
    ),
    Expanded(
      flex: 1, // 1 bagian
      child: Container(height: 50, color: Colors.green),
    ),
  ],
)
```

**Visualisasi:**

```
┌──────┬────────────────┬──────┐
│ Red  │      Blue      │Green │
│ 1/4  │      2/4       │ 1/4  │
└──────┴────────────────┴──────┘
```

---

## 📏 BAGIAN 5: Spacing & Alignment

### 5.1 SizedBox

Untuk memberikan jarak antar widget.

```dart
Column(
  children: [
    Text('Item 1'),
    SizedBox(height: 20), // Jarak vertikal 20 pixel
    Text('Item 2'),
    SizedBox(height: 10),
    Text('Item 3'),
  ],
)

Row(
  children: [
    Icon(Icons.home),
    SizedBox(width: 16), // Jarak horizontal 16 pixel
    Text('Home'),
  ],
)
```

### 5.2 Padding

Memberikan jarak di dalam widget.

```dart
// Padding semua sisi sama
Padding(
  padding: EdgeInsets.all(16),
  child: Text('Padding 16 di semua sisi'),
)

// Padding horizontal dan vertikal berbeda
Padding(
  padding: EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 12,
  ),
  child: Text('Padding H24 V12'),
)

// Padding tiap sisi berbeda
Padding(
  padding: EdgeInsets.only(
    left: 10,
    top: 20,
    right: 10,
    bottom: 5,
  ),
  child: Text('Padding custom'),
)

// Padding dengan LTRB (Left, Top, Right, Bottom)
Padding(
  padding: EdgeInsets.fromLTRB(10, 20, 10, 5),
  child: Text('LTRB'),
)
```

### 5.3 Center

Menempatkan child di tengah parent.

```dart
Center(
  child: Text('Saya di tengah!'),
)
```

### 5.4 Align

Menempatkan child di posisi tertentu.

```dart
Container(
  width: 200,
  height: 200,
  color: Colors.grey[300],
  child: Align(
    alignment: Alignment.topRight,
    child: Text('Top Right'),
  ),
)

// Alignment options:
// Alignment.topLeft      Alignment.topCenter      Alignment.topRight
// Alignment.centerLeft   Alignment.center         Alignment.centerRight
// Alignment.bottomLeft   Alignment.bottomCenter   Alignment.bottomRight
```

### 5.5 Spacer

Mengisi ruang kosong di Row/Column.

```dart
Row(
  children: [
    Text('Left'),
    Spacer(), // Mengisi ruang di tengah
    Text('Right'),
  ],
)
```

**Visualisasi:**

```
┌─────────────────────────────────┐
│ Left                      Right │
└─────────────────────────────────┘
```

---

## 🖼️ BAGIAN 6: Assets (Gambar & Font)

### 6.1 Menambahkan Gambar

#### Langkah 1: Buat folder assets

```
project_flutter/
├── lib/
├── assets/           ← Buat folder ini
│   └── images/       ← Untuk gambar
│       ├── logo.png
│       └── background.jpg
└── pubspec.yaml
```

#### Langkah 2: Daftarkan di pubspec.yaml

```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/images/logo.png
    - assets/images/background.jpg

  # Atau untuk semua file dalam folder:
  # assets:
  #   - assets/images/
```

#### Langkah 3: Gunakan di kode

```dart
Image.asset('assets/images/logo.png')

// Dengan properti
Image.asset(
  'assets/images/logo.png',
  width: 150,
  height: 150,
  fit: BoxFit.contain,
)
```

### 6.2 Menambahkan Font Custom

#### Langkah 1: Download font

Download dari https://fonts.google.com (format .ttf)

#### Langkah 2: Buat folder fonts

```
project_flutter/
├── lib/
├── assets/
│   └── fonts/           ← Buat folder ini
│       ├── Poppins-Regular.ttf
│       ├── Poppins-Bold.ttf
│       └── Poppins-Italic.ttf
└── pubspec.yaml
```

#### Langkah 3: Daftarkan di pubspec.yaml

```yaml
flutter:
  uses-material-design: true

  fonts:
    - family: Poppins
      fonts:
        - asset: assets/fonts/Poppins-Regular.ttf
        - asset: assets/fonts/Poppins-Bold.ttf
          weight: 700
        - asset: assets/fonts/Poppins-Italic.ttf
          style: italic
```

#### Langkah 4: Gunakan di kode

```dart
// Per widget
Text(
  'Hello Custom Font!',
  style: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
  ),
)

// Atau set sebagai default di theme
MaterialApp(
  theme: ThemeData(
    fontFamily: 'Poppins',
  ),
  home: MyHomePage(),
)
```

> ⚠️ **Penting**: Setelah mengubah pubspec.yaml, jalankan `flutter pub get` dan restart aplikasi!

---

## 🎨 BAGIAN 7: Theming

### 7.1 Apa itu Theme?

Theme adalah **konfigurasi visual** yang berlaku untuk seluruh aplikasi.

Dengan theme, kamu bisa mengatur:

- Warna utama
- Warna teks
- Font default
- Bentuk tombol
- dan lainnya...

### 7.2 Menggunakan ThemeData

```dart
MaterialApp(
  title: 'My App',
  theme: ThemeData(
    // Warna utama
    primarySwatch: Colors.purple,

    // Gunakan Material Design 3
    useMaterial3: true,

    // Warna background
    scaffoldBackgroundColor: Colors.grey[100],

    // AppBar theme
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    // Text theme
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Colors.black54,
      ),
    ),

    // Button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  ),
  home: HomePage(),
)
```

### 7.3 ColorScheme (Material 3)

```dart
MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
  ),
  home: HomePage(),
)
```

### 7.4 Dark Theme

```dart
MaterialApp(
  theme: ThemeData.light(useMaterial3: true),  // Light theme
  darkTheme: ThemeData.dark(useMaterial3: true), // Dark theme
  themeMode: ThemeMode.system, // Ikuti pengaturan sistem
  home: HomePage(),
)
```

**ThemeMode options:**

- `ThemeMode.light` - Selalu light
- `ThemeMode.dark` - Selalu dark
- `ThemeMode.system` - Ikuti pengaturan HP

### 7.5 Mengakses Theme

```dart
// Di dalam widget
Widget build(BuildContext context) {
  // Akses warna dari theme
  final primaryColor = Theme.of(context).primaryColor;
  final textTheme = Theme.of(context).textTheme;

  return Text(
    'Hello',
    style: textTheme.headlineLarge,
  );
}
```

### 7.6 Contoh Theme Lengkap

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
      title: 'Themed App',
      debugShowCheckedModeBanner: false,

      // Light Theme
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
        ),
      ),

      // Dark Theme
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
        fontFamily: 'Poppins',
      ),

      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: Icon(Icons.star, color: colorScheme.primary),
                title: const Text('Themed Card'),
                subtitle: const Text('Using theme colors'),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Themed Button'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 🎯 PRAKTIKUM: Membuat Halaman Profil

Buat halaman profil dengan kriteria:

### Requirements:

1. AppBar dengan judul "Profil Saya"
2. Foto profil (bisa pakai Icon atau Image.network)
3. Nama dan deskripsi
4. 3-4 info card (email, telepon, alamat, dll)
5. Tombol "Edit Profil" dan "Logout"
6. Gunakan custom theme

### Template Awal:

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
      title: 'Profil App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const ProfilPage(),
    );
  }
}

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // TODO: Foto profil (ClipOval + Icon/Image)

            const SizedBox(height: 16),

            // TODO: Nama

            // TODO: Deskripsi/Bio

            const SizedBox(height: 24),

            // TODO: Info Cards (Email, Phone, Address)

            const SizedBox(height: 24),

            // TODO: Buttons (Edit Profil, Logout)
          ],
        ),
      ),
    );
  }
}

// TODO: Buat widget InfoCard terpisah
class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement card UI
    return Container();
  }
}
```

---

## 📝 LATIHAN

### Latihan 1: StatelessWidget

Buat widget `ProductCard` yang menampilkan:

- Gambar produk (Image.network)
- Nama produk
- Harga
- Tombol "Beli"

### Latihan 2: StatefulWidget

Buat widget `FavoriteButton` yang:

- Menampilkan icon hati
- Icon berubah warna (merah/abu-abu) saat ditekan
- Menampilkan jumlah like

### Latihan 3: Layout

Buat tampilan grid 2 kolom berisi 4-6 kartu produk menggunakan:

- Row dan Column
- Atau coba GridView (bonus)

### Latihan 4: Theme

Buat aplikasi dengan 2 tombol:

- "Light Mode"
- "Dark Mode"
  Yang bisa mengubah tema aplikasi saat ditekan.

---

## 📚 TUGAS MINGGU INI

### Tugas Individu (Deadline: Pertemuan 3)

**Buat Halaman Profil Lengkap dengan kriteria:**

1. ✅ AppBar dengan judul dan action icon
2. ✅ Foto profil (lingkaran) dengan nama dan bio
3. ✅ Minimal 4 info card (email, phone, lokasi, website)
4. ✅ 2 tombol dengan styling berbeda
5. ✅ Menggunakan custom theme (pilih warna favoritmu)
6. ✅ Kode rapi dan ada komentar
7. ✅ Buat sebagai StatelessWidget

**Bonus poin:**

- Menggunakan font custom (+10)
- Menggunakan gambar dari assets (+10)
- Responsive di berbagai ukuran layar (+10)

**Pengumpulan:**

- Upload ke GitHub Classroom
- Format: `NIM_NamaLengkap_Tugas2`

---

## 📖 REFERENSI

### Dokumentasi Widget:

- [Text](https://api.flutter.dev/flutter/widgets/Text-class.html)
- [Container](https://api.flutter.dev/flutter/widgets/Container-class.html)
- [Row](https://api.flutter.dev/flutter/widgets/Row-class.html)
- [Column](https://api.flutter.dev/flutter/widgets/Column-class.html)
- [Stack](https://api.flutter.dev/flutter/widgets/Stack-class.html)

### Tutorial:

- [Flutter Layout Tutorial](https://docs.flutter.dev/ui/layout)
- [Adding Assets](https://docs.flutter.dev/ui/assets-and-images)
- [Theming](https://docs.flutter.dev/cookbook/design/themes)

### Video:

- [Flutter Widget of the Week](https://www.youtube.com/playlist?list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG)

---

## 🚫 BAGIAN 9: Error Umum & Solusinya

### Error Layout

| Error                                            | Penyebab                                      | Solusi                                         |
| ------------------------------------------------ | --------------------------------------------- | ---------------------------------------------- |
| `A RenderFlex overflowed by X pixels`            | Konten lebih panjang dari layar               | Bungkus dengan `SingleChildScrollView`         |
| `Vertical viewport was given unbounded height`   | Column/ListView di dalam Column tanpa batasan | Bungkus dengan `Expanded` atau berikan tinggi  |
| `BoxConstraints forces an infinite width/height` | Widget tidak punya batasan ukuran             | Berikan `width`/`height` atau pakai `Expanded` |

### Error Image

| Error                          | Penyebab                                | Solusi                                               |
| ------------------------------ | --------------------------------------- | ---------------------------------------------------- |
| `Unable to load asset`         | Path asset salah atau belum didaftarkan | Cek path di pubspec.yaml, jalankan `flutter pub get` |
| `Image not found`              | Nama file typo                          | Periksa nama file (case-sensitive!)                  |
| `Network image failed to load` | URL salah atau tidak ada internet       | Tambahkan `errorBuilder` untuk handle error          |

### Error Theme

| Error                            | Penyebab                   | Solusi                               |
| -------------------------------- | -------------------------- | ------------------------------------ |
| `No MediaQuery ancestor found`   | Widget di luar MaterialApp | Pastikan widget di dalam MaterialApp |
| `Theme.of(context) returns null` | Context salah              | Gunakan context dari build method    |

### Error Umum

| Error                                 | Penyebab                                  | Solusi                          |
| ------------------------------------- | ----------------------------------------- | ------------------------------- |
| `setState() called after dispose()`   | Memanggil setState setelah widget dihapus | Cek `mounted` sebelum setState  |
| `The method 'X' was called on null`   | Objek belum diinisialisasi                | Gunakan null safety (`?`, `??`) |
| `'const' keyword cannot be used here` | Nilai tidak compile-time constant         | Hapus `const`                   |

### Contoh Penanganan Error Image

```dart
Image.network(
  'https://example.com/image.jpg',
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return Center(
      child: CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
            : null,
      ),
    );
  },
  errorBuilder: (context, error, stackTrace) {
    return Container(
      color: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.broken_image, size: 50, color: Colors.grey),
          SizedBox(height: 8),
          Text('Gagal memuat gambar'),
        ],
      ),
    );
  },
)
```

### Tips Debugging Layout

```dart
// 1. Gunakan Container dengan border untuk debug
Container(
  decoration: BoxDecoration(
    border: Border.all(color: Colors.red, width: 2),
  ),
  child: YourWidget(),
)

// 2. Gunakan Flutter Inspector di Android Studio
// View → Tool Windows → Flutter Inspector

// 3. Aktifkan debug paint
// Di terminal saat app running, tekan 'p' untuk toggle debug paint
```

---

## ❓ FAQ (Pertanyaan Umum)

**Q: Kenapa muncul garis kuning-hitam di bawah layar?**

> A: Itu "Overflow Error". Konten kamu lebih panjang dari layar. Bungkus Column dengan `SingleChildScrollView`.

**Q: Apa bedanya Container dan SizedBox?**

> A: `SizedBox` hanya untuk ukuran/spacing. `Container` lebih lengkap (warna, border, padding, margin, dll). Gunakan SizedBox jika hanya perlu spacing.

**Q: Kapan pakai Padding widget vs padding di Container?**

> A: Keduanya sama saja. Tapi jika Container sudah ada, gunakan padding di Container. Jika hanya perlu padding, gunakan Padding widget langsung.

**Q: Gambar dari internet tidak muncul, kenapa?**

> A: Cek koneksi internet. Pastikan URL valid. Di Android, pastikan sudah ada permission internet di AndroidManifest.xml (biasanya sudah default).

**Q: Bagaimana membuat gambar berbentuk lingkaran?**

> A: Gunakan `ClipOval` atau `CircleAvatar`. Contoh:
>
> ```dart
> CircleAvatar(
>   radius: 50,
>   backgroundImage: NetworkImage('url'),
> )
> ```

**Q: Apa itu Hot Reload dan Hot Restart?**

> A:
>
> - **Hot Reload (r)**: Update UI tanpa restart, state dipertahankan
> - **Hot Restart (R)**: Restart app, state direset
>   Gunakan Hot Reload untuk perubahan UI, Hot Restart jika ada perubahan di main() atau initState()

**Q: Kenapa font custom saya tidak muncul?**

> A: Checklist:
>
> 1. File .ttf ada di folder yang benar
> 2. Sudah didaftarkan di pubspec.yaml dengan benar
> 3. Sudah run `flutter pub get`
> 4. Sudah restart aplikasi (Hot Restart)
> 5. Nama fontFamily sama persis dengan yang di pubspec

**Q: Apa beda ElevatedButton, TextButton, OutlinedButton?**

> A:
>
> - **ElevatedButton**: Tombol utama, ada bayangan/elevasi
> - **TextButton**: Tombol teks saja, untuk aksi sekunder
> - **OutlinedButton**: Tombol dengan border, alternatif ElevatedButton

---

## 🎯 CHECKLIST SEBELUM PERTEMUAN 3

- [ ] Memahami perbedaan StatelessWidget dan StatefulWidget
- [ ] Bisa menggunakan widget dasar (Text, Container, Image, Icon, Button)
- [ ] Bisa mengatur layout dengan Row, Column, Stack
- [ ] Bisa menambahkan assets (gambar)
- [ ] Bisa menerapkan custom theme
- [ ] Mengumpulkan tugas tepat waktu

---

> 💬 **Pertanyaan?**
>
> Hubungi dosen/asisten via email atau WhatsApp group.
>
> **Selamat belajar! 🚀**

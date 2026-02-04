# 📱 PERTEMUAN 2 - LIVE CODING

## Widget Dasar, Layout & Theming

---

## 🎯 Tujuan Pembelajaran

Setelah mengikuti pertemuan ini, Anda diharapkan mampu:

1. ✅ Memahami perbedaan StatelessWidget dan StatefulWidget
2. ✅ Menggunakan widget dasar Flutter (Text, Container, Image, Icon, Button)
3. ✅ Mengatur layout dengan Row, Column, Stack
4. ✅ Menambahkan assets (gambar dan font custom)
5. ✅ Menerapkan theming pada aplikasi

---

## 📂 RESOURCES

> 💡 **File demo tersedia di folder `contoh_kode/pertemuan_2/`**

| File                             | Topik                                |
| -------------------------------- | ------------------------------------ |
| `01_counter_demo.dart`           | StatelessWidget vs StatefulWidget    |
| `02_widget_dasar_demo.dart`      | Text, Container, Image, Icon, Button |
| `03_layout_demo.dart`            | Row, Column, Stack                   |
| `04_spacing_alignment_demo.dart` | Padding, SizedBox, Expanded          |
| `05_theme_demo.dart`             | ThemeData, Dark/Light Mode           |
| `06_profil_page_lengkap.dart`    | Contoh Jawaban Praktikum             |

---

## ⏱️ TIMELINE SESI (Total: 150 menit)

| Waktu    | Bagian | Topik            | Aktivitas                         |
| -------- | ------ | ---------------- | --------------------------------- |
| 10 menit | Part 0 | Review & Setup   | Quiz cepat + setup project        |
| 20 menit | Part 1 | StatefulWidget   | Counter App - hands-on coding     |
| 30 menit | Part 2 | Widget Dasar     | Build Profile Card step-by-step   |
| 35 menit | Part 3 | Layout Deep Dive | Row, Column, Stack, Expanded      |
| 20 menit | Part 4 | Spacing & Assets | Padding, SizedBox, Images & Fonts |
| 20 menit | Part 5 | Theming          | Transform app dengan theme        |
| 15 menit | Part 6 | Praktikum        | Guided practice                   |

---

## 📋 PERSIAPAN SEBELUM MEMULAI

### ✅ Checklist Persiapan:

- [ ] Flutter SDK OK - jalankan `flutter doctor`
- [ ] Emulator/HP sudah terhubung dan running
- [ ] VS Code terbuka dengan Flutter extension
- [ ] Folder `contoh_kode/pertemuan_2/` siap untuk referensi
- [ ] Koneksi internet stabil (untuk Image.network)

### 🎬 Setup Project Baru:

```bash
# Ketik bersama:
flutter create demo_pertemuan2
cd demo_pertemuan2
code .
```

```bash
# Jalankan aplikasi
flutter run
```

> 💡 **Tips**: Jalankan `flutter run` dulu, nanti gunakan Hot Reload (tekan `r`) untuk update cepat

---

## 🚀 PART 0: Review & Warm Up (10 menit)

### Quiz Cepat (5 menit)

Pertanyaan untuk mengecek pemahaman:

1. ❓ "Apa fungsi `void main()` di Dart?"
2. ❓ "Sebutkan 3 tipe data dasar!"
3. ❓ "Apa itu class dan object?"
4. ❓ "Widget apa yang membungkus aplikasi Flutter?"

### Penjelasan Konsep Dasar (5 menit)

```
📌 KONSEP PENTING PERTEMUAN INI:

Di Flutter, SEMUA yang terlihat adalah WIDGET.

Tombol    → Widget
Teks      → Widget
Gambar    → Widget
Halaman   → Widget (kumpulan widget)
Aplikasi  → Widget (MaterialApp)

Widget = Building Blocks UI
```

---

## 🧩 PART 1: StatefulWidget - Counter App (20 menit)

### 🎯 Tujuan:

Memahami kapan dan bagaimana menggunakan StatefulWidget

### ✏️ CODING BERSAMA:

**� LANGKAH**: "Hapus semua kode default dan mulai dari 0. Mari kita ketik dari awal!"

#### Step 1: Hapus semua isi `lib/main.dart`

```dart
// Ketik dari awal, jangan copy-paste!
import 'package:flutter/material.dart';

void main() {
  // Entry point - fungsi pertama yang dijalankan
  runApp(MyApp());
}

// MyApp = widget root aplikasi
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pertemuan 2',
      home: CounterPage(),
    );
  }
}
```

**🤔 PIKIRKAN**: "Apa fungsi `runApp()`?" → Jawaban: Menjalankan widget root

#### Step 2: Buat StatefulWidget

```dart
// STATEFULWIDGET = Widget yang datanya BISA BERUBAH
class CounterPage extends StatefulWidget {
  @override
  State<CounterPage> createState() => _CounterPageState();
}

// State = tempat menyimpan data yang bisa berubah
class _CounterPageState extends State<CounterPage> {
  // DATA (state) - angka counter
  int _counter = 0;

  // Method untuk tambah counter
  void _increment() {
    // setState() = beritahu Flutter untuk UPDATE tampilan
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter Demo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Anda menekan tombol sebanyak:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '$_counter',  // $ untuk interpolasi variabel
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        child: Icon(Icons.add),
        tooltip: 'Tambah',
      ),
    );
  }
}
```

### ⚡ HOT RELOAD:

Tekan `r` di terminal → Lihat hasilnya!

### 🎯 EKSPERIMEN 1: Apa yang terjadi tanpa setState()?

**💡 PENTING**: "Mari kita coba hapus setState dan lihat apa yang terjadi"

```dart
void _increment() {
  // Hapus setState() dulu
  _counter++;  // Hanya ini
}
```

**Hot Reload** → Tekan tombol → **Angka TIDAK berubah!**

**💡 PENTING**:

> "Tanpa `setState()`, Flutter tidak tahu harus update UI. Data berubah tapi tampilan tidak!"

**Kembalikan setState()**:

```dart
void _increment() {
  setState(() {
    _counter++;
  });
}
```

### 🎯 EKSPERIMEN 2: Tambah tombol decrement

**🤔 PIKIRKAN**: "Bagaimana kalau kita tambah tombol kurang?"

```dart
// Tambah method baru
void _decrement() {
  setState(() {
    if (_counter > 0) _counter--;
  });
}

// Di floatingActionButton, ganti jadi Row:
floatingActionButton: Padding(
  padding: const EdgeInsets.only(left: 32),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      FloatingActionButton(
        onPressed: _decrement,
        child: Icon(Icons.remove),
        heroTag: 'decrement',
      ),
      FloatingActionButton(
        onPressed: _increment,
        child: Icon(Icons.add),
        heroTag: 'increment',
      ),
    ],
  ),
),
```

**Hot Reload** → Test kedua tombol!

### 💡 Kapan Pakai StatefulWidget vs StatelessWidget?

```
Pertanyaan: "Apakah data dalam widget ini BERUBAH?"

         │
         ▼
    ┌────────┐
    │  YA?   │
    └────────┘
     /      \
   YA        TIDAK
    │          │
    ▼          ▼
StatefulWidget  StatelessWidget
```

**Contoh:**

- ✅ **Stateful**: Counter, Form, Checkbox, Animation
- ✅ **Stateless**: Text statis, Icon, Logo, About page

---

## 🎨 PART 2: Widget Dasar - Build Profile Card (30 menit)

### 🎯 Tujuan:

Menguasai Text, Container, Image, Icon, Button

### ✏️ Buat Halaman Baru

**Step 1: Tambah widget ProfilCard sebagai halaman baru**

Ubah `home:` di MaterialApp:

```dart
home: ProfilCardDemo(),
```

**Step 2: Buat StatelessWidget baru**

```dart
class ProfilCardDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Dasar'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kita akan isi step by step
          ],
        ),
      ),
    );
  }
}
```

**📝 CATATAN**: "SingleChildScrollView membuat konten bisa di-scroll kalau panjang"

### 📝 Demo 1: Text Widget

Tambahkan di dalam Column children:

```dart
// 1. TEXT WIDGET
Text('Halo Dunia!'),

SizedBox(height: 10),

Text(
  'Teks dengan Style',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
),

SizedBox(height: 10),

Text(
  'Teks dengan berbagai gaya: italic, underline',
  style: TextStyle(
    fontSize: 16,
    fontStyle: FontStyle.italic,
    decoration: TextDecoration.underline,
    letterSpacing: 1.5,
  ),
),

SizedBox(height: 20),
```

**Hot Reload** → Lihat hasilnya!

**🎯 EKSPERIMEN**: Ubah warna dari `Colors.blue` ke `Colors.purple` → Hot Reload

### 📝 Demo 2: Container Widget

```dart
// 2. CONTAINER WIDGET
Container(
  width: double.infinity,
  height: 100,
  color: Colors.orange,
  child: Center(
    child: Text(
      'Container Sederhana',
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
  ),
),

SizedBox(height: 20),

// Container dengan decoration (lebih keren!)
Container(
  width: double.infinity,
  padding: EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
    border: Border.all(color: Colors.white, width: 3),
  ),
  child: Column(
    children: [
      Text(
        'Container dengan Decoration',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 8),
      Text(
        'Border radius + Shadow + Border',
        style: TextStyle(color: Colors.white70),
      ),
    ],
  ),
),

SizedBox(height: 20),
```

**� PENTING**:

> "Container itu seperti kotak serbaguna. Bisa atur ukuran, warna, border, shadow, padding!"

**Visualisasi Margin vs Padding:**

```
┌─────────────────────────────┐
│         MARGIN              │  ← Jarak ke LUAR
│  ┌───────────────────────┐  │
│  │       BORDER          │  │
│  │  ┌─────────────────┐  │  │
│  │  │    PADDING      │  │  │  ← Jarak ke DALAM
│  │  │  ┌───────────┐  │  │  │
│  │  │  │  CONTENT  │  │  │  │
│  │  │  └───────────┘  │  │  │
│  │  └─────────────────┘  │  │
│  └───────────────────────┘  │
└─────────────────────────────┘
```

### 📝 Demo 3: Image Widget

```dart
// 3. IMAGE WIDGET
Text(
  'Image dari Internet:',
  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
),

SizedBox(height: 10),

ClipRRect(
  borderRadius: BorderRadius.circular(12),
  child: Image.network(
    'https://picsum.photos/400/200',
    width: double.infinity,
    height: 200,
    fit: BoxFit.cover,
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) return child;
      return Container(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    },
    errorBuilder: (context, error, stackTrace) {
      return Container(
        height: 200,
        color: Colors.grey[300],
        child: Center(
          child: Icon(Icons.broken_image, size: 50),
        ),
      );
    },
  ),
),

SizedBox(height: 20),
```

**� PENTING**:

> "Image.network untuk gambar dari internet. Ada loadingBuilder untuk tampilan saat loading!"

### 📝 Demo 4: Icon & CircleAvatar

```dart
// 4. ICON & CIRCLE AVATAR
Text(
  'Icon & Avatar:',
  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
),

SizedBox(height: 10),

Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Icon(Icons.home, size: 40, color: Colors.blue),
    Icon(Icons.favorite, size: 40, color: Colors.red),
    Icon(Icons.star, size: 40, color: Colors.amber),
    Icon(Icons.settings, size: 40, color: Colors.grey),
  ],
),

SizedBox(height: 20),

// CircleAvatar
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    CircleAvatar(
      radius: 30,
      backgroundColor: Colors.purple,
      child: Icon(Icons.person, size: 30, color: Colors.white),
    ),
    CircleAvatar(
      radius: 30,
      backgroundImage: NetworkImage('https://picsum.photos/100/100'),
    ),
    CircleAvatar(
      radius: 30,
      backgroundColor: Colors.green,
      child: Text(
        'AB',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    ),
  ],
),

SizedBox(height: 20),
```

### 📝 Demo 5: Button Widgets

```dart
// 5. BUTTON WIDGETS
Text(
  'Berbagai Jenis Button:',
  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
),

SizedBox(height: 10),

// ElevatedButton
ElevatedButton(
  onPressed: () {
    print('ElevatedButton ditekan!');
  },
  child: Text('ElevatedButton'),
),

SizedBox(height: 10),

// ElevatedButton dengan icon
ElevatedButton.icon(
  onPressed: () {},
  icon: Icon(Icons.send),
  label: Text('Kirim Pesan'),
),

SizedBox(height: 10),

// TextButton
TextButton(
  onPressed: () {},
  child: Text('TextButton (Aksi Sekunder)'),
),

SizedBox(height: 10),

// OutlinedButton
OutlinedButton(
  onPressed: () {},
  child: Text('OutlinedButton (Alternatif)'),
),

SizedBox(height: 10),

// Custom styled button
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.deepPurple,
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  child: Text('Custom Button'),
),

SizedBox(height: 10),

// IconButton
IconButton(
  onPressed: () {},
  icon: Icon(Icons.favorite),
  color: Colors.red,
  iconSize: 32,
),
```

**🎯 CHALLENGE**: "Coba ubah warna button dari purple ke warna favorit kalian!"

### 📝 Demo 6: Card & ListTile

**📝 CATATAN**: "Card itu seperti kartu informasi. ListTile memudahkan kita susun isi card!"

```dart
// 6. CARD & LISTTILE
Text(
  'Card & ListTile:',
  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
),

SizedBox(height: 10),

// Card sederhana
Card(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('Ini adalah Card sederhana'),
  ),
),

SizedBox(height: 10),

// Card dengan ListTile
Card(
  elevation: 4,  // Tinggi bayangan (shadow)
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  child: ListTile(
    leading: CircleAvatar(
      backgroundColor: Colors.blue,
      child: Icon(Icons.person, color: Colors.white),
    ),
    title: Text(
      'Nama Mahasiswa',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    subtitle: Text('NIM: 123456789'),
    trailing: Icon(Icons.arrow_forward_ios, size: 16),
    onTap: () {
      print('Card ditekan!');
    },
  ),
),

SizedBox(height: 10),

// Card dengan info lebih lengkap
Card(
  child: Column(
    children: [
      ListTile(
        leading: Icon(Icons.email, color: Colors.blue),
        title: Text('Email'),
        subtitle: Text('mahasiswa@example.com'),
      ),
      Divider(height: 1),  // Garis pemisah
      ListTile(
        leading: Icon(Icons.phone, color: Colors.green),
        title: Text('Telepon'),
        subtitle: Text('+62 812-3456-7890'),
      ),
      Divider(height: 1),
      ListTile(
        leading: Icon(Icons.location_on, color: Colors.red),
        title: Text('Alamat'),
        subtitle: Text('Jakarta, Indonesia'),
      ),
    ],
  ),
),
```

**Visualisasi ListTile:**

```
┌────────────────────────────────────────┐
│ [Leading]  Title              [Trailing]│
│            Subtitle                     │
└────────────────────────────────────────┘

Leading  = Widget di kiri (biasanya icon/avatar)
Title    = Text utama
Subtitle = Text sekunder (opsional)
Trailing = Widget di kanan (biasanya icon/button)
```

**🎯 EKSPERIMEN**: Klik card dan lihat console output `print()`!

### 💡 Kapan Pakai `const`?

**💡 PENTING**: "`const` itu untuk optimasi. Memberitahu Flutter: widget ini tidak akan berubah!"

```dart
// ✅ PAKAI const - nilai tidak pernah berubah
const Text('Hello World')  // Teks selalu sama
const Icon(Icons.home)     // Icon selalu sama
const SizedBox(height: 20) // Ukuran selalu sama

// ❌ JANGAN pakai const - nilai bisa berubah
Text(namaUser)             // namaUser bisa beda-beda
Text('$_counter')          // _counter berubah
Icon(iconDariVariabel)     // icon dari variabel
```

**Aturan Sederhana:**

- Kalau IDE kasih garis biru di bawah widget → tambahkan `const`
- Kalau ada variabel/data yang berubah → jangan pakai `const`
- Kalau ragu → biarkan saja (program tetap jalan, cuma lebih lambat dikit)

**📝 CATATAN**: "`const` itu seperti foto KTP. Sekali dibuat, tidak berubah. Tapi umur di KTP vs umur sebenarnya bisa beda!"

---

## 📐 PART 3: Layout Deep Dive (35 menit)

### 🎯 Tujuan:

Menguasai Row, Column, Stack, Expanded, Positioned

**� PENTING**:

- **Column** = Susun vertikal, seperti tumpukan buku
- **Row** = Susun horizontal, seperti barisan orang
- **Stack** = Tumpuk seperti kartu remi
- **Expanded** = Rebutan ruang, yang dapat flex lebih banyak dapat bagian lebih besar

### Buat Halaman Layout Demo:

```dart
// Di MaterialApp, ganti home jadi:
home: LayoutDemo(),
```

### ✏️ CODING: Column & Row

```dart
class LayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Layout Demo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === SECTION 1: COLUMN ===
            Text(
              '1. COLUMN (Vertikal)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(height: 50, color: Colors.red, child: Center(child: Text('Item 1'))),
                  SizedBox(height: 10),
                  Container(height: 50, color: Colors.green, child: Center(child: Text('Item 2'))),
                  SizedBox(height: 10),
                  Container(height: 50, color: Colors.blue, child: Center(child: Text('Item 3'))),
                ],
              ),
            ),

            SizedBox(height: 30),

            // === SECTION 2: ROW ===
            Text(
              '2. ROW (Horizontal)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.home, size: 50, color: Colors.blue),
                  Icon(Icons.search, size: 50, color: Colors.green),
                  Icon(Icons.person, size: 50, color: Colors.orange),
                  Icon(Icons.settings, size: 50, color: Colors.purple),
                ],
              ),
            ),

            SizedBox(height: 30),

            // === SECTION 3: MainAxisAlignment ===
            Text(
              '3. MainAxisAlignment',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            _buildAlignmentDemo('start', MainAxisAlignment.start),
            SizedBox(height: 10),
            _buildAlignmentDemo('center', MainAxisAlignment.center),
            SizedBox(height: 10),
            _buildAlignmentDemo('end', MainAxisAlignment.end),
            SizedBox(height: 10),
            _buildAlignmentDemo('spaceBetween', MainAxisAlignment.spaceBetween),
            SizedBox(height: 10),
            _buildAlignmentDemo('spaceEvenly', MainAxisAlignment.spaceEvenly),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildAlignmentDemo(String label, MainAxisAlignment alignment) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: alignment,
        children: [
          Container(width: 50, height: 40, color: Colors.red, child: Center(child: Text('1'))),
          Container(width: 50, height: 40, color: Colors.green, child: Center(child: Text('2'))),
          Container(width: 50, height: 40, color: Colors.blue, child: Center(child: Text('3'))),
        ],
      ),
    );
  }
}
```

**🤔 PIKIRKAN**: "Apa bedanya spaceBetween dan spaceEvenly?"

**Hot Reload** → Lihat perbedaannya!

**💡 PENJELASAN**:

- **start**: Mulai dari kiri (Row) atau atas (Column)
- **center**: Di tengah-tengah
- **end**: Di ujung kanan (Row) atau bawah (Column)
- **spaceBetween**: Jarak HANYA di antara item, tidak di pinggir
- **spaceAround**: Jarak di antara DAN sedikit di pinggir
- **spaceEvenly**: Jarak SAMA RATA di semua tempat

**📢 ANALOGI**:

> "Bayangkan 3 orang berdiri di ruangan:
>
> - **start**: Ketiga orang berkumpul di pojok kiri
> - **spaceBetween**: Orang 1 di kiri mentok, orang 3 di kanan mentok, orang 2 di tengah
> - **spaceEvenly**: Ketiga orang dengan jarak yang sama persis"

### ✏️ Demo Stack

Tambahkan di Column children:

```dart
// === SECTION 4: STACK ===
Text(
  '4. STACK (Tumpukan)',
  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
),
SizedBox(height: 10),

Container(
  width: double.infinity,
  height: 250,
  child: Stack(
    children: [
      // Layer 1 (paling bawah)
      Container(
        width: 200,
        height: 200,
        color: Colors.blue,
      ),
      // Layer 2
      Positioned(
        top: 50,
        left: 50,
        child: Container(
          width: 150,
          height: 150,
          color: Colors.red,
        ),
      ),
      // Layer 3 (paling atas)
      Positioned(
        top: 100,
        left: 100,
        child: Container(
          width: 100,
          height: 100,
          color: Colors.yellow,
        ),
      ),
      // Text di pojok kanan atas
      Positioned(
        top: 10,
        right: 10,
        child: Icon(Icons.favorite, color: Colors.white, size: 30),
      ),
      // Text di tengah
      Center(
        child: Text(
          'CENTER',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  ),
),

SizedBox(height: 30),
```

**💡 PENTING**:

> "Stack seperti tumpukan kertas. Yang ditulis terakhir ada di paling atas! Positioned untuk atur posisi absolut."

**Visualisasi Stack:**

```
Tampak dari depan:          Tampak dari samping:

┌────────────────────┐      ┌─ Yellow (atas)
│  Blue              │      ├─ Red (tengah)
│   ┌──────────────┐ │      └─ Blue (bawah)
│   │ Red          │ │
│   │  ┌────────┐  │ │      Yang terakhir di kode
│   │  │ Yellow │  │ │      = paling atas di layar!
│   │  └────────┘  │ │
│   └──────────────┘ │
└────────────────────┘
```

> ⚠️ **CATATAN PENTING**:
>
> - Urutan widget di Stack = urutan layer (pertama = bawah, terakhir = atas)
> - Positioned harus di dalam Stack, atau akan error!
> - Kalau tidak pakai Positioned, widget akan otomatis di pojok kiri atas

### ✏️ Demo Expanded & Flexible

```dart
// === SECTION 5: EXPANDED ===
Text(
  '5. EXPANDED (Membagi Ruang)',
  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
),
SizedBox(height: 10),

Text('Tanpa Expanded:'),
Row(
  children: [
    Container(width: 50, height: 50, color: Colors.red),
    Container(width: 50, height: 50, color: Colors.blue),
    Container(width: 50, height: 50, color: Colors.green),
  ],
),

SizedBox(height: 10),

Text('Dengan Expanded:'),
Row(
  children: [
    Container(width: 50, height: 50, color: Colors.red),
    Expanded(
      child: Container(height: 50, color: Colors.blue, child: Center(child: Text('EXPANDED'))),
    ),
    Container(width: 50, height: 50, color: Colors.green),
  ],
),

SizedBox(height: 10),

Text('Expanded dengan flex ratio (1:2:1):'),
Row(
  children: [
    Expanded(
      flex: 1,
      child: Container(height: 50, color: Colors.red, child: Center(child: Text('1'))),
    ),
    Expanded(
      flex: 2,
      child: Container(height: 50, color: Colors.blue, child: Center(child: Text('2'))),
    ),
    Expanded(
      flex: 1,
      child: Container(height: 50, color: Colors.green, child: Center(child: Text('1'))),
    ),
  ],
),

SizedBox(height: 30),
```

**📢 JELASKAN**:

> "Expanded membagi ruang yang tersisa. Flex menentukan berapa bagian yang didapat."

**📢 ANALOGI**:

> "Bayangkan 3 anak rebutan pizza:
>
> - Tanpa Expanded: Masing-masing dapat 1 slice, sisanya terbuang
> - Dengan Expanded: Semua pizza dibagi habis!
> - Dengan flex: Anak 1 dapat 1 bagian, anak 2 dapat 2 bagian (lebih besar), anak 3 dapat 1 bagian
>   Total flex = 1+2+1 = 4 bagian, anak 2 dapat 2/4 = setengah pizza!"

**Visualisasi Expanded:**

```
Tanpa Expanded:
┌────┬────┬────┬─────────────────┐
│Red │Blue│Grn │ (ruang kosong)  │
└────┴────┴────┴─────────────────┘
 50   50   50   sisanya tidak terpakai

Dengan Expanded (semua ruang terpakai):
┌────┬──────────────────────────┬────┐
│Red │         Blue             │Grn │
└────┴──────────────────────────┴────┘
 50   expanded (otomatis)        50

Dengan flex ratio 1:2:1 (ruang dibagi proporsional):
┌──────┬────────────────┬──────┐
│ Red  │      Blue      │Green │
│ 1/4  │      2/4       │ 1/4  │
└──────┴────────────────┴──────┘
Red 25% Blue 50% Green 25%
```

> ⚠️ **HATI-HATI**:
>
> - Expanded hanya bisa di dalam Row, Column, atau Flex!
> - Jangan pakai width di widget yang sudah di-Expanded
> - Kalau error "RenderFlex children have non-zero flex" → cek Expanded di tempat yang salah

### ✏️ Demo Spacer & Align

```dart
// === SECTION 6: SPACER & ALIGN ===
Text(
  '6. SPACER & ALIGN',
  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
),
SizedBox(height: 10),

Container(
  width: double.infinity,
  height: 60,
  color: Colors.grey[200],
  child: Row(
    children: [
      Text('Left'),
      Spacer(),
      Text('Right'),
    ],
  ),
),

SizedBox(height: 10),

Container(
  width: double.infinity,
  height: 100,
  color: Colors.blue[50],
  child: Align(
    alignment: Alignment.topRight,
    child: Container(
      padding: EdgeInsets.all(8),
      color: Colors.red,
      child: Text('Top Right', style: TextStyle(color: Colors.white)),
    ),
  ),
),
```

---

## 📏 PART 4: Spacing & Assets (20 menit)

### ✏️ Demo Spacing

```dart
// Buat halaman baru atau tambahkan di layout demo

// === PADDING ===
Text(
  'Padding Demo',
  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
),
SizedBox(height: 10),

Container(
  color: Colors.yellow,
  child: Padding(
    padding: EdgeInsets.all(20),
    child: Container(
      color: Colors.blue,
      child: Text('Padding 20 semua sisi'),
    ),
  ),
),

SizedBox(height: 10),

Container(
  color: Colors.yellow,
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
    child: Container(
      color: Colors.green,
      child: Text('Padding H:40 V:10'),
    ),
  ),
),

SizedBox(height: 10),

Container(
  color: Colors.yellow,
  child: Padding(
    padding: EdgeInsets.only(left: 50, top: 10),
    child: Container(
      color: Colors.red,
      child: Text('Padding Left:50 Top:10'),
    ),
  ),
),
```

### 🖼️ Menambahkan Assets (Demonstrasi Live)

**📢 JELASKAN**: "Sekarang kita akan menambahkan gambar dari folder lokal"

#### Step 1: Buat folder assets

```bash
# Di terminal VS Code:
mkdir assets
mkdir assets\images
```

#### Step 2: Download gambar sample

**� LANGKAH**: Buka browser → https://picsum.photos → Download 1 gambar → Simpan di `assets/images/` sebagai `sample.jpg`

#### Step 3: Edit `pubspec.yaml`

**� CATATAN**: "File pubspec.yaml adalah konfigurasi project kita"

Cari baris `flutter:` dan tambahkan:

```yaml
flutter:
  uses-material-design: true

  # Tambahkan ini:
  assets:
    - assets/images/
```

**PENTING**: Perhatikan indentasi (2 spasi)!

#### Step 4: Jalankan flutter pub get

```bash
flutter pub get
```

#### Step 5: Gunakan di kode

```dart
Image.asset(
  'assets/images/sample.jpg',
  width: 200,
  height: 200,
  fit: BoxFit.cover,
)
```

**Hot Restart** (tekan `R` di terminal, bukan `r`)

**� PENTING**: "Untuk assets, harus Hot Restart, bukan Hot Reload!"

### 🔤 Font Custom (Optional)

```yaml
# Di pubspec.yaml
fonts:
  - family: Poppins
    fonts:
      - asset: assets/fonts/Poppins-Regular.ttf
      - asset: assets/fonts/Poppins-Bold.ttf
        weight: 700
```

**Catatan**: Section ini opsional dan bisa dipelajari mandiri jika waktu terbatas.

> ⚠️ **TROUBLESHOOTING ASSETS**:
>
> **Problem: "Unable to load asset"**
>
> - ✅ Cek path di `pubspec.yaml` (huruf besar/kecil penting!)
> - ✅ Pastikan indentasi benar (2 spasi)
> - ✅ Jalankan `flutter pub get`
> - ✅ Hot **Restart** (R), bukan Hot Reload (r)
>
> **Problem: "No file or directory"**
>
> - ✅ Pastikan file ada di folder yang benar
> - ✅ Nama file sama persis (case-sensitive!)
>
> **� CATATAN**:
>
> > "Assets seperti foto di album. Kalau fotonya belum ditempel (pub get), dan album belum dibuka ulang (restart), kamu tidak bisa lihat fotonya!"

---

## 🎨 PART 5: Theming (20 menit)

### 🎯 Tujuan:

Mengubah tampilan seluruh app dengan theme

**� PENTING**:

> "Theme itu seperti filter Instagram. Sekali pilih, seluruh foto pake filter yang sama. Ga perlu edit satu-satu!"

### ✏️ Basic Theme

**� CATATAN**: "Theme itu seperti template warna untuk seluruh app!"

Di MaterialApp, tambahkan theme:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pertemuan 2',

      // THEME - Atur tampilan app
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),

        // AppBar theme
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),

        // Card theme
        cardTheme: CardTheme(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      home: LayoutDemo(),
    );
  }
}
```

**Hot Reload** → Lihat perubahan warna!

### 🎯 EKSPERIMEN: Ganti Seed Color

**📢 TANYA**: "Apa warna favorit kalian?"

Coba ganti-ganti:

- `Colors.deepPurple` → `Colors.teal`
- `Colors.teal` → `Colors.orange`
- `Colors.orange` → `Colors.pink`

**Hot Reload setiap kali** → Lihat seluruh app berubah warna!

### ✏️ Dark Theme

```dart
return MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
  ),

  // DARK THEME
  darkTheme: ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
  ),

  // Mode: system = ikuti pengaturan HP
  themeMode: ThemeMode.system,

  home: LayoutDemo(),
);
```

**� PERHATIKAN**: Ubah dark mode di HP → App ikut berubah!

### ✏️ Mengakses Theme di Widget

```dart
Widget build(BuildContext context) {
  // Ambil theme dari context
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;

  return Container(
    color: colorScheme.primaryContainer,
    child: Text(
      'Menggunakan theme color',
      style: theme.textTheme.headlineMedium,
    ),
  );
}
```

---

## 🎯 PART 6: Praktikum Terpandu (15 menit)

### 🎯 Tugas: Buat Halaman Profil Sederhana

**🎯 LATIHAN**: "Sekarang kita coding bersama untuk membuat halaman profil!"

### Template Awal:

```dart
class ProfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Saya'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // STEP 1: Foto Profil
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage('https://picsum.photos/200/200'),
            ),

            SizedBox(height: 16),

            // STEP 2: Nama
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            // STEP 3: Bio
            Text(
              'Flutter Developer | Tech Enthusiast',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),

            SizedBox(height: 24),

            // STEP 4: Info Cards
            _buildInfoCard(
              icon: Icons.email,
              title: 'Email',
              value: 'john.doe@example.com',
            ),

            SizedBox(height: 12),

            _buildInfoCard(
              icon: Icons.phone,
              title: 'Telepon',
              value: '+62 812-3456-7890',
            ),

            SizedBox(height: 12),

            _buildInfoCard(
              icon: Icons.location_on,
              title: 'Lokasi',
              value: 'Jakarta, Indonesia',
            ),

            SizedBox(height: 12),

            _buildInfoCard(
              icon: Icons.web,
              title: 'Website',
              value: 'www.johndoe.com',
            ),

            SizedBox(height: 24),

            // STEP 5: Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                    label: Text('Edit Profil'),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.logout),
                    label: Text('Logout'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
```

**✏️ CODING BERSAMA**: Ketik bersama step by step

**Hot Reload** setelah setiap section!

### 🎯 Challenge:

"Sekarang customisasi dengan data kalian sendiri!"

1. Ganti nama dan bio
2. Ganti info card dengan data kalian
3. Ganti warna theme
4. Tambah 1 info card baru (misal: Instagram, GitHub)

**⏱️ Waktu eksperimen: 5 menit**

---

## 📝 PENUTUP & TUGAS

### 📚 TUGAS MINGGU INI

**Buat Halaman Profil Lengkap dengan kriteria:**

✅ **Wajib:**

1. AppBar dengan judul dan action icon
2. Foto profil lingkaran dengan nama dan bio
3. Minimal 4 info card (email, phone, lokasi, dll)
4. 2 tombol dengan styling berbeda
5. Menggunakan custom theme
6. Kode rapi dan ada komentar
7. Buat sebagai StatelessWidget

🌟 **Bonus Poin:**

- Menggunakan font custom (+10)
- Menggunakan gambar dari assets (+10)
- Tambah animasi sederhana (+10)

**Deadline: Pertemuan 3**

**Pengumpulan:**

- Upload ke GitHub Classroom
- Format: `NIM_NamaLengkap_Tugas2`

---

## 🚫 ERROR UMUM & SOLUSI

### 🐛 Error yang Sering Muncul:

| Error                               | Penyebab                          | Solusi                                 |
| ----------------------------------- | --------------------------------- | -------------------------------------- |
| `RenderFlex overflowed`             | Konten lebih panjang dari layar   | Bungkus dengan `SingleChildScrollView` |
| `Unable to load asset`              | Path salah di pubspec.yaml        | Cek path, jalankan `flutter pub get`   |
| `setState() called after dispose()` | setState setelah widget dihapus   | Cek `mounted` sebelum setState         |
| `const cannot be used`              | Nilai tidak compile-time constant | Hapus `const`                          |

### 💡 Tips Debugging:

```dart
// 1. Gunakan Container dengan border
Container(
  decoration: BoxDecoration(
    border: Border.all(color: Colors.red, width: 2),
  ),
  child: YourWidget(),
)

// 2. Print untuk debug
print('Nilai counter: $_counter');

// 3. Gunakan Flutter Inspector
// View → Tool Windows → Flutter Inspector
```

---

## ❓ FAQ

**Q: Kenapa muncul garis kuning-hitam?**

> A: Overflow error. Bungkus dengan `SingleChildScrollView`

**Q: Hot Reload vs Hot Restart?**

> A:
>
> - Hot Reload (r) = Update UI, state dipertahankan
> - Hot Restart (R) = Restart app, state direset

**Q: Kapan pakai Container vs SizedBox?**

> A: SizedBox hanya untuk ukuran/spacing. Container lebih lengkap.

**Q: Image dari internet tidak muncul?**

> A: Cek koneksi internet dan URL valid.

---

## ✅ CHECKLIST SEBELUM PERTEMUAN 3

- [ ] Memahami perbedaan StatelessWidget dan StatefulWidget
- [ ] Bisa menggunakan widget dasar (Text, Container, Image, Icon, Button)
- [ ] Bisa mengatur layout dengan Row, Column, Stack
- [ ] Memahami Expanded dan Flexible
- [ ] Bisa menambahkan assets (gambar)
- [ ] Bisa menerapkan custom theme
- [ ] Mengumpulkan tugas tepat waktu

---

## 📖 REFERENSI

### Dokumentasi:

- [Flutter Widget Catalog](https://docs.flutter.dev/ui/widgets)
- [Layout Tutorial](https://docs.flutter.dev/ui/layout)
- [Adding Assets](https://docs.flutter.dev/ui/assets-and-images)
- [Theming](https://docs.flutter.dev/cookbook/design/themes)

### Video:

- [Flutter Widget of the Week](https://www.youtube.com/playlist?list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG)

---

## 📚 BAGIAN UNTUK PENGAJAR

> ℹ️ **Catatan**: Bagian ini berisi panduan khusus untuk pengajar/dosen. Mahasiswa yang belajar mandiri bisa skip ke checklist persiapan pertemuan berikutnya.

---

## 💬 PERTANYAAN INTERAKTIF SELAMA KELAS

Pertanyaan untuk mengecek pemahaman:

1. ❓ "Apa bedanya StatelessWidget dan StatefulWidget?"
2. ❓ "Kenapa harus pakai setState()?"
3. ❓ "Row vs Column, apa bedanya?"
4. ❓ "Stack itu seperti apa dalam kehidupan nyata?"
5. ❓ "Kapan pakai Expanded?"
6. ❓ "Apa fungsi Theme dalam Flutter?"
7. ❓ "Kapan pakai Hot Reload vs Hot Restart?"

---

## 💡 TIPS MENGAJAR

### ✅ DO (Lakukan):

- **Ketik manual**, jangan copy-paste → Mahasiswa ikut mikir
- **Buat kesalahan sengaja** lalu debug bersama → Belajar dari error
- **Tanya mahasiswa prediksi**: "Menurutmu apa yang terjadi kalau...?" → Active learning
- **Hot Reload sering-sering** → Instant feedback
- **Beri waktu eksperimen** → Hands-on practice
- **Gunakan analogi sederhana** → Pizza, poster, Instagram filter, dll
- **Ulangi konsep penting** → Repetition is key
- **Tunjukkan console/terminal** → Mahasiswa lihat cara debugging

### ❌ DON'T (Jangan):

- **Terlalu cepat** → Mahasiswa ketinggalan
- **Skip penjelasan saat error** → Miss learning opportunity
- **Abaikan pertanyaan** → Mahasiswa jadi takut bertanya
- **Langsung kasih jawaban** → Bimbing mereka menemukan sendiri
- **Pakai istilah terlalu teknis** → Gunakan bahasa sehari-hari dulu

### 🎯 Tips Praktis untuk Kelas:

**Dealing dengan Mahasiswa Ketinggalan:**

1. Pause sebentar → Tanya "Ada yang belum selesai?"
2. Pair programming → Yang cepat bantu yang lambat
3. Sediakan completed code di file demo untuk catch up

**Contoh Pertanyaan Interaktif:**

- "Widget apa yang kalian sudah coba?"
- "Kenapa pakai StatefulWidget di sini, bukan Stateless?"
- "Kapan sebaiknya pakai Expanded vs SizedBox?"

**Phrases yang Membantu:**

- Saat ada error: "Bagus! Error itu guru terbaik. Mari kita baca pesannya..."
- Saat mahasiswa stuck: "Coba lihat baris X, apa yang berbeda?"
- Saat menjelaskan: "Analoginya seperti... [gunakan analogi sehari-hari]"

---

> 🚀 **Selamat Mengajar! Semoga sesi live coding menyenangkan dan efektif!**
>
> 💬 Jika ada pertanyaan dari mahasiswa di luar materi, catat dan jawab di pertemuan berikutnya.

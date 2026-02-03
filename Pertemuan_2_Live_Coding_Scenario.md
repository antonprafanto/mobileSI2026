# 🎓 Pertemuan 2 - Skenario Live Coding

## Widget Dasar, Layout & Theming

Panduan step-by-step untuk demonstrasi di kelas (~60 menit).

---

## 📋 Sebelum Kelas

### Persiapan Wajib

- [ ] Flutter SDK OK (`flutter doctor` tidak error)
- [ ] Emulator/HP sudah terhubung
- [ ] Buka folder `contoh_kode/pertemuan_2/` sebagai referensi

### Buat Proyek Baru di Depan Mahasiswa

```bash
flutter create demo_kelas
cd demo_kelas
code .        # Buka di VS Code
flutter run   # Jalankan
```

> 💡 **Tips**: Jalankan `flutter run` dulu, nanti gunakan Hot Reload untuk update

---

## 🎬 SKENARIO LIVE CODING

## Part 1: Counter App - StatefulWidget (15 menit)

### ✏️ Yang Diketik:

**Hapus semua isi `lib/main.dart`, ketik dari awal:**

```dart
import 'package:flutter/material.dart';

void main() {
  // Ini adalah entry point - fungsi pertama yang dijalankan
  runApp(MyApp());
}

// MyApp adalah widget root (akar) aplikasi kita
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterPage(), // Halaman utama
    );
  }
}
```

> 📢 **Jelaskan**: "Setiap app Flutter dimulai dari `main()` yang memanggil `runApp()`"

**Lanjutkan ketik:**

```dart
// STATEFULWIDGET = Widget yang datanya bisa berubah
class CounterPage extends StatefulWidget {
  @override
  State<CounterPage> createState() => _CounterPageState();
}

// State = tempat menyimpan data yang bisa berubah
class _CounterPageState extends State<CounterPage> {
  // Ini adalah DATA (state) - angka counter
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter Demo')),
      body: Center(
        // Menampilkan nilai counter
        child: Text(
          '$counter',  // $ untuk memasukkan variabel ke string
          style: TextStyle(fontSize: 80),
        ),
      ),
      // Tombol mengambang di pojok kanan bawah
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // setState() = beritahu Flutter untuk update tampilan
          setState(() {
            counter = counter + 1;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
```

### 🎯 Eksperimen Bersama Mahasiswa:

1. **Tekan tombol +** → Angka bertambah
2. **Hapus `setState()`** → Tekan tombol, angka tidak update!
3. **Kembalikan `setState()`** → Berfungsi lagi

> 📢 **Jelaskan**: "Tanpa setState(), Flutter tidak tahu harus update tampilan!"

---

## Part 2: Widget Dasar (15 menit)

### ✏️ Ganti body dengan Column:

```dart
body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // 1. TEXT WIDGET
      Text('Halo Dunia!'),

      Text(
        'Teks dengan Style',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),

      SizedBox(height: 20), // Jarak/spacing

      // 2. CONTAINER WIDGET
      Container(
        width: 200,
        height: 100,
        color: Colors.orange,
        child: Center(child: Text('Container')),
      ),

      SizedBox(height: 20),

      // 3. BUTTON WIDGET
      ElevatedButton(
        onPressed: () {
          print('Tombol ditekan!');
        },
        child: Text('Klik Saya'),
      ),
    ],
  ),
),
```

### 🎯 Tunjukkan Hot Reload:

1. Ubah warna dari `Colors.orange` ke `Colors.purple`
2. Tekan `r` di terminal
3. "Lihat! Perubahan langsung terlihat tanpa restart!"

---

## Part 3: Layout - Row & Column (15 menit)

### ✏️ Jelaskan dengan Gambar:

```
COLUMN = Vertikal (atas-bawah)     ROW = Horizontal (kiri-kanan)

   ┌─────────┐                      ┌───────────────────┐
   │    1    │                      │  1  │  2  │  3    │
   ├─────────┤                      └───────────────────┘
   │    2    │
   ├─────────┤
   │    3    │
   └─────────┘
```

### ✏️ Demo Row:

```dart
body: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text('Ini Column (vertikal)'),
    SizedBox(height: 20),

    // Row = susun horizontal
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.home, size: 50, color: Colors.blue),
        Icon(Icons.favorite, size: 50, color: Colors.red),
        Icon(Icons.star, size: 50, color: Colors.amber),
      ],
    ),
  ],
),
```

### 🎯 Eksperimen MainAxisAlignment:

Ganti-ganti nilai dan lihat perbedaannya:

- `MainAxisAlignment.start` → Di kiri
- `MainAxisAlignment.center` → Di tengah
- `MainAxisAlignment.end` → Di kanan
- `MainAxisAlignment.spaceEvenly` → Jarak sama rata

---

## Part 4: Stack (5 menit)

```dart
body: Center(
  child: Stack(
    children: [
      // Layer 1 (paling bawah)
      Container(width: 200, height: 200, color: Colors.blue),
      // Layer 2
      Container(width: 150, height: 150, color: Colors.green),
      // Layer 3 (paling atas)
      Container(width: 100, height: 100, color: Colors.red),
    ],
  ),
),
```

> 📢 **Jelaskan**: "Stack seperti tumpukan kertas. Yang ditulis terakhir ada di paling atas!"

---

## Part 5: Theme (10 menit)

### ✏️ Tambahkan theme di MaterialApp:

```dart
return MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
  ),
  home: CounterPage(),
);
```

> 📢 **Jelaskan**: "Dengan theme, kita bisa mengubah warna seluruh app dari satu tempat!"

---

## 📝 Catatan Penting untuk Pengajar

### ✅ Tips Mengajar:

- **Ketik manual**, jangan copy-paste (mahasiswa lebih paham)
- **Buat kesalahan** yang disengaja lalu debug bersama
- **Tanya mahasiswa**: "Menurutmu apa yang terjadi kalau...?"
- **Hot Reload sering-sering** untuk tunjukkan perubahan

### ❌ Hindari:

- Terlalu cepat
- Skip penjelasan ketika error
- Abaikan pertanyaan mahasiswa

### 💬 Pertanyaan Interaktif:

1. "Apa bedanya StatelessWidget dan StatefulWidget?"
2. "Kenapa harus pakai setState()?"
3. "Row vs Column, apa bedanya?"
4. "Stack itu seperti apa dalam kehidupan nyata?"

---

## 📌 Setelah Kelas

- Berikan **tugas membuat Halaman Profil**
- Contoh jawaban ada di: `06_profil_page_lengkap.dart`
- Deadline: Pertemuan 3

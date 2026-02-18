# 🔑 KUNCI JAWABAN LATIHAN PERTEMUAN 1

## (Dokumen untuk Dosen/Asisten - TIDAK UNTUK MAHASISWA)

---

## Latihan 1: Dart Dasar

```dart
void main() {
  // 1. Buat variabel nama (String) berisi nama kamu
  String nama = 'Budi Santoso';

  // 2. Buat variabel umur (int) berisi umur kamu
  int umur = 20;

  // 3. Buat variabel ipk (double) berisi IPK kamu
  double ipk = 3.75;

  // 4. Tampilkan semua data dengan format:
  print('Nama: $nama, Umur: $umur, IPK: $ipk');

  // 5. Buat kondisi: jika IPK >= 3.5 print "Cumlaude!"
  if (ipk >= 3.5) {
    print('Cumlaude!');
  } else {
    print('Tetap semangat!');
  }
}
```

**Output:**

```
Nama: Budi Santoso, Umur: 20, IPK: 3.75
Cumlaude!
```

---

## Latihan 2: Fungsi

```dart
// 1. Fungsi hitungLuasPersegiPanjang
int hitungLuasPersegiPanjang(int panjang, int lebar) {
  return panjang * lebar;
}

// 2. Fungsi cekGanjilGenap
void cekGanjilGenap(int angka) {
  if (angka % 2 == 0) {
    print('$angka adalah bilangan Genap');
  } else {
    print('$angka adalah bilangan Ganjil');
  }
}

// 3. Fungsi tampilkanGrade
void tampilkanGrade(int nilai) {
  String grade;
  if (nilai >= 80) {
    grade = 'A';
  } else if (nilai >= 70) {
    grade = 'B';
  } else if (nilai >= 60) {
    grade = 'C';
  } else {
    grade = 'D';
  }
  print('Nilai: $nilai → Grade: $grade');
}

void main() {
  // Test fungsi 1
  int luas = hitungLuasPersegiPanjang(10, 5);
  print('Luas persegi panjang: $luas');

  // Test fungsi 2
  cekGanjilGenap(7);
  cekGanjilGenap(12);

  // Test fungsi 3
  tampilkanGrade(85);
  tampilkanGrade(72);
  tampilkanGrade(58);
}
```

**Output:**

```
Luas persegi panjang: 50
7 adalah bilangan Ganjil
12 adalah bilangan Genap
Nilai: 85 → Grade: A
Nilai: 72 → Grade: B
Nilai: 58 → Grade: D
```

---

## Latihan 3: List dan Loop

```dart
void main() {
  // Diberikan list mahasiswa
  List<String> mahasiswa = ['Andi', 'Budi', 'Citra', 'Doni', 'Eka'];

  // 1. Tampilkan semua nama dengan format: "1. Andi", "2. Budi", dst
  print('=== Daftar Mahasiswa ===');
  for (int i = 0; i < mahasiswa.length; i++) {
    print('${i + 1}. ${mahasiswa[i]}');
  }

  // Alternatif dengan forEach dan index
  // mahasiswa.asMap().forEach((index, nama) {
  //   print('${index + 1}. $nama');
  // });

  // 2. Tambahkan nama "Fani" ke list
  mahasiswa.add('Fani');
  print('\nSetelah ditambah Fani: $mahasiswa');

  // 3. Hapus nama "Citra" dari list
  mahasiswa.remove('Citra');
  print('Setelah dihapus Citra: $mahasiswa');

  // 4. Tampilkan jumlah mahasiswa sekarang
  print('\nJumlah mahasiswa sekarang: ${mahasiswa.length}');
}
```

**Output:**

```
=== Daftar Mahasiswa ===
1. Andi
2. Budi
3. Citra
4. Doni
5. Eka

Setelah ditambah Fani: [Andi, Budi, Citra, Doni, Eka, Fani]
Setelah dihapus Citra: [Andi, Budi, Doni, Eka, Fani]

Jumlah mahasiswa sekarang: 5
```

---

## Latihan 4: Class dan OOP

```dart
class Buku {
  // Properties
  String judul;
  String penulis;
  int tahun;
  double harga;

  // Constructor
  Buku(this.judul, this.penulis, this.tahun, this.harga);

  // Method info()
  void info() {
    print('=== Info Buku ===');
    print('Judul  : $judul');
    print('Penulis: $penulis');
    print('Tahun  : $tahun');
    print('Harga  : Rp${harga.toStringAsFixed(0)}');
  }

  // Method diskon()
  double diskon(int persen) {
    double potongan = harga * persen / 100;
    return harga - potongan;
  }
}

void main() {
  // Buat 2 object buku
  Buku buku1 = Buku('Flutter in Action', 'Eric Windmill', 2020, 350000);
  Buku buku2 = Buku('Clean Code', 'Robert C. Martin', 2008, 500000);

  // Tampilkan info
  buku1.info();
  print('');
  buku2.info();

  // Hitung harga setelah diskon 20%
  print('\n=== Harga Setelah Diskon 20% ===');
  print('${buku1.judul}: Rp${buku1.diskon(20).toStringAsFixed(0)}');
  print('${buku2.judul}: Rp${buku2.diskon(20).toStringAsFixed(0)}');
}
```

**Output:**

```
=== Info Buku ===
Judul  : Flutter in Action
Penulis: Eric Windmill
Tahun  : 2020
Harga  : Rp350000

=== Info Buku ===
Judul  : Clean Code
Penulis: Robert C. Martin
Tahun  : 2008
Harga  : Rp500000

=== Harga Setelah Diskon 20% ===
Flutter in Action: Rp280000
Clean Code: Rp400000
```

---

## Latihan 5: Modifikasi Flutter App

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
      title: 'Profil Saya',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple, // 1. Ganti warna AppBar
        useMaterial3: true,
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
        title: const Text('Profil Mahasiswa'),
        backgroundColor: Colors.purple, // Warna favorit
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 4. Icon berbeda
            const Icon(
              Icons.person,
              size: 100,
              color: Colors.purple,
            ),
            const SizedBox(height: 20),

            // 2. Data tentang diri
            const Text(
              'Budi Santoso',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'NIM: 2209106001',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 5),
            const Text(
              'Hobi: Coding & Gaming',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Tombol 1 (asli)
            ElevatedButton.icon(
              onPressed: () {
                print('Tombol Like ditekan!');
              },
              icon: const Icon(Icons.favorite),
              label: const Text('Like'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),

            // 3. Tombol 2 tambahan
            ElevatedButton.icon(
              onPressed: () {
                print('Tombol Share ditekan!');
              },
              icon: const Icon(Icons.share),
              label: const Text('Share'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),

            // 3. Tombol 3 tambahan
            OutlinedButton.icon(
              onPressed: () {
                print('Tombol Edit ditekan!');
              },
              icon: const Icon(Icons.edit),
              label: const Text('Edit Profil'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 📊 Rubrik Penilaian Latihan

| Kriteria                      | Poin |
| ----------------------------- | ---- |
| Kode berjalan tanpa error     | 40%  |
| Output sesuai yang diminta    | 30%  |
| Kode rapi dan ada komentar    | 15%  |
| Kreativitas (untuk Latihan 5) | 15%  |

---

## 📝 Catatan untuk Asisten Dosen

1. **Toleransi**: Nama variabel boleh berbeda selama logika benar
2. **Bonus poin**: Jika mahasiswa menggunakan pendekatan alternatif yang lebih efisien
3. **Pengurangan poin**: Jika ada warning tapi tidak error, kurangi 5%
4. **Kreativitas**: Berikan poin ekstra untuk mahasiswa yang menambahkan fitur di luar requirement

---

> **RAHASIA - Tidak untuk didistribusikan kepada mahasiswa**

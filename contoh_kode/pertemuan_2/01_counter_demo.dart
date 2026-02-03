// =============================================================================
// 📱 PERTEMUAN 2 - DEMO 1: STATEFULWIDGET (COUNTER APP)
// =============================================================================
// File ini mendemonstrasikan perbedaan StatelessWidget dan StatefulWidget
// dengan membuat aplikasi counter sederhana.
//
// CARA MENJALANKAN:
// 1. Copy isi file ini ke main.dart proyek Flutter Anda
// 2. Jalankan dengan: flutter run
// =============================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const CounterPage(),
    );
  }
}

// =============================================================================
// CONTOH STATELESSWIDGET
// Widget yang tampilannya TIDAK BERUBAH setelah ditampilkan
// =============================================================================
class KartuProfil extends StatelessWidget {
  final String nama;
  final String pekerjaan;

  // Constructor dengan required parameters
  const KartuProfil({
    super.key,
    required this.nama,
    required this.pekerjaan,
  });

  @override
  Widget build(BuildContext context) {
    // build() hanya dipanggil SEKALI saat widget dibuat
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

// =============================================================================
// CONTOH STATEFULWIDGET
// Widget yang tampilannya BISA BERUBAH saat ada interaksi
// =============================================================================
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  // createState() membuat objek State yang menyimpan data
  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  // STATE = data yang bisa berubah
  int _counter = 0;

  // Method untuk menambah counter
  void _increment() {
    // setState() memberitahu Flutter untuk rebuild UI
    setState(() {
      _counter++;
    });
  }

  // Method untuk mengurangi counter
  void _decrement() {
    setState(() {
      if (_counter > 0) _counter--;
    });
  }

  // Method untuk reset counter
  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // build() dipanggil SETIAP KALI setState() dipanggil
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Demo'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Menggunakan StatelessWidget yang kita buat
            const KartuProfil(
              nama: 'Demo Counter',
              pekerjaan: 'Belajar StatefulWidget',
            ),
            const SizedBox(height: 40),

            // Tampilan counter
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    'Counter:',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '$_counter', // Menampilkan nilai counter
                    style: const TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Tombol-tombol
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tombol Kurang
                ElevatedButton.icon(
                  onPressed: _decrement,
                  icon: const Icon(Icons.remove),
                  label: const Text('Kurang'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[100],
                  ),
                ),
                const SizedBox(width: 16),

                // Tombol Reset
                OutlinedButton.icon(
                  onPressed: _reset,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                ),
                const SizedBox(width: 16),

                // Tombol Tambah
                ElevatedButton.icon(
                  onPressed: _increment,
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[100],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      // FloatingActionButton juga bisa untuk tambah
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        tooltip: 'Tambah',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// =============================================================================
// 📝 CATATAN PENTING:
// 
// 1. StatelessWidget:
//    - Tidak punya state internal
//    - build() dipanggil sekali
//    - Cocok untuk tampilan statis
//
// 2. StatefulWidget:
//    - Punya state yang bisa berubah
//    - Terdiri dari 2 class: Widget dan State
//    - setState() memicu rebuild UI
//    - Cocok untuk tampilan dinamis/interaktif
//
// 3. Kapan pakai mana?
//    - Mulai dengan StatelessWidget
//    - Ubah ke StatefulWidget jika perlu setState()
// =============================================================================

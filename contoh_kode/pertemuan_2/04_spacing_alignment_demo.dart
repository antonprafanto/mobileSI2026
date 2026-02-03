// =============================================================================
// 📱 PERTEMUAN 2 - DEMO 4: SPACING & ALIGNMENT
// =============================================================================
// Demonstrates: Padding, Margin, SizedBox, Expanded, Align
// CARA MENJALANKAN: Copy ke main.dart dan jalankan flutter run
// =============================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spacing Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange)),
      home: const SpacingDemoPage(),
    );
  }
}

class SpacingDemoPage extends StatelessWidget {
  const SpacingDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Spacing & Alignment'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PADDING VS MARGIN
            const Text('1. Padding vs Margin', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              color: Colors.blue[100],
              margin: const EdgeInsets.all(8), // MARGIN = jarak keluar
              child: Container(
                padding: const EdgeInsets.all(16), // PADDING = jarak ke dalam
                color: Colors.orange[200],
                child: const Text('Content'),
              ),
            ),
            const Text('• Margin = jarak ke LUAR\n• Padding = jarak ke DALAM', style: TextStyle(fontSize: 12)),
            const Divider(height: 32),

            // EDGEINSETS OPTIONS
            const Text('EdgeInsets Options:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _edgeDemo('EdgeInsets.all(16)', const EdgeInsets.all(16)),
            _edgeDemo('EdgeInsets.symmetric(h:32, v:8)', const EdgeInsets.symmetric(horizontal: 32, vertical: 8)),
            _edgeDemo('EdgeInsets.only(left: 32)', const EdgeInsets.only(left: 32)),
            const Divider(height: 32),

            // SIZEDBOX
            const Text('2. SizedBox (Spacing)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(children: [
              _box('A', Colors.red), const SizedBox(width: 8),
              _box('B', Colors.green), const SizedBox(width: 16),
              _box('C', Colors.blue), const SizedBox(width: 32),
              _box('D', Colors.purple),
            ]),
            const Text('SizedBox memberikan jarak antar widget', style: TextStyle(fontSize: 12, color: Colors.grey)),
            const Divider(height: 32),

            // EXPANDED
            const Text('3. Expanded', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Tanpa Expanded:'),
            Row(children: [_box('A', Colors.red), _box('B', Colors.green), _box('C', Colors.blue)]),
            const SizedBox(height: 8),
            const Text('Dengan Expanded:'),
            Row(children: [
              Expanded(child: _box('A', Colors.red)),
              Expanded(child: _box('B', Colors.green)),
              Expanded(child: _box('C', Colors.blue)),
            ]),
            const SizedBox(height: 8),
            const Text('Expanded flex 1:2:1:'),
            Row(children: [
              Expanded(flex: 1, child: _box('1', Colors.red)),
              Expanded(flex: 2, child: _box('2', Colors.green)),
              Expanded(flex: 1, child: _box('1', Colors.blue)),
            ]),
            const Divider(height: 32),

            // ALIGN
            const Text('4. Center & Align', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Container(
              height: 100, color: Colors.grey[200],
              child: Stack(children: [
                Align(alignment: Alignment.topLeft, child: _smallBox('TL', Colors.red)),
                Align(alignment: Alignment.topRight, child: _smallBox('TR', Colors.blue)),
                Align(alignment: Alignment.center, child: _smallBox('C', Colors.purple)),
                Align(alignment: Alignment.bottomLeft, child: _smallBox('BL', Colors.orange)),
                Align(alignment: Alignment.bottomRight, child: _smallBox('BR', Colors.teal)),
              ]),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _edgeDemo(String label, EdgeInsets p) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      Container(color: Colors.blue[100], child: Container(padding: p, color: Colors.orange[200], child: const Text('Content'))),
      const SizedBox(height: 8),
    ],
  );
}

Widget _box(String t, Color c) => Container(
  width: 50, height: 50, margin: const EdgeInsets.all(2),
  decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(8)),
  child: Center(child: Text(t, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
);

Widget _smallBox(String t, Color c) => Container(
  width: 30, height: 30,
  decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(4)),
  child: Center(child: Text(t, style: const TextStyle(color: Colors.white, fontSize: 10))),
);

// =============================================================================
// 📝 CATATAN PENTING (UNTUK PEMULA):
// 
// 1. PADDING = jarak ke DALAM widget
//    Contoh: Padding membuat teks tidak menempel ke tepi container
//
// 2. MARGIN = jarak ke LUAR widget  
//    Contoh: Margin membuat container tidak menempel ke widget lain
//
// 3. SizedBox = kotak kosong untuk memberikan jarak
//    - SizedBox(width: 16) = jarak horizontal 16 pixel
//    - SizedBox(height: 16) = jarak vertical 16 pixel
//
// 4. Expanded = mengisi ruang yang tersisa
//    - Digunakan di dalam Row atau Column
//    - flex: 2 artinya mengambil 2x lebih banyak ruang
//
// 5. Align = memposisikan widget di tempat tertentu
//    - Alignment.topLeft = pojok kiri atas
//    - Alignment.bottomRight = pojok kanan bawah
//    - Alignment.center = tengah
//
// 💡 Tips: Gunakan SizedBox untuk spacing, lebih ringan dari Padding!
// =============================================================================

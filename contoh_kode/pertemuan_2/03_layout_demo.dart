// =============================================================================
// 📱 PERTEMUAN 2 - DEMO 3: LAYOUT WIDGETS
// =============================================================================
// File ini mendemonstrasikan layout widgets Flutter:
// - Row (Horizontal)
// - Column (Vertikal)
// - Stack (Tumpukan)
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
      title: 'Layout Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const LayoutDemoPage(),
    );
  }
}

class LayoutDemoPage extends StatelessWidget {
  const LayoutDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Layout Demo'),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Row'),
              Tab(text: 'Column'),
              Tab(text: 'Stack'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            RowDemoTab(),
            ColumnDemoTab(),
            StackDemoTab(),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// TAB 1: ROW DEMO
// Row menyusun children dari KIRI ke KANAN (horizontal)
// =============================================================================
class RowDemoTab extends StatelessWidget {
  const RowDemoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle('Row - Menyusun Horizontal'),
          const SizedBox(height: 16),

          // Row sederhana
          _buildSubtitle('Row Sederhana:'),
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                _buildBox('1', Colors.red),
                _buildBox('2', Colors.green),
                _buildBox('3', Colors.blue),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // MainAxisAlignment
          _buildSubtitle('MainAxisAlignment Options:'),
          const SizedBox(height: 8),
          
          _buildLabel('start (default)'),
          _buildRowDemo(MainAxisAlignment.start),
          
          _buildLabel('center'),
          _buildRowDemo(MainAxisAlignment.center),
          
          _buildLabel('end'),
          _buildRowDemo(MainAxisAlignment.end),
          
          _buildLabel('spaceBetween'),
          _buildRowDemo(MainAxisAlignment.spaceBetween),
          
          _buildLabel('spaceAround'),
          _buildRowDemo(MainAxisAlignment.spaceAround),
          
          _buildLabel('spaceEvenly'),
          _buildRowDemo(MainAxisAlignment.spaceEvenly),

          const SizedBox(height: 24),

          // Contoh Praktis - Rating Stars
          _buildSubtitle('Contoh Praktis - Rating Stars:'),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.amber, size: 32),
                Icon(Icons.star, color: Colors.amber, size: 32),
                Icon(Icons.star, color: Colors.amber, size: 32),
                Icon(Icons.star, color: Colors.amber, size: 32),
                Icon(Icons.star_border, color: Colors.amber, size: 32),
                const SizedBox(width: 8),
                const Text('4.0', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildRowDemo(MainAxisAlignment alignment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.grey[200],
      height: 50,
      child: Row(
        mainAxisAlignment: alignment,
        children: [
          _buildSmallBox('1', Colors.red),
          _buildSmallBox('2', Colors.green),
          _buildSmallBox('3', Colors.blue),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 2: COLUMN DEMO
// Column menyusun children dari ATAS ke BAWAH (vertikal)
// =============================================================================
class ColumnDemoTab extends StatelessWidget {
  const ColumnDemoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle('Column - Menyusun Vertikal'),
          const SizedBox(height: 16),

          // Row berisi 3 Column untuk perbandingan
          _buildSubtitle('CrossAxisAlignment Options:'),
          const SizedBox(height: 8),

          Row(
            children: [
              // CrossAxisAlignment.start
              Expanded(
                child: Column(
                  children: [
                    const Text('start', style: TextStyle(fontWeight: FontWeight.bold)),
                    Container(
                      height: 150,
                      color: Colors.grey[200],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSmallBox('1', Colors.red),
                          _buildSmallBox('2', Colors.green),
                          _buildSmallBox('3', Colors.blue),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              
              // CrossAxisAlignment.center
              Expanded(
                child: Column(
                  children: [
                    const Text('center', style: TextStyle(fontWeight: FontWeight.bold)),
                    Container(
                      height: 150,
                      color: Colors.grey[200],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildSmallBox('1', Colors.red),
                          _buildSmallBox('2', Colors.green),
                          _buildSmallBox('3', Colors.blue),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              
              // CrossAxisAlignment.end
              Expanded(
                child: Column(
                  children: [
                    const Text('end', style: TextStyle(fontWeight: FontWeight.bold)),
                    Container(
                      height: 150,
                      color: Colors.grey[200],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildSmallBox('1', Colors.red),
                          _buildSmallBox('2', Colors.green),
                          _buildSmallBox('3', Colors.blue),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // MainAxisAlignment untuk Column
          _buildSubtitle('MainAxisAlignment (dalam Column):'),
          const SizedBox(height: 8),

          Row(
            children: [
              _buildColumnDemo('start', MainAxisAlignment.start),
              const SizedBox(width: 8),
              _buildColumnDemo('center', MainAxisAlignment.center),
              const SizedBox(width: 8),
              _buildColumnDemo('end', MainAxisAlignment.end),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildColumnDemo('between', MainAxisAlignment.spaceBetween),
              const SizedBox(width: 8),
              _buildColumnDemo('around', MainAxisAlignment.spaceAround),
              const SizedBox(width: 8),
              _buildColumnDemo('evenly', MainAxisAlignment.spaceEvenly),
            ],
          ),

          const SizedBox(height: 24),

          // Contoh Praktis - Menu List
          _buildSubtitle('Contoh Praktis - Menu List:'),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.home, color: Colors.teal),
                  title: const Text('Home'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.teal),
                  title: const Text('Profile'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.teal),
                  title: const Text('Settings'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildColumnDemo(String label, MainAxisAlignment alignment) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          Container(
            height: 120,
            color: Colors.grey[200],
            child: Column(
              mainAxisAlignment: alignment,
              children: [
                _buildSmallBox('1', Colors.red),
                _buildSmallBox('2', Colors.green),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 3: STACK DEMO
// Stack menyusun children BERTUMPUK (layer)
// =============================================================================
class StackDemoTab extends StatelessWidget {
  const StackDemoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle('Stack - Menyusun Bertumpuk'),
          const SizedBox(height: 16),

          // Stack sederhana
          _buildSubtitle('Stack Sederhana:'),
          Container(
            height: 150,
            color: Colors.grey[200],
            child: Stack(
              children: [
                // Layer 1 (paling bawah)
                Container(
                  width: 150,
                  height: 150,
                  color: Colors.blue,
                  child: const Center(
                    child: Text('Layer 1', style: TextStyle(color: Colors.white)),
                  ),
                ),
                // Layer 2
                Positioned(
                  left: 50,
                  top: 30,
                  child: Container(
                    width: 120,
                    height: 80,
                    color: Colors.green,
                    child: const Center(
                      child: Text('Layer 2', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                // Layer 3 (paling atas)
                Positioned(
                  left: 100,
                  top: 60,
                  child: Container(
                    width: 80,
                    height: 60,
                    color: Colors.red,
                    child: const Center(
                      child: Text('Layer 3', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '* Widget pertama = paling bawah, widget terakhir = paling atas',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 24),

          // Positioned Widget
          _buildSubtitle('Positioned Widget:'),
          Container(
            height: 200,
            color: Colors.grey[200],
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 10,
                  child: _buildPositionedBox('top: 10\nleft: 10', Colors.blue),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: _buildPositionedBox('top: 10\nright: 10', Colors.green),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: _buildPositionedBox('bottom: 10\nleft: 10', Colors.orange),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: _buildPositionedBox('bottom: 10\nright: 10', Colors.purple),
                ),
                // Center
                Center(
                  child: _buildPositionedBox('Center\n(no position)', Colors.red),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Contoh Praktis - Profile Card dengan Badge
          _buildSubtitle('Contoh Praktis - Profile dengan Badge:'),
          Center(
            child: Stack(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('https://picsum.photos/200/200'),
                ),
                // Badge online status
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Contoh Praktis - Image dengan Text Overlay
          _buildSubtitle('Contoh Praktis - Image dengan Text Overlay:'),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://picsum.photos/400/200',
                    fit: BoxFit.cover,
                  ),
                ),
                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
                // Text di bawah
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Beautiful Landscape',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Stack dengan gradient overlay',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildPositionedBox(String text, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// =============================================================================
// HELPER WIDGETS
// =============================================================================
Widget _buildTitle(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.teal,
    ),
  );
}

Widget _buildSubtitle(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget _buildLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Text(text, style: const TextStyle(fontSize: 12, color: Colors.grey)),
  );
}

Widget _buildBox(String text, Color color) {
  return Container(
    width: 60,
    height: 60,
    margin: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    ),
  );
}

Widget _buildSmallBox(String text, Color color) {
  return Container(
    width: 40,
    height: 40,
    margin: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    ),
  );
}

// =============================================================================
// 📝 CATATAN PENTING:
// 
// 1. Row: Horizontal (kiri → kanan)
//    - mainAxisAlignment: mengatur posisi horizontal
//    - crossAxisAlignment: mengatur posisi vertikal
//
// 2. Column: Vertikal (atas → bawah)
//    - mainAxisAlignment: mengatur posisi vertikal
//    - crossAxisAlignment: mengatur posisi horizontal
//
// 3. Stack: Bertumpuk (layer)
//    - Widget pertama = paling bawah
//    - Gunakan Positioned untuk mengatur posisi
//
// Tips:
// - Gunakan Expanded atau Flexible untuk mengisi ruang yang tersisa
// - Gunakan SizedBox untuk spacing antar widget
// - Bungkus dengan SingleChildScrollView jika konten overflow
// =============================================================================

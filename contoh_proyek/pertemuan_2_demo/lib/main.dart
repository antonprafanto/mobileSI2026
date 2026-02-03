// =============================================================================
// 📱 PERTEMUAN 2 - PROYEK DEMO LENGKAP
// =============================================================================
//
// CARA MENJALANKAN:
// 1. Buka terminal/command prompt
// 2. Masuk ke folder ini: cd contoh_proyek/pertemuan_2_demo
// 3. Jalankan: flutter run
//
// Proyek ini menggabungkan semua contoh dari Pertemuan 2 dengan navigasi menu.
// Klik setiap item untuk melihat demo yang berbeda!
//
// =============================================================================

import 'package:flutter/material.dart';

// FUNGSI MAIN = Entry point (titik awal) aplikasi Flutter
// Fungsi ini yang pertama kali dijalankan saat app dibuka
void main() => runApp(const MyApp());

// =============================================================================
// MyApp - WIDGET ROOT (AKAR) APLIKASI
// =============================================================================
// Ini adalah StatefulWidget karena kita ingin bisa mengganti tema (light/dark)
// StatefulWidget = Widget yang datanya bisa berubah
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // STATE: Menyimpan mode tema saat ini (light atau dark)
  ThemeMode _themeMode = ThemeMode.light;

  // FUNGSI: Untuk toggle (ganti) tema
  void _toggleTheme() {
    setState(() {
      // Jika sekarang light, ganti ke dark. Dan sebaliknya.
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pertemuan 2 Demo',
      debugShowCheckedModeBanner: false, // Hilangkan banner "DEBUG"
      
      // LIGHT THEME (tema terang)
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo, // Warna dasar
          brightness: Brightness.light,
        ),
      ),
      
      // DARK THEME (tema gelap)
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
      ),
      
      themeMode: _themeMode, // Gunakan tema sesuai state
      home: HomePage(
        onThemeToggle: _toggleTheme,
        isDark: _themeMode == ThemeMode.dark,
      ),
    );
  }
}

// =============================================================================
// HOME PAGE - HALAMAN MENU UTAMA
// =============================================================================
// StatelessWidget karena tampilan tidak berubah (kecuali tema dari parent)
class HomePage extends StatelessWidget {
  final VoidCallback onThemeToggle; // Fungsi untuk toggle tema
  final bool isDark; // Apakah sedang mode gelap

  const HomePage({
    super.key,
    required this.onThemeToggle,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR = Bar di bagian atas
      appBar: AppBar(
        title: const Text('📱 Pertemuan 2 Demo'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Tombol untuk toggle tema
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: onThemeToggle,
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      
      // BODY = Isi halaman
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header dengan gradient
          _buildHeader(context),
          const SizedBox(height: 16),
          
          // Menu cards untuk setiap demo
          _buildMenuCard(
            context,
            '1️⃣',
            'Counter App',
            'Belajar StatefulWidget & setState()',
            Colors.blue,
            const CounterDemo(),
          ),
          _buildMenuCard(
            context,
            '2️⃣',
            'Widget Dasar',
            'Text, Container, Image, Icon, Button',
            Colors.purple,
            const WidgetDasarDemo(),
          ),
          _buildMenuCard(
            context,
            '3️⃣',
            'Layout Demo',
            'Row, Column, Stack',
            Colors.teal,
            const LayoutDemo(),
          ),
          _buildMenuCard(
            context,
            '4️⃣',
            'Spacing & Alignment',
            'Padding, SizedBox, Expanded',
            Colors.orange,
            const SpacingDemo(),
          ),
          _buildMenuCard(
            context,
            '5️⃣',
            'Profil Page',
            'Contoh Praktikum Lengkap',
            Colors.indigo,
            const ProfilPage(),
          ),
        ],
      ),
    );
  }

  // HELPER: Membuat header dengan gradient
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.indigo, Colors.purple],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        children: [
          Icon(Icons.flutter_dash, size: 60, color: Colors.white),
          SizedBox(height: 8),
          Text(
            'Widget, Layout & Theming',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Pilih demo untuk dipelajari',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // HELPER: Membuat card menu
  Widget _buildMenuCard(
    BuildContext ctx,
    String emoji,
    String title,
    String subtitle,
    Color color,
    Widget page,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(emoji, style: const TextStyle(fontSize: 24)),
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        // NAVIGASI: Pindah ke halaman demo saat di-tap
        onTap: () => Navigator.push(
          ctx,
          MaterialPageRoute(builder: (_) => page),
        ),
      ),
    );
  }
}

// =============================================================================
// DEMO 1: COUNTER APP
// =============================================================================
// Contoh StatefulWidget sederhana
// State = int _counter yang bisa berubah saat tombol ditekan
class CounterDemo extends StatefulWidget {
  const CounterDemo({super.key});

  @override
  State<CounterDemo> createState() => _CounterDemoState();
}

class _CounterDemoState extends State<CounterDemo> {
  // STATE: Nilai counter yang bisa berubah
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Label
            const Text(
              'Contoh StatefulWidget',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            
            // Tampilan angka counter
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                '$_counter', // Menampilkan nilai counter
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            // Tombol-tombol
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tombol KURANG
                ElevatedButton.icon(
                  onPressed: () {
                    // setState() memberitahu Flutter untuk rebuild UI
                    setState(() {
                      if (_counter > 0) _counter--;
                    });
                  },
                  icon: const Icon(Icons.remove),
                  label: const Text('Kurang'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[100],
                  ),
                ),
                const SizedBox(width: 16),
                
                // Tombol TAMBAH
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() => _counter++);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[100],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Tombol RESET
            TextButton(
              onPressed: () => setState(() => _counter = 0),
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// DEMO 2: WIDGET DASAR
// =============================================================================
// Menampilkan berbagai widget dasar yang sering dipakai
class WidgetDasarDemo extends StatelessWidget {
  const WidgetDasarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widget Dasar')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TEXT WIDGET
            _section('1. Text Widget'),
            const Text('Hello World - Teks biasa'),
            const Text(
              'Bold & Colored',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 20,
              ),
            ),
            const Divider(),

            // CONTAINER WIDGET
            _section('2. Container Widget'),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Container dengan Gradient',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(),

            // IMAGE WIDGET
            _section('3. Image Widget'),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://picsum.photos/400/150',
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    color: Colors.grey[300],
                    child: const Center(child: Icon(Icons.broken_image, size: 50)),
                  );
                },
              ),
            ),
            const Divider(),

            // ICON WIDGET
            _section('4. Icon Widget'),
            const Wrap(
              spacing: 16,
              children: [
                Icon(Icons.home, size: 40, color: Colors.blue),
                Icon(Icons.favorite, size: 40, color: Colors.red),
                Icon(Icons.star, size: 40, color: Colors.amber),
                Icon(Icons.settings, size: 40, color: Colors.grey),
              ],
            ),
            const Divider(),

            // BUTTON WIDGETS
            _section('5. Button Widgets'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Elevated'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Outlined'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Text'),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.thumb_up),
                ),
              ],
            ),
            const Divider(),

            // CARD & LISTTILE
            _section('6. Card & ListTile'),
            const Card(
              child: ListTile(
                leading: CircleAvatar(child: Icon(Icons.person)),
                title: Text('John Doe'),
                subtitle: Text('Developer'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // HELPER: Membuat section title
  Widget _section(String title) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
      );
}

// =============================================================================
// DEMO 3: LAYOUT (Row, Column, Stack)
// =============================================================================
class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Layout Demo'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Row'),
              Tab(text: 'Column'),
              Tab(text: 'Stack'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // TAB 1: ROW (Horizontal)
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Row = Menyusun secara Horizontal (→)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _label('MainAxisAlignment.start'),
                  _rowDemo(MainAxisAlignment.start),
                  _label('MainAxisAlignment.center'),
                  _rowDemo(MainAxisAlignment.center),
                  _label('MainAxisAlignment.spaceBetween'),
                  _rowDemo(MainAxisAlignment.spaceBetween),
                  _label('MainAxisAlignment.spaceEvenly'),
                  _rowDemo(MainAxisAlignment.spaceEvenly),
                ],
              ),
            ),
            
            // TAB 2: COLUMN (Vertical)
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Column = Menyusun secara Vertikal (↓)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: _colDemo('start', CrossAxisAlignment.start)),
                      const SizedBox(width: 8),
                      Expanded(child: _colDemo('center', CrossAxisAlignment.center)),
                      const SizedBox(width: 8),
                      Expanded(child: _colDemo('end', CrossAxisAlignment.end)),
                    ],
                  ),
                ],
              ),
            ),
            
            // TAB 3: STACK (Tumpukan)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Stack = Menyusun Bertumpuk',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(width: 200, height: 200, color: Colors.blue),
                      Container(width: 150, height: 150, color: Colors.green),
                      Container(width: 100, height: 100, color: Colors.red),
                      const Text(
                        'Stack',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('Biru → Hijau → Merah (dari bawah ke atas)'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String t) => Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 4),
        child: Text(t, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      );

  Widget _rowDemo(MainAxisAlignment a) => Container(
        height: 50,
        color: Colors.grey[200],
        margin: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: a,
          children: [_box(Colors.red), _box(Colors.green), _box(Colors.blue)],
        ),
      );

  Widget _colDemo(String l, CrossAxisAlignment a) => Column(
        children: [
          Text(l, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          Container(
            height: 120,
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: a,
              children: [_box(Colors.red), _box(Colors.green), _box(Colors.blue)],
            ),
          ),
        ],
      );

  Widget _box(Color c) => Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.all(2),
        color: c,
      );
}

// =============================================================================
// DEMO 4: SPACING & ALIGNMENT
// =============================================================================
class SpacingDemo extends StatelessWidget {
  const SpacingDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Spacing & Alignment')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PADDING VS MARGIN
            const Text(
              '1. Padding vs Margin',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              color: Colors.blue[100],
              margin: const EdgeInsets.all(8), // Jarak KELUAR
              child: Container(
                padding: const EdgeInsets.all(16), // Jarak KEDALAM
                color: Colors.orange[200],
                child: const Text('Content'),
              ),
            ),
            const Text(
              '• Margin = jarak KELUAR (dari widget lain)\n'
              '• Padding = jarak KEDALAM (dari content)',
              style: TextStyle(fontSize: 12),
            ),
            const Divider(),

            // SIZEDBOX
            const Text(
              '2. SizedBox Spacing',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _box(Colors.red),
                const SizedBox(width: 16), // Jarak 16
                _box(Colors.green),
                const SizedBox(width: 32), // Jarak 32
                _box(Colors.blue),
              ],
            ),
            const Text(
              'SizedBox(width: 16) dan SizedBox(width: 32)',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const Divider(),

            // EXPANDED
            const Text(
              '3. Expanded',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Tanpa Expanded:'),
            Row(children: [_box(Colors.red), _box(Colors.green), _box(Colors.blue)]),
            const SizedBox(height: 8),
            const Text('Dengan Expanded (mengisi ruang tersisa):'),
            Row(
              children: [
                Expanded(child: _box(Colors.red)),
                Expanded(child: _box(Colors.green)),
                Expanded(child: _box(Colors.blue)),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _box(Color c) => Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: c,
          borderRadius: BorderRadius.circular(8),
        ),
      );
}

// =============================================================================
// DEMO 5: PROFIL PAGE (CONTOH PRAKTIKUM)
// =============================================================================
class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // FOTO PROFIL
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage('https://picsum.photos/200/200'),
            ),
            const SizedBox(height: 16),
            
            // NAMA
            Text(
              'Budi Santoso',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            
            // PEKERJAAN
            Text(
              'Flutter Developer',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            
            // INFO CARDS
            _infoCard(context, Icons.email, 'Email', 'budi@example.com'),
            _infoCard(context, Icons.phone, 'Telepon', '+62 812 3456 7890'),
            _infoCard(context, Icons.location_on, 'Alamat', 'Jakarta, Indonesia'),
            _infoCard(context, Icons.language, 'Website', 'www.budi.dev'),
            const SizedBox(height: 24),
            
            // TOMBOL EDIT PROFIL
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profil'),
              ),
            ),
            const SizedBox(height: 12),
            
            // TOMBOL LOGOUT
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // HELPER: Membuat info card
  Widget _infoCard(BuildContext context, IconData icon, String title, String value) => Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: ListTile(
          leading: CircleAvatar(child: Icon(icon)),
          title: Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          subtitle: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      );
}

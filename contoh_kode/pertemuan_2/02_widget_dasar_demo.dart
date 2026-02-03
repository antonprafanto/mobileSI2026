// =============================================================================
// 📱 PERTEMUAN 2 - DEMO 2: WIDGET DASAR
// =============================================================================
// File ini mendemonstrasikan widget dasar Flutter:
// - Text
// - Container
// - Image
// - Icon
// - Button (berbagai jenis)
// - Card & ListTile
// - CircleAvatar
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
      title: 'Widget Dasar Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      home: const WidgetDasarPage(),
    );
  }
}

class WidgetDasarPage extends StatelessWidget {
  const WidgetDasarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Dasar Demo'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =================================================================
            // 1. TEXT WIDGET
            // =================================================================
            _buildSectionTitle('1. Text Widget'),
            const SizedBox(height: 8),

            // Text sederhana
            const Text('Hello World - Text Sederhana'),
            const SizedBox(height: 8),

            // Text dengan styling lengkap
            const Text(
              'Flutter Keren!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                letterSpacing: 2.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 8),

            // Text dengan overflow handling
            const Text(
              'Ini teks yang sangat panjang sekali dan mungkin tidak muat dalam satu baris sehingga akan terpotong...',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),

            const Divider(height: 32),

            // =================================================================
            // 2. CONTAINER WIDGET
            // =================================================================
            _buildSectionTitle('2. Container Widget'),
            const SizedBox(height: 8),

            // Container sederhana
            Container(
              width: double.infinity,
              height: 60,
              color: Colors.blue,
              child: const Center(
                child: Text(
                  'Container Sederhana',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Container dengan BoxDecoration
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                'Container dengan Gradient & Shadow',
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),

            // Container dengan border
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.purple, width: 2),
              ),
              child: const Text('Container dengan Border'),
            ),

            const Divider(height: 32),

            // =================================================================
            // 3. IMAGE WIDGET
            // =================================================================
            _buildSectionTitle('3. Image Widget'),
            const SizedBox(height: 8),

            // Image dari network
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://picsum.photos/400/200',
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 150,
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 150,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, size: 50),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            const Text('(Image dari internet dengan loading & error handler)',
                style: TextStyle(fontSize: 12, color: Colors.grey)),

            const Divider(height: 32),

            // =================================================================
            // 4. ICON WIDGET
            // =================================================================
            _buildSectionTitle('4. Icon Widget'),
            const SizedBox(height: 8),

            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildIconDemo(Icons.home, 'Home', Colors.blue),
                _buildIconDemo(Icons.person, 'Person', Colors.green),
                _buildIconDemo(Icons.settings, 'Settings', Colors.grey),
                _buildIconDemo(Icons.favorite, 'Favorite', Colors.red),
                _buildIconDemo(Icons.star, 'Star', Colors.amber),
                _buildIconDemo(Icons.shopping_cart, 'Cart', Colors.purple),
              ],
            ),

            const Divider(height: 32),

            // =================================================================
            // 5. BUTTON WIDGETS
            // =================================================================
            _buildSectionTitle('5. Button Widgets'),
            const SizedBox(height: 8),

            // ElevatedButton
            ElevatedButton(
              onPressed: () => _showSnackbar(context, 'ElevatedButton ditekan!'),
              child: const Text('ElevatedButton'),
            ),
            const SizedBox(height: 8),

            // ElevatedButton dengan icon
            ElevatedButton.icon(
              onPressed: () => _showSnackbar(context, 'Mengirim...'),
              icon: const Icon(Icons.send),
              label: const Text('Kirim'),
            ),
            const SizedBox(height: 8),

            // Custom styled ElevatedButton
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Custom Styled Button'),
            ),
            const SizedBox(height: 8),

            // TextButton
            TextButton(
              onPressed: () => _showSnackbar(context, 'TextButton ditekan!'),
              child: const Text('TextButton'),
            ),
            const SizedBox(height: 8),

            // OutlinedButton
            OutlinedButton(
              onPressed: () => _showSnackbar(context, 'OutlinedButton ditekan!'),
              child: const Text('OutlinedButton'),
            ),
            const SizedBox(height: 8),

            // Row of IconButtons
            Row(
              children: [
                IconButton(
                  onPressed: () => _showSnackbar(context, 'Home!'),
                  icon: const Icon(Icons.home),
                  color: Colors.blue,
                ),
                IconButton(
                  onPressed: () => _showSnackbar(context, 'Favorite!'),
                  icon: const Icon(Icons.favorite),
                  color: Colors.red,
                ),
                IconButton(
                  onPressed: () => _showSnackbar(context, 'Share!'),
                  icon: const Icon(Icons.share),
                  color: Colors.green,
                ),
                const Text(' ← IconButton'),
              ],
            ),

            const Divider(height: 32),

            // =================================================================
            // 6. CARD & LISTTILE
            // =================================================================
            _buildSectionTitle('6. Card & ListTile'),
            const SizedBox(height: 8),

            // Card sederhana
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: const Text('Card Sederhana'),
              ),
            ),
            const SizedBox(height: 8),

            // Card dengan ListTile
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.person, color: Colors.purple),
                title: const Text('Judul ListTile'),
                subtitle: const Text('Subtitle atau deskripsi'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _showSnackbar(context, 'Card ditekan!'),
              ),
            ),
            const SizedBox(height: 8),

            // Card dengan konten kustom
            Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Card dengan Konten Kustom',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Card bisa berisi berbagai widget sesuai kebutuhan.',
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Action'),
                    ),
                  ],
                ),
              ),
            ),

            const Divider(height: 32),

            // =================================================================
            // 7. CIRCLEAVATAR
            // =================================================================
            _buildSectionTitle('7. CircleAvatar'),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // CircleAvatar dengan icon
                Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.person, size: 40, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    const Text('Icon'),
                  ],
                ),

                // CircleAvatar dengan image
                Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage('https://picsum.photos/100/100'),
                    ),
                    const SizedBox(height: 4),
                    const Text('Image'),
                  ],
                ),

                // CircleAvatar dengan teks
                Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.purple,
                      child: const Text(
                        'BS',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text('Inisial'),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Helper method untuk membuat section title
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.purple,
      ),
    );
  }

  // Helper method untuk demo icon
  Widget _buildIconDemo(IconData icon, String label, Color color) {
    return Column(
      children: [
        Icon(icon, size: 32, color: color),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  // Helper method untuk menampilkan snackbar
  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }
}

// =============================================================================
// 📝 CATATAN PENTING:
// 
// 1. Text: Untuk menampilkan teks dengan berbagai styling
// 2. Container: Widget serbaguna untuk styling dan layout
// 3. Image: Menampilkan gambar dari network atau asset
// 4. Icon: Menampilkan ikon Material Design
// 5. Button: Berbagai jenis tombol untuk interaksi
// 6. Card: Container dengan elevasi untuk grouping konten
// 7. CircleAvatar: Widget lingkaran, biasa untuk foto profil
//
// Tips:
// - Gunakan const untuk widget yang tidak berubah
// - Selalu handle loading dan error untuk Image.network
// - Gunakan BoxDecoration untuk styling Container yang lebih kompleks
// =============================================================================

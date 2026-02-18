# 🔑 KUNCI JAWABAN LATIHAN PERTEMUAN 2

## (Dokumen untuk Dosen/Asisten - TIDAK UNTUK MAHASISWA)

---

## Latihan 1: ProductCard (StatelessWidget)

```dart
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double price;
  final VoidCallback onBuy;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar produk
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
            child: Image.network(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, size: 50),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nama produk
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // Harga
                Text(
                  'Rp ${price.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),

                // Tombol Beli
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onBuy,
                    child: const Text('Beli'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Contoh penggunaan:
// ProductCard(
//   imageUrl: 'https://picsum.photos/200/150',
//   name: 'Laptop Gaming',
//   price: 15000000,
//   onBuy: () => print('Beli diklik!'),
// )
```

---

## Latihan 2: FavoriteButton (StatefulWidget)

```dart
import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  final int initialLikes;

  const FavoriteButton({
    super.key,
    this.initialLikes = 0,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late int _likeCount;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.initialLikes;
  }

  void _toggleLike() {
    setState(() {
      if (_isLiked) {
        _likeCount--;
      } else {
        _likeCount++;
      }
      _isLiked = !_isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: _toggleLike,
          icon: Icon(
            _isLiked ? Icons.favorite : Icons.favorite_border,
            color: _isLiked ? Colors.red : Colors.grey,
            size: 32,
          ),
        ),
        Text(
          '$_likeCount',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// Contoh penggunaan:
// FavoriteButton(initialLikes: 42)
```

---

## Latihan 3: Grid Produk

```dart
import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // Data produk
    final products = [
      {'name': 'Laptop', 'price': 12000000, 'image': 'https://picsum.photos/200/150?random=1'},
      {'name': 'Smartphone', 'price': 5000000, 'image': 'https://picsum.photos/200/150?random=2'},
      {'name': 'Headphone', 'price': 500000, 'image': 'https://picsum.photos/200/150?random=3'},
      {'name': 'Keyboard', 'price': 750000, 'image': 'https://picsum.photos/200/150?random=4'},
      {'name': 'Mouse', 'price': 250000, 'image': 'https://picsum.photos/200/150?random=5'},
      {'name': 'Monitor', 'price': 3000000, 'image': 'https://picsum.photos/200/150?random=6'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Produk')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(
              imageUrl: product['image'] as String,
              name: product['name'] as String,
              price: (product['price'] as int).toDouble(),
              onBuy: () => print('Beli ${product['name']}'),
            );
          },
        ),
      ),
    );
  }
}

// Alternatif tanpa GridView (menggunakan Row & Column):
class ProductGridManual extends StatelessWidget {
  const ProductGridManual({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildCard('Laptop', 12000000)),
              const SizedBox(width: 8),
              Expanded(child: _buildCard('Smartphone', 5000000)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildCard('Headphone', 500000)),
              const SizedBox(width: 8),
              Expanded(child: _buildCard('Keyboard', 750000)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String name, int price) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Icon(Icons.devices, size: 50),
            const SizedBox(height: 8),
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Rp $price'),
          ],
        ),
      ),
    );
  }
}
```

---

## Latihan 4: Theme Switcher

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const ThemeSwitcherApp());
}

class ThemeSwitcherApp extends StatefulWidget {
  const ThemeSwitcherApp({super.key});

  @override
  State<ThemeSwitcherApp> createState() => _ThemeSwitcherAppState();
}

class _ThemeSwitcherAppState extends State<ThemeSwitcherApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _setLightMode() {
    setState(() {
      _themeMode = ThemeMode.light;
    });
  }

  void _setDarkMode() {
    setState(() {
      _themeMode = ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Theme Switcher',
      debugShowCheckedModeBanner: false,

      // Light Theme
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),

      // Dark Theme
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),

      themeMode: _themeMode,

      home: HomePage(
        onLightMode: _setLightMode,
        onDarkMode: _setDarkMode,
        currentMode: _themeMode,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final VoidCallback onLightMode;
  final VoidCallback onDarkMode;
  final ThemeMode currentMode;

  const HomePage({
    super.key,
    required this.onLightMode,
    required this.onDarkMode,
    required this.currentMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Switcher'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              currentMode == ThemeMode.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 20),
            Text(
              currentMode == ThemeMode.dark ? 'Dark Mode' : 'Light Mode',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: onLightMode,
                  icon: const Icon(Icons.light_mode),
                  label: const Text('Light'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: currentMode == ThemeMode.light
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    foregroundColor: currentMode == ThemeMode.light
                        ? Colors.white
                        : null,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: onDarkMode,
                  icon: const Icon(Icons.dark_mode),
                  label: const Text('Dark'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: currentMode == ThemeMode.dark
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    foregroundColor: currentMode == ThemeMode.dark
                        ? Colors.white
                        : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## Praktikum: Halaman Profil (Solusi Lengkap)

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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        centerTitle: true,
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
            // Foto profil
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: colorScheme.primaryContainer,
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: colorScheme.primary,
                  ),
                ),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: colorScheme.primary,
                  child: const Icon(
                    Icons.camera_alt,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Nama
            Text(
              'Budi Santoso',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),

            // Bio
            Text(
              'Flutter Developer • Coffee Lover ☕',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),

            // Info Cards
            const InfoCard(
              icon: Icons.email,
              title: 'Email',
              value: 'budi@email.com',
            ),
            const InfoCard(
              icon: Icons.phone,
              title: 'Telepon',
              value: '+62 812 3456 7890',
            ),
            const InfoCard(
              icon: Icons.location_on,
              title: 'Alamat',
              value: 'Samarinda, Kalimantan Timur',
            ),
            const InfoCard(
              icon: Icons.link,
              title: 'Website',
              value: 'www.budisantoso.dev',
            ),
            const SizedBox(height: 24),

            // Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profil'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  foregroundColor: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
```

---

## 📊 Rubrik Penilaian

### Latihan 1-3 (per latihan):

| Kriteria                        | Poin |
| ------------------------------- | ---- |
| Kode berjalan tanpa error       | 40%  |
| Implementasi sesuai requirement | 30%  |
| Kode rapi dan ada komentar      | 15%  |
| Kreativitas styling             | 15%  |

### Latihan 4 (Theme Switcher):

| Kriteria                                | Poin |
| --------------------------------------- | ---- |
| Theme bisa berubah saat tombol ditekan  | 50%  |
| Menggunakan StatefulWidget dengan benar | 30%  |
| UI menarik                              | 20%  |

### Praktikum (Halaman Profil):

| Kriteria                                        | Poin |
| ----------------------------------------------- | ---- |
| Semua komponen ada (foto, nama, cards, buttons) | 30%  |
| Layout rapi dan proporsional                    | 25%  |
| Custom theme diterapkan                         | 20%  |
| Kode terorganisir (widget terpisah)             | 15%  |
| Kreativitas dan attention to detail             | 10%  |

---

> **RAHASIA - Tidak untuk didistribusikan kepada mahasiswa**

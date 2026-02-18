# 🔑 KUNCI JAWABAN LATIHAN PERTEMUAN 3

## (Dokumen untuk Dosen/Asisten - TIDAK UNTUK MAHASISWA)

---

## Latihan 1: ListView dengan Data Model (Daftar Kontak)

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Model Contact
class Contact {
  final String id;
  final String name;
  final String phone;
  final String email;

  Contact({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Kontak',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const ContactListPage(),
    );
  }
}

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  // Dummy data 10 kontak
  List<Contact> get contacts => [
    Contact(id: '1', name: 'Andi Pratama', phone: '081234567890', email: 'andi@email.com'),
    Contact(id: '2', name: 'Budi Santoso', phone: '081234567891', email: 'budi@email.com'),
    Contact(id: '3', name: 'Citra Dewi', phone: '081234567892', email: 'citra@email.com'),
    Contact(id: '4', name: 'Dimas Aditya', phone: '081234567893', email: 'dimas@email.com'),
    Contact(id: '5', name: 'Eka Putri', phone: '081234567894', email: 'eka@email.com'),
    Contact(id: '6', name: 'Fajar Rahman', phone: '081234567895', email: 'fajar@email.com'),
    Contact(id: '7', name: 'Gita Nirmala', phone: '081234567896', email: 'gita@email.com'),
    Contact(id: '8', name: 'Hadi Wijaya', phone: '081234567897', email: 'hadi@email.com'),
    Contact(id: '9', name: 'Indah Lestari', phone: '081234567898', email: 'indah@email.com'),
    Contact(id: '10', name: 'Joko Susilo', phone: '081234567899', email: 'joko@email.com'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Kontak'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ContactTile(
            contact: contacts[index],
            onTap: () {
              // Bisa ditambahkan navigasi ke detail
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped: ${contacts[index].name}')),
              );
            },
          );
        },
      ),
    );
  }
}

// Custom ContactTile Widget
class ContactTile extends StatelessWidget {
  final Contact contact;
  final VoidCallback onTap;

  const ContactTile({
    super.key,
    required this.contact,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            contact.name[0].toUpperCase(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          contact.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(contact.phone),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
```

---

## Latihan 2: GridView Galeri Foto

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
      title: 'Galeri Foto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      home: const GalleryPage(),
    );
  }
}

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  // Generate 12 foto dari picsum
  List<String> get photos => List.generate(
    12,
    (index) => 'https://picsum.photos/300/300?random=$index',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeri Foto'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,  // 3 kolom
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigasi ke halaman gambar besar
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullImagePage(imageUrl: photos[index]),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                photos[index],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// Halaman gambar besar
class FullImagePage extends StatelessWidget {
  final String imageUrl;

  const FullImagePage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Preview'),
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
```

---

## Latihan 3: Navigasi Multi-halaman

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Models
class Category {
  final String id;
  final String name;
  final IconData icon;

  Category({required this.id, required this.name, required this.icon});
}

class Item {
  final String id;
  final String name;
  final String description;
  final double price;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi-Page Navigation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/categories': (context) => const CategoryListPage(),
        '/items': (context) => const ItemListPage(),
        '/detail': (context) => const ItemDetailPage(),
      },
    );
  }
}

// Halaman 1: Home
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.store, size: 100),
            const SizedBox(height: 20),
            const Text('Selamat Datang!', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/categories'),
              icon: const Icon(Icons.category),
              label: const Text('Lihat Kategori'),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman 2: Daftar Kategori
class CategoryListPage extends StatelessWidget {
  const CategoryListPage({super.key});

  List<Category> get categories => [
    Category(id: '1', name: 'Elektronik', icon: Icons.devices),
    Category(id: '2', name: 'Fashion', icon: Icons.checkroom),
    Category(id: '3', name: 'Makanan', icon: Icons.fastfood),
    Category(id: '4', name: 'Olahraga', icon: Icons.sports_soccer),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kategori')),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            leading: CircleAvatar(child: Icon(category.icon)),
            title: Text(category.name),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/items',
                arguments: category,
              );
            },
          );
        },
      ),
    );
  }
}

// Halaman 3: Daftar Item
class ItemListPage extends StatelessWidget {
  const ItemListPage({super.key});

  List<Item> getItems(String categoryId) {
    // Dummy items berdasarkan kategori
    return [
      Item(id: '1', name: 'Item 1', description: 'Deskripsi item 1', price: 100000),
      Item(id: '2', name: 'Item 2', description: 'Deskripsi item 2', price: 200000),
      Item(id: '3', name: 'Item 3', description: 'Deskripsi item 3', price: 300000),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as Category;
    final items = getItems(category.id);

    return Scaffold(
      appBar: AppBar(title: Text('Items: ${category.name}')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: ListTile(
              title: Text(item.name),
              subtitle: Text('Rp ${item.price.toStringAsFixed(0)}'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: item,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Halaman 4: Detail Item
class ItemDetailPage extends StatelessWidget {
  const ItemDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as Item;

    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[300],
              child: const Icon(Icons.image, size: 100),
            ),
            const SizedBox(height: 16),
            Text(
              item.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Rp ${item.price.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(item.description),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ditambahkan ke keranjang!')),
                  );
                },
                child: const Text('Tambah ke Keranjang'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## Latihan 4: Return Data

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
      title: 'Return Data Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const ProfileFormPage(),
    );
  }
}

// Halaman 1: Form input nama + pilih avatar
class ProfileFormPage extends StatefulWidget {
  const ProfileFormPage({super.key});

  @override
  State<ProfileFormPage> createState() => _ProfileFormPageState();
}

class _ProfileFormPageState extends State<ProfileFormPage> {
  final _nameController = TextEditingController();
  String? _selectedAvatar;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _selectAvatar() async {
    // Navigasi ke halaman pilih avatar dan tunggu result
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const AvatarSelectionPage()),
    );

    // Jika ada result, update state
    if (result != null) {
      setState(() {
        _selectedAvatar = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buat Profil')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar yang dipilih
            GestureDetector(
              onTap: _selectAvatar,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[300],
                backgroundImage: _selectedAvatar != null
                    ? NetworkImage(_selectedAvatar!)
                    : null,
                child: _selectedAvatar == null
                    ? const Icon(Icons.add_a_photo, size: 40)
                    : null,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _selectAvatar,
              child: const Text('Pilih Avatar'),
            ),
            const SizedBox(height: 24),

            // Input nama
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 24),

            // Tombol simpan
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Nama tidak boleh kosong')),
                    );
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Profil disimpan: ${_nameController.text}',
                      ),
                    ),
                  );
                },
                child: const Text('Simpan Profil'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman 2: Pilih Avatar
class AvatarSelectionPage extends StatelessWidget {
  const AvatarSelectionPage({super.key});

  // Daftar avatar dari picsum
  List<String> get avatars => List.generate(
    12,
    (index) => 'https://i.pravatar.cc/150?img=${index + 1}',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Avatar')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: avatars.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Return avatar yang dipilih
              Navigator.pop(context, avatars[index]);
            },
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(avatars[index]),
            ),
          );
        },
      ),
    );
  }
}
```

---

## Praktikum: Katalog Produk (Solusi Lengkap)

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Model Produk
class Product {
  final String id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Katalog Produk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ProductGridPage(),
        '/detail': (context) => const ProductDetailPage(),
      },
    );
  }
}

class ProductGridPage extends StatelessWidget {
  const ProductGridPage({super.key});

  // Dummy data 6 produk
  List<Product> get products => [
    Product(
      id: '1',
      name: 'Laptop Gaming',
      price: 15000000,
      description: 'Laptop gaming dengan spesifikasi tinggi untuk gaming dan produktivitas.',
      imageUrl: 'https://picsum.photos/200?1',
    ),
    Product(
      id: '2',
      name: 'Smartphone Pro',
      price: 8000000,
      description: 'Smartphone flagship dengan kamera 108MP dan layar AMOLED.',
      imageUrl: 'https://picsum.photos/200?2',
    ),
    Product(
      id: '3',
      name: 'Headphone Wireless',
      price: 1500000,
      description: 'Headphone wireless dengan noise cancelling aktif.',
      imageUrl: 'https://picsum.photos/200?3',
    ),
    Product(
      id: '4',
      name: 'Mechanical Keyboard',
      price: 1200000,
      description: 'Keyboard mechanical dengan switch Cherry MX Blue.',
      imageUrl: 'https://picsum.photos/200?4',
    ),
    Product(
      id: '5',
      name: 'Gaming Mouse',
      price: 800000,
      description: 'Mouse gaming dengan sensor 16000 DPI dan RGB lighting.',
      imageUrl: 'https://picsum.photos/200?5',
    ),
    Product(
      id: '6',
      name: 'Monitor 4K',
      price: 5000000,
      description: 'Monitor 4K 27 inch dengan panel IPS dan 144Hz.',
      imageUrl: 'https://picsum.photos/200?6',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Produk'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.7,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            product: product,
            onTap: () {
              Navigator.pushNamed(
                context,
                '/detail',
                arguments: product,
              );
            },
          );
        },
      ),
    );
  }
}

// Widget Product Card
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar produk
            Expanded(
              flex: 3,
              child: Image.network(
                product.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(child: Icon(Icons.image, size: 50)),
                  );
                },
              ),
            ),
            // Info produk
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Text(
                      'Rp ${product.price.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Detail Produk
class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar produk
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(child: Icon(Icons.image, size: 100)),
                  );
                },
              ),
            ),
            // Info produk
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rp ${product.price.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  Text(
                    'Deskripsi Produk',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.chat),
                label: const Text('Chat'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} ditambahkan ke keranjang'),
                    ),
                  );
                },
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Tambah ke Keranjang'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 📊 Rubrik Penilaian

### Latihan 1-4 (per latihan):

| Kriteria                        | Poin |
| ------------------------------- | ---- |
| Kode berjalan tanpa error       | 40%  |
| Implementasi sesuai requirement | 30%  |
| Kode rapi dan ada komentar      | 15%  |
| Kreativitas dan UI              | 15%  |

### Praktikum (Katalog Produk):

| Kriteria                              | Poin |
| ------------------------------------- | ---- |
| GridView dengan minimal 6 produk      | 25%  |
| Navigasi ke detail berfungsi          | 25%  |
| Halaman detail menampilkan semua info | 20%  |
| Menggunakan named routes              | 15%  |
| UI menarik dan proporsional           | 15%  |

### Tugas (Aplikasi Daftar Kontak):

| Kriteria                              | Poin |
| ------------------------------------- | ---- |
| Model class Contact lengkap           | 10%  |
| ListView.builder berfungsi            | 20%  |
| Custom ContactTile dengan Card        | 15%  |
| Navigasi ke detail berfungsi          | 20%  |
| Halaman detail menampilkan semua info | 15%  |
| Named routes digunakan                | 10%  |
| Kode rapi dan ada komentar            | 10%  |

---

> **RAHASIA - Tidak untuk didistribusikan kepada mahasiswa**

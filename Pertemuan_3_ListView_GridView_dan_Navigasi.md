# 📱 PERTEMUAN 3 - ListView GridView dan Navigasi

## ListView, GridView & Navigasi

---

## 🎯 Tujuan Pembelajaran

Setelah mengikuti pertemuan ini, Anda diharapkan mampu:

1. ✅ Menampilkan data dalam ListView
2. ✅ Membuat custom list items  
3. ✅ Mengimplementasikan navigasi antar halaman
4. ✅ Mengirim dan menerima data antar halaman
5. ✅ Menggunakan named routes

---

## ⏱️ TIMELINE SESI (Total: 150 menit)

| Durasi   | Topik | Aktivitas |
|----------|-------|-----------|
| 10 menit | Part 0 | Review & Warm Up |
| 30 menit | Part 1 | ListView Hands-On |
| 20 menit | Part 2 | GridView Hands-On |
| 40 menit | Part 3 | Navigation + Data Passing |
| 10 menit | Part 4 | Named Routes Overview |
| 35 menit | Part 5 | Praktikum Terpandu - Catalog app dengan navigation |
| 5 menit  | Part 6 | Wrap Up + Q&A + checklist |

---

## 📂 RESOURCES

> 💡 **File demo tersedia di folder `contoh_kode/pertemuan_3/`**

| File | Deskripsi |
|------|-----------|
| `01_contact_list_demo.dart` | Contact list dengan ListView |
| `02_product_grid_demo.dart` | Product grid dengan GridView |
| `03_navigation_basic_demo.dart` | Push dan Pop navigation |
| `04_navigation_with_data_demo.dart` | Navigation dengan passing data |
| `05_return_data_demo.dart` | Menerima return value dari page |
| `06_named_routes_demo.dart` | Named routes setup |
| `07_catalog_app_complete.dart` | Catalog app lengkap (praktikum solution) |

---

## 📋 PERSIAPAN SEBELUM MEMULAI

- ✅ Flutter SDK terinstall
- ✅ Editor (VS Code / Android Studio) ready
- ✅ Device / emulator running
- ✅ Review materi Pertemuan 2 (Widget & Layout)

---

## 🔄 PART 0: Review & Warm Up (10 menit)

### Quick Quiz (5 menit)

**Jawab pertanyaan berikut untuk check understanding:**

1. **Apa bedanya StatelessWidget dan StatefulWidget?**
2. **Kapan pakai Column, kapan pakai ListView?**
3. **Apa fungsi `setState`?**
4. **Bagaimana cara membuat widget reusable?**
5. **Apa itu BuildContext?**

> 💡 **JANGAN LANJUT** sebelum yakin paham basic concepts di atas!

### Konsep Hari Ini (5 menit)

**Analogi sederhana:**

> **ListView** = Instagram feed (scroll tak terbatas)  
> **GridView** = Galeri foto (grid layout)  
> **Navigation** = Perpindahan antar halaman seperti buka app lain

**Yang akan kita pelajari:**

1. Menampilkan **banyak data** efisien (lazy loading)
2. Membuat **grid layout** untuk catalog/gallery
3. **Navigasi** antar halaman dengan data
4. **Return value** dari halaman yang ditutup

---

## 📋 PART 1: ListView Hands-On (30 menit)

### 💡 Konsep Dasar: ListView vs Column

**Kapan pakai Column? Kapan pakai ListView?**

```
Column:                    ListView:
┌─────────┐               ┌─────────┐
│ Item 1  │               │ Item 1  │ ← Scroll otomatis
│ Item 2  │               │ Item 2  │ ← Lazy loading  
│ Item 3  │               │ Item 3  │ ← Untuk data banyak (10+)
└─────────┘               │ Item 4  │
                          │ Item 5  │
❌ Tidak bisa scroll      └─────────┘
❌ Semua item dirender    
❌ Untuk item sedikit (<10)
```

**💡 ANALOGI**:

> "Column seperti **daftar di kertas** (terbatas).  
> ListView seperti **feed Instagram** (scroll tak terbatas)."

**Kapan pakai ListView:**
- ✅ Data banyak (>10 items)
- ✅ Butuh scroll
- ✅ Perlu performance (lazy loading)

### ✏️ CODING BERSAMA: Contact List App (25 menit)

**Step 1: Create Contact Model** (3 menit)

Buat file `lib/models/contact.dart`:

```dart
// lib/models/contact.dart
class Contact {
  final String name;
  final String phone;
  final String imageUrl;

  Contact({
    required this.name,
    required this.phone,
    required this.imageUrl,
  });
}
```

**📝 CATATAN**: Model ini simple data class untuk hold contact info.

**Step 2: Create Contact List Page** (10 menit)

Buat file `lib/pages/contact_list_page.dart`:

```dart
// lib/pages/contact_list_page.dart
import 'package:flutter/material.dart';
import '../models/contact.dart';

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data - nanti bisa dari API
    final contacts = [
      Contact(
        name: 'Alice Johnson',
        phone: '+62 812 3456 7890',
        imageUrl: 'https://i.pravatar.cc/150?img=1',
      ),
      Contact(
        name: 'Bob Smith',
        phone: '+62 813 9876 5432',
        imageUrl: 'https://i.pravatar.cc/150?img=2',
      ),
      Contact(
        name: 'Charlie Brown',
        phone: '+62 821 1111 2222',
        imageUrl: 'https://i.pravatar.cc/150?img=3',
      ),
      // Tambah 5 contacts lagi untuk test scroll
      Contact(
        name: 'Diana Prince',
        phone: '+62 822 3333 4444',
        imageUrl: 'https://i.pravatar.cc/150?img=4',
      ),
      Contact(
        name: 'Ethan Hunt',
        phone: '+62 823 5555 6666',
        imageUrl: 'https://i.pravatar.cc/150?img=5',
      ),
      Contact(
        name: 'Fiona Apple',
        phone: '+62 824 7777 8888',
        imageUrl: 'https://i.pravatar.cc/150?img=6',
      ),
      Contact(
        name: 'George Martin',
        phone: '+62 825 9999 0000',
        imageUrl: 'https://i.pravatar.cc/150?img=7',
      ),
      Contact(
        name: 'Hannah Montana',
        phone: '+62 826 1234 5678',
        imageUrl: 'https://i.pravatar.cc/150?img=8',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kontak Saya'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(contact.imageUrl),
            ),
            title: Text(contact.name),
            subtitle: Text(contact.phone),
            onTap: () {
              print('Tapped: ${contact.name}');
            },
          );
        },
      ),
    );
  }
}
```

**Step 3: Update main.dart** (2 menit)

```dart
import 'package:flutter/material.dart';
import 'pages/contact_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pertemuan 3',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ContactListPage(),
    );
  }
}
```

**Hot Reload!** (Ctrl+S atau save file)

✅ You should see scrollable list of 8 contacts!

**💡 PENTING**: 
- `ListView.builder` hanya render items yang visible (lazy loading)
- `itemCount` = jumlah total items
- `itemBuilder` = function yang dipanggil per item

### 🎯 EKSPERIMEN 1: ListView vs Column Performance (5 menit)

**Try this**: Generate 50 contacts!

```dart
final contacts = List.generate(
  50,
  (index) => Contact(
    name: 'Contact ${index + 1}',
    phone: '+62 812 ${index.toString().padLeft(4, '0')} ${index.toString().padLeft(4, '0')}',
    imageUrl: 'https://picsum.photos/seed/${index + 1}/150',
  ),
);
```

**Hot Reload!** Scroll super smooth!

**Now try Column** (bad practice):

```dart
body: SingleChildScrollView(
  child: Column(
    children: contacts.map((contact) {
      return ListTile(/* ... */);
    }).toList(),
  ),
)
```

**Hot Reload!** Scroll laggy karena render ALL 50 items sekaligus!

**🎓 PELAJARAN**: Untuk data banyak, ALWAYS use `ListView.builder`!

### 🎯 EKSPERIMEN 2: Pull-to-Refresh (5 menit)

Upgrade to StatefulWidget dan add RefreshIndicator:

```dart
class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  List<Contact> contacts = [/* ... sama seperti sebelumnya ... */];

  Future<void> _refreshData() async {
    // Simulasi loading dari API
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() {
      // Shuffle contacts untuk demo
      contacts.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kontak Saya')),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView.builder(/* ... sama seperti sebelumnya ... */),
      ),
    );
  }
}
```

**Hot Reload!** Tarik dari atas untuk refresh!

### 💡 Advanced ListView Topics

#### ListView.separated - Garis Pembatas

Untuk add divider/separator between items:

```dart
ListView.separated(
  itemCount: contacts.length,
  separatorBuilder: (context, index) {
    return const Divider(
      thickness: 1,
      height: 1,
      color: Colors.grey,
    );
  },
  itemBuilder: (context, index) {
    return ContactTile(contact: contacts[index]);
  },
)
```

#### ScrollController - Kontrol Scroll Programmatically

```dart
final ScrollController _scrollController = ScrollController();

// In build:
body: Column(
  children: [
    Expanded(
      child: ListView.builder(
        controller: _scrollController,
        /* ... */
      ),
    ),
    FloatingActionButton(
      onPressed: () {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      },
      child: const Icon(Icons.arrow_upward),
    ),
  ],
),

// IMPORTANT: Dispose controller!
@override
void dispose() {
  _scrollController.dispose();
  super.dispose();
}
```

#### Horizontal ListView - Scroll Horizontal

```dart
SizedBox(
  height: 120, // REQUIRED!
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 10,
    itemBuilder: (context, index) {
      return Container(
        width: 100,
        margin: const EdgeInsets.all(8),
        color: Colors.blue,
        child: Center(
          child: Text('Item $index'),
        ),
      );
    },
  ),
)
```

> ⚠️ **TROUBLESHOOTING**:
>
> **Problem**: "ListView items tidak muncul"
> - **Cause**: ListView di dalam Column tanpa Expanded
> - **Fix**: Wrap ListView dengan `Expanded` widget
>
> **Problem**: "Horizontal ListView unbounded width error"
> - **Cause**: Tidak ada height constraint
> - **Fix**: Wrap dengan `SizedBox(height: ...)` 

### 💡 Tips & Best Practices

**DO ✅:**
- Gunakan `ListView.builder` untuk data > 10 items
- Gunakan `const` untuk widget yang tidak berubah
- Add `separatorBuilder` jika butuh divider
- Dispose ScrollController saat tidak dipakai

**DON'T ❌:**
- Jangan pakai Column untuk data banyak
- Jangan render semua items sekaligus
- Jangan lupa dispose controller

---

## 🔲 PART 2: GridView Hands-On (20 menit)

### 💡 Konsep Dasar: GridView vs ListView

**Kapan pakai GridView? Kapan pakai ListView?**

```
ListView (1 kolom):          GridView (multiple kolom):
┌─────────────┐             ┌─────┬─────┬─────┐
│   Item 1    │             │  1  │  2  │  3  │
├─────────────┤             ├─────┼─────┼─────┤
│   Item 2    │             │  4  │  5  │  6  │
├─────────────┤             ├─────┼─────┼─────┤
│   Item 3    │             │  7  │  8  │  9  │
└─────────────┘             └─────┴─────┴─────┘

Untuk list items      Untuk gallery/catalog
```

**💡 ANALOGI**:

> "ListView = Daftar kontak (vertical).  
> GridView = Etalase toko (grid produk)."

**Kapan pakai GridView:**
- ✅ Gallery / Photo grid
- ✅ Product catalog
- ✅ Icon grid / App drawer
- ✅ Calendar / Date picker

### ✏️ CODING BERSAMA: Product Grid (15 menit)

**Step 1: Create Product Model** (3 menit)

Buat file `lib/models/product.dart`:

```dart
// lib/models/product.dart
class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
  });
}
```

**Step 2: Create ProductCard Widget** (7 menit)

Buat file `lib/widgets/product_card.dart`:

```dart
// lib/widgets/product_card.dart
import 'package:flutter/material.dart';
import '../models/product.dart';

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
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image takes available space
            Expanded(
              child: Image.network(
                product.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.image,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            // Product info
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp ${product.price.toStringAsFixed(0)}',
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

**Step 3: Create ProductGridPage** (10 menit)

Buat file `lib/pages/product_grid_page.dart`:

```dart
// lib/pages/product_grid_page.dart
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class ProductGridPage extends StatelessWidget {
  const ProductGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy products
    final products = [
      Product(
        id: 1,
        name: 'Laptop Gaming',
        price: 15000000,
        imageUrl: 'https://picsum.photos/seed/laptop/300',
        category: 'Electronics',
      ),
      Product(
        id: 2,
        name: 'Smartphone Pro',
        price: 8000000,
        imageUrl: 'https://picsum.photos/seed/phone/300',
        category: 'Electronics',
      ),
      Product(
        id: 3,
        name: 'Headphones',
        price: 500000,
        imageUrl: 'https://picsum.photos/seed/headphone/300',
        category: 'Audio',
      ),
      Product(
        id: 4,
        name: 'Smart Watch',
        price: 3000000,
        imageUrl: 'https://picsum.photos/seed/watch/300',
        category: 'Wearables',
      ),
      Product(
        id: 5,
        name: 'Camera DSLR',
        price: 12000000,
        imageUrl: 'https://picsum.photos/seed/camera/300',
        category: 'Photography',
      ),
      Product(
        id: 6,
        name: 'Tablet Pro',
        price: 7000000,
        imageUrl: 'https://picsum.photos/seed/tablet/300',
        category: 'Electronics',
      ),
      Product(
        id: 7,
        name: 'Gaming Mouse',
        price: 800000,
        imageUrl: 'https://picsum.photos/seed/mouse/300',
        category: 'Gaming',
      ),
      Product(
        id: 8,
        name: 'Mechanical Keyboard',
        price: 1500000,
        imageUrl: 'https://picsum.photos/seed/keyboard/300',
        category: 'Gaming',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Produk'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index],
            onTap: () {
              print('Tapped: ${products[index].name}');
            },
          );
        },
      ),
    );
  }
}
```

**Hot Reload!** Grid of 8 products muncul!

### 🎯 EKSPERIMEN 1: CrossAxisCount - Ubah Jumlah Kolom (3 menit)

Try different column counts:

**2 Kolom** (default):
```dart
crossAxisCount: 2,
```

**3 Kolom**:
```dart
crossAxisCount: 3,
```

**4 Kolom**:
```dart
crossAxisCount: 4,
```

Visualisasi:
```
2 kolom:          3 kolom:        4 kolom:
┌────┬────┐      ┌───┬───┬───┐   ┌──┬──┬──┬──┐
│ 1  │ 2  │      │ 1 │ 2 │ 3 │   │1 │2 │3 │4 │
├────┼────┤      ├───┼───┼───┤   ├──┼──┼──┼──┤
│ 3  │ 4  │      │ 4 │ 5 │ 6 │   │5 │6 │7 │8 │
└────┴────┘      └───┴───┴───┘   └──┴──┴──┴──┘
```

**🎓 PELAJARAN**: `crossAxisCount` = jumlah kolom horizontal

### 🎯 EKSPERIMEN 2: ChildAspectRatio - Ubah Bentuk Item (3 menit)

**Ratio 1.0** (kotak/square):
```dart
childAspectRatio: 1.0,
```

**Ratio 0.75** (portrait - lebih tinggi):
```dart
childAspectRatio: 0.75,
```

**Ratio 1.5** (landscape - lebih lebar):
```dart
childAspectRatio: 1.5,
```

**💡 ANALOGI**:

> "Aspect ratio seperti bentuk kotak:
> - 1.0 = Rubik cube (kotak sempurna)
> - 0.75 = Smartphone (vertikal)
> - 1.5 = Laptop screen (horizontal)"

### 🎯 EKSPERIMEN 3 (BONUS): MaxCrossAxisExtent - Responsive Grid (2 menit)

Instead of fixed columns, use max width per item:

```dart
gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
  maxCrossAxisExtent: 150, // Max 150px per item
  crossAxisSpacing: 12,
  mainAxisSpacing: 12,
  childAspectRatio: 0.75,
),
```

**Result**: Jumlah kolom adjust otomatis based on screen width!
- Small screen (360px) → 2 kolom
- Medium screen (540px) → 3 kolom
- Large screen (720px) → 4 kolom

> ⚠️ **TROUBLESHOOTING**:
>
> **Problem**: "GridView tidak muncul / blank"
> - **Cause**: GridView di dalam Column tanpa Expanded
> - **Fix**: Wrap dengan `Expanded`
>
> **Problem**: "Images tidak load"
> - **Cause**: Network issue atau URL salah
> - **Fix**: Add `errorBuilder` (sudah ada di code)
>
> **Problem**: "Bottom overflowed by X pixels"
> - **Cause**: Text terlalu panjang atau aspectRatio salah
> - **Fix**: Gunakan `maxLines` + `overflow: TextOverflow.ellipsis`

### 💡 Tips & Best Practices

**DO ✅:**
- Gunakan `.builder` untuk data > 10 items
- Add loading & error builders untuk images
- Gunakan `childAspectRatio` untuk control item shape
- Consider `MaxCrossAxisExtent` untuk responsive layout

**DON'T ❌:**
- Jangan hardcode image size inside GridView
- Jangan lupa `Expanded` untuk image widget
- Jangan pakai GridView untuk list items (use ListView)

---

## 🧭 PART 3: Navigation + Passing Data (40 menit)

### 💡 Konsep Stack Navigation

Flutter menggunakan konsep **Stack** (tumpukan) untuk navigasi.

**Visualisasi:**

```
Awal:                Push:                Pop:
┌─────────┐         ┌─────────┐         ┌─────────┐
│         │         │ Page B  │ ← Top   │         │
│         │         ├─────────┤         │         │
│ Page A  │ ← Top   │ Page A  │         │ Page A  │ ← Top
└─────────┘         └─────────┘         └─────────┘

                    Add new page        Remove top page
```

**💡 ANALOGI**:

> "Navigator seperti tumpukan buku di meja:
> - **Push** = Taruh buku baru di atas tumpukan
> - **Pop** = Ambil buku paling atas
> - **Yang di atas** = Halaman yang terlihat user"

### ✏️ CODING BERSAMA: Multi-Page App (20 menit)

**Step 1: Create Product Detail Page** (8 menit)

Buat file `lib/pages/product_detail_page.dart`:

```dart
// lib/pages/product_detail_page.dart
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Large image
            Image.network(
              product.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 300,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, size: 100),
                );
              },
            ),
            // Product info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rp ${product.price.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      product.category,
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Deskripsi Produk',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              print('Add to cart: ${product.name}');
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: const Text(
              'Tambah ke Keranjang',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
```

**Step 2: Navigate dari Grid ke Detail** (5 menit)

Update `ProductGridPage` - ganti `onTap`:

```dart
itemBuilder: (context, index) {
  return ProductCard(
    product: products[index],
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailPage(
            product: products[index],
          ),
        ),
      );
    },
  );
},
```

**Hot Reload & Test!** Tap produk → Detail page muncul!

**💡 PENTING**: 
- `Navigator.push` menambah halaman baru di atas stack
- `MaterialPageRoute` mengatur transition animation
- `builder` function creates the destination page

**Step 3: Test Push & Pop** (7 menit)

1. **Tap** salah satu product → Detail page muncul
2. **Tap back button** di appBar → Kembali ke grid
3. **Tap** product lain → Detail page baru muncul

**Visualisasi apa yang terjadi:**

```
Awal (Grid):          Tap Product 1:        Tap Back:
┌───────────┐        ┌───────────┐         ┌───────────┐
│   Grid    │ ← Top  │  Detail 1 │ ← Top   │   Grid    │ ← Top  
└───────────┘        ├───────────┤         └───────────┘
                     │   Grid    │
                     └───────────┘
```

### 🎯 EKSPERIMEN 1: Return Data dari Detail Page (15 menit)

**Task**: Tambah fitur rating di detail page, return rating ke grid!

**Step 1**: Modifikasi ProductDetailPage untuk return rating

```dart
// Ganti ElevatedButton di bottomNavigationBar:
ElevatedButton(
  onPressed: () {
    Navigator.pop(context, 5); // Return rating 5
  },
  child: const Text('Beri Rating & Kembali'),
)
```

**Step 2**: Terima return value di ProductGridPage

```dart
onTap: () async {
  final rating = await Navigator.push<int>(
    context,
    MaterialPageRoute(
      builder: (context) => ProductDetailPage(
        product: products[index],
      ),
    ),
  );
  
  if (rating != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Rating ${products[index].name}: $rating ⭐',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
},
```

**Hot Reload & Test!** Snackbar muncul dengan rating!

### 🎯 EKSPERIMEN 2: Navigator.pushReplacement (5 menit)

**Visualisasi:**

```
push:                      pushReplacement:
┌─────────┐               ┌─────────┐
│ Page C  │ ← New         │ Page C  │ ← New
├─────────┤               └─────────┘
│ Page B  │               (Page B diganti)
├─────────┤
│ Page A  │
└─────────┘
```

**Kapan Pakai pushReplacement?**
- ✅ Login → Home (tidak bisa back ke login)
- ✅ Splash → Home
- ✅ Payment Success → Order List

**💡 ANALOGI**: "push = Tambah buku baru. pushReplacement = Ganti buku paling atas."

> ⚠️ **TROUBLESHOOTING**:
>
> **Problem**: "Navigator operation requested with a context..."
> - **Cause**: Context salah (dari MaterialApp)
> - **Fix**: Gunakan context dari widget di DALAM MaterialApp
>
> **Problem**: "Multiple heroes that share the same tag"
> - **Cause**: Dua widget dengan Hero tag sama
> - **Fix**: Gunakan unique tag: `Hero(tag: 'product-${product.id}')`

### 💡 Tips & Best Practices

**DO ✅:**
- Gunakan constructor untuk passing data (type-safe)
- `await` Navigator.push jika butuh return value
- Gunakan `pushReplacement` untuk flow yang tidak boleh back
- Dispose controller/listener saat pop

**DON'T ❌:**
- Jangan push terlalu banyak halaman (deep stack)
- Jangan lupa handle null return value
- Jangan gunakan global variable untuk passing data
- Jangan pakai `pushReplacement` jika user perlu back

---

## 🗺️ PART 4: Named Routes - Quick Overview (10 menit)

> 📝 **NOTE**: Named routes adalah topik advanced. Untuk pertemuan ini, kita hanya **kenalan dulu**.

### Before vs After

**Before (Tanpa Named Routes):**
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => DetailPage()),
);
```

**After (Dengan Named Routes):**
```dart
// Setup di main.dart
routes: {
  '/': (context) => HomePage(),
  '/detail': (context) => DetailPage(),
},

// Navigate
Navigator.pushNamed(context, '/detail');
```

**💡 ANALOGI**: "Bayangkan peta - lebih mudah sebut nama tempat (/home, /detail) daripada alamat lengkap!"

**Kapan Pakai Named Routes?**
- ✅ App punya banyak halaman (>5)
- ✅ Perlu deep linking
- ❌ Skip jika app simple (2-3 halaman)

---

## 🛠️ PART 5: Praktikum Terpandu - Catalog App (35 menit)

### 🎯 Tujuan

Buat **Mini E-Commerce App** dengan:
1. ✅ Product Grid (GridView)
2. ✅ Product Detail Page (Navigation)
3. ✅ Add to Cart (Return data)
4. ✅ Cart counter badge

### Step 1: Add Cart State (5 menit)

Convert ProductGridPage to StatefulWidget:

```dart
class ProductGridPage extends StatefulWidget {
  const ProductGridPage({super.key});

  @override
  State<ProductGridPage> createState() => _ProductGridPageState();
}

class _ProductGridPageState extends State<ProductGridPage> {
  int cartCount = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Produk'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
              if (cartCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$cartCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: GridView.builder(/* ... */),
    );
  }
}
```

### Step 2: Update ProductDetailPage (5 menit)

```dart
ElevatedButton(
  onPressed: () {
    Navigator.pop(context, true); // Return true = added
  },
  child: const Text('Tambah ke Keranjang'),
)
```

### Step 3: Handle Return Value (10 menit)

```dart
onTap: () async {
  final result = await Navigator.push<bool>(
    context,
    MaterialPageRoute(
      builder: (context) => ProductDetailPage(
        product: products[index],
      ),
    ),
  );
  
  if (result == true) {
    setState(() {
      cartCount++;
    });
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${products[index].name} ditambahkan ke keranjang!'),
        ),
      );
    }
  }
},
```

**Test!** Badge updates saat add to cart!

---

## 🎯 PART 6: Wrap Up & Review (5 menit)

### ✅ Yang Sudah Dipelajari

1. **ListView.builder** - Efficient scrolling lists
2. **GridView.builder** - Grid layouts  
3. **Navigator.push/pop** - Navigation dengan stack
4. **Passing Data** - Via constructor
5. **Return Data** - Terima value dari halaman tertutup

### 🏆 Achievement Unlocked

- ✅ Bisa buat scrollable list
- ✅ Bisa buat product grid
- ✅ Bisa navigasi antar halaman
- ✅ Bisa kirim/terima data
- ✅ Buat multi-page app

### 📝 Tugas Rumah

Kembangkan Catalog App dengan:

1. **Category Filter** (MEDIUM) - Filter by category
2. **Search** (MEDIUM) - Search bar
3. **Cart Page** (HARD) - Full cart page
4. **Rating** (EASY) - Add product ratings

**Deadline**: Sebelum Pertemuan 4

---

## ❓ FAQ - Frequently Asked Questions

### Q1: Kapan pakai ListView vs GridView vs SingleChildScrollView?

**A**: 
- `ListView` → Data banyak, 1 kolom vertikal
- `GridView` → Data banyak, multiple kolom
- `SingleChildScrollView` → Content sedikit/static

**Rule**: Data > 10 items → WAJIB pakai .builder!

### Q2: Bedanya push, pushReplacement, pushAndRemoveUntil?

**A**:
- `push` → Tambah halaman (bisa back)
- `pushReplacement` → Ganti halaman (tidak bisa back)
- `pushAndRemoveUntil` → Push + hapus semua sebelumnya

### Q3: Kenapa images tidak muncul?

**A**: 
1. Network issue → Cek internet
2. URL salah → Verify di browser
3. Tidak ada errorBuilder → Add error handling

**Fix**: Selalu add `loadingBuilder` dan `errorBuilder`!

### Q4: Error "RenderBox was not laid out"?

**A**: Widget butuh constraint tapi tidak dapat.

**Fix**:
```dart
Column(
  children: [
    Expanded( // ← ADD THIS!
      child: ListView.builder(/* ... */),
    ),
  ],
)
```

### Q5: Cara pass multiple data ke halaman baru?

**A**: 

**Best - Multiple constructor parameters**:
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailPage(
      product: product,
      userId: userId,
      isFromCart: true,
    ),
  ),
);
```

### Q6: Apa itu `mounted` dan kenapa perlu cek?

**A**: `mounted` cek apakah widget masih di tree.

**Fix**:
```dart
Future<void> loadData() async {
  await Future.delayed(Duration(seconds: 2));
  if (mounted) { // ✅ Safe!
    setState(() {});
  }
}
```

### Q7: Cara buat Hero animation?

**A**: 

**Grid Page**:
```dart
Hero(
  tag: 'product-${product.id}',
  child: Image.network(product.imageUrl),
)
```

**Detail Page**:
```dart
Hero(
  tag: 'product-${product.id}', // SAME tag!
  child: Image.network(product.imageUrl),
)
```

Result: Image "terbang" dengan smooth animation! ✨

### Q8: Cara handle async operation saat navigate?

**A**:
```dart
onTap: () async {
  showDialog(/* loading */);
  final data = await fetchData();
  Navigator.pop(context); // Hide loading
  
  if (mounted) {
    await Navigator.push(/* ... */);
  }
}
```

---

## 👨‍🏫 FOR INSTRUCTORS ONLY

> 📌 Instruksi untuk Dosen/Instruktur

### Persiapan Sebelum Kelas (30 menit)

1. **Test All Code**
   - Run semua demo files
   - Verify images load
   - Test pada device fisik

2. **Prepare Backup Plan**
   - Download local images jika internet unstable
   - Prepare screenshots
   - Backup project

3. **Setup Classroom**
   - Projector tested
   - Sample app running
   - WiFi stable

### Timeline Management

**STRICT timing untuk 150 menit**:
- Part 0: 10 min (skip quiz jika slow)
- Part 1: 30 min (bisa skip horizontal ListView)
- Part 2: 20 min (skip Experiment 3 jika perlu)
- Part 3: 40 min (JANGAN potong - core!)  
- Part 4: 10 min (concept only)
- Part 5: 35 min (students code along)
- Part 6: 5 min

**Jika waktu kurang**: Skip Part 4, fokus praktikum.

### Common Student Mistakes

1. **Lupa import** - Remind to check imports
2. **Typo** - `requierd` instead of `required`
3. **Null safety** - Lupa `?` atau `!`
4. **Context error** - Wrong widget context
5. **setState di async** - Lupa cek `mounted`

### Grading Praktikum

**Quick grading**:
- 50% = Code runs
- 70% = All features work
- 85% = Code clean
- 95%+ = Bonus features

### Discussion Prompts

- "Apa app favorit kalian yang pakai GridView?"
- "Pernah experience app yang navigation-nya membingungkan?"

### Differentiation

**Fast learners**:
- Hero animation
- Full cart page
- Sort & filter

**Struggling students**:
- Provide skeleton code
- Pair programming
- Focus on cart logic only

---

**🎉 Pertemuan 3 Complete!**

**Next**: Pertemuan 4 - Forms, Input & Validation



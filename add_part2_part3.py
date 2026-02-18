# -*- coding: utf-8 -*-
"""Append Part 2 and Part 3 to Pertemuan 3"""

part2_content = """
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
"""

# Append to file
with open('Pertemuan_3_ListView_GridView_dan_Navigasi.md', 'a', encoding='utf-8') as f:
    f.write(part2_content)

print("✅ Part 2 & Part 3 appended successfully!")
print("Total new lines:", len(part2_content.split('\n')))

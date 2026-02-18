# -*- coding: utf-8 -*-
"""Append Part 4-6, FAQ, Instructor section"""

final_content = """
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
"""

# Append final content
with open('Pertemuan_3_ListView_GridView_dan_Navigasi.md', 'a', encoding='utf-8') as f:
    f.write(final_content)

print("✅ ALL PARTS COMPLETE!")
print("File: Pertemuan_3_ListView_GridView_dan_Navigasi.md")
print("Total final lines:", len(final_content.split('\n')))

# Verify emoji in file
with open('Pertemuan_3_ListView_GridView_dan_Navigasi.md', 'r', encoding='utf-8') as f:
    content = f.read()
    print("\n📊 Verification:")
    print(f"Total file length: {len(content)} characters")
    print(f"Contains 📱: {' 📱 PERTEMUAN' in content}")
    print(f"Contains 🎯: {'🎯 Tujuan' in content}")
    print(f"Contains ✅: {'✅ Menampilkan' in content}")
    print(f"First 100 chars:", content[:100])

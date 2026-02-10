# 📱 PERTEMUAN 3 - LIVE CODING

## ListView, GridView & Navigasi

---

## 🎯 Tujuan Pembelajaran

Setelah mengikuti pertemuan ini, Anda diharapkan mampu:

1. ✅ Menampilkan data dalam ListView dan GridView
2. ✅ Membuat custom list item
3. ✅ Mengimplementasikan navigasi antar halaman
4. ✅ Mengirim dan menerima data antar halaman
5. ✅ Menggunakan named routes

---

## 📂 RESOURCES

> 💡 **File demo tersedia di folder `contoh_kode/pertemuan_3/`**

| File                           | Topik                               |
| ------------------------------ | ----------------------------------- |
| `01_contact_list_demo.dart`    | ListView.builder dengan custom item |
| `02_product_grid_demo.dart`    | GridView.builder untuk product grid |
| `03_navigation_demo.dart`      | Navigator push dan pop              |
| `04_data_passing_demo.dart`    | Passing data via constructor        |
| `05_return_data_demo.dart`     | Return data dari halaman            |
| `06_named_routes_demo.dart`    | Named routes setup                  |
| `07_catalog_app_complete.dart` | Solusi lengkap praktikum            |

---

## ⏱️ TIMELINE SESI (Total: 150 menit)

| Waktu    | Bagian | Topik                | Aktivitas                                   |
| -------- | ------ | -------------------- | ------------------------------------------- |
| 10 menit | Part 0 | Review & Setup       | Quiz cepat + setup project                  |
| 30 menit | Part 1 | ListView Hands-On    | Builder demo + custom item + experiment     |
| 20 menit | Part 2 | GridView Hands-On    | Product grid demo + aspect ratio experiment |
| 40 menit | Part 3 | Navigation + Data    | Push/pop + passing data integrated          |
| 10 menit | Part 4 | Named Routes (Quick) | Show setup, reference untuk later           |
| 35 menit | Part 5 | Praktikum Terpandu   | Catalog app dengan navigation               |
| 5 menit  | Part 6 | Wrap Up              | Q&A + checklist                             |

---

## 📋 PERSIAPAN SEBELUM MEMULAI

### ✅ Checklist Persiapan:

- [ ] Flutter SDK installed & verified (`flutter doctor`)
- [ ] VS Code dengan Flutter extension
- [ ] Sudah menyelesaikan tugas Pertemuan 2
- [ ] Memahami StatefulWidget & setState
- [ ] Familiar dengan MaterialApp & Scaffold

### 🎬 Setup Project Baru:

```bash
# Ketik bersama:
flutter create demo_pertemuan3
cd demo_pertemuan3
code .
```

**Hot Reload shortcut**: Tekan `r` di terminal setelah save file.

---

## 🚀 PART 0: Review & Warm Up (10 menit)

### Quiz Cepat (5 menit)

Pertanyaan untuk mengecek pemahaman:

1. ❓ Apa perbedaan StatelessWidget dan StatefulWidget?
2. ❓ Widget apa yang dipakai untuk layout horizontal?
3. ❓ Apa fungsi `SingleChildScrollView`?
4. ❓ Bagaimana cara menggunakan `CircleAvatar` untuk foto profil?
5. ❓ Apa fungsi `Theme.of(context)`?

> 💡 Jika belum bisa menjawab, review materi Pertemuan 2!

### Konsep Penting (5 menit)

```
📌 KONSEP PENTING PERTEMUAN INI:

ListView & GridView = Scrollable widgets untuk menampilkan data banyak
Navigator = System navigasi antar halaman (menggunakan stack)

Analogi Sederhana:
• ListView = Instagram feed (scroll vertikal satu-satu)
• GridView = Galeri foto (kotak-kotak)
• Navigator = Tumpukan buku (push = naruh buku, pop = ambil buku)
```

---

## 📋 PART 1: ListView Hands-On (30 menit)

### 💡 Konsep Dasar: ListView vs Column

**Kapan pakai Column? Kapan pakai ListView?**

```
Bedanya dengan Column:
┌─────────────────────────────────────────────────────────────┐
│              Column                    ListView             │
├─────────────────────────────────────────────────────────────┤
│ • Tidak bisa scroll otomatis   │ • Otomatis scrollable      │
│ • Semua item dirender          │ • Hanya item terlihat      │
│ • Untuk item sedikit (<10)     │ • Untuk item banyak (10+)  │
│ • Perlu SingleChildScrollView  │ • Sudah include scroll     │
└─────────────────────────────────────────────────────────────┘
```

**💡 ANALOGI**:

> "Column seperti foto grup yang dicetak semua sekaligus.
> ListView seperti scroll Instagram - hanya muat foto yang terlihat di layar, sisanya di-load saat scroll."

### ✏️ CODING BERSAMA: Contact List App

**Step 1: Create Contact Model** (5 menit)

Buat folder baru `lib/models/` dan file `contact.dart`:

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

**📝 CATATAN**: Model ini untuk menyimpan data kontak. Properties-nya final karena data tidak berubah setelah dibuat.

**Step 2: Create Contact List Page** (10 menit)

Buat file baru `lib/pages/contact_list_page.dart`:

```dart
// lib/pages/contact_list_page.dart
import 'package:flutter/material.dart';
import '../models/contact.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  // Dummy data contacts
  final List<Contact> contacts = [
    Contact(
      name: 'Budi Santoso',
      phone: '+62 812-3456-7890',
      imageUrl: 'https://i.pravatar.cc/150?img=1',
    ),
    Contact(
      name: 'Siti Aminah',
      phone: '+62 813-9876-5432',
      imageUrl: 'https://i.pravatar.cc/150?img=2',
    ),
    Contact(
      name: 'Ahmad Fauzi',
      phone: '+62 815-1111-2222',
      imageUrl: 'https://i.pravatar.cc/150?img=3',
    ),
    Contact(
      name: 'Dewi Lestari',
      phone: '+62 821-3333-4444',
      imageUrl: 'https://i.pravatar.cc/150?img=4',
    ),
    Contact(
      name: 'Rizki Pratama',
      phone: '+62 822-5555-6666',
      imageUrl: 'https://i.pravatar.cc/150?img=5',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kontak Saya'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: contacts.length,  // Jumlah item
        itemBuilder: (context, index) {
          // Builder dipanggil untuk SETIAP item
          final contact = contacts[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(contact.imageUrl),
            ),
            title: Text(contact.name),
            subtitle: Text(contact.phone),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
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

**Step 3: Update main.dart**

Ganti `home:` di MaterialApp:

```dart
// lib/main.dart
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
      debugShowCheckedModeBanner: false,
      title: 'Pertemuan 3',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const ContactListPage(),
    );
  }
}
```

**Hot Reload** → Lihat contact list muncul!

**💡 PENTING**: Perhatikan `itemBuilder` dipanggil untuk setiap item. Ini yang disebut **lazy loading** - hanya render item yang terlihat di layar.

**Visualisasi cara kerja ListView.builder:**

```
Data: [A, B, C, D, E, F, G, H, I, J, ...]

Layar (hanya render yang terlihat):
┌─────────────────┐
│  A  ← rendered  │
│  B  ← rendered  │
│  C  ← rendered  │
│  D  ← rendered  │
│  E  ← rendered  │
└─────────────────┘
   F  ← belum dirender
   G  ← belum dirender
   ...

Saat scroll ke bawah, F dan G baru di-render!
```

**💡 ANALOGI**:

> "itemBuilder seperti pabrik. Tidak buat semua produk sekaligus, tapi buat satu-satu saat dibutuhkan. Lebih efisien!"

> ⚠️ **TROUBLESHOOTING**:
>
> **Problem**: "RenderBox was not laid out"
>
> - **Cause**: ListView di dalam Column tanpa Expanded
> - **Fix**: Wrap ListView dengan `Expanded`:
>   ```dart
>   Column(
>     children: [
>       Text('Header'),
>       Expanded(  // ← Tambahkan ini!
>         child: ListView.builder(...),
>       ),
>     ],
>   )
>   ```
>
> **Problem**: "The getter 'length' was called on null"
>
> - **Cause**: List contacts belum diinisialisasi
> - **Fix**: Initialize dengan empty list:
>   ```dart
>   final List<Contact> contacts = [];
>   ```

### Step 4: Custom List Item (10 menit)

Buat widget terpisah untuk custom list item:

```dart
// lib/widgets/contact_tile.dart
import 'package:flutter/material.dart';
import '../models/contact.dart';

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
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(contact.imageUrl),
        ),
        title: Text(
          contact.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.phone, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(contact.phone),
              ],
            ),
          ],
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}
```

Update `ContactListPage` untuk gunakan `ContactTile`:

```dart
// Dalam ListView.builder, ganti return statement:
itemBuilder: (context, index) {
  return ContactTile(
    contact: contacts[index],
    onTap: () {
      print('Tapped: ${contacts[index].name}');
    },
  );
},
```

**Hot Reload** → Sekarang list lebih menarik dengan Card!

### 🎯 EKSPERIMEN 1: ListView vs Column

**Task**: Mari buktikan bedanya Column dan ListView!

1. **Buat 50 items** - Tambah lebih banyak dummy data:

   ```dart
   final List<Contact> contacts = List.generate(
     50,
     (index) => Contact(
       name: 'Contact ${index + 1}',
       phone: '+62 812-${1000 + index}',
       imageUrl: 'https://i.pravatar.cc/150?img=${(index % 70) + 1}',
     ),
   );
   ```

2. **Ganti ListView dengan Column**:

   ```dart
   // Ganti ini:
   ListView.builder(...)

   // Dengan ini:
   SingleChildScrollView(
     child: Column(
       children: contacts.map((contact) => ContactTile(...)).toList(),
     ),
   )
   ```

3. **Hot Reload** → Lihat: Loading lebih lambat karena semua 50 items di-render sekaligus!

4. **Kembalikan ke ListView.builder** → Hot Reload → Lebih cepat!

**🎯 Lesson**: ListView.builder lebih efisien untuk data banyak!

### 🎯 EKSPERIMEN 2: Pull-to-Refresh

**Task**: Tambahkan fitur "tarik untuk refresh"

Wrap ListView dengan `RefreshIndicator`:

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Kontak Saya')),
    body: RefreshIndicator(
      onRefresh: _refreshData,  // Fungsi yang dipanggil saat refresh
      child: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ContactTile(
            contact: contacts[index],
            onTap: () => print('Tapped: ${contacts[index].name}'),
          );
        },
      ),
    ),
  );
}

// Tambahkan method ini:
Future<void> _refreshData() async {
  // Simulasi loading dari server
  await Future.delayed(const Duration(seconds: 2));

  setState(() {
    // Update UI (misal: shuffle data)
    contacts.shuffle();
  });
}
```

**Hot Reload** → Tarik ke bawah → Data di-shuffle!

### 💡 Tips & Best Practices

**DO ✅:**

- Gunakan `.builder` untuk data > 10 items
- Pisahkan custom item ke widget terpisah (reusable!)
- Gunakan `const` untuk widget yang tidak berubah
- Tambahkan `itemExtent` jika semua item sama tinggi:
  ```dart
  ListView.builder(
    itemExtent: 72.0,  // Tinggi tetap, lebih cepat render!
    itemBuilder: ...,
  )
  ```

**DON'T ❌:**

- Jangan gunakan `ListView(children: ...)` untuk data banyak
- Jangan buat widget kompleks di dalam `itemBuilder` - extract ke class
- Jangan panggil `setState` terlalu sering saat scroll

---
### ?? Advanced ListView Topics

#### ListView.separated - Garis Pembatas

Menambahkan **divider** (garis pembatas) antar item secara otomatis:

```dart
ListView.separated(
  itemCount: contacts.length,
  separatorBuilder: (context, index) {
    // Builder untuk pembatas
    return const Divider(
      thickness: 1,
      height: 1,
      color: Colors.grey,
    );
  },
  itemBuilder: (context, index) {
    return ContactTile(
      contact: contacts[index],
      onTap: () => print('Tapped: {contacts[index].name}'),
    );
  },
)
```

**Visualisasi:**

```
+-----------------+
�   Contact 1     �
+-----------------�  ? Divider
�   Contact 2     �
+-----------------�  ? Divider
�   Contact 3     �
+-----------------+
```

**?? CATATAN**: `separatorBuilder` dipanggil untuk setiap gap antar item. Item terakhir tidak punya separator.

#### ScrollController - Kontrol Scroll Programmatically

Untuk scroll ke posisi tertentu dengan kode:

```dart
class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  final ScrollController _scrollController = ScrollController();
  final List<Contact> contacts = [...];  // Data contacts

  @override
  void dispose() {
    _scrollController.dispose();  // PENTING: Dispose untuk avoid memory leak!
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,  // Posisi awal (top)
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kontak Saya')),
      body: ListView.builder(
        controller: _scrollController,  // Attach controller
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ContactTile(
            contact: contacts[index],
            onTap: () => print('Tapped: {contacts[index].name}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollToTop,
        child: const Icon(Icons.arrow_upward),
        tooltip: 'Scroll to Top',
      ),
    );
  }
}
```

**?? ANALOGI**:

> "ScrollController seperti remote control elevator - bisa langsung ke lantai tertentu (posisi scroll) dengan kode."

**?? PENTING**: Jangan lupa `dispose()` controller! Kalau tidak, terjadi memory leak.

#### Horizontal ListView - Scroll Horizontal

ListView yang scroll ke samping (horizontal):

```dart
SizedBox(
  height: 120,  // WAJIB berikan tinggi untuk horizontal ListView!
  child: ListView.builder(
    scrollDirection: Axis.horizontal,  // Ubah arah scroll
    itemCount: 10,
    itemBuilder: (context, index) {
      return Container(
        width: 100,  // Lebar setiap item
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue[100 * ((index % 9) + 1)],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            'Item index',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      );
    },
  ),
)
```

**Visualisasi:**

```
? Scroll horizontal ?
+----+ +----+ +----+ +----+
� 1  � � 2  � � 3  � � 4  � ...
+----+ +----+ +----+ +----+
```

**?? TROUBLESHOOTING**:

**Problem**: "RenderBox has unbounded width"
- **Cause**: Horizontal ListView tanpa height constraint
- **Fix**: WAJIB wrap dengan `SizedBox` yang punya `height`:
  ```dart
  SizedBox(
    height: 120,  // ? HARUS ada!
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      ...
    ),
  )
  ```

---

## ?? PART 2: GridView Hands-On (20 menit)

### ?? Konsep Dasar: GridView vs ListView

**Kapan pakai ListView? Kapan pakai GridView?**

```
ListView vs GridView:

ListView:           GridView:
+---------+         +---------+
� Item 1  �         � 1  � 2  �
+---------�         +----+----�
� Item 2  �         � 3  � 4  �
+---------�         +----+----�
� Item 3  �         � 5  � 6  �
+---------+         +---------+

Satu kolom          Multiple kolom
Scroll vertikal     Scroll vertikal tapi banyak per baris
```

**?? ANALOGI**:

> "ListView seperti antrian ATM (satu-satu ke bawah).
> GridView seperti etalase toko - produk disusun rapi dalam kotak-kotak, mudah lihat banyak item sekaligus!"

**Kapan Pakai GridView?**
- ? Galeri foto/video
- ? Product catalog/marketplace
- ? Dashboard dengan tiles
- ? Icon grid
- ? Calendar view

### ?? CODING BERSAMA: Product Grid

**Step 1: Create Product Model** (3 menit)

Buat file `lib/models/product.dart`:

```dart
// lib/models/product.dart
class Product {
  final String id;
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

**Step 2: Create Product Card Widget** (7 menit)

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
            // Gambar produk (bagian atas)
            Expanded(
              child: Image.network(
                product.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(),
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
            // Info produk (bagian bawah)
            Padding(
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp {product.price.toStringAsFixed(0)}',
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
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

**?? CATATAN**: 
- `Expanded` pada gambar membuat gambar mengisi space yang tersedia
- `loadingBuilder` menampilkan loading indicator saat gambar loading
- `errorBuilder` menampilkan icon jika gambar gagal load

**Step 3: Create Product Grid Page** (10 menit)

Buat file `lib/pages/product_grid_page.dart`:

```dart
// lib/pages/product_grid_page.dart
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class ProductGridPage extends StatelessWidget {
  ProductGridPage({super.key});

  // Dummy data products
  final List<Product> products = [
    Product(
      id: '1',
      name: 'Laptop Gaming',
      price: 12000000,
      imageUrl: 'https://picsum.photos/seed/laptop/200/200',
      category: 'Electronics',
    ),
    Product(
      id: '2',
      name: 'Smartphone',
      price: 5000000,
      imageUrl: 'https://picsum.photos/seed/phone/200/200',
      category: 'Electronics',
    ),
    Product(
      id: '3',
      name: 'Headphone',
      price: 500000,
      imageUrl: 'https://picsum.photos/seed/headphone/200/200',
      category: 'Accessories',
    ),
    Product(
      id: '4',
      name: 'Mechanical Keyboard',
      price: 750000,
      imageUrl: 'https://picsum.photos/seed/keyboard/200/200',
      category: 'Accessories',
    ),
    Product(
      id: '5',
      name: 'Gaming Mouse',
      price: 350000,
      imageUrl: 'https://picsum.photos/seed/mouse/200/200',
      category: 'Accessories',
    ),
    Product(
      id: '6',
      name: 'Monitor 27 inch',
      price: 3500000,
      imageUrl: 'https://picsum.photos/seed/monitor/200/200',
      category: 'Electronics',
    ),
    Product(
      id: '7',
      name: 'Webcam HD',
      price: 800000,
      imageUrl: 'https://picsum.photos/seed/webcam/200/200',
      category: 'Accessories',
    ),
    Product(
      id: '8',
      name: 'USB Microphone',
      price: 1200000,
      imageUrl: 'https://picsum.photos/seed/mic/200/200',
      category: 'Accessories',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Produk'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,        // Jumlah kolom
          crossAxisSpacing: 12,     // Jarak horizontal antar item
          mainAxisSpacing: 12,      // Jarak vertikal antar item
          childAspectRatio: 0.75,   // Rasio lebar:tinggi (0.75 = lebih tinggi)
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index],
            onTap: () {
              print('Tapped: {products[index].name}');
            },
          );
        },
      ),
    );
  }
}
```

**Update main.dart** untuk ProductGridPage:

```dart
// lib/main.dart - Update home:
home: ProductGridPage(),
```

**Hot Reload** ? Product grid muncul dengan 2 kolom!

**?? PENTING**: Perhatikan `gridDelegate` - ini yang mengatur layout grid!

### ?? EKSPERIMEN 1: CrossAxisCount - Ubah Jumlah Kolom

**Task**: Mari coba ubah jumlah kolom!

1. **2 kolom (default)**:
   ```dart
   crossAxisCount: 2,  // Lebar, spacing besar
   ```

2. **3 kolom**:
   ```dart
   crossAxisCount: 3,  // Lebih rapat, item lebih kecil
   ```
   **Hot Reload** ? Item jadi lebih kecil!

3. **4 kolom**:
   ```dart
   crossAxisCount: 4,  // Sangat rapat
   ```
   **Hot Reload** ? Item sangat kecil!

**Visualisasi:**

```
crossAxisCount: 2         crossAxisCount: 3         crossAxisCount: 4
+-----------+            +-----------+            +-----------+
�  1  �  2  �            � 1 � 2 � 3 �            �1 �2 �3 �4 �
+-----+-----�            +---+---+---�            +--+--+--+--�
�  3  �  4  �            � 4 � 5 � 6 �            �5 �6 �7 �8 �
+-----------+            +-----------+            +-----------+
Lebih lebar              Balanced                 Lebih sempit
```

**?? Lesson**: crossAxisCount mengatur berapa kolom. Semakin banyak kolom, semakin kecil item!

**?? ANALOGI**:

> "crossAxisCount = berapa kolom rak di toko. 2 kolom = lebar dan jelas, 4 kolom = lebih banyak tapi kecil."

### ?? EKSPERIMEN 2: ChildAspectRatio - Ubah Bentuk Item

**Task**: Ubah rasio lebar:tinggi item!

1. **1.0 (kotak sempurna)**:
   ```dart
   childAspectRatio: 1.0,  // Width = Height
   ```
   **Hot Reload** ? Item jadi kotak sempurna!

2. **0.75 (lebih tinggi - portrait)**:
   ```dart
   childAspectRatio: 0.75,  // Height > Width
   ```
   **Hot Reload** ? Item lebih tinggi (default untuk product)

3. **1.5 (lebih lebar - landscape)**:
   ```dart
   childAspectRatio: 1.5,  // Width > Height
   ```
   **Hot Reload** ? Item lebih lebar/pendek

**Visualisasi:**

```
childAspectRatio: 1.0    childAspectRatio: 0.75   childAspectRatio: 1.5
(Kotak sempurna)         (Tinggi/Portrait)        (Lebar/Landscape)

+--------+               +------+                 +--------------+
�        �               �      �                 �              �
�   1:1  �               �      �                 �     1.5:1    �
�        �               � 3:4  �                 �              �
+--------+               �      �                 +--------------+
                         +------+
```

**?? Lesson**: AspectRatio mengontrol bentuk item!

**?? ANALOGI**:

> "AspectRatio = bentuk kotak. 1.0 = Rubik (kotak), 0.75 = Smartphone (berdiri), 1.5 = Laptop (tidur)."

> ?? **TROUBLESHOOTING**:
>
> **Problem**: "GridView tidak muncul" / layar kosong
> - **Cause 1**: GridView di dalam Column tanpa Expanded
> - **Fix**: Wrap dengan `Expanded`:
>   ```dart
>   Column(
>     children: [
>       Text('Header'),
>       Expanded(  // ? Tambahkan!
>         child: GridView.builder(...),
>       ),
>     ],
>   )
>   ```
> - **Cause 2**: itemCount = 0 atau data kosong
> - **Fix**: Pastikan `itemCount: products.length` dan products tidak kosong
>
> **Problem**: "Images tidak muncul"
> - **Cause**: Network error atau URL salah
> - **Fix**: Cek `errorBuilder` sudah ada, gunakan placeholder icon
>
> **Problem**: "Bottom overflowed by X pixels"  
> - **Cause**: AspectRatio terlalu kecil, text overflow
> - **Fix**: Increase aspectRatio atau gunakan `maxLines` + `overflow: TextOverflow.ellipsis`

### ?? EKSPERIMEN 3 (BONUS): MaxCrossAxisExtent

**Task**: Buat grid responsive berdasarkan lebar maksimum item!

Ganti `gridDelegate` dengan:

```dart
gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
  maxCrossAxisExtent: 150,  // Lebar maksimum setiap item (px)
  crossAxisSpacing: 12,
  mainAxisSpacing: 12,
  childAspectRatio: 0.75,
),
```

**Hot Reload** ? Jumlah kolom otomatis adjust based on screen width!

**?? CATATAN**: 
- Layar 400px lebar ? 2 kolom (400 / 150 � 2.6 ? floor = 2)
- Layar 600px lebar ? 4 kolom (600 / 150 = 4)
- More responsive untuk berbagai ukuran layar!

**Kapan Pakai Mana?**
- `FixedCrossAxisCount` ? Jumlah kolom tetap (misal: always 2 kolom)
- `MaxCrossAxisExtent` ? Responsive, adjust otomatis based on screen width

### ?? Tips \u0026 Best Practices

**DO ?:**
- Gunakan `.builder` untuk data dinamis
- Set `childAspectRatio` sesuai konten (product biasanya 0.6-0.8)
- Tambahkan `loadingBuilder` dan `errorBuilder` untuk images
- Gunakan `MaxCrossAxisExtent` untuk responsive design
- Keep card content simple untuk performa

**DON'T ?:**
- Jangan hardcode terlalu banyak children (gunakan `.builder`!)
- Jangan lupa `Expanded` pada image di dalam Column
- Jangan set aspectRatio terlalu ekstrem (< 0.5 atau > 2.0)

---

## ?? PART 3: Navigation + Passing Data (40 menit)

### ?? Konsep Stack Navigation

Flutter menggunakan konsep **Stack** (tumpukan) untuk navigasi.

**Visualisasi:**

```
Awal:                Push:                Pop:
+---------+         +---------+         +---------+
�         �         � Page B  � ? Top   �         �
�         �         +---------�         �         �
� Page A  � ? Top   � Page A  �         � Page A  � ? Top
+---------+         +---------+         +---------+

                    Add new page        Remove top page
```

**?? ANALOGI**:

> "Navigator seperti tumpukan buku di meja:
> - **Push** = Naruh buku baru di atas tumpukan
> - **Pop** = Ambil buku paling atas
> - **Yang di atas** = Halaman yang terlihat user"

### ?? CODING BERSAMA: Multi-Page App (20 menit)

**Step 1: Create Product Detail Page** (8 menit)

Buat file `lib/pages/product_detail_page.dart`:

```dart
// lib/pages/product_detail_page.dart
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;  // Data dari halaman sebelumnya

  const ProductDetailPage({
    super.key,
    required this.product,  // Constructor parameter
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        // Back button otomatis muncul!
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar besar
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
            // Info produk
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama produk
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Harga
                  Text(
                    'Rp {product.price.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Category
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
                  // Description
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
      // Tombol di bottom
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              // TODO: Add to cart logic (nanti di return data)
              print('Add to cart: {product.name}');
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

**?? CATATAN**: 
- Product data dikirim via **constructor parameter**
- Back button otomatis muncul di AppBar
- `SafeArea` memastikan bottom button tidak tertutup notch/gesture bar

**Step 2: Navigate dari Grid ke Detail** (5 menit)

Update `ProductGridPage` - ganti `onTap`:

```dart
// Di ProductGridPage, dalam GridView.builder:
itemBuilder: (context, index) {
  return ProductCard(
    product: products[index],
    onTap: () {
      // Navigator.push untuk buka halaman baru
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailPage(
            product: products[index],  // Kirim data via constructor
          ),
        ),
      );
    },
  );
},
```

**Hot Reload & Test** ? Tap produk ? Detail page muncul!

**?? PENTING**: 
- `Navigator.push` menambah halaman baru di atas stack
- `MaterialPageRoute` mengatur transition animation
- `builder` function creates the destination page

**Step 3: Test Push & Pop** (7 menit)

1. **Tap** salah satu product ? Detail page muncul
2. **Tap back button** di appBar ? Kembali ke grid
3. **Tap** product lain ? Detail page baru muncul

**Visualisasi apa yang terjadi:**

```
Awal (Grid):          Tap Product 1:        Tap Back:
+-----------+        +-----------+         +-----------+
�   Grid    � ? Top  �  Detail 1 � ? Top   �   Grid    � ? Top  
+-----------+        +-----------�         +-----------+
                     �   Grid    �
                     +-----------+
```

**?? PIKIRKAN**: Apa yang terjadi jika kita push 5 halaman berturut-turut? Stack jadi:

```
+-----------+
�  Detail 5 � ? Top (visible)
+-----------�
�  Detail 4 �
+-----------�
�  Detail 3 �
+-----------�
�  Detail 2 �
+-----------�
�  Detail 1 �
+-----------�
�   Grid    �
+-----------+
```

Pop 5 kali untuk kembali ke Grid!

> ?? **TROUBLESHOOTING**:
>
> **Problem**: "Navigator operation requested with a context that does not include a Navigator"
> - **Cause**: Menggunakan `context` yang salah (biasanya context dari MaterialApp)
> - **Fix**: Pastikan context dari widget di DALAM MaterialApp:
>   ```dart
>   // SALAH:
>   class MyApp extends StatelessWidget {
>     Widget build(BuildContext context) {
>       return MaterialApp(
>         home: ElevatedButton(
>           onPressed: () => Navigator.push(context, ...),  // ? context MyApp!
>         ),
>       );
>     }
>   }
>  
>   // BENAR:
>   class MyApp extends StatelessWidget {
>     Widget build(BuildContext context) {
>       return MaterialApp(
>         home: HomePage(),  // ? Separate widget
>       );
>     }
>   }
>  
>   class HomePage extends StatelessWidget {
>     Widget build(BuildContext context) {
>       return ...ElevatedButton(
>         onPressed: () => Navigator.push(context, ...),  // ? context HomePage ?
>       );
>     }
>   }
>   ```
>
> **Problem**: "There are multiple heroes that share the same tag"
> - **Cause**: Dua widget dengan Hero tag yang sama
> - **Fix**: Gunakan unique tag, misalnya product ID:
>   ```dart
>   Hero(tag: 'product-{product.id}', child: Image(...))
>   ```

### ?? EKSPERIMEN 1: Return Data dari Detail Page (15 menit)

**Task**: Tambah fitur rating di detail page, return rating ke grid!

**Step 1**: Modifikasi ProductDetailPage untuk return rating

Update tombol di `ProductDetailPage`:

```dart
// Ganti ElevatedButton di bottomNavigationBar:
ElevatedButton(
  onPressed: () {
    // Pop dengan return value (rating)
    Navigator.pop(context, 5);  // Return rating 5
  },
  child: const Text('Beri Rating \u0026 Kembali'),
)
```

**Step 2**: Terima return value di ProductGridPage

Update `onTap` di ProductGridPage:

```dart
onTap: () async {
  // await untuk tunggu hasil dari detail page
  final rating = await Navigator.push<int>(
    context,
    MaterialPageRoute(
      builder: (context) => ProductDetailPage(
        product: products[index],
      ),
    ),
  );
  
  // rating akan null jika user tap back button
  // rating akan ada value jika user tap tombol
  if (rating != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Rating {products[index].name}: rating \u2b50'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
},
```

**Hot Reload & Test**:
1. Tap product
2. Tap "Beri Rating & Kembali"  
3. Snackbar muncul dengan rating!

**?? PENTING**: 
- `await Navigator.push` menunggu halaman di-pop
- `Navigator.pop(context, value)` return value saat pop
- Value bisa any type (int, String, Map, custom object)

**?? PIKIRKAN**: Bagaimana jika ingin return complex data?

```dart
// Bisa return Map:
Navigator.pop(context, {
  'rating': 5,
  'review': 'Produk bagus!',
  'wouldRecommend': true,
});

// Atau custom class:
class ReviewData {
  final int rating;
  final String review;
  ReviewData(this.rating, this.review);
}
Navigator.pop(context, ReviewData(5, 'Bagus!'));
```

### ?? EKSPERIMEN 2: Navigator.pushReplacement (5 menit)

**Task**: Pahami bedanya push vs pushReplacement!

Create simple demo page:

```dart
// Mini demo - tidak perlu file terpisah, test di existing page
ElevatedButton(
  onPressed: () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NextPage()),
    );
  },
  child: Text('Go to Next (Replace)'),
)
```

**Visualisasi:**

```
push:                      pushReplacement:
+---------+               +---------+
� Page C  � ? New         � Page C  � ? New
+---------�               +---------+
� Page B  �               (Page B diganti, hilang dari stack)
+---------�
� Page A  �
+---------+
```

**Kapan Pakai pushReplacement?**
- ? Login ? Home (setelah login, tidak bisa back ke login)
- ? Splash ? Home
- ? Onboarding ? Home
- ? Payment Success ? Order List (tidak bisa back ke payment)

**?? ANALOGI**:

> "push = Tambah buku baru di tumpukan (bisa kembali).  
> pushReplacement = Ganti buku paling atas (tidak bisa kembali ke buku lama)."

### ?? Data Passing: Constructor vs Arguments

**Analogi Pengiriman Paket:**

```
Constructor Method (RECOMMENDED):
+-------------+                  +-------------+
�  List Page  �                  � Detail Page �
�             � --------------? �             �
� Product obj � ProductDetailPage� product     �
+-------------+    (product: p)  +-------------+
  Type-safe ?                      Direct access ?
  "Langsung kasih paket pas antar"

Arguments Method:
+-------------+                  +-------------+
�  List Page  �                  � Detail Page �
�             � --------------? �             �
� Any data    � arguments: {...} � Cast needed �
+-------------+                  +-------------+
  Flexible ?                       Type-unsafe ??
  "Tulis alamat di amplop, harus buka dulu"
```

**Rekomendasi**: Gunakan **Constructor** (yang kita pakai di atas) - lebih aman dan langsung!

### ?? Tips \u0026 Best Practices

**DO ?:**
- Gunakan constructor untuk passing data (type-safe)
- `await` Navigator.push jika butuh return value
- Gunakan `pushReplacement` untuk flow yang tidak boleh back
- Add Hero animation untuk smooth transition
- Dispose controller/listener saat pop

**DON'T ?:**
- Jangan push terlalu banyak halaman (deep stack = memory issue)
- Jangan lupa handle null return value
- Jangan gunakan global variable untuk passing data
- Jangan pakai `pushReplacement` jika user perlu back

---

## ??? PART 4: Named Routes - Quick Overview (10 menit)

> **?? NOTE**: Named routes adalah topik advanced. Untuk pertemuan ini, kita hanya **kenalan dulu**. Implementasi detail nanti di pertemuan berikutnya!

### ?? Apa itu Named Routes?

Daripada tulis `MaterialPageRoute` berulang-ulang, kita bisa kasih **nama** ke setiap route.

**Analogi**: 

> "Bayangkan peta. Daripada tulis alamat lengkap tiap kali (MaterialPageRoute), lebih mudah sebut nama tempat saja: '/ home', '/detail', '/cart'."

### Before (Tanpa Named Routes):

```dart
// Harus tulis berulang-ulang
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => DetailPage()),
);

Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => CartPage()),
);
```

### After (Dengan Named Routes):

**Setup di main.dart:**

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Define routes sekali
      routes: {
        '/': (context) => HomePage(),
        '/detail': (context) => DetailPage(),
        '/cart': (context) => CartPage(),
      },
      initialRoute: '/',
    );
  }
}
```

**Navigate cukup pakai nama:**

```dart
// Lebih simple!
Navigator.pushNamed(context, '/detail');
Navigator.pushNamed(context, '/cart');
```

### ?? Kapan Pakai Named Routes?

**Pakai Named Routes jika:**
- ? App punya banyak halaman (>5)
- ? Navigation flow kompleks
- ? Perlu deep linking (buka app langsung ke halaman tertentu)
- ? Team besar (konsistensi naming)

**Skip Named Routes jika:**
- ? App simple (2-3 halaman saja)
- ? Perlu pass complex data via constructor (named routes lebih ribet)

### ?? Challenge (Optional):

Coba convert ProductGrid ? ProductDetail navigation ke named routes!

**Hint:**
1. Define routes di main.dart
2. Ganti `Navigator.push` jadi `Navigator.pushNamed`
3. Pass data via arguments (bukan constructor)

**Solusi ada di file demo**: `06_named_routes_demo.dart`

> ?? **PENTING**: Untuk praktikum hari ini, **pakai constructor method** (yang sudah kita pelajari). Named routes optional!

---

## ??? PART 5: Praktikum Terpandu - Catalog App (35 menit)

### ?? Tujuan Praktikum:

Buat **Mini E-Commerce App** dengan fitur:
1. ? Product Grid (GridView)
2. ? Product Detail Page (Navigation)
3. ? Add to Cart (Return data)
4. ? Cart counter badge

### ?? Requirements Checklist:

- [ ] Minimal 8 produk (network images)
- [ ] Grid 2 kolom, aspect ratio 0.75
- [ ] Tap produk ? Detail page
- [ ] Detail page: image, name, price, category, description
- [ ] Tombol "Tambah ke Keranjang"
- [ ] Return `true` saat add to cart
- [ ] Show cart count di AppBar badge

### ?? Step-by-Step Implementation (30 menit)

**CATATAN**: Kita sudah punya ProductGridPage dan ProductDetailPage dari Part 2-3. Sekarang tinggal tambah cart functionality!

#### Step 1: Add Cart State to Grid Page (5 menit)

Update `ProductGridPage` jadi StatefulWidget dengan cart counter:

```dart
class ProductGridPage extends StatefulWidget {
  const ProductGridPage({super.key});

  @override
  State<ProductGridPage> createState() => _ProductGridPageState();
}

class _ProductGridPageState extends State<ProductGridPage> {
  int cartCount = 0;  // Track jumlah item di cart
  
  final List<Product> products = [...];  // Existing products

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Produk'),
        actions: [
          // Cart badge
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  // TODO: Navigate to cart page (nanti)
                },
              ),
              if (cartCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Text(
                      'cartCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: GridView.builder(...),  // Existing grid
    );
  }
}
```

**Hot Reload** ? Cart icon muncul di AppBar (badge masih 0)

#### Step 2: Update ProductDetailPage to Return Boolean (5 menit)

Modify tombol di `ProductDetailPage`:

```dart
// Ganti ElevatedButton di bottomNavigationBar:
ElevatedButton(
  onPressed: () {
    // Return true = item berhasil ditambahkan
    Navigator.pop(context, true);
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
```

#### Step 3: Handle Return Value in Grid Page (10 menit)

Update `onTap` di GridView.builder:

```dart
itemBuilder: (context, index) {
  return ProductCard(
    product: products[index],
    onTap: () async {
      // await untuk tunggu user tap button
      final result = await Navigator.push<bool>(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailPage(
            product: products[index],
          ),
        ),
      );
      
      // Jika user tap "Tambah ke Keranjang"
      if (result == true) {
        setState(() {
          cartCount++;  // Increment cart
        });
        
        // Show confirmation snackbar
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '{products[index].name} ditambahkan ke keranjang!',
              ),
              duration: const Duration(seconds: 2),
              action: SnackBarAction(
                label: 'OK',
                onPressed: () {},
              ),
            ),
          );
        }
      }
    },
  );
},
```

**Hot Reload & Test**:
1. Tap produk ? Detail page
2. Tap "Tambah ke Keranjang"
3. Kembali ke grid ? Badge muncul dengan angka 1!
4. Tap produk lain ? Tambah lagi ? Badge jadi 2!

**?? Selamat! Cart functionality works!**

#### Step 4: BONUS - Add Loading State (5 menit)

Make detail page more realistic dengan simulasi loading:

```dart
// Di ProductDetailPage, ubah button jadi StatefulWidget button:
class _AddToCartButton extends StatefulWidget {
  @override
  State<_AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<_AddToCartButton> {
  bool isLoading = false;

  Future<void> addToCart() async {
    setState(() => isLoading = true);
    
    // Simulasi API call
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() => isLoading = false);
    
    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : addToCart,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : const Text(
              'Tambah ke Keranjang',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
    );
  }
}
```

**Hot Reload & Test** ? Button shows loading spinner selama 1 detik!

#### Step 5: Polish & Testing (5 menit)

**Checklist Final:**
- [ ] 8+ products displayed in grid
- [ ] Grid scrollable
- [ ] Tap product opens detail
- [ ] Detail shows all info (image, name, price, category, description)
- [ ] "Tambah ke Keranjang" button works
- [ ] Cart badge updates correctly
- [ ] SnackBar shows confirmation
- [ ] Back navigation works smoothly

**?? COMPLETED! Mini E-Commerce App selesai!**

### ?? Tips Debugging:

**Problem**: Badge tidak update setelah add to cart
- **Check**: Apakah `setState` dipanggil?
- **Check**: Apakah `result == true` condition benar?

**Problem**: SnackBar tidak muncul
- **Check**: Apakah `if (mounted)` ada?
- **Check**: Apakah context masih valid?

**Problem**: App crash saat pop
- **Check**: Apakah ada Navigator.pop ganda?
- **Check**: Apakah dispose dipanggil dua kali?

---

## ?? PART 6: Wrap Up \u0026 Review (5 menit)

### ? Apa yang Sudah Dipelajari Hari Ini?

1. **ListView.builder** - Efisien untuk data banyak, lazy loading
2. **GridView.builder** - Grid layout untuk galeri/catalog
3. **Navigator.push/pop** - Navigasi antar halaman dengan stack
4. **Passing Data** - Via constructor (recommended)
5. **Return Data** - Terima value dari halaman yang di-close
6. **Praktikum** - Mini e-commerce dengan cart functionality

### ?? Achievement Unlocked:

- ? Bisa buat scrollable list dengan custom items
- ? Bisa buat product grid responsif
- ? Bisa navigasi antar halaman
- ? Bisa kirim dan terima data antar halaman
- ? Bisa buat multi-page app dengan state management

### ?? Tugas Rumah:

**Kembangkan Mini E-Commerce App dengan fitur tambahan:**

1. **Category Filter** (MEDIUM)
   - Tambah dropdown/chips untuk filter by category
   - GridView update based on selected category

2. **Search Functionality** (MEDIUM)
   - Add search bar di AppBar
   - Filter products by name

3. **Cart Page** (HARD)
   - Buat halaman baru untuk lihat cart items
   - List semua produk yang ditambahkan
   - Bisa hapus item dari cart
   - Total price calculation

4. **Product Rating** (EASY)
   - Tambah rating (1-5 ?) di product model
   - Show stars di product card dan detail page

**Deadline**: Submit sebelum Pertemuan 4

**Format Submit**:
- ZIP file atau GitHub repo link
- Include: full Flutter project (ready to run)
- Filename: `Pertemuan3_NIM_Nama.zip`

### ?? Pertanyaan Refleksi:

1. Apa bedanya ListView.builder dan ListView biasa?
2. Kapan pakai GridView, kapan pakai ListView?
3. Apa yang terjadi jika push 10 halaman tanpa pernah pop?
4. Kenapa harus pakai constructor untuk passing data?
5. Apa fungsi `await` di Navigator.push?

---

## ? FAQ - Frequently Asked Questions

### Q1: Kapan pakai ListView vs GridView vs SingleChildScrollView?

**A**: 
- `ListView` ? Data banyak, satu kolom vertikal
- `GridView` ? Data banyak, multiple kolom (galeri, products)
- `SingleChildScrollView` ? Content static/sedikit yang perlu scroll (misal: form panjang)

**Rule of thumb**: Data > 10 items ? WAJIB pakai .builder!

### Q2: Apa bedanya push, pushReplacement, dan pushAndRemoveUntil?

**A**:
- `push` ? Tambah halaman di atas stack (bisa back)
- `pushReplacement` ? Ganti halaman current (tidak bisa back ke current)
- `pushAndRemoveUntil` ? Push halaman baru, hapus semua halaman sebelumnya sampai kondisi tertentu

**Example use cases**:
- Login ? Home: `pushReplacement` (tidak bisa back ke login)
- Logout: `pushAndRemoveUntil` (hapus semua, back ke landing page)

### Q3: Kenapa images tidak muncul di GridView?

**A**: Beberapa kemungkinan:
1. **Network issue** ? Cek internet connection
2. **URL salah** ? Verify URL di browser dulu
3. **Tidak ada errorBuilder** ? Image error tidak keliatan
4. **Aspect ratio masalah** ? Image terlalu kecil

**Fix**: Selalu tambahkan `loadingBuilder` dan `errorBuilder`!

### Q4: Error "RenderBox was not laid out" - gimana fix?

**A**: Ini berarti widget butuh constraint tapi tidak dapat.

**Common causes**:
- ListView/GridView di dalam Column tanpa `Expanded`
- Nested scrollable widgets

**Fix**:
```dart
Column(
  children: [
    Text('Header'),
    Expanded(  // ? ADD THIS!
      child: ListView.builder(...),
    ),
  ],
)
```

### Q5: Bagaimana cara pass multiple data ke halaman baru?

**A**: Beberapa cara:

**1. Multiple constructor parameters (BEST)**:
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

**2. Custom class/model**:
```dart
class PageData {
  final Product product;
  final int userId;
  PageData(this.product, this.userId);
}

Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailPage(data: pageData),
  ),
);
```

### Q6: Apa itu `mounted` dan kenapa harus cek `if (mounted)`?

**A**: `mounted` cek apakah widget masih ada di tree (belum di-dispose).

**Problem tanpa cek**:
```dart
Future<void> loadData() async {
  await Future.delayed(Duration(seconds: 2));
  setState(() {});  // ? CRASH jika user sudah pop page!
}
```

**Fix**:
```dart
Future<void> loadData() async {
  await Future.delayed(Duration(seconds: 2));
  if (mounted) {  // ? Safe!
    setState(() {});
  }
}
```

### Q7: Bagaimana cara buat Hero animation untuk smooth transition?

**A**: Wrap image dengan `Hero` widget:

**Di Grid Page**:
```dart
Hero(
  tag: 'product-{product.id}',  // Unique tag
  child: Image.network(product.imageUrl),
)
```

**Di Detail Page**:
```dart
Hero(
  tag: 'product-{product.id}',  // SAME tag!
  child: Image.network(product.imageUrl),
)
```

**Result**: Image "terbang" dari grid ke detail dengan smooth animation! ?

### Q8: Cara handle async operation saat navigate?

**A**: Gunakan `await` dan `async`:

```dart
onTap: () async {
  // Show loading
  showDialog(context: context, builder: (context) => LoadingDialog());
  
  // Fetch data
  final data = await fetchProductDetail(product.id);
  
  // Hide loading
  if (mounted) Navigator.pop(context);
  
  // Navigate dengan data
  if (mounted) {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(data: data),
      ),
    );
  }
}
```

---

## ????? FOR INSTRUCTORS ONLY

> **?? Instruksi untuk Dosen/Instruktur**

### Persiapan Sebelum Kelas:

1. **Test All Code** (30 menit before class)
   - Run semua demo files di `contoh_kode/pertemuan_3/`
   - Verify images load (network connection!)
   - Test pada emulator DAN device fisik

2. **Prepare Backup Plan**
   - Download local images jika internet unstable
   - Prepare screenshots untuk key steps
   - Backup project jika live coding gagal

3. **Setup Classroom**
   - Projector/screen tested
   - Sample app running di device
   - WiFi stable (untuk network images)

### Timeline Management:

**STRICT timing to fit 150 minutes**:
- Part 0: 10 min MAX (skip quiz jika students slow)
- Part 1: 30 min (bisa skip horizontal ListView jika waktu mepet)
- Part 2: 20 min (skip Experiment 3 jika perlu)
- Part 3: 40 min (JANGAN potong - ini core!)  
- Part 4: 10 min (cukup explain concept, no coding)
- Part 5: 35 min (students code along, instructor guide)
- Part 6: 5 min (wrap up cepat)

**Jika waktu kurang**: Skip Part 4 entirely, fokus ke praktikum.

### Common Student Mistakes to Watch:

1. **Lupa import** - Sering lupa import model/widget
2. **Typo di constructor** - `requierd` instead of `required`
3. **Null safety** - Lupa `?` atau `!` untuk nullable
4. **Context error** - Pakai context dari wrong widget
5. **setState di async** - Lupa cek `mounted`

### Grading Praktikum:

Use rubric from implementation plan (Section 8).

**Quick grading tips**:
- 50% = Code runs without error
- 70% = All basic features work
- 85% = Code clean, well-structured
- 95%+ = Bonus features implemented

### Discussion Prompts:

**For engagement**:
- "Apa app favorit kalian yang pakai GridView?"
- "Gimana rasanya pakai app yang load 1000 items sekaligus?" (introduce lazy loading)
- "Pernah experience app yang navigation-nya membingungkan? Kenapa?"

### Differentiation:

**For fast learners**:
- Challenge: Implement MaxCrossAxisExtent responsive grid
- Challenge: Add Hero animation
- Challenge: Implement full cart page with remove functionality

**For struggling students**:
- Provide complete `ProductGridPage` skeleton
- Let them just modify `onTap` and cart logic
- Pair programming with faster student

### Extension Activities:

Jika ada waktu extra (unlikely), students bisa:
1. Add product favorit feature (heart icon toggle)
2. Implement sort (price low-high, name A-Z)
3. Add product quantity selector di detail page

---

**?? Pertemuan 3 Materi Complete! ??**

**Next**: Pertemuan 4 - Forms, Input \u0026 Validation



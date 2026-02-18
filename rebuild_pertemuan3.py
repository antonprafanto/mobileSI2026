# -*- coding: utf-8 -*-
"""Rebuild Pertemuan 3 with proper UTF-8 encoding"""

content = """# 📱 PERTEMUAN 3 - LIVE CODING

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
    imageUrl: 'https://i.pravatar.cc/150?img=${index % 70}',
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
"""

# Write to file
with open('Pertemuan_3_ListView_GridView_dan_Navigasi.md', 'w', encoding='utf-8') as f:
    f.write(content)

print("✅ Part 0 & Part 1 written successfully!")
print("File: Pertemuan_3_ListView_GridView_dan_Navigasi.md")
print("Lines written:", len(content.split('\n')))

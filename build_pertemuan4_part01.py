# -*- coding: utf-8 -*-
"""Build Pertemuan 4: State Management dengan Provider - Part 0 & Part 1"""

content = """# 📱 PERTEMUAN 4 - LIVE CODING

## State Management dengan Provider

---

## 🎯 Tujuan Pembelajaran

Setelah mengikuti pertemuan ini, Anda diharapkan mampu:

1. ✅ Menjelaskan perbedaan ephemeral state dan app state
2. ✅ Menggunakan setState untuk state lokal
3. ✅ Memahami keterbatasan setState
4. ✅ Mengimplementasikan Provider untuk app state
5. ✅ Membuat ChangeNotifier class
6. ✅ Membangun shopping cart dengan Provider

---

## ⏱️ TIMELINE SESI (Total: 150 menit)

| Durasi   | Topik  | Aktivitas                                |
|----------|--------|------------------------------------------|
| 10 menit | Part 0 | Review & Warm Up                         |
| 15 menit | Part 1 | Understanding State (Ephemeral vs App)   |
| 20 menit | Part 2 | setState dan Keterbatasannya             |
| 10 menit | Part 3 | Introduction to Provider                 |
| 25 menit | Part 4 | ChangeNotifier Pattern                   |
| 50 menit | Part 5 | Shopping Cart Hands-On (MAIN PROJECT)    |
| 15 menit | Part 6 | Advanced Provider Topics                 |
| 5 menit  | Part 7 | Wrap Up + Praktikum briefing             |

---

## 📂 RESOURCES

> 💡 **File demo tersedia di folder `contoh_kode/pertemuan_4/`**

| File | Deskripsi |
|------|-----------|
| `01_counter_setstate_demo.dart` | Counter dengan setState (baseline) |
| `02_prop_drilling_problem_demo.dart` | Problem: passing state 3 levels deep |
| `03_counter_provider_demo.dart` | Counter solution dengan Provider |
| `04_shopping_cart_complete.dart` | Shopping cart lengkap (praktikum solution) |
| `05_multi_provider_demo.dart` | Multiple providers (Cart + User + Theme) |
| `06_selector_optimization_demo.dart` | Selector untuk performance optimization |

---

## 📋 PERSIAPAN SEBELUM MEMULAI

- ✅ Flutter SDK terinstall
- ✅ Editor (VS Code / Android Studio) ready
- ✅ Device / emulator running
- ✅ Review materi Pertemuan 3 (Navigation, passing data)
- ✅ Install provider package: `flutter pub add provider`

---

## 🔄 PART 0: Review & Warm Up (10 menit)

### Quick Quiz (5 menit)

**Jawab pertanyaan berikut untuk check understanding:**

1. **Apa bedanya Navigator.push dan Navigator.pop?**
2. **Bagaimana cara pass data ke halaman baru?**
3. **Bagaimana cara return value dari halaman yang ditutup?**
4. **Apa fungsi setState dalam StatefulWidget?**
5. **Kapan widget akan rebuild?**

> 💡 **JANGAN LANJUT** sebelum yakin paham basic state management dengan setState!

### Today's Challenge: The State Problem (5 menit)

**Scenario:**

> Bayangkan kamu buat aplikasi **shopping cart**:
> - Product list page perlu show items
> - Cart badge di AppBar perlu show jumlah items
> - Cart page perlu show detail items
> - Cart page perlu update quantity
> - All pages share **SAME cart data**

**Question**: Gimana caranya semua page bisa akses cart yang SAMA? 🤔

**Bad Solution** (yang akan kita hindari):
```dart
HomePage(cart: myCart, onAdd: () {...})
  └─> ProductPage(cart: myCart, onAdd: () {...})
      └─> DetailPage(cart: myCart, onAdd: () {...})
          └─> CartPage(cart: myCart, onUpdate: () {...})
```

Pass cart ke SEMUA widget? 😱 **NIGHTMARE!**

**Good Solution** (yang akan kita pelajari):
```dart
Provider<CartModel> ← ONE source
    ├─> HomePage ← read cart
    ├─> ProductPage ← read cart
    ├─> DetailPage ← add to cart
    └─> CartPage ← manage cart
```

Semua widget akses cart langsung! 🎉

---

## 💡 PART 1: Understanding State (15 menit)

### Konsep Dasar: Apa itu State?

**State** = Data yang bisa berubah dan mempengaruhi tampilan UI.

**Contoh State**:
- Counter value (0, 1, 2, ...)
- Login status (logged in / logged out)
- Shopping cart items
- Form input values
- Dark mode on/off

**2 Jenis State:**

```
┌────────────────────┬─────────────────────┐
│  Ephemeral State   │    App State        │
├────────────────────┼─────────────────────┤
│ Local to 1 widget  │ Shared across app   │
│ setState()         │ Provider/Riverpod   │
│ Dies on navigate   │ Persists in app     │
│ Example: TextField │ Example: Cart       │
└────────────────────┴─────────────────────┘
```

### 💡 ANALOGI: State seperti Catatan

> **Ephemeral State** = Sticky note di mejamu  
> - Hanya kamu yang akses
> - Hilang kalau pindah meja
> - Contoh: Draft email yang belum dikirim
>
> **App State** = Whiteboard di ruang meeting  
> - Semua orang lihat
> - Tetap ada meskipun orang keluar-masuk
> - Contoh: Todo list tim

### 🎯 EKSPERIMEN 1: Ephemeral State - Counter Demo (7 menit)

Mari buat counter sederhana dengan setState!

**Create new file**: `lib/pages/counter_page.dart`

```dart
// lib/pages/counter_page.dart
import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  // Ephemeral state - local to this widget
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++; // Modify state
    }); // Trigger rebuild
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('CounterPage rebuilt!'); // ← We'll see this print
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter with setState'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              '$_counter',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _increment,
                  child: const Text('Increment'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _reset,
                  child: const Text('Reset'),
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

**Update main.dart**:

```dart
import 'package:flutter/material.dart';
import 'pages/counter_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pertemuan 4 - State Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CounterPage(),
    );
  }
}
```

**Hot Reload!** Klik tombol Increment → Counter naik!

**💡 YANG TERJADI**:
1. User tap button → `_increment()` dipanggil
2. `setState(() { _counter++; })` → Modify state + mark dirty
3. Flutter rebuild widget
4. `build()` dipanggil lagi → UI update dengan nilai baru

**setState SANGAT COCOK untuk:**
- ✅ Local widget state (form input, checkbox)
- ✅ Simple counter, toggle
- ✅ Animation state
- ✅ UI-only state (expanded/collapsed)

### 🎯 EKSPERIMEN 2: App State Problem - Sharing Between Pages (8 menit)

**Task**: Tampilkan counter di 2 halaman berbeda!

**Create**: `lib/pages/counter_display_page.dart`

```dart
// lib/pages/counter_display_page.dart
import 'package:flutter/material.dart';

class CounterDisplayPage extends StatelessWidget {
  final int counter; // ← Need counter dari parent!

  const CounterDisplayPage({
    super.key,
    required this.counter,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Display'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Counter value from HomePage:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              '$counter',
              style: const TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              '⚠️ But I can\\'t increment it here!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

**Update CounterPage** dengan navigation button:

```dart
// Di dalam build method, tambahkan di Column setelah Row
ElevatedButton.icon(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CounterDisplayPage(
          counter: _counter, // ← Pass counter value
        ),
      ),
    );
  },
  icon: const Icon(Icons.arrow_forward),
  label: const Text('View Counter'),
),
```

**Hot Reload & Test!**

1. Increment counter di HomePage (mis: 5)
2. Klik "View Counter" → Muncul 5 ✓
3. Back ke HomePage
4. Ke DisplayPage lagi → Still 5 ✓

**Tapi... MASALAH**:

```
❌ CounterDisplayPage can't increment counter
❌ Need to pass callback: onIncrement
❌ Multiple pages = many parameters
❌ Deep nesting = NIGHTMARE
```

**Visualisasi Masalah**:

```
CounterPage (_counter: 5)
      │
      ├─> Display value: ✓ Easy  
      │
      └─> Navigate to DisplayPage(counter: 5)
              │
              └─> Display: ✓ Works
                  Increment: ❌ Can't! No setState here
```

**💡 MASALAH INI DISEBUT**: **Prop Drilling** atau **State Lifting Problem**

> ⚠️ **PROBLEM YANG MUNCUL**:
>
> **Problem**: "Too many parameters to pass"
> - **Symptom**: Constructor jadi panjang dengan banyak callbacks
> - **Worse**: Deep widgets (3+ levels) susah akses data dari top
> - **Result**: Code jadi messy, hard to maintain
> - **Example**: Cart harus di-pass ke 10 widget berbeda!

### 💡 Tips & Best Practices - Kapan Pakai setState

**DO ✅:**
- Gunakan setState untuk state LOCAL (1 widget)
- State yang bersifat sementara (UI state)
- Simple toggle, checkbox, text input
- State yang tidak perlu di-share

**DON'T ❌:**
- Jangan pakai setState untuk state yang di-share >2 widgets
- Jangan pass state through 3+ levels (prop drilling)
- Jangan duplicate state di multiple widgets
- Jangan pakai untuk app-wide data (cart, user, theme)

**KAPAN PINDAH KE PROVIDER?**
- State perlu diakses >2 pages
- Banyak widgets perlu same state
- State complex (cart with add/remove/update)
- State persist selama app lifetime

---
"""

# Write to file with UTF-8
with open('Pertemuan_4_State_Management_dengan_Provider.md', 'w', encoding='utf-8') as f:
    f.write(content)

print("✅ Part 0 & Part 1 written successfully!")
print("File: Pertemuan_4_State_Management_dengan_Provider.md")
print("Lines written:", len(content.split('\n')))
print("\n📊 Content includes:")
print("- 🎯 Learning objectives")
print("- ⏱️ Timeline (150 min)")
print("- 📂 Resources (6 demo files)")
print("- 🔄 Part 0: Review & Warm Up")
print("- 💡 Part 1: Understanding State")
print("- 🎯 2 Experiments (Ephemeral & App State)")
print("- 💡 1 Analogy (Sticky note vs Whiteboard)")
print("- ⚠️ 1 Troubleshooting box (Prop drilling)")
print("- ✅ Tips & Best Practices")

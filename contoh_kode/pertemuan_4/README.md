# Contoh Kode - Pertemuan 4

Folder ini berisi file demo untuk **State Management dengan Provider**.

## 📁 Daftar File Demo

Berdasarkan materi [Pertemuan_4_State_Management_dengan_Provider.md](../Pertemuan_4_State_Management_dengan_Provider.md), berikut adalah file demo yang direferensikan:

| File                                 | Deskripsi                                  |
| ------------------------------------ | ------------------------------------------ |
| `01_counter_setstate_demo.dart`      | Counter dengan setState (baseline)         |
| `02_prop_drilling_problem_demo.dart` | Problem: passing state 3 levels deep       |
| `03_counter_provider_demo.dart`      | Counter solution dengan Provider           |
| `04_shopping_cart_complete.dart`     | Shopping cart lengkap (praktikum solution) |
| `05_multi_provider_demo.dart`        | Multiple providers (Cart + User + Theme)   |
| `06_selector_optimization_demo.dart` | Selector untuk performance optimization    |

## 🎯 Cara Menggunakan

### Setup Provider Package

Semua demo memerlukan package `provider`. Install terlebih dahulu:

```bash
flutter pub add provider
```

### Running Demos

1. Buat Flutter project baru:

   ```bash
   flutter create demo_pertemuan4
   cd demo_pertemuan4
   ```

2. Install provider:

   ```bash
   flutter pub add provider
   ```

3. Copy isi file demo (mis: `03_counter_provider_demo.dart`) ke `lib/main.dart`

4. Run:
   ```bash
   flutter run
   ```

## 📝 Demo Descriptions

### 01 - Counter setState

- Basic counter menggunakan setState
- Baseline untuk comparison
- Menunjukkan limitasi setState

### 02 - Prop Drilling Problem

- 3-page navigation flow
- Demonstrates prop drilling nightmare
- Shows why Provider is needed

### 03 - Counter Provider

- Same counter tapi dengan Provider
- Menunjukkan solusi yang lebih clean
- Contoh ChangeNotifier pattern

### 04 - Shopping Cart Complete

- Full e-commerce shopping cart
- CRUD operations (add, remove, update quantity)
- Best practices implementation
- **Praktikum solution reference**

### 05 - MultiProvider

- Multiple state objects (Cart + User + Theme)
- How to structure complex apps
- Provider composition

### 06 - Selector Optimization

- Performance optimization dengan Selector
- Comparing rebuild counts
- Advanced Provider usage

## 📚 Learning Path

**Recommended order**:

1. `01_counter_setstate_demo.dart` - Understand the problem
2. `02_prop_drilling_problem_demo.dart` - See prop drilling hell
3. `03_counter_provider_demo.dart` - Learn Provider solution
4. `04_shopping_cart_complete.dart` - Apply to real project
5. `05_multi_provider_demo.dart` - Multiple providers
6. `06_selector_optimization_demo.dart` - Optimization

## 📝 Note

File demo ini merupakan reference implementation dari materi yang diajarkan di Pertemuan 4. Untuk pembelajaran lengkap, silakan baca dokumen utama [Pertemuan_4_State_Management_dengan_Provider.md](../Pertemuan_4_State_Management_dengan_Provider.md).

## 🔗 Referensi

- [Materi Lengkap Pertemuan 4](../Pertemuan_4_State_Management_dengan_Provider.md)
- [Provider Package](https://pub.dev/packages/provider)
- [Flutter State Management Guide](https://docs.flutter.dev/data-and-backend/state-mgmt/simple)
- [ChangeNotifier Documentation](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html)

# Penjelasan: Contoh Kode vs Contoh Proyek

## 📂 Struktur Repository

Repository ini memiliki 2 jenis resource pembelajaran:

### 1. `contoh_kode/` - Demo Files (Standalone)

File-file `.dart` standalone yang bisa langsung di-copy ke `main.dart` untuk testing cepat.

**Cara pakai:**

```bash
# Copy isi file demo ke main.dart Flutter project
# Lalu run
flutter run
```

**Tersedia untuk:**

- ✅ Pertemuan 2: 7 demo files
- ✅ Pertemuan 3: 7 demo files (with README)
- ✅ Pertemuan 4: 6 demo files (with README)
- ✅ Pertemuan 5: 7 demo files (with README)

### 2. `contoh_proyek/` - Full Flutter Projects

Complete Flutter projects dengan multiple files, proper structure, dll.

**Cara pakai:**

```bash
cd contoh_proyek/pertemuan_X_demo
flutter pub get
flutter run
```

**Tersedia untuk:**

- ✅ Pertemuan 2: `pertemuan_2_demo/` (interactive demo app)
- ✅ Pertemuan 3: `pertemuan_3_catalog/` (Catalog App)
- ✅ Pertemuan 4: `pertemuan_4_shopping_cart/` (Shopping Cart App)
- ✅ Pertemuan 5: `pertemuan_5_registration/` (Registration Form App)

---

## 🎯 Detail Per Pertemuan

### Pertemuan 3 - ListView, GridView, Navigasi

**Status**: Demo files tersedia di `contoh_kode/pertemuan_3/`

**Praktikum Project**:

- **Catalog App** dibangun sebagai exercise oleh mahasiswa
- Step-by-step ada di materi [Pertemuan_3_ListView_GridView_dan_Navigasi.md](../Pertemuan_3_ListView_GridView_dan_Navigasi.md) Part 5
- Reference solution bisa dibuat di `07_catalog_app_complete.dart`

### Pertemuan 4 - State Management dengan Provider

**Status**: Demo files tersedia di `contoh_kode/pertemuan_4/`

**Praktikum Project**:

- **Shopping Cart App** dibangun step-by-step dalam material
- Full code ada di materi [Pertemuan_4_State_Management_dengan_Provider.md](../Pertemuan_4_State_Management_dengan_Provider.md) Part 5
- Complete implementation ~500 lines dengan semua features

### Pertemuan 5 - Form, Validasi & Debugging

**Status**: Demo files tersedia di `contoh_kode/pertemuan_5/`

**Praktikum Project**:

- **Registration Form App** full Flutter project di `contoh_proyek/pertemuan_5_registration/`
- Features: Form with validation, Provider, multi-page (form → list → detail)
- Dependencies: `provider`
- Reusable widgets: CustomTextField, StepIndicator, SummaryCard

---

## 💡 Recommendation untuk Instructor

- Demo files di `contoh_kode/` untuk quick testing
- Full projects di `contoh_proyek/` untuk reference solution
- Material lengkap dengan step-by-step di markdown modules
- Student build praktikum sendiri = better learning

---

## 📝 Summary

| Pertemuan | Demo Files          | Full Project                 | Notes                           |
| --------- | ------------------- | ---------------------------- | ------------------------------- |
| 2         | ✅ 7 files          | ✅ pertemuan_2_demo          | Interactive demo app            |
| 3         | ✅ 7 files (README) | ✅ pertemuan_3_catalog       | Catalog App                     |
| 4         | ✅ 6 files (README) | ✅ pertemuan_4_shopping_cart | Shopping Cart App with Provider |
| 5         | ✅ 7 files (README) | ✅ pertemuan_5_registration  | Registration Form App           |

**Semua code yang dibutuhkan sudah ada di material!** Demo files untuk quick testing, material untuk full implementation.

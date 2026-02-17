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
- ⏰ Pertemuan 3: Coming soon (Catalog App)
- ⏰ Pertemuan 4: Coming soon (Shopping Cart App)

---

## 🎯 Untuk Pertemuan 3 & 4

### Pertemuan 3 - ListView, GridView, Navigasi

**Status**: Demo files tersedia di `contoh_kode/pertemuan_3/`

**Praktikum Project**:

- **Catalog App** dibangun sebagai exercise oleh mahasiswa
- Step-by-step ada di materi [Pertemuan_3_ListView_GridView_dan_Navigasi.md](../Pertemuan_3_ListView_GridView_dan_Navigasi.md) Part 5
- Reference solution bisa dibuat di `07_catalog_app_complete.dart`

**Kenapa tidak ada full project?**

- Praktikum dirancang untuk dibangun dari scratch (learning by doing)
- Material sudah sangat detail dengan step-by-step
- Student build sendiri = better understanding

### Pertemuan 4 - State Management dengan Provider

**Status**: Demo files tersedia di `contoh_kode/pertemuan_4/`

**Praktikum Project**:

- **Shopping Cart App** dibangun step-by-step dalam material
- Full code ada di materi [Pertemuan_4_State_Management_dengan_Provider.md](../Pertemuan_4_State_Management_dengan_Provider.md) Part 5
- Complete implementation ~500 lines dengan semua features
- Reference solution bisa dibuat di `04_shopping_cart_complete.dart`

**Kenapa tidak ada full project?**

- Material Part 5 sudah berisi COMPLETE working code
- Shopping cart di-build incrementally (Step 1-6)
- Student bisa follow along dan build sendiri
- Lebih baik daripada copy-paste full project

---

## 💡 Recommendation untuk Instructor

**Option 1: Keep as-is** ✅ (Recommended)

- Demo files di `contoh_kode/` sudah cukup
- Material lengkap dengan step-by-step
- Student build praktikum sendiri = better learning
- Less clutter di repository

**Option 2: Create Full Projects**

- Buat `contoh_proyek/pertemuan_3_catalog/`
- Buat `contoh_proyek/pertemuan_4_shopping_cart/`
- Pros: Reference solution lengkap
- Cons: Student mungkin langsung copy-paste tanpa paham

**Keputusan**: Untuk sekarang, **Option 1** sudah optimal. Full projects bisa ditambahkan later kalau dibutuhkan untuk grading/demo purposes.

---

## 📝 Summary

| Pertemuan | Demo Files          | Full Project         | Notes                                      |
| --------- | ------------------- | -------------------- | ------------------------------------------ |
| 2         | ✅ 7 files          | ✅ pertemuan_2_demo  | Interactive demo app                       |
| 3         | ✅ 7 files (README) | ⏰ Build as exercise | Material has complete step-by-step         |
| 4         | ✅ 6 files (README) | ⏰ Build as exercise | Material Part 5 has full code (~500 lines) |

**Semua code yang dibutuhkan sudah ada di material!** Demo files untuk quick testing, material untuk full implementation.

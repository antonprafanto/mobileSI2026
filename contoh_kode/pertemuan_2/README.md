# 📁 Contoh Kode Pertemuan 2

Folder ini berisi file-file demo yang dapat langsung dijalankan untuk mempelajari materi **Pertemuan 2: Widget Dasar, Layout & Theming**.

---

## 🚀 CARA MENJALANKAN (Step-by-Step untuk Pemula)

### Langkah 1: Buat Proyek Flutter Baru (Jika Belum Ada)

Buka terminal/command prompt, lalu ketik:

```bash
flutter create belajar_flutter
cd belajar_flutter
```

### Langkah 2: Buka File main.dart

Buka folder proyek di VS Code atau Android Studio, lalu buka file:

```
lib/main.dart
```

### Langkah 3: Copy Kode Demo

1. Pilih salah satu file demo dari folder ini (misalnya `01_counter_demo.dart`)
2. Buka file tersebut
3. **Hapus semua isi** file `lib/main.dart` di proyek Anda
4. **Copy-paste seluruh isi** file demo ke `lib/main.dart`
5. **Simpan** file (Ctrl+S)

### Langkah 4: Jalankan Aplikasi

Di terminal, jalankan:

```bash
flutter run
```

Atau di VS Code: tekan **F5** atau klik **Run > Start Debugging**

### Langkah 5: Lihat Hasilnya!

Aplikasi akan muncul di emulator atau device Anda. 🎉

---

## 📋 Daftar File Demo

| No  | File                             | Apa yang Dipelajari?                        |
| --- | -------------------------------- | ------------------------------------------- |
| 1️⃣  | `01_counter_demo.dart`           | Perbedaan StatelessWidget vs StatefulWidget |
| 2️⃣  | `02_widget_dasar_demo.dart`      | Text, Container, Image, Icon, Button        |
| 3️⃣  | `03_layout_demo.dart`            | Row, Column, Stack                          |
| 4️⃣  | `04_spacing_alignment_demo.dart` | Padding, Margin, SizedBox, Expanded         |
| 5️⃣  | `05_theme_demo.dart`             | ThemeData, Dark/Light Mode                  |
| 6️⃣  | `06_profil_page_lengkap.dart`    | Contoh jawaban tugas Halaman Profil         |

---

## 📖 Urutan Belajar yang Disarankan

1. **Mulai dari `01_counter_demo.dart`** - Pahami konsep dasar StatefulWidget
2. **Lanjut ke `02_widget_dasar_demo.dart`** - Kenali widget-widget yang sering dipakai
3. **Kemudian `03_layout_demo.dart`** - Pelajari cara menyusun layout
4. **Lalu `04_spacing_alignment_demo.dart`** - Atur jarak dan posisi
5. **Terakhir `05_theme_demo.dart`** - Buat tampilan lebih menarik dengan theme
6. **Bonus: `06_profil_page_lengkap.dart`** - Lihat contoh aplikasi lengkap

---

## ❓ FAQ (Pertanyaan Umum)

### "Error: Unable to locate Android SDK"

✅ Pastikan Android Studio sudah terinstall dan `flutter doctor` tidak ada error

### "Emulator tidak muncul"

✅ Buka Android Studio → Tools → Device Manager → Create Device

### "Hot Reload tidak bekerja"

✅ Pastikan app sedang running, lalu tekan `r` di terminal atau Ctrl+S di VS Code

### "Kode error setelah di-copy"

✅ Pastikan copy **seluruh isi file** dari baris pertama sampai terakhir

---

## 💡 Tips untuk Pemula

- ✅ **Jangan takut error!** Error adalah cara terbaik untuk belajar
- ✅ **Coba modifikasi kode** - Ubah warna, ukuran, atau text untuk melihat hasilnya
- ✅ **Gunakan Hot Reload (r)** - Perubahan langsung terlihat tanpa restart
- ✅ **Baca komentar di kode** - Setiap file sudah ada penjelasannya
- ✅ **Eksperimen!** - Coba hapus beberapa baris, lihat apa yang terjadi

---

## 🔗 Alternatif: Gunakan Proyek Demo Lengkap

Jika tidak mau copy-paste satu per satu, gunakan proyek Flutter lengkap:

```bash
cd contoh_proyek/pertemuan_2_demo
flutter run
```

Proyek ini sudah berisi semua demo dengan navigasi menu! 🎉

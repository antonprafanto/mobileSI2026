# Proyek Pertemuan 5: Form Registrasi Event Multi-Step

Aplikasi Flutter untuk pendaftaran **Tech Summit 2026** yang mendemonstrasikan berbagai jenis input widget, validasi form multi-step, dan state management dengan Provider.

## 📱 Fitur Aplikasi

- **Form 3 langkah** (Multi-Step Wizard):
  - Step 1: Informasi Pribadi (nama, email, telepon, tanggal lahir, jenis kelamin)
  - Step 2: Preferensi Acara (tiket, sesi, kota, minat, vegetarian, jumlah tamu)
  - Step 3: Konfirmasi & Submit
- **Validasi per step** — tidak bisa lanjut jika ada field tidak valid
- **DatePicker** untuk tanggal lahir
- **RadioListTile** untuk jenis tiket dan jenis kelamin
- **DropdownButtonFormField** untuk sesi dan kota
- **FilterChip** untuk topik minat (multi-select)
- **Slider** untuk jumlah tamu
- **SwitchListTile** untuk opsi vegetarian
- **Step Indicator** visual progress
- **Halaman sukses** dengan "kartu tiket" bergradien
- **State management** dengan Provider

## 🗂️ Struktur Proyek

```
lib/
├── main.dart                          # Entry point & setup Provider + Theme
├── models/
│   └── registrant_model.dart          # Data model pendaftar + helpers
├── providers/
│   └── registration_provider.dart     # State management form
├── pages/
│   ├── registration_page.dart         # Halaman form 3 langkah
│   └── success_page.dart              # Halaman konfirmasi sukses
└── widgets/
    ├── custom_text_field.dart         # TextFormField reusable
    └── step_indicator.dart            # Progress indicator widget
```

## 🚀 Cara Menjalankan

```bash
# Install dependencies
flutter pub get

# Jalankan di emulator/device
flutter run

# Build APK debug
flutter build apk --debug
```

## 🧩 Widget yang Digunakan

| Widget                          | Digunakan Di                |
| ------------------------------- | --------------------------- |
| `TextFormField`                 | Semua input teks            |
| `RadioListTile`                 | Jenis tiket, jenis kelamin  |
| `DropdownButtonFormField`       | Sesi, kota asal             |
| `FilterChip`                    | Topik minat (multi-select)  |
| `Slider`                        | Jumlah tamu                 |
| `SwitchListTile`                | Pilihan vegetarian          |
| `showDatePicker()`              | Tanggal lahir               |
| `Form` + `GlobalKey<FormState>` | Validasi per step           |
| `AnimatedSwitcher`              | Animasi transisi antar step |

## 📚 Konsep yang Dipraktikkan

- `Form` widget dan `GlobalKey<FormState>`
- Validator function pattern
- `AutovalidateMode`
- `TextEditingController` & `FocusNode`
- `showDatePicker()` dengan kustomisasi tema
- Provider + `ChangeNotifier` untuk state form
- Pemisahan logika (provider) dari tampilan (page)
- Reusable widget dengan parameter

## 🔗 Materi Terkait

Lihat `Pertemuan_5_Form_Validasi_dan_Debugging.md` di root repositori untuk penjelasan konsep lengkap.

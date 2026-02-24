# Contoh Kode - Pertemuan 5: Form, Validasi & Debugging

Direktori ini berisi 6 file demo yang dapat dijalankan secara mandiri di [DartPad](https://dartpad.dev) atau sebagai file utama proyek Flutter.

## 📁 Daftar File

| File                                 | Topik                   | Konsep Utama                                                                      |
| ------------------------------------ | ----------------------- | --------------------------------------------------------------------------------- |
| `01_textfield_controller_demo.dart`  | TextField & Controller  | `TextEditingController`, `FocusNode`, `dispose()`, `InputDecoration`              |
| `02_form_validation_demo.dart`       | Form & Validasi         | `Form`, `GlobalKey<FormState>`, `TextFormField`, `validator`, `autovalidateMode`  |
| `03_input_widgets_demo.dart`         | Input Widget Lanjutan   | `Checkbox`, `Radio`, `Switch`, `Slider`, `RangeSlider`, `DropdownButtonFormField` |
| `04_date_time_picker_demo.dart`      | Date & Time Picker      | `showDatePicker()`, `showTimePicker()`, `showDateRangePicker()`                   |
| `05_registration_form_complete.dart` | Form Multi-Step Lengkap | Semua widget input, validasi per step, step indicator                             |
| `06_error_handling_demo.dart`        | Error Handling          | `try-catch-finally`, custom exception, async safety, debug tools                  |

## 🚀 Cara Menjalankan

### Opsi 1: DartPad (tanpa instalasi)

1. Buka [https://dartpad.dev](https://dartpad.dev)
2. Copy-paste isi salah satu file
3. Klik **Run**

### Opsi 2: Flutter Project

1. Buat project baru: `flutter create demo_p5`
2. Ganti isi `lib/main.dart` dengan salah satu file demo
3. Jalankan: `flutter run`

## 🔑 Urutan Belajar yang Direkomendasikan

```
01 → 02 → 03 → 04 → (pahami semua dulu) → 05 (integrasi)
                                           → 06 (error handling)
```

## 📚 Referensi

- [Flutter Forms Cookbook](https://docs.flutter.dev/cookbook/forms)
- [TextFormField API](https://api.flutter.dev/flutter/material/TextFormField-class.html)
- [Error handling in Dart](https://dart.dev/language/error-handling)
- [Flutter DevTools](https://docs.flutter.dev/tools/devtools/overview)

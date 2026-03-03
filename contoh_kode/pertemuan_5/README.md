# Pertemuan 5 - Demo: Form, Validasi & Debugging

Kumpulan demo standalone untuk materi **Form, Validasi & Debugging** di Flutter.

## 📂 Daftar File

| #   | File                                 | Topik                                                                        | Dependency |
| --- | ------------------------------------ | ---------------------------------------------------------------------------- | ---------- |
| 01  | `01_textfield_basic_demo.dart`       | TextField, TextEditingController, InputDecoration, obscureText, keyboardType | -          |
| 02  | `02_form_validation_demo.dart`       | Form widget, GlobalKey, validator, autovalidateMode, cross-field validation  | -          |
| 03  | `03_input_widgets_demo.dart`         | Checkbox, Radio, Switch, Slider, RangeSlider, DropdownButtonFormField        | -          |
| 04  | `04_date_time_picker_demo.dart`      | showDatePicker, showTimePicker, DateRangePicker, Form integration            | -          |
| 05  | `05_registration_form_complete.dart` | Form registrasi lengkap + Provider + multi-page                              | `provider` |
| 06  | `06_focus_error_handling_demo.dart`  | FocusNode, textInputAction, try-catch, tryParse, custom exceptions           | -          |
| 07  | `07_devtools_debug_demo.dart`        | Debug prints, rebuild counter, DevTools exploration                          | -          |

## 🚀 Cara Pakai

### File tanpa dependency (01-04, 06-07):

```bash
flutter create demo_app
cd demo_app
# Copy-paste isi file ke lib/main.dart
flutter run
```

### File dengan Provider (05):

```bash
flutter create demo_app
cd demo_app
flutter pub add provider
# Copy-paste isi file ke lib/main.dart
flutter run
```

## 📖 Learning Path (Urutan Belajar)

1. **01** → Pahami TextField dasar dan controller
2. **02** → Tambah Form widget dan validasi
3. **03** → Kenali input widgets lain (Checkbox, Radio, dll)
4. **04** → DatePicker dan TimePicker
5. **05** → Gabungkan semuanya di form registrasi lengkap
6. **06** → FocusNode dan error handling
7. **07** → Latihan debugging dengan DevTools

## 💡 Tips

- Setiap file bisa langsung **copy-paste** ke `lib/main.dart`
- Baca komentar di setiap file — penjelasan ada di sana
- Coba **modifikasi** code untuk eksperimen
- Buka **DevTools** (tekan `d` di terminal) untuk debugging

## 📝 Referensi

- [Pertemuan_5_Form_Validasi_dan_Debugging.md](../../Pertemuan_5_Form_Validasi_dan_Debugging.md)
- [Flutter Forms Docs](https://docs.flutter.dev/cookbook/forms)
- [Flutter DevTools](https://docs.flutter.dev/tools/devtools)

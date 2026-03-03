# 📱 PERTEMUAN 5

## Form, Validasi & Debugging

---

## 🎯 Tujuan Pembelajaran

Setelah mengikuti pertemuan ini, Anda diharapkan mampu:

1. ✅ Membuat form dengan berbagai input widget
2. ✅ Menggunakan TextFormField dengan TextEditingController
3. ✅ Mengimplementasikan validasi form (real-time & on-submit)
4. ✅ Menggunakan widget input: Checkbox, Radio, Switch, Slider, Dropdown
5. ✅ Menggunakan DatePicker dan TimePicker
6. ✅ Mengelola FocusNode dan keyboard
7. ✅ Menerapkan error handling (try-catch)
8. ✅ Menggunakan Flutter DevTools untuk debugging

---

## ⏱️ TIMELINE SESI (Total: 150 menit)

| Durasi   | Topik  | Aktivitas                                 |
| -------- | ------ | ----------------------------------------- |
| 10 menit | Part 0 | Review & Warm Up                          |
| 15 menit | Part 1 | TextField & TextFormField Basics          |
| 15 menit | Part 2 | Form Widget & Validasi                    |
| 15 menit | Part 3 | Input Widgets (Checkbox, Radio, dll)      |
| 10 menit | Part 4 | DatePicker & TimePicker                   |
| 50 menit | Part 5 | Registration Form Hands-On (MAIN PROJECT) |
| 15 menit | Part 6 | FocusNode, Error Handling & Debugging     |
| 10 menit | Part 7 | Flutter DevTools & Wrap Up                |
| 10 menit | Part 8 | Latihan & Tugas Praktikum                 |

---

## 📂 RESOURCES

> 💡 **File demo tersedia di folder `contoh_kode/pertemuan_5/`**

| File                                 | Deskripsi                                    |
| ------------------------------------ | -------------------------------------------- |
| `01_textfield_basic_demo.dart`       | TextField & TextEditingController basics     |
| `02_form_validation_demo.dart`       | Form widget, GlobalKey, validator            |
| `03_input_widgets_demo.dart`         | Checkbox, Radio, Switch, Slider, Dropdown    |
| `04_date_time_picker_demo.dart`      | DatePicker & TimePicker                      |
| `05_registration_form_complete.dart` | Form registrasi lengkap (praktikum solution) |
| `06_focus_error_handling_demo.dart`  | FocusNode, keyboard, try-catch               |
| `07_devtools_debug_demo.dart`        | App untuk latihan debugging DevTools         |

---

## 📋 PERSIAPAN SEBELUM MEMULAI

- ✅ Flutter SDK terinstall
- ✅ Editor (VS Code / Android Studio) ready
- ✅ Device / emulator running
- ✅ Review materi Pertemuan 4 (Provider, ChangeNotifier)
- ✅ Install provider package: `flutter pub add provider`

---

## 🔄 PART 0: Review & Warm Up (10 menit)

### Quick Quiz (5 menit)

**Jawab pertanyaan berikut untuk check understanding:**

1. **Apa fungsi ChangeNotifier dalam Provider?**
2. **Bedanya context.read dan context.watch?**
3. **Kapan pakai Consumer vs context.watch?**
4. **Apa yang terjadi kalau lupa notifyListeners()?**
5. **Bagaimana cara share state ke seluruh app?**

> 💡 **JANGAN LANJUT** sebelum yakin paham Provider dari Pertemuan 4!

### Today's Challenge: Form yang BENAR (5 menit)

**Scenario:**

> Bayangkan kamu buat **form registrasi** untuk event kampus:
>
> - Nama lengkap (wajib, min 3 karakter)
> - Email (wajib, format email valid)
> - Password (wajib, min 8 karakter)
> - Jenis kelamin (Radio button)
> - Program studi (Dropdown)
> - Tanggal lahir (DatePicker)
> - Setuju syarat & ketentuan (Checkbox)

**Question**: Gimana caranya memastikan SEMUA input terisi dengan benar sebelum submit? 🤔

**Bad Solution** (yang sering dilakukan):

```dart
// Manual check satu-satu 😱
if (nameController.text.isEmpty) {
  showError('Nama kosong!');
} else if (!emailController.text.contains('@')) {
  showError('Email invalid!');
} else if (passwordController.text.length < 8) {
  showError('Password terlalu pendek!');
}
// ... dst 10+ if-else 😱
```

**Good Solution** (yang akan kita pelajari):

```dart
// Flutter Form + Validator = CLEAN! 🎉
Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) return 'Wajib diisi';
          if (value.length < 3) return 'Minimal 3 karakter';
          return null; // Valid!
        },
      ),
      // ... more fields
    ],
  ),
)

// Submit: satu baris!
if (_formKey.currentState!.validate()) {
  // ALL fields valid → proceed!
}
```

Satu method `validate()` check SEMUA field sekaligus! 🎉

---

## 📝 PART 1: TextField & TextFormField Basics (15 menit)

### Konsep Dasar: Input Text di Flutter

Flutter punya 2 widget utama untuk input text:

```
┌─────────────────────────────┬──────────────────────────────┐
│       TextField             │       TextFormField           │
├─────────────────────────────┼──────────────────────────────┤
│ Basic text input            │ TextField + Form integration │
│ Standalone (tanpa Form)     │ Butuh Form widget sebagai    │
│ Pakai onChanged callback    │   parent                     │
│ Manual validation           │ Built-in validator property   │
│ Cocok untuk: search bar,    │ Cocok untuk: login form,     │
│   chat input                │   registration, profile edit  │
└─────────────────────────────┴──────────────────────────────┘
```

### 💡 ANALOGI: TextField vs TextFormField

> **TextField** = Kertas kosong
>
> - Kamu tulis bebas, tidak ada yang ngecek
> - Mau tulis apa saja boleh
>
> **TextFormField** = Formulir resmi
>
> - Ada kolom yang harus diisi
> - Ada aturan pengisian (validator)
> - Ada yang ngecek sebelum diterima (satpam = Form widget)

### TextEditingController

**TextEditingController** = cara Flutter untuk "mengelola" isi text field.

```dart
// 1. Buat controller
final _nameController = TextEditingController();

// 2. Pasang ke TextField
TextField(
  controller: _nameController,
)

// 3. Ambil nilainya kapan saja
String nama = _nameController.text;

// 4. Set value programmatically
_nameController.text = 'John Doe';

// 5. PENTING: dispose saat widget dihapus!
@override
void dispose() {
  _nameController.dispose();
  super.dispose();
}
```

> ⚠️ **PENTING**: Selalu `dispose()` controller di method `dispose()` widget! Kalau tidak, bisa menyebabkan **memory leak**. Ini salah satu kesalahan paling umum!

### 🎯 EKSPERIMEN 1: TextField Dasar (7 menit)

**Create new file**: `lib/pages/text_input_page.dart`

```dart
// lib/pages/text_input_page.dart
import 'package:flutter/material.dart';

class TextInputPage extends StatefulWidget {
  const TextInputPage({super.key});

  @override
  State<TextInputPage> createState() => _TextInputPageState();
}

class _TextInputPageState extends State<TextInputPage> {
  // Controllers untuk mengelola text
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  String _displayText = '';

  @override
  void dispose() {
    // WAJIB dispose semua controller!
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TextField Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. TextField Dasar
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                hintText: 'Masukkan nama lengkap',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _displayText = 'Hello, $value!';
                });
              },
            ),
            const SizedBox(height: 16),

            // 2. TextField Email
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'contoh@email.com',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            // 3. TextField Password (dengan toggle visibility)
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Min. 8 karakter',
                prefixIcon: const Icon(Icons.lock),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              obscureText: _obscurePassword,
            ),
            const SizedBox(height: 24),

            // Display text
            if (_displayText.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _displayText,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            const SizedBox(height: 16),

            // Tombol untuk ambil semua nilai
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final info = '''
Nama: ${_nameController.text}
Email: ${_emailController.text}
Password: ${'*' * _passwordController.text.length}
                  ''';
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Data Input'),
                      content: Text(info),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Tampilkan Data'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

**Hot Reload!** Coba ketik di setiap field.

**💡 YANG TERJADI**:

1. `onChanged` dipanggil setiap user ketik karakter
2. `controller.text` menyimpan value terkini
3. `obscureText: true` menyembunyikan password
4. `keyboardType` menentukan jenis keyboard yang muncul

### 💡 Tips & Best Practices - TextField

**InputDecoration Properties yang Sering Dipakai:**

```dart
InputDecoration(
  labelText: 'Label',        // Label di atas field
  hintText: 'Hint...',       // Placeholder
  helperText: 'Helper',      // Text bantuan di bawah
  errorText: 'Error!',       // Text error (merah)
  prefixIcon: Icon(...),     // Icon di kiri
  suffixIcon: Icon(...),     // Icon di kanan
  border: OutlineInputBorder(), // Border style
  filled: true,              // Background terisi
  fillColor: Colors.grey[100], // Warna background
)
```

**Keyboard Types:**

| KeyboardType                 | Tampilan                 |
| ---------------------------- | ------------------------ |
| `TextInputType.text`         | Keyboard biasa (default) |
| `TextInputType.number`       | Angka saja               |
| `TextInputType.emailAddress` | Ada @ dan .com           |
| `TextInputType.phone`        | Dial pad                 |
| `TextInputType.multiline`    | Enter = new line         |
| `TextInputType.url`          | Ada .com dan /           |

---

## ✅ PART 2: Form Widget & Validasi (15 menit)

### Kenapa Butuh Form Widget?

TextField biasa **tidak punya** built-in validation. Kita harus manual cek satu-satu. Ini rawan kesalahan!

**Form Widget** membungkus semua field dan menyediakan:

- ✅ **Validasi otomatis** semua field sekaligus
- ✅ **Auto-validate mode** (real-time feedback)
- ✅ **Save** semua field values
- ✅ **Reset** semua field sekaligus

### 💡 ANALOGI: Form Widget = Kepala Satpam

```
┌─────────────────────────────────────────┐
│ Form (GlobalKey<FormState>)             │ ← Kepala Satpam
│                                         │
│  ┌─────────────────────────────────┐    │
│  │ TextFormField (validator: ...)  │    │ ← Satpam 1
│  └─────────────────────────────────┘    │
│  ┌─────────────────────────────────┐    │
│  │ TextFormField (validator: ...)  │    │ ← Satpam 2
│  └─────────────────────────────────┘    │
│  ┌─────────────────────────────────┐    │
│  │ TextFormField (validator: ...)  │    │ ← Satpam 3
│  └─────────────────────────────────┘    │
│                                         │
│  [Submit] → _formKey.validate()         │ ← "Semua satpam,
│            checks ALL fields!           │    CEK SEKARANG!"
└─────────────────────────────────────────┘
```

### 3 Langkah Membuat Form

```dart
// STEP 1: Buat GlobalKey
final _formKey = GlobalKey<FormState>();

// STEP 2: Bungkus fields dengan Form widget
Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        // STEP 3: Tambahkan validator
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Field ini wajib diisi'; // ← Error message
          }
          return null; // ← null = valid!
        },
      ),
    ],
  ),
)

// SUBMIT: Validate semua field
if (_formKey.currentState!.validate()) {
  // Semua field valid! Lanjut proses...
}
```

### 🎯 EKSPERIMEN 2: Form dengan Validasi (8 menit)

**Create**: `lib/pages/form_validation_page.dart`

```dart
// lib/pages/form_validation_page.dart
import 'package:flutter/material.dart';

class FormValidationPage extends StatefulWidget {
  const FormValidationPage({super.key});

  @override
  State<FormValidationPage> createState() => _FormValidationPageState();
}

class _FormValidationPageState extends State<FormValidationPage> {
  // Step 1: GlobalKey untuk mengakses Form state
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // Step 3: Validate semua field sekaligus!
    if (_formKey.currentState!.validate()) {
      // Semua valid → show success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registrasi berhasil: ${_nameController.text}'),
          backgroundColor: Colors.green,
        ),
      );
    }
    // Jika ada yang invalid, error message otomatis muncul!
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Validation Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          // Step 2: Pasang key ke Form
          key: _formKey,
          // Auto validate setelah user interact
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Nama
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap *',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  if (value.length < 3) {
                    return 'Nama minimal 3 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email *',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email wajib diisi';
                  }
                  // Regex sederhana untuk email
                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                  if (!emailRegex.hasMatch(value)) {
                    return 'Format email tidak valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Password
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password *',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                ),
                obscureText: _obscurePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password wajib diisi';
                  }
                  if (value.length < 8) {
                    return 'Password minimal 8 karakter';
                  }
                  if (!value.contains(RegExp(r'[A-Z]'))) {
                    return 'Password harus mengandung huruf besar';
                  }
                  if (!value.contains(RegExp(r'[0-9]'))) {
                    return 'Password harus mengandung angka';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Confirm Password
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Konfirmasi Password *',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Konfirmasi password wajib diisi';
                  }
                  if (value != _passwordController.text) {
                    return 'Password tidak cocok!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'DAFTAR',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),

              // Reset Button
              TextButton(
                onPressed: () {
                  _formKey.currentState!.reset();
                  _nameController.clear();
                  _emailController.clear();
                  _passwordController.clear();
                  _confirmPasswordController.clear();
                },
                child: const Text('Reset Form'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

**Hot Reload & Test!**

1. Klik DAFTAR tanpa isi apa-apa → Semua error muncul! ✓
2. Isi nama "Ab" → "Minimal 3 karakter" ✓
3. Isi email tanpa @ → "Format email tidak valid" ✓
4. Password "abc" → "Minimal 8 karakter" ✓
5. Password beda → "Password tidak cocok!" ✓

**💡 YANG TERJADI**:

1. `_formKey.currentState!.validate()` → panggil SEMUA validator
2. Validator return `String` = **error message** (tampil merah)
3. Validator return `null` = **valid** (tidak ada error)
4. `autovalidateMode: AutovalidateMode.onUserInteraction` = validasi real-time setelah user mulai ketik

### autovalidateMode Options

| Mode                | Behavior                                      |
| ------------------- | --------------------------------------------- |
| `disabled`          | Hanya validate saat `validate()` dipanggil    |
| `always`            | Validate terus menerus (setiap build)         |
| `onUserInteraction` | Validate setelah user mulai interaksi ✅ BEST |

> ⚠️ **TROUBLESHOOTING - Validasi**:
>
> **Problem**: "Validator tidak dipanggil"
>
> - **Cause**: Pakai `TextField` bukan `TextFormField`
> - **Fix**: Ganti ke `TextFormField` (yang punya property `validator`)
>
> **Problem**: "Error message tidak hilang"
>
> - **Cause**: `autovalidateMode` = `always` tanpa fix input
> - **Fix**: Pakai `onUserInteraction` agar hanya validate setelah user edit
>
> **Problem**: "Form key null"
>
> - **Cause**: Lupa pasang `key: _formKey` di Form widget
> - **Fix**: Pastikan `Form(key: _formKey, ...)`

---

## 🎛️ PART 3: Input Widgets (15 menit)

### Beyond TextField: Widget Input Lainnya

Flutter punya banyak widget input selain TextField. Berikut yang paling sering dipakai:

```
┌────────────────┬──────────────────────────────────────┐
│ Widget         │ Kegunaan                             │
├────────────────┼──────────────────────────────────────┤
│ Checkbox       │ Pilihan ya/tidak (boolean)           │
│ Radio          │ Pilih satu dari beberapa opsi        │
│ Switch         │ Toggle on/off (seperti lampu)        │
│ Slider         │ Pilih nilai dari range (0.0 - 1.0)   │
│ Dropdown       │ Pilih satu dari daftar (hemat ruang) │
└────────────────┴──────────────────────────────────────┘
```

### 💡 ANALOGI: Widget Input = Alat di Kehidupan Nyata

> **Checkbox** = Checklist belanja 🛒
>
> - Bisa centang banyak sekaligus
> - Contoh: "Saya setuju syarat & ketentuan"
>
> **Radio** = Remote AC 🌡️
>
> - Hanya bisa pilih SATU mode (cool/dry/fan)
> - Contoh: "Jenis kelamin: L / P"
>
> **Switch** = Saklar lampu 💡
>
> - On atau Off, tidak ada di tengah
> - Contoh: "Mode gelap: ON/OFF"
>
> **Slider** = Volume speaker 🔊
>
> - Geser dari min ke max
> - Contoh: "Rating kepuasan: 1-10"
>
> **Dropdown** = Menu restoran 📋
>
> - Banyak pilihan, cuma tampil satu
> - Contoh: "Pilih program studi"

### 🎯 EKSPERIMEN 3: Showcase Input Widgets (10 menit)

**Create**: `lib/pages/input_widgets_page.dart`

```dart
// lib/pages/input_widgets_page.dart
import 'package:flutter/material.dart';

class InputWidgetsPage extends StatefulWidget {
  const InputWidgetsPage({super.key});

  @override
  State<InputWidgetsPage> createState() => _InputWidgetsPageState();
}

class _InputWidgetsPageState extends State<InputWidgetsPage> {
  // Checkbox
  bool _agreeTerms = false;
  bool _subscribeNewsletter = false;

  // Radio
  String _selectedGender = 'Laki-laki';

  // Switch
  bool _darkMode = false;
  bool _notifications = true;

  // Slider
  double _satisfaction = 5.0;
  double _fontSize = 16.0;

  // Dropdown
  String? _selectedProdi;
  final List<String> _prodiList = [
    'Teknik Informatika',
    'Sistem Informasi',
    'Teknik Komputer',
    'Data Science',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Widgets Showcase'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === CHECKBOX ===
            _buildSectionTitle('☑️ Checkbox'),
            CheckboxListTile(
              title: const Text('Saya setuju dengan syarat & ketentuan'),
              subtitle: const Text('Wajib dicentang'),
              value: _agreeTerms,
              onChanged: (value) {
                setState(() => _agreeTerms = value ?? false);
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: const Text('Berlangganan newsletter'),
              subtitle: const Text('Opsional'),
              value: _subscribeNewsletter,
              onChanged: (value) {
                setState(() => _subscribeNewsletter = value ?? false);
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const Divider(),

            // === RADIO ===
            _buildSectionTitle('🔘 Radio Button'),
            const Text('Jenis Kelamin:'),
            RadioListTile<String>(
              title: const Text('Laki-laki'),
              value: 'Laki-laki',
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() => _selectedGender = value!);
              },
            ),
            RadioListTile<String>(
              title: const Text('Perempuan'),
              value: 'Perempuan',
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() => _selectedGender = value!);
              },
            ),
            const Divider(),

            // === SWITCH ===
            _buildSectionTitle('🔀 Switch'),
            SwitchListTile(
              title: const Text('Dark Mode'),
              subtitle: Text(_darkMode ? 'Aktif' : 'Nonaktif'),
              value: _darkMode,
              onChanged: (value) {
                setState(() => _darkMode = value);
              },
              secondary: Icon(
                _darkMode ? Icons.dark_mode : Icons.light_mode,
              ),
            ),
            SwitchListTile(
              title: const Text('Notifikasi'),
              subtitle: Text(_notifications ? 'Aktif' : 'Nonaktif'),
              value: _notifications,
              onChanged: (value) {
                setState(() => _notifications = value);
              },
              secondary: const Icon(Icons.notifications),
            ),
            const Divider(),

            // === SLIDER ===
            _buildSectionTitle('🎚️ Slider'),
            const Text('Tingkat Kepuasan:'),
            Slider(
              value: _satisfaction,
              min: 0,
              max: 10,
              divisions: 10,
              label: _satisfaction.round().toString(),
              onChanged: (value) {
                setState(() => _satisfaction = value);
              },
            ),
            Text(
              'Nilai: ${_satisfaction.round()}/10',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text('Ukuran Font:'),
            Slider(
              value: _fontSize,
              min: 12,
              max: 32,
              divisions: 20,
              label: '${_fontSize.round()}px',
              onChanged: (value) {
                setState(() => _fontSize = value);
              },
            ),
            Text(
              'Preview: Hello World!',
              style: TextStyle(fontSize: _fontSize),
            ),
            const Divider(),

            // === DROPDOWN ===
            _buildSectionTitle('📋 DropdownButtonFormField'),
            DropdownButtonFormField<String>(
              value: _selectedProdi,
              decoration: const InputDecoration(
                labelText: 'Program Studi',
                prefixIcon: Icon(Icons.school),
                border: OutlineInputBorder(),
              ),
              hint: const Text('Pilih Program Studi'),
              items: _prodiList.map((prodi) {
                return DropdownMenuItem<String>(
                  value: prodi,
                  child: Text(prodi),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _selectedProdi = value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Pilih program studi';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // === SUMMARY ===
            _buildSectionTitle('📊 Summary'),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('✅ Setuju T&C: $_agreeTerms'),
                  Text('📧 Newsletter: $_subscribeNewsletter'),
                  Text('👤 Gender: $_selectedGender'),
                  Text('🌙 Dark Mode: $_darkMode'),
                  Text('🔔 Notifikasi: $_notifications'),
                  Text('⭐ Kepuasan: ${_satisfaction.round()}/10'),
                  Text('📏 Font Size: ${_fontSize.round()}px'),
                  Text('🎓 Prodi: ${_selectedProdi ?? "Belum dipilih"}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
```

**Hot Reload & Test!** Coba semua widget input dan lihat summary berubah real-time!

### 💡 Tips: Checkbox vs Radio vs Switch

| Gunakan...   | Ketika...                                          |
| ------------ | -------------------------------------------------- |
| **Checkbox** | Multiple selection ATAU single boolean (agree/not) |
| **Radio**    | User HARUS pilih tepat SATU dari beberapa opsi     |
| **Switch**   | Toggle setting on/off (immediate effect)           |

### DropdownButtonFormField vs DropdownButton

| Widget                    | Perbedaan                              |
| ------------------------- | -------------------------------------- |
| `DropdownButton`          | Standalone, tanpa Form integration     |
| `DropdownButtonFormField` | Ada `validator`, cocok di dalam `Form` |

> 💡 **GUNAKAN** `DropdownButtonFormField` kalau ada di dalam `Form` widget!

> ⚠️ **TROUBLESHOOTING - Input Widgets**:
>
> **Problem**: "There should be exactly one item with [DropdownButton]'s value"
>
> - **Cause**: Initial value tidak ada di list items, atau value bukan null tapi tidak match
> - **Fix**: Set initial value ke `null` dan pakai `hint` property
>
> ```dart
> // ❌ Salah:
> String _prodi = 'TI'; // Tidak ada di items list!
>
> // ✅ Benar:
> String? _prodi; // null → tampilkan hint
> DropdownButtonFormField(
>   value: _prodi,
>   hint: Text('Pilih...'),
>   items: [...], // value harus match salah satu item
> )
> ```
>
> **Problem**: "Checkbox/Switch tidak berubah saat diklik"
>
> - **Cause**: Lupa panggil `setState()` di `onChanged`
> - **Fix**: Selalu update state di dalam `setState()`

---

## 📅 PART 4: DatePicker & TimePicker (10 menit)

### Built-in Dialogs untuk Tanggal & Waktu

Flutter menyediakan dialog bawaan yang cantik untuk memilih tanggal dan waktu:

```
┌──────────────────────────────────────┐
│ showDatePicker()                     │
│                                      │
│ ┌────────────────────────────────┐   │
│ │     📅 MARCH 2026              │   │
│ │  Su Mo Tu We Th Fr Sa         │   │
│ │                    1  2  3  4  │   │
│ │  5  6  7  8  9 10 11         │   │
│ │ 12 13 14 [15] 16 17 18       │   │
│ │ 19 20 21 22 23 24 25         │   │
│ │ 26 27 28 29 30 31            │   │
│ │                                │   │
│ │        [CANCEL]  [OK]          │   │
│ └────────────────────────────────┘   │
└──────────────────────────────────────┘
```

### 🎯 EKSPERIMEN 4: DatePicker & TimePicker (7 menit)

**Create new file**: `lib/pages/date_page.dart`

```dart
// lib/pages/date_page.dart
import 'package:flutter/material.dart';

// Contoh penggunaan DatePicker & TimePicker (PART 4 - Pertemuan 5)
class DateTimePickerDemo extends StatefulWidget {
  const DateTimePickerDemo({super.key});

  @override
  State<DateTimePickerDemo> createState() => _DateTimePickerDemoState();
}

class _DateTimePickerDemoState extends State<DateTimePickerDemo> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  // Fungsi untuk menampilkan DatePicker
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1990),       // Batas awal
      lastDate: DateTime(2030),        // Batas akhir
      helpText: 'Pilih Tanggal Lahir', // Judul dialog
      cancelText: 'Batal',
      confirmText: 'Pilih',
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  // Fungsi untuk menampilkan TimePicker
  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      helpText: 'Pilih Waktu',
      cancelText: 'Batal',
      confirmText: 'Pilih',
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  // Format tanggal manual (tanpa package intl)
  String _formatDate(DateTime date) {
    final months = [
      '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
    ];
    return '${date.day} ${months[date.month]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Date & Time Picker')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // === DATE PICKER ===
            _buildSectionTitle('📅 Date Picker'),
            ListTile(
              leading: const Icon(Icons.calendar_today, color: Colors.blue),
              title: const Text('Tanggal Lahir'),
              subtitle: Text(
                _selectedDate != null
                    ? _formatDate(_selectedDate!)
                    : 'Belum dipilih',
              ),
              trailing: const Icon(Icons.arrow_drop_down),
              onTap: _pickDate,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            const SizedBox(height: 16),

            // === TIME PICKER ===
            _buildSectionTitle('⏰ Time Picker'),
            ListTile(
              leading: const Icon(Icons.access_time, color: Colors.orange),
              title: const Text('Waktu'),
              subtitle: Text(
                _selectedTime != null
                    ? _selectedTime!.format(context)
                    : 'Belum dipilih',
              ),
              trailing: const Icon(Icons.arrow_drop_down),
              onTap: _pickTime,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            const SizedBox(height: 24),

            // === SUMMARY ===
            _buildSectionTitle('📊 Summary'),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '📅 Tanggal: ${_selectedDate != null ? _formatDate(_selectedDate!) : "Belum dipilih"}',
                  ),
                  Text(
                    '⏰ Waktu: ${_selectedTime != null ? _selectedTime!.format(context) : "Belum dipilih"}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
```

**💡 TIP**: Untuk format tanggal yang lebih bagus, bisa pakai package `intl`:

```dart
// pubspec.yaml → flutter pub add intl
import 'package:intl/intl.dart';

String formatted = DateFormat('dd MMMM yyyy', 'id').format(date);
// Output: "15 Maret 2026"
```

### DatePicker di dalam Form

Untuk menggunakan DatePicker di dalam Form, bungkus dengan `TextFormField` yang read-only:

```dart
TextFormField(
  readOnly: true, // ← User tidak bisa ketik manual
  decoration: InputDecoration(
    labelText: 'Tanggal Lahir',
    prefixIcon: const Icon(Icons.calendar_today),
    border: const OutlineInputBorder(),
    suffixIcon: const Icon(Icons.arrow_drop_down),
  ),
  controller: _dateController,
  onTap: () async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _dateController.text = _formatDate(picked);
    }
  },
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Tanggal lahir wajib diisi';
    }
    return null;
  },
)
```

> ⚠️ **PENTING**: Set `readOnly: true` agar user HARUS pilih dari dialog, bukan ketik manual. Ini mencegah format tanggal yang salah!

> ⚠️ **TROUBLESHOOTING - DatePicker & TimePicker**:
>
> **Problem**: "DatePicker dialog tidak muncul"
>
> - **Cause 1**: Lupa `await` pada `showDatePicker()`
> - **Cause 2**: `context` tidak valid (sudah di-dispose)
> - **Fix**: Pastikan pakai `await` dan `context` masih valid
>
> **Problem**: "Null error setelah user cancel DatePicker"
>
> - **Cause**: `showDatePicker()` return `null` jika user tekan Cancel
> - **Fix**: Selalu check `if (picked != null)` sebelum assign
>
> **Problem**: "Tanggal yang dipilih hilang setelah rebuild"
>
> - **Cause**: Tidak simpan DateTime ke variable state, hanya ke controller text
> - **Fix**: Simpan ke variable `DateTime?` DAN ke controller:
>
> ```dart
> DateTime? _selectedDate; // ← Simpan actual DateTime
> if (picked != null) {
>   _selectedDate = picked;           // Simpan value
>   _dateCtrl.text = format(picked);  // Tampilkan text
> }
> ```

---

## 🏗️ PART 5: Registration Form Hands-On (50 menit) — MAIN PROJECT

### Project Overview

Kita akan membangun **Form Registrasi Event Kampus** yang lengkap!

**Features:**

- ✅ Multi-field form (nama, email, password, dll)
- ✅ Real-time validation
- ✅ Berbagai input widgets (TextFormField, Radio, Dropdown, DatePicker, Checkbox)
- ✅ Provider untuk menyimpan daftar pendaftar
- ✅ Halaman list pendaftar
- ✅ Halaman detail pendaftar

**App Structure:**

```
┌──────────────────┐     ┌──────────────────┐     ┌──────────────────┐
│  Registration    │────→│  Registrant      │────→│  Registrant      │
│  Form Page       │     │  List Page       │     │  Detail Page     │
│                  │     │                  │     │                  │
│ • Name           │     │ • ListView       │     │ • Full info      │
│ • Email          │     │ • Badge count    │     │ • All fields     │
│ • Password       │     │ • Delete action  │     │                  │
│ • Gender (Radio) │     │                  │     │                  │
│ • Prodi (Drop)   │     │                  │     │                  │
│ • DoB (Date)     │     │                  │     │                  │
│ • Agree (Check)  │     │                  │     │                  │
└──────────────────┘     └──────────────────┘     └──────────────────┘
       ↑                          ↑                        ↑
       └──────────────────────────┴────────────────────────┘
                    Provider (RegistrationProvider)
                  Shared state: List<Registrant>
```

### Step 1: Setup Project (3 menit)

```bash
flutter create registration_app
cd registration_app
flutter pub add provider
```

### Step 2: Create Model (5 menit)

**Create**: `lib/models/registrant_model.dart`

```dart
// lib/models/registrant_model.dart

class Registrant {
  final String id;
  final String name;
  final String email;
  final String gender;
  final String programStudi;
  final DateTime dateOfBirth;
  final DateTime registeredAt;

  Registrant({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.programStudi,
    required this.dateOfBirth,
    DateTime? registeredAt,
  }) : registeredAt = registeredAt ?? DateTime.now();

  // Helper: hitung umur
  int get age {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  // Helper: format tanggal lahir
  String get formattedDateOfBirth {
    final months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
    ];
    return '${dateOfBirth.day} ${months[dateOfBirth.month]} ${dateOfBirth.year}';
  }

  // Helper: format waktu registrasi
  String get formattedRegisteredAt {
    return '${registeredAt.day}/${registeredAt.month}/${registeredAt.year} '
        '${registeredAt.hour.toString().padLeft(2, '0')}:'
        '${registeredAt.minute.toString().padLeft(2, '0')}';
  }
}
```

### Step 3: Create Provider (5 menit)

**Create**: `lib/providers/registration_provider.dart`

```dart
// lib/providers/registration_provider.dart
import 'package:flutter/foundation.dart';
import '../models/registrant_model.dart';

class RegistrationProvider extends ChangeNotifier {
  final List<Registrant> _registrants = [];

  // Getters
  List<Registrant> get registrants => List.unmodifiable(_registrants);
  int get count => _registrants.length;

  // Add registrant
  void addRegistrant(Registrant registrant) {
    _registrants.add(registrant);
    notifyListeners();
  }

  // Remove registrant
  void removeRegistrant(String id) {
    _registrants.removeWhere((r) => r.id == id);
    notifyListeners();
  }

  // Get by ID
  Registrant? getById(String id) {
    try {
      return _registrants.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }

  // Check if email already registered
  bool isEmailRegistered(String email) {
    return _registrants.any(
      (r) => r.email.toLowerCase() == email.toLowerCase(),
    );
  }
}
```

### Step 4: Create Registration Form Page (20 menit)

**Create**: `lib/pages/registration_page.dart`

```dart
// lib/pages/registration_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/registrant_model.dart';
import '../providers/registration_provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dateController = TextEditingController();

  // State
  bool _obscurePassword = true;
  String _selectedGender = 'Laki-laki';
  String? _selectedProdi;
  DateTime? _selectedDate;
  bool _agreeTerms = false;

  final List<String> _prodiList = [
    'Teknik Informatika',
    'Sistem Informasi',
    'Teknik Komputer',
    'Data Science',
    'Desain Komunikasi Visual',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    final months = [
      '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
    ];
    return '${date.day} ${months[date.month]} ${date.year}';
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2004, 1, 1),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      helpText: 'Pilih Tanggal Lahir',
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = _formatDate(picked);
      });
    }
  }

  void _submitForm() {
    // Validate form
    if (!_formKey.currentState!.validate()) return;

    // Check checkbox
    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap setujui syarat & ketentuan'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Check email duplicate
    final provider = context.read<RegistrationProvider>();
    if (provider.isEmailRegistered(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email sudah terdaftar!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Create registrant
    final registrant = Registrant(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      gender: _selectedGender,
      programStudi: _selectedProdi!,
      dateOfBirth: _selectedDate!,
    );

    // Add to provider
    provider.addRegistrant(registrant);

    // Show success
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Colors.green, size: 48),
        title: const Text('Registrasi Berhasil!'),
        content: Text('${registrant.name} berhasil didaftarkan.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              _resetForm();
            },
            child: const Text('Daftar Lagi'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushNamed(context, '/list');
            },
            child: const Text('Lihat Daftar'),
          ),
        ],
      ),
    );
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _dateController.clear();
    setState(() {
      _selectedGender = 'Laki-laki';
      _selectedProdi = null;
      _selectedDate = null;
      _agreeTerms = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi Event'),
        actions: [
          // Badge jumlah pendaftar
          Consumer<RegistrationProvider>(
            builder: (context, provider, child) {
              return Badge(
                label: Text('${provider.count}'),
                isLabelVisible: provider.count > 0,
                child: IconButton(
                  icon: const Icon(Icons.people),
                  onPressed: () => Navigator.pushNamed(context, '/list'),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              const Text(
                '📝 Form Pendaftaran',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Isi semua field yang bertanda (*)',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // === NAMA ===
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap *',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  if (value.trim().length < 3) {
                    return 'Nama minimal 3 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // === EMAIL ===
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email *',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  hintText: 'nama@email.com',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email wajib diisi';
                  }
                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                  if (!emailRegex.hasMatch(value.trim())) {
                    return 'Format email tidak valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // === PASSWORD ===
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password *',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                ),
                obscureText: _obscurePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password wajib diisi';
                  }
                  if (value.length < 8) {
                    return 'Password minimal 8 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // === GENDER (Radio) ===
              const Text(
                'Jenis Kelamin *',
                style: TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Laki-laki'),
                      value: 'Laki-laki',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() => _selectedGender = value!);
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Perempuan'),
                      value: 'Perempuan',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() => _selectedGender = value!);
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // === PROGRAM STUDI (Dropdown) ===
              DropdownButtonFormField<String>(
                value: _selectedProdi,
                decoration: const InputDecoration(
                  labelText: 'Program Studi *',
                  prefixIcon: Icon(Icons.school),
                  border: OutlineInputBorder(),
                ),
                hint: const Text('Pilih Program Studi'),
                items: _prodiList.map((prodi) {
                  return DropdownMenuItem(
                    value: prodi,
                    child: Text(prodi),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedProdi = value);
                },
                validator: (value) {
                  if (value == null) return 'Pilih program studi';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // === TANGGAL LAHIR (DatePicker) ===
              TextFormField(
                controller: _dateController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Lahir *',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
                onTap: _pickDate,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tanggal lahir wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // === AGREE TERMS (Checkbox) ===
              CheckboxListTile(
                title: const Text('Saya setuju dengan syarat & ketentuan *'),
                subtitle: const Text('Wajib dicentang'),
                value: _agreeTerms,
                onChanged: (value) {
                  setState(() => _agreeTerms = value ?? false);
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 24),

              // === BUTTONS ===
              ElevatedButton.icon(
                onPressed: _submitForm,
                icon: const Icon(Icons.app_registration),
                label: const Text('DAFTAR SEKARANG'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: _resetForm,
                child: const Text('Reset Form'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### Step 5: Create Registrant List Page (10 menit)

**Create**: `lib/pages/registrant_list_page.dart`

```dart
// lib/pages/registrant_list_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/registration_provider.dart';

class RegistrantListPage extends StatelessWidget {
  const RegistrantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<RegistrationProvider>(
          builder: (context, provider, _) {
            return Text('Daftar Peserta (${provider.count})');
          },
        ),
      ),
      body: Consumer<RegistrationProvider>(
        builder: (context, provider, child) {
          if (provider.registrants.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Belum ada pendaftar',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Daftar sekarang di halaman registrasi!',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: provider.registrants.length,
            itemBuilder: (context, index) {
              final registrant = provider.registrants[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(registrant.name[0].toUpperCase()),
                  ),
                  title: Text(
                    registrant.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${registrant.programStudi} • ${registrant.email}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Hapus Pendaftar?'),
                          content: Text(
                            'Yakin hapus ${registrant.name}?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text('Batal'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                provider.removeRegistrant(registrant.id);
                                Navigator.pop(ctx);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text('Hapus'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: registrant.id,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### Step 6: Create Detail Page & Setup main.dart (7 menit)

**Create**: `lib/pages/registrant_detail_page.dart`

```dart
// lib/pages/registrant_detail_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/registration_provider.dart';

class RegistrantDetailPage extends StatelessWidget {
  const RegistrantDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final registrant = context.read<RegistrationProvider>().getById(id);

    if (registrant == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Not Found')),
        body: const Center(child: Text('Pendaftar tidak ditemukan')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(registrant.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Avatar
            CircleAvatar(
              radius: 50,
              child: Text(
                registrant.name[0].toUpperCase(),
                style: const TextStyle(fontSize: 36),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              registrant.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Terdaftar: ${registrant.formattedRegisteredAt}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Info Cards
            _buildInfoCard(Icons.email, 'Email', registrant.email),
            _buildInfoCard(Icons.person, 'Gender', registrant.gender),
            _buildInfoCard(Icons.school, 'Program Studi', registrant.programStudi),
            _buildInfoCard(
              Icons.cake,
              'Tanggal Lahir',
              '${registrant.formattedDateOfBirth} (${registrant.age} tahun)',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
```

**Update**: `lib/main.dart`

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/registration_provider.dart';
import 'pages/registration_page.dart';
import 'pages/registrant_list_page.dart';
import 'pages/registrant_detail_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => RegistrationProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registrasi Event',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const RegistrationPage(),
        '/list': (context) => const RegistrantListPage(),
        '/detail': (context) => const RegistrantDetailPage(),
      },
    );
  }
}
```

**Hot Reload & Test Full Flow!**

1. Isi form → Submit → Lihat success dialog ✓
2. Klik "Lihat Daftar" → Muncul di list ✓
3. Tap item → Detail page ✓
4. Badge di AppBar update ✓
5. Delete → Confirm → Removed ✓

---

## 🔍 PART 6: FocusNode, Error Handling & Debugging (15 menit)

### FocusNode: Mengelola Focus Input

**FocusNode** memungkinkan kita mengontrol focus antar field:

```dart
class _MyFormState extends State<MyForm> {
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();

  @override
  void dispose() {
    _nameFocus.dispose();  // WAJIB dispose!
    _emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          focusNode: _nameFocus,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) {
            // Pindah focus ke email saat tekan Enter/Next
            FocusScope.of(context).requestFocus(_emailFocus);
          },
        ),
        TextFormField(
          focusNode: _emailFocus,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) {
            _emailFocus.unfocus(); // Tutup keyboard
          },
        ),
      ],
    );
  }
}
```

> ⚠️ **TROUBLESHOOTING - FocusNode**:
>
> **Problem**: "Keyboard tidak mau tutup"
>
> - **Cause**: Tidak ada mekanisme untuk unfocus
> - **Fix**: Panggil `FocusScope.of(context).unfocus()` atau tap di luar field
>
> **Problem**: "FocusNode already disposed" error
>
> - **Cause**: FocusNode di-dispose tapi masih di-reference di widget tree
> - **Fix**: Pastikan dispose di `dispose()` method, dan jangan requestFocus setelah dispose
>
> **Problem**: "Focus pindah ke field yang salah"
>
> - **Cause**: FocusNode tertukar atau salah assign ke field
> - **Fix**: Beri nama FocusNode yang jelas: `_nameFocus`, `_emailFocus`, dll

**💡 TIP**: Gunakan `textInputAction` untuk mengubah tombol di keyboard:

| TextInputAction | Tombol Keyboard |
| --------------- | --------------- |
| `.next`         | → (Next)        |
| `.done`         | ✓ (Done)        |
| `.search`       | 🔍 (Search)     |
| `.send`         | ➤ (Send)        |

### Error Handling: try-catch

Saat bekerja dengan form, sering ada operasi yang bisa gagal (parsing, konversi). Gunakan `try-catch`:

```dart
void _processAge() {
  try {
    // Operasi yang bisa gagal
    int age = int.parse(_ageController.text);

    if (age < 0) {
      throw FormatException('Umur tidak boleh negatif');
    }

    setState(() {
      _result = 'Umur: $age tahun';
    });
  } on FormatException catch (e) {
    // Tangkap error spesifik
    setState(() {
      _result = 'Error: ${e.message}';
    });
  } catch (e) {
    // Tangkap semua error lain
    setState(() {
      _result = 'Unexpected error: $e';
    });
  } finally {
    // Selalu dijalankan (optional)
    print('Process completed');
  }
}
```

**Pattern try-catch:**

```
try {
  // Code yang mungkin error
} on SpecificException catch (e) {
  // Handle error spesifik
} catch (e, stackTrace) {
  // Handle semua error + stack trace
} finally {
  // Selalu dijalankan
}
```

> ⚠️ **TROUBLESHOOTING - Error Handling**:
>
> **Problem**: "App crash saat parsing input"
>
> - **Cause**: `int.parse()` atau `double.parse()` gagal
> - **Fix**: Gunakan `tryParse()` yang return `null` jika gagal
>
> ```dart
> int? age = int.tryParse(text); // null jika gagal, tidak crash!
> if (age == null) {
>   showError('Input harus angka');
> }
> ```

---

## 🛠️ PART 7: Flutter DevTools & Wrap Up (10 menit)

### Flutter DevTools

**Flutter DevTools** adalah browser-based debugging tool yang powerful:

```
┌────────────────────────────────────┐
│ Flutter DevTools                   │
├────────────────────────────────────┤
│ 🔍 Widget Inspector               │ ← Inspect widget tree
│ 📊 Performance                    │ ← Frame rendering
│ 🧠 Memory                        │ ← Memory usage
│ 🌐 Network                       │ ← HTTP requests
│ 📝 Logging                       │ ← App logs
│ 🐛 Debugger                      │ ← Breakpoints
└────────────────────────────────────┘
```

### Cara Buka DevTools

```bash
# Dari terminal saat app running:
flutter run
# Tekan 'd' untuk DevTools

# Atau langsung:
dart devtools
```

**Di VS Code**: Klik "Open DevTools" di Debug toolbar.

### Widget Inspector - Yang Paling Berguna

Widget Inspector memungkinkan kamu:

1. **Inspect widget tree** → Lihat hierarki widget
2. **Select widget** → Klik widget di emulator, lihat properties
3. **Layout explorer** → Visualisasi Row/Column/Flex
4. **Debug paint** → Lihat boundaries, padding, alignment

**Shortcut Berguna:**

| Shortcut | Fungsi                        |
| -------- | ----------------------------- |
| `r`      | Hot reload                    |
| `R`      | Hot restart                   |
| `d`      | Open DevTools                 |
| `p`      | Toggle debug paint            |
| `o`      | Toggle platform (iOS/Android) |
| `q`      | Quit                          |

### 💡 Tips Debugging Form

1. **Gunakan `print()` di validator** untuk debug:

```dart
validator: (value) {
  print('Validating name: "$value"'); // Debug
  if (value == null || value.isEmpty) return 'Wajib diisi';
  return null;
},
```

2. **Check form state** via debug console:

```dart
// Di onPressed handler
print('Form valid: ${_formKey.currentState!.validate()}');
print('Name: ${_nameController.text}');
```

3. **Breakpoint di submit handler** untuk step-through

### ✅ Yang Sudah Dipelajari

1. **TextField & TextFormField** - Input text dengan controller dan decoration
2. **Form & Validation** - GlobalKey, validator, autovalidateMode
3. **Input Widgets** - Checkbox, Radio, Switch, Slider, Dropdown
4. **DatePicker & TimePicker** - Built-in date/time selection dialogs
5. **Registration Form** - Real-world form dengan Provider integration
6. **FocusNode & Error Handling** - Focus traversal dan try-catch
7. **Flutter DevTools** - Debugging tools dan techniques

### 🏆 Achievement Unlocked

- ✅ Bisa buat form dengan berbagai jenis input
- ✅ Bisa implementasi validasi real-time dan on-submit
- ✅ Bisa pakai DatePicker & TimePicker di dalam Form
- ✅ Bisa manage state form dengan Provider
- ✅ Bisa handle errors dengan try-catch
- ✅ Bisa debug app dengan Flutter DevTools
- ✅ Working registration form app! 📝

---

## 📝 PART 8: Latihan & Tugas Praktikum (10 menit)

### Latihan 1: Form Login Sederhana

**Buat form login** dengan:

- Email (validasi format email)
- Password (min 8 karakter, harus ada huruf besar & angka)
- Checkbox "Ingat Saya"
- Tombol Login & Register

### Latihan 2: Form Survey

**Buat form survey** dengan:

- Nama (TextFormField)
- Jenis kelamin (Radio: L/P)
- Semester (Dropdown: 1-8)
- Tingkat kepuasan (Slider: 1-10)
- Bidang minat (Checkbox multiple: Mobile, Web, AI, Database)
- Saran (TextFormField multiline)
- Summary hasilnya di bawah

### Latihan 3: Form Multi-Step (Bonus)

**Buat form multi-step** (3 steps) menggunakan `Stepper` widget:

- Step 1: Data diri (nama, email)
- Step 2: Akademik (prodi, semester, IPK)
- Step 3: Review & Submit

### 📋 Tugas Praktikum (Deadline: H+7)

**Buat Form Pendaftaran Event** dengan spesifikasi:

**Wajib:**

1. ✅ Minimal 5 field input berbeda jenis
2. ✅ Validasi real-time (`autovalidateMode`)
3. ✅ Minimal 2 jenis input selain TextFormField (Radio, Dropdown, Checkbox, DatePicker, dll)
4. ✅ Provider untuk menyimpan data pendaftar
5. ✅ Halaman list pendaftar
6. ✅ Error handling (try-catch minimal 1 kali)
7. ✅ Reset form setelah submit berhasil

**Bonus (+20):**

- Multi-step form dengan Stepper (+10)
- Edit data pendaftar (+5)
- Search/filter pendaftar (+5)

**Format Pengumpulan:**

- GitHub repository
- Screenshot: form kosong, form terisi, validation error, list pendaftar
- Penamaan: `NIM_NamaLengkap_Tugas5`

---

## ❓ FAQ (Frequently Asked Questions)

### Q1: Bedanya TextField dan TextFormField?

**A**: `TextFormField` = `TextField` + `validator` property. Gunakan `TextFormField` di dalam `Form` widget untuk mendapat fitur validasi otomatis.

### Q2: Kenapa harus dispose Controller?

**A**: Controller menempati memory. Kalau tidak dispose, terjadi **memory leak** — memory yang tidak dibebaskan meskipun widget sudah tidak ada. Di app kecil mungkin tidak terasa, tapi di app besar bisa bikin app lambat/crash.

### Q3: Kapan pakai autovalidateMode?

**A**:

- `disabled` → Form simple yang hanya validate saat submit
- `onUserInteraction` → **RECOMMENDED!** User dapat feedback instant setelah mulai ketik
- `always` → Jarang dipakai, karena error muncul sebelum user mulai ketik

### Q4: Bagaimana validasi yang complex (cross-field)?

**A**: Lakukan di `_submitForm()`, bukan di validator individu:

```dart
void _submitForm() {
  if (_formKey.currentState!.validate()) {
    // Cross-field validation
    if (_password.text != _confirmPassword.text) {
      // Show snackbar atau set error
    }
  }
}
```

### Q5: Bisa custom style error message?

**A**: Ya, via `InputDecoration`:

```dart
TextFormField(
  decoration: InputDecoration(
    errorStyle: TextStyle(
      color: Colors.red.shade700,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
    ),
  ),
)
```

### Q6: Form bisa pake Riverpod / Bloc?

**A**: YES! Tapi **Provider cukup** untuk kebanyakan form. Form state biasanya local ke halaman, jadi Provider sudah optimal. Pertimbangkan Riverpod/Bloc kalau:

- Form data perlu persist across sessions
- Form logic sangat complex (multi-step with branching)
- State perlu di-share ke banyak widgets

---

## 👨‍🏫 FOR INSTRUCTORS ONLY

> 📌 Instruksi untuk Dosen/Instruktur

### Persiapan Sebelum Kelas (30 menit)

1. **Test All Code**
   - Run registration form demo
   - Test semua validator
   - Verify Provider works
   - Test on physical device

2. **Prepare Materials**
   - Form validation flow diagram
   - Input widgets comparison chart
   - DevTools screenshot

3. **Setup Classroom**
   - Projector tested
   - Sample app running
   - WiFi stable for pub get

### Timeline Management (STRICT 150 min)

**Cannot skip**:

- Part 0: 10 min (review essential)
- Part 1: 15 min (TextField basics)
- Part 2: 15 min (Form + validation — CORE!)
- Part 5: 50 min (main project)

**Can adjust**:

- Part 3: 15 min → 10 min (show 3 widgets saja)
- Part 4: 10 min → 7 min (DatePicker saja)
- Part 6: 15 min → 10 min (skip FocusNode, focus try-catch)
- Part 7: 10 min → 5 min (quick DevTools intro)

**If running late**: Skip Part 3-4 detail, incorporate into Part 5 project.

### Common Student Mistakes

1. **Pakai TextField bukan TextFormField** — PALING UMUM!
   - Symptom: validator property doesn't exist
   - Fix: Ganti ke TextFormField

2. **Lupa dispose Controller**
   - Symptom: memory leaks, yellow warning in logs
   - Fix: override dispose(), dispose semua controllers

3. **Lupa GlobalKey di Form**
   - Symptom: `_formKey.currentState` is null
   - Fix: Pasang `key: _formKey` di Form widget

4. **Dropdown value tidak sesuai items**
   - Symptom: error "items must contain value"
   - Fix: Initial value harus null atau ada di items list

5. **DatePicker return null**
   - Symptom: Null error setelah cancel DatePicker
   - Fix: Check `if (picked != null)` sebelum assign

### Grading Praktikum (100 points)

| Kriteria           | Weight | Details                                          |
| ------------------ | ------ | ------------------------------------------------ |
| **Form Fields**    | 25%    | Min 5 fields, berbagai jenis input               |
| **Validation**     | 25%    | Real-time, proper messages, all fields validated |
| **Provider**       | 20%    | Store data, list page, Provider pattern benar    |
| **Error Handling** | 15%    | try-catch, proper error messages                 |
| **Code Quality**   | 15%    | Clean, disposed, proper naming                   |

**Bonus** (+20):

- Multi-step form (+10)
- Edit data (+5)
- Search/filter (+5)

### Discussion Prompts

- "Aplikasi apa yang punya form paling panjang yang pernah kalian isi?"
- "Kenapa Instagram cuma butuh username + password untuk daftar?"
- "Validasi client-side vs server-side — bedanya apa?"

### Differentiation

**Fast learners**:

- Implement multi-step form
- Add image picker untuk foto profil
- Persistent data (SharedPreferences)
- Custom form field widgets

**Struggling students**:

- Provide skeleton code with TODOs
- Focus on 3 fields only (nama, email, password)
- Skip DatePicker dan Radio, pakai TextFormField saja
- Reference solution available

---

**🎉 Pertemuan 5 Complete!**

**Next**: Pertemuan 6 - Integrasi REST API & JSON

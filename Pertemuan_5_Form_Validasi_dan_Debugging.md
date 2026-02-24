# Pertemuan 5: Form, Validasi & Debugging

## 📋 Informasi Pertemuan

| Komponen     | Detail                                       |
| ------------ | -------------------------------------------- |
| **Topik**    | Form, Validasi & Debugging                   |
| **Sub-CPMK** | CPMK-4                                       |
| **Durasi**   | 150 menit (50' teori + 100' praktikum)       |
| **Tugas**    | Form pendaftaran event dengan berbagai input |

---

## 🎯 Tujuan Pembelajaran

Setelah mengikuti pertemuan ini, mahasiswa mampu:

1. ✅ Membuat form dengan berbagai jenis input widget Flutter
2. ✅ Mengimplementasikan validasi form menggunakan `GlobalKey<FormState>`
3. ✅ Menangani keyboard dan focus node dengan benar
4. ✅ Menggunakan DatePicker dan TimePicker
5. ✅ Menerapkan error handling dengan `try-catch`
6. ✅ Menggunakan Flutter DevTools untuk debugging dasar

---

## 📚 Materi 1: TextField dan TextEditingController

### 1.1 Konsep Dasar TextField

`TextField` adalah widget input teks paling dasar di Flutter. Untuk mengontrol dan membaca nilainya, kita menggunakan `TextEditingController`.

```dart
class TextFieldDemo extends StatefulWidget {
  const TextFieldDemo({super.key});

  @override
  State<TextFieldDemo> createState() => _TextFieldDemoState();
}

class _TextFieldDemoState extends State<TextFieldDemo> {
  // Controller untuk membaca/menulis nilai TextField
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _result = '';

  @override
  void dispose() {
    // PENTING: Selalu dispose controller untuk menghindari memory leak!
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TextField Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TextField dasar
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                hintText: 'Masukkan nama Anda',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // TextField untuk email
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'contoh@email.com',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  _result = 'Nama: ${_nameController.text}\n'
                      'Email: ${_emailController.text}';
                });
              },
              child: const Text('Tampilkan'),
            ),

            if (_result.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(_result, style: const TextStyle(fontSize: 16)),
              ),
          ],
        ),
      ),
    );
  }
}
```

### 1.2 Properti Penting TextField

```dart
TextField(
  controller: _controller,

  // Jenis keyboard
  keyboardType: TextInputType.emailAddress,
  // TextInputType.number, .phone, .url, .multiline, .text

  // Tombol action di keyboard
  textInputAction: TextInputAction.next,
  // TextInputAction.done, .search, .send, .go

  // Sembunyikan teks (untuk password)
  obscureText: true,
  obscuringCharacter: '●',

  // Batas jumlah karakter
  maxLength: 50,
  // Catatan: maxLines: 1 otomatis diberlakukan jika obscureText: true.
  // Tidak perlu menulis maxLines secara eksplisit untuk field password.
  maxLines: 1, // null untuk multiline (non-password)

  // Auto-complete dan koreksi
  autocorrect: false,
  enableSuggestions: false,

  // Kapitalisasi
  // ⚠️ Catatan: textCapitalization TIDAK berpengaruh jika obscureText: true.
  // Gunakan textCapitalization HANYA untuk field teks biasa (nama, alamat, dsb.).
  textCapitalization: TextCapitalization.words,

  // Callback
  onChanged: (value) => debugPrint('Berubah: $value'),
  onSubmitted: (value) => debugPrint('Submit: $value'),
  onTap: () => debugPrint('TextField diklik'),

  // InputDecoration untuk styling
  decoration: InputDecoration(
    labelText: 'Label',
    hintText: 'Hint text',
    helperText: 'Teks bantuan di bawah',
    prefixIcon: Icon(Icons.search),
    suffixIcon: IconButton(
      icon: Icon(Icons.clear),
      onPressed: () => _controller.clear(),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    filled: true,
    fillColor: Colors.grey[100],
  ),
)
```

### 1.3 FocusNode - Mengatur Fokus Keyboard

`FocusNode` memungkinkan kita mengontrol field mana yang aktif (mendapat fokus keyboard).

```dart
class FocusNodeDemo extends StatefulWidget {
  const FocusNodeDemo({super.key});

  @override
  State<FocusNodeDemo> createState() => _FocusNodeDemoState();
}

class _FocusNodeDemoState extends State<FocusNodeDemo> {
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();

  @override
  void dispose() {
    _nameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          focusNode: _nameFocus,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) {
            // Pindah fokus ke field berikutnya
            FocusScope.of(context).requestFocus(_emailFocus);
          },
          decoration: const InputDecoration(labelText: 'Nama'),
        ),
        TextField(
          focusNode: _emailFocus,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) {
            FocusScope.of(context).requestFocus(_phoneFocus);
          },
          decoration: const InputDecoration(labelText: 'Email'),
        ),
        TextField(
          focusNode: _phoneFocus,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) {
            // Tutup keyboard
            _phoneFocus.unfocus();
          },
          decoration: const InputDecoration(labelText: 'No. HP'),
        ),
      ],
    );
  }
}
```

> 💡 **Tips**: Gunakan `TextInputAction.next` agar tombol Enter di keyboard berpindah ke field berikutnya, dan `TextInputAction.done` untuk menutup keyboard.

---

## 📚 Materi 2: Form dan Validasi

### 2.1 Mengapa Perlu Validasi?

Validasi form penting untuk:

- 🛡️ Memastikan data yang diinput benar dan lengkap
- 🚫 Mencegah crash akibat data tidak valid
- 😊 Memberikan feedback yang jelas kepada pengguna

### 2.2 Form Widget dan GlobalKey

`Form` widget adalah container khusus yang membungkus field input dan menyediakan API validasi.

```dart
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // GlobalKey untuk mengakses state Form
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // validate() menjalankan semua validator dan menampilkan error
    if (_formKey.currentState!.validate()) {
      // Form valid! Proses data
      // Catatan: currentState!.save() berguna jika TextFormField Anda mendefinisikan
      // callback onSaved: (val) { ... }. Jika tidak ada onSaved, baris ini bisa dilewati.
      // _formKey.currentState!.save();
      debugPrint('Login: ${_emailController.text}');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login berhasil!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          // TextFormField = TextField + dukungan Form
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email tidak boleh kosong';
              }
              // Gunakan RegExp untuk validasi email yang lebih akurat
              final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
              if (!emailRegex.hasMatch(value)) {
                return 'Format email tidak valid';
              }
              return null; // null = valid
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock),
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password tidak boleh kosong';
              }
              if (value.length < 6) {
                return 'Password minimal 6 karakter';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Login'),
            ),
          ),
        ],
      ),
    );
  }
}
```

### 2.3 Validator Pattern - Berbagai Contoh

```dart
// Validator untuk berbagai kebutuhan

// 1. Wajib diisi
String? requiredValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Field ini wajib diisi';
  }
  return null;
}

// 2. Validasi email dengan RegExp
String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email wajib diisi';
  }
  final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  if (!emailRegex.hasMatch(value)) {
    return 'Format email tidak valid';
  }
  return null;
}

// 3. Validasi nomor telepon Indonesia
String? phoneValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Nomor HP wajib diisi';
  }
  final phoneRegex = RegExp(r'^(\+62|62|0)[0-9]{8,12}$');
  if (!phoneRegex.hasMatch(value.replaceAll(' ', '').replaceAll('-', ''))) {
    return 'Format nomor HP tidak valid (contoh: 081234567890)';
  }
  return null;
}

// 4. Validasi password kuat
String? strongPasswordValidator(String? value) {
  if (value == null || value.isEmpty) return 'Password wajib diisi';
  if (value.length < 8) return 'Password minimal 8 karakter';
  if (!value.contains(RegExp(r'[A-Z]'))) return 'Harus ada huruf kapital';
  if (!value.contains(RegExp(r'[0-9]'))) return 'Harus ada angka';
  return null;
}

// 5. Konfirmasi password
// ⚠️ Fungsi ini punya 2 parameter, sehingga tidak bisa langsung dipakai sebagai validator.
// Gunakan sebagai closure agar _passwordController bisa diakses:
//
//   TextFormField(
//     validator: (v) => confirmPasswordValidator(v, _passwordController.text),
//   )
String? confirmPasswordValidator(String? value, String originalPassword) {
  if (value == null || value.isEmpty) return 'Konfirmasi password wajib diisi';
  if (value != originalPassword) return 'Password tidak cocok';
  return null;
}

// 6. Validasi URL
String? urlValidator(String? value) {
  if (value == null || value.isEmpty) return null; // Opsional
  // Regex lebih ketat: harus ada karakter non-spasi setelah '://'
  final urlRegex = RegExp(r'^https?:\/\/[^\s]+\.[^\s]+');
  if (!urlRegex.hasMatch(value.trim())) {
    return 'URL harus diawali dengan http:// atau https://';
  }
  return null;
}
```

### 2.4 AutovalidateMode

```dart
Form(
  key: _formKey,
  // Pilihan mode auto-validasi:

  // Default: hanya validate saat _formKey.currentState!.validate() dipanggil
  autovalidateMode: AutovalidateMode.disabled,

  // Validasi setiap kali pengguna berinteraksi dengan field
  // autovalidateMode: AutovalidateMode.onUserInteraction,

  // Validasi terus-menerus (selalu tampilkan error)
  // autovalidateMode: AutovalidateMode.always,

  child: Column(children: [...]),
)
```

---

## 📚 Materi 3: Input Widget Lanjutan

### 3.1 Checkbox

```dart
class CheckboxDemo extends StatefulWidget {
  const CheckboxDemo({super.key});

  @override
  State<CheckboxDemo> createState() => _CheckboxDemoState();
}

class _CheckboxDemoState extends State<CheckboxDemo> {
  bool _agreeTerms = false;
  final List<String> _selectedHobbies = []; // final: list-nya tetap, isinya yang berubah
  final List<String> _hobbies = ['Membaca', 'Gaming', 'Memasak', 'Olahraga', 'Musik'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Checkbox tunggal
        CheckboxListTile(
          title: const Text('Saya setuju dengan syarat dan ketentuan'),
          value: _agreeTerms,
          onChanged: (bool? value) {
            setState(() => _agreeTerms = value ?? false);
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),

        const Divider(),

        // Multiple checkboxes
        const Text('Pilih hobi Anda:', style: TextStyle(fontWeight: FontWeight.bold)),
        ..._hobbies.map((hobby) => CheckboxListTile(
          title: Text(hobby),
          value: _selectedHobbies.contains(hobby),
          onChanged: (bool? checked) {
            setState(() {
              if (checked == true) {
                _selectedHobbies.add(hobby);
              } else {
                _selectedHobbies.remove(hobby);
              }
            });
          },
        )),

        Text('Hobi dipilih: ${_selectedHobbies.join(', ')}'),
      ],
    );
  }
}
```

### 3.2 Radio Button

```dart
class RadioDemo extends StatefulWidget {
  const RadioDemo({super.key});

  @override
  State<RadioDemo> createState() => _RadioDemoState();
}

class _RadioDemoState extends State<RadioDemo> {
  // Gunakan nilai yang sama dengan label agar output konsisten (misal: 'Laki-laki', bukan 'male')
  String _gender = 'Laki-laki';
  String _education = 'S1';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Jenis Kelamin:', style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Radio<String>(
              value: 'Laki-laki',
              groupValue: _gender,
              onChanged: (value) => setState(() => _gender = value!),
            ),
            const Text('Laki-laki'),
            const SizedBox(width: 16),
            Radio<String>(
              value: 'Perempuan',
              groupValue: _gender,
              onChanged: (value) => setState(() => _gender = value!),
            ),
            const Text('Perempuan'),
          ],
        ),

        const Divider(),

        // RadioListTile lebih mudah digunakan
        const Text('Pendidikan Terakhir:', style: TextStyle(fontWeight: FontWeight.bold)),
        ...['SMA/SMK', 'D3', 'S1', 'S2', 'S3'].map((edu) => RadioListTile<String>(
          title: Text(edu),
          value: edu,
          groupValue: _education,
          onChanged: (value) => setState(() => _education = value!),
        )),

        Text('Terpilih: $_gender, $_education'),
      ],
    );
  }
}
```

### 3.3 Switch dan Slider

```dart
class SwitchSliderDemo extends StatefulWidget {
  const SwitchSliderDemo({super.key});

  @override
  State<SwitchSliderDemo> createState() => _SwitchSliderDemoState();
}

class _SwitchSliderDemoState extends State<SwitchSliderDemo> {
  bool _notifications = true;
  bool _darkMode = false;
  double _volume = 50.0;
  RangeValues _priceRange = const RangeValues(100000, 500000);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Switch
        SwitchListTile(
          title: const Text('Notifikasi'),
          subtitle: const Text('Terima notifikasi push'),
          value: _notifications,
          onChanged: (value) => setState(() => _notifications = value),
        ),
        SwitchListTile(
          title: const Text('Mode Gelap'),
          value: _darkMode,
          onChanged: (value) => setState(() => _darkMode = value),
        ),

        const Divider(),

        // Slider
        const Text('Volume:'),
        Slider(
          value: _volume,
          min: 0,
          max: 100,
          divisions: 10, // Snap to divisions
          label: '${_volume.round()}',
          onChanged: (value) => setState(() => _volume = value),
        ),
        Text('Volume: ${_volume.round()}%'),

        const SizedBox(height: 16),

        // RangeSlider (untuk rentang nilai)
        const Text('Rentang Harga:'),
        RangeSlider(
          values: _priceRange,
          min: 0,
          max: 1000000,
          divisions: 20,
          labels: RangeLabels(
            'Rp ${_priceRange.start.round()}',
            'Rp ${_priceRange.end.round()}',
          ),
          onChanged: (values) => setState(() => _priceRange = values),
        ),
        Text('Harga: Rp ${_priceRange.start.round()} - Rp ${_priceRange.end.round()}'),
      ],
    );
  }
}
```

### 3.4 Dropdown

```dart
class DropdownDemo extends StatefulWidget {
  const DropdownDemo({super.key});

  @override
  State<DropdownDemo> createState() => _DropdownDemoState();
}

class _DropdownDemoState extends State<DropdownDemo> {
  String? _selectedProvince;
  String? _selectedCity;

  final Map<String, List<String>> _citiesByProvince = {
    'Jawa Barat': ['Bandung', 'Bekasi', 'Bogor', 'Depok', 'Cimahi'],
    'DKI Jakarta': ['Jakarta Pusat', 'Jakarta Barat', 'Jakarta Timur', 'Jakarta Selatan', 'Jakarta Utara'],
    'Jawa Tengah': ['Semarang', 'Solo', 'Yogyakarta', 'Magelang', 'Purwokerto'],
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // DropdownButtonFormField (direkomendasikan untuk Form)
        DropdownButtonFormField<String>(
          value: _selectedProvince,
          decoration: const InputDecoration(
            labelText: 'Provinsi',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.location_on),
          ),
          hint: const Text('Pilih provinsi'),
          items: _citiesByProvince.keys.map((province) {
            return DropdownMenuItem<String>(
              value: province,
              child: Text(province),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedProvince = value;
              _selectedCity = null; // Reset kota saat provinsi berganti
            });
          },
          validator: (value) {
            if (value == null) return 'Pilih provinsi terlebih dahulu';
            return null;
          },
        ),

        const SizedBox(height: 16),

        // Dropdown kota (bergantung pada provinsi)
        DropdownButtonFormField<String>(
          value: _selectedCity,
          decoration: const InputDecoration(
            labelText: 'Kota',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.location_city),
          ),
          hint: const Text('Pilih kota'),
          items: (_selectedProvince != null
              ? _citiesByProvince[_selectedProvince]!
              : [])
              .map((city) => DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  ))
              .toList(),
          onChanged: _selectedProvince != null
              ? (value) => setState(() => _selectedCity = value)
              : null,
          validator: (value) {
            if (_selectedProvince != null && value == null) {
              return 'Pilih kota terlebih dahulu';
            }
            return null;
          },
        ),

        if (_selectedProvince != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text('Lokasi: ${_selectedCity ?? '...'}, $_selectedProvince'),
          ),
      ],
    );
  }
}
```

---

## 📚 Materi 4: DatePicker dan TimePicker

> 💡 **Catatan Lokalisasi**: Untuk menampilkan DatePicker dalam Bahasa Indonesia, tambahkan
> `flutter_localizations` ke `pubspec.yaml` dan daftarkan `localizationsDelegates` di `MaterialApp`.
> Contoh di bawah menggunakan `locale: const Locale('id', 'ID')` — **hapus baris ini** jika belum
> setup lokalisasi agar tidak error. DatePicker tetap berfungsi normal dalam Bahasa Inggris tanpa setup tersebut.

```dart
class DateTimePickerDemo extends StatefulWidget {
  const DateTimePickerDemo({super.key});

  @override
  State<DateTimePickerDemo> createState() => _DateTimePickerDemoState();
}

class _DateTimePickerDemoState extends State<DateTimePickerDemo> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  DateTimeRange? _selectedRange;

  // Menampilkan DatePicker
  Future<void> _pickDate() async {
    // Clamp initialDate agar selalu dalam range [firstDate, lastDate]
    final firstDate = DateTime(2000);
    final lastDate = DateTime(2100);
    final initialDate = (_selectedDate != null &&
            !_selectedDate!.isBefore(firstDate) &&
            !_selectedDate!.isAfter(lastDate))
        ? _selectedDate!
        : DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      helpText: 'Pilih Tanggal Lahir',
      // locale: const Locale('id', 'ID'), // Aktifkan jika sudah setup flutter_localizations
      builder: (context, child) {
        // Contoh kustomisasi warna DatePicker
        // Ganti Colors.teal dengan warna brand aplikasi Anda
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.teal, // Warna header & tombol OK
              onPrimary: Colors.white, // Warna teks di atas primary
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  // Menampilkan TimePicker
  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      helpText: 'Pilih Waktu',
    );

    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  // DateRange Picker untuk rentang tanggal
  Future<void> _pickDateRange() async {
    // ⚠️ Gunakan date-only (tanpa jam) untuk firstDate agar tidak crash.
    // DateTime.now() menyertakan jam:menit:detik sehingga bisa lebih besar
    // dari initialDateRange.start yang tersimpan sebagai midnight (DateTime(y,m,d)).
    final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final lastDay = today.add(const Duration(days: 365));

    // Pastikan initialDateRange tidak di luar [firstDate, lastDate]
    final safeInitialRange = (_selectedRange != null &&
            !_selectedRange!.start.isBefore(today) &&
            !_selectedRange!.end.isAfter(lastDay))
        ? _selectedRange
        : null;

    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: today,
      lastDate: lastDay,
      initialDateRange: safeInitialRange,
      helpText: 'Pilih Rentang Tanggal',
    );

    if (picked != null) {
      setState(() => _selectedRange = picked);
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return '${date.day} ${months[date.month]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ① Date Picker
        ListTile(
          leading: const Icon(Icons.calendar_today, color: Colors.blue),
          title: const Text('Tanggal Lahir'),
          subtitle: Text(
            _selectedDate != null
                ? _formatDate(_selectedDate!)
                : 'Belum dipilih',
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: _pickDate,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
        ),

        const SizedBox(height: 12),

        // ② Time Picker
        ListTile(
          leading: const Icon(Icons.access_time, color: Colors.orange),
          title: const Text('Waktu Acara'),
          subtitle: Text(
            _selectedTime != null
                ? _selectedTime!.format(context)
                : 'Belum dipilih',
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: _pickTime,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
        ),

        const SizedBox(height: 12),

        // ③ DateRange Picker (untuk rentang tanggal: misal check-in s/d check-out)
        ListTile(
          leading: const Icon(Icons.date_range, color: Colors.green),
          title: const Text('Rentang Tanggal Acara'),
          subtitle: Text(
            _selectedRange != null
                ? '${_formatDate(_selectedRange!.start)} — ${_formatDate(_selectedRange!.end)}'
                : 'Belum dipilih',
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: _pickDateRange,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }
}
```

---

## 📚 Materi 5: Error Handling

### 5.1 Try-Catch Dasar

```dart
// Contoh penanganan error di Flutter
// Catatan: someHttpCall() dan showErrorDialog() adalah pseudocode.
// Pada kode nyata, someHttpCall() bisa berupa http.get(), dio.get(), dsb.
// import 'dart:io' show SocketException;
// import 'dart:async' show TimeoutException;

Future<void> fetchData() async {
  try {
    // Operasi yang mungkin gagal
    // 'response' tidak di-assign ke variabel agar tidak timbul lint 'unused_local_variable'.
    // Pada kode nyata, olah return value-nya: final data = await someHttpCall();
    await someHttpCall();
    // Process response...
  } on FormatException catch (e) {
    // Error spesifik: format data salah (misalnya JSON rusak)
    debugPrint('Format error: $e');
    showErrorDialog('Data tidak valid');
  } on SocketException catch (e) {
    // Error spesifik: masalah jaringan / tidak ada koneksi
    debugPrint('Network error: $e');
    showErrorDialog('Tidak ada koneksi internet');
  } on TimeoutException catch (e) {
    // Error spesifik: request terlalu lama
    debugPrint('Timeout: $e');
    showErrorDialog('Koneksi timeout, coba lagi');
  } catch (e, stackTrace) {
    // Error umum (catch-all)
    debugPrint('Error tidak terduga: $e');
    debugPrint('Stack trace: $stackTrace');
    showErrorDialog('Terjadi kesalahan: $e');
  } finally {
    // Selalu dijalankan, baik sukses maupun error
    // setState hanya bisa dipanggil di dalam State class
    setState(() => _isLoading = false);
  }
}
```

### 5.2 Validasi Input Sebelum Submit

```dart
void _processForm() {
  // Pola validasi berlapis
  // (Pastikan controller sudah dideklarasikan di State class Anda)
  // final _emailController = TextEditingController();
  // final _ageController = TextEditingController();
  try {
    final email = _emailController.text.trim();
    final age = int.parse(_ageController.text); // Bisa throw FormatException

    if (age < 18 || age > 100) {
      throw RangeError('Usia harus antara 18-100 tahun');
    }

    // Lanjut proses...
    debugPrint('Data valid: $email, $age tahun');

  } on FormatException {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Usia harus berupa angka valid')),
    );
  } on RangeError catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      // e.message bertipe Object? — gunakan toString() untuk konversi aman ke String
      SnackBar(content: Text(e.message?.toString() ?? 'Nilai di luar rentang')),
    );
  }
}
```

### 5.3 Menampilkan Error ke Pengguna

```dart
// Cara 1: SnackBar (untuk pesan singkat)
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: const Text('Email tidak valid!'),
    backgroundColor: Colors.red,
    action: SnackBarAction(
      label: 'OK',
      textColor: Colors.white,
      onPressed: () {},
    ),
  ),
);

// Cara 2: AlertDialog (untuk konfirmasi penting)
showDialog(
  context: context,
  builder: (ctx) => AlertDialog(
    title: const Text('Error'),
    content: const Text('Terjadi kesalahan. Coba lagi?'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(ctx),
        child: const Text('Batal'),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.pop(ctx);
          // Retry
        },
        child: const Text('Coba Lagi'),
      ),
    ],
  ),
);

// Cara 3: Inline error di bawah field
// Gunakan TextFormField dengan validator (sudah dibahas di Materi 2)
```

---

## 📚 Materi 6: Flutter DevTools - Dasar Debugging

### 6.1 Membuka DevTools

Flutter DevTools adalah tools resmi untuk debugging dan profiling aplikasi Flutter.

**Cara membuka:**

1. Jalankan aplikasi: `flutter run`
2. Di terminal akan muncul: `Flutter DevTools:  http://127.0.0.1:9100?...`
3. Buka URL tersebut di browser

**Atau lewat VS Code:**

- Tekan `F5` untuk run
- Klik tombol Flutter icon di status bar bawah
- Pilih "Open DevTools"

### 6.2 Widget Inspector

Widget Inspector membantu memahami struktur widget tree aplikasi Anda.

```
📱 Fitur Widget Inspector:
├── Select Widget Mode  → Klik widget di layar untuk melihat detailnya
├── Widget Tree Panel  → Struktur hierarki widget
├── Details Panel      → Properties widget yang dipilih
└── Layout Explorer    → Visualisasi constraints & sizing
```

**Cara penggunaan:**

1. Buka DevTools → Tab **Flutter Inspector**
2. Klik ikon **Select Widget Mode** (cursor icon)
3. Klik widget di emulator/device
4. Lihat properties di panel kanan

### 6.3 Debug Print dan Breakpoint

```dart
// Debug print sederhana
// print() bawaan Dart — cukup untuk log pendek
print('Nilai x: $x');
// debugPrint() dari package:flutter/foundation.dart — lebih aman untuk pesan panjang
// karena membatasi output agar tidak terpotong di console Android/iOS
debugPrint('Pesan debug: $message');

// Kondisional debug (assert body hanya dieksekusi di debug mode)
assert(() {
  debugPrint('Ini hanya tampil di debug mode');
  return true;
}());

// Breakpoint di kode (pause eksekusi)
// Tambahkan di VS Code: klik di sebelah kiri nomor baris
// Atau tambahkan di kode:
debugger(); // Membutuhkan import 'dart:developer';
```

### 6.4 Common Debugging Tips

| Problem                      | Gejala                                   | Solusi                                                       |
| ---------------------------- | ---------------------------------------- | ------------------------------------------------------------ |
| **Overflow**                 | Garis kuning merah di widget             | Gunakan `Expanded`, `Flexible`, atau `SingleChildScrollView` |
| **Null Error**               | `Null check operator used on null value` | Periksa null safety, gunakan `?` dan `??`                    |
| **setState() after dispose** | Warning di console                       | Cek `mounted` sebelum `setState`                             |
| **InkWell tidak respond**    | Area tap tidak bereaksi                  | Pastikan parent tidak opaque/blocking                        |
| **Column overflow**          | Konten terpotong                         | Bungkus dengan `SingleChildScrollView`                       |

```dart
// Cara aman setState setelah operasi async
Future<void> loadData() async {
  final data = await fetchFromServer();

  // Cek apakah widget masih terpasang sebelum setState
  if (mounted) {
    setState(() => _data = data);
  }
}
```

---

## 🏗️ Proyek Praktikum: Form Registrasi Multi-Step

### Deskripsi Proyek

Mahasiswa membangun form registrasi event yang terdiri dari 3 langkah (step):

1. **Step 1**: Informasi Pribadi (nama, email, telepon, tanggal lahir)
2. **Step 2**: Preferensi Acara (jenis tiket, sesi pilihan, kebutuhan khusus)
3. **Step 3**: Review & Konfirmasi

### Struktur Proyek

```
pertemuan_5_registration/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   └── registrant_model.dart
│   ├── providers/
│   │   └── registration_provider.dart
│   ├── pages/
│   │   ├── registration_page.dart
│   │   └── success_page.dart
│   └── widgets/
│       ├── custom_text_field.dart
│       └── step_indicator.dart
├── pubspec.yaml
└── README.md
```

### Fitur Utama

- ✅ Form multi-step dengan progress indicator
- ✅ Validasi per step sebelum lanjut
- ✅ DatePicker untuk tanggal lahir
- ✅ Dropdown untuk pilihan kota
- ✅ Checkbox untuk persetujuan syarat & ketentuan
- ✅ Radio untuk jenis tiket
- ✅ Slider untuk jumlah porsi makan
- ✅ Summary di step terakhir
- ✅ State management dengan Provider

---

## 📝 Latihan Mandiri

### Latihan 1: Form Login Sederhana

Buat form login dengan:

- Field email dengan validasi format email
- Field password (tersembunyi) minimal 6 karakter
- Tombol "Tampilkan Password"
- Tombol Login yang menampilkan SnackBar jika valid

### Latihan 2: Form Profil Pengguna

Buat form edit profil dengan:

- Nama lengkap (wajib, min 3 karakter)
- Email (wajib, validasi format)
- Nomor HP (opsional, validasi format Indonesia)
- Tanggal lahir via DatePicker
- Jenis kelamin via Radio button
- Bio (opsional, multiline, max 200 karakter)
- Tombol Simpan

### Latihan 3: Quiz Widget

Identifikasi widget yang tepat untuk setiap kasus:

1. Input kata sandi → ?
2. Pilih satu dari banyak opsi → ?
3. Pilih banyak dari banyak opsi → ?
4. Toggle on/off → ?
5. Pilih nilai dari rentang → ?
6. Pilih tanggal → ?

---

## 💡 Rangkuman

| Topik           | Widget / Kelas Kunci                                            |
| --------------- | --------------------------------------------------------------- |
| Input teks      | `TextField`, `TextFormField`, `TextEditingController`           |
| Pilihan         | `Checkbox`, `Radio`, `Switch`, `DropdownButtonFormField`        |
| Nilai           | `Slider`, `RangeSlider`                                         |
| Tanggal/Waktu   | `showDatePicker()`, `showTimePicker()`, `showDateRangePicker()` |
| Form & Validasi | `Form`, `GlobalKey<FormState>`, `validator`, `autovalidateMode` |
| Fokus keyboard  | `FocusNode`, `FocusScope`, `TextInputAction`                    |
| Error handling  | `try-catch-finally`, `on ExceptionType`                         |
| Debugging       | `print()`, `debugPrint()`, `Flutter DevTools`                   |

---

## 📚 Referensi

- [Flutter Forms Cookbook](https://docs.flutter.dev/cookbook/forms)
- [Build a form with validation](https://docs.flutter.dev/cookbook/forms/validation)
- [TextFormField - Flutter API](https://api.flutter.dev/flutter/material/TextFormField-class.html)
- [Flutter DevTools](https://docs.flutter.dev/tools/devtools/overview)
- [Error handling in Dart](https://dart.dev/language/error-handling)

---

## 🏠 Tugas Pertemuan 5

**Form Pendaftaran Event**

Buat aplikasi Flutter dengan form pendaftaran event yang memenuhi persyaratan:

### Persyaratan Teknis:

1. ✅ **Minimal 6 jenis input berbeda**: TextField/TextFormField, Checkbox/CheckboxListTile, Radio/RadioListTile, Switch/SwitchListTile, DropdownButton/DropdownButtonFormField, Slider, DatePicker/TimePicker
2. ✅ **Validasi lengkap** pada semua field wajib
3. ✅ **Tampilkan error** yang informatif kepada pengguna
4. ✅ **Halaman konfirmasi** setelah form berhasil disubmit, menampilkan data yang diinput
5. ✅ **State management** dengan `setState` atau Provider

### Nilai Bonus:

- ⭐ Form multi-step (wizard/stepper)
- ⭐ Animasi transisi antar bagian form
- ⭐ Simpan data ke SharedPreferences (preview Pertemuan 7)

### Format Pengumpulan:

- Zip source code: `NIM_Nama_Tugas5.zip`
- Screenshot minimal 3 tampilan berbeda
- Upload ke LMS sebelum pertemuan berikutnya

# 🔑 KUNCI JAWABAN RAHASIA — Pertemuan 5: Form, Validasi & Debugging

> ⚠️ DOKUMEN INI HANYA UNTUK DOSEN. Jangan dibagikan ke mahasiswa sebelum nilai diumumkan.

---

## 📝 Latihan Mandiri — Jawaban

### Latihan 1: Form Login Sederhana — Kunci Jawaban

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: LoginPage()));

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() => _isLoading = true);
    // Aktifkan autovalidate setelah tombol ditekan
    if (!_formKey.currentState!.validate()) {
      setState(() => _isLoading = false);
      return;
    }
    // Simulasi proses login
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login berhasil! Selamat datang, ${_emailController.text}'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Email wajib diisi';
                  if (!RegExp(r'^[\w\-.]+@[\w\-]+\.\w{2,}$').hasMatch(v)) {
                    return 'Format email tidak valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                    tooltip: 'Tampilkan/Sembunyikan Password',
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Password wajib diisi';
                  if (v.length < 6) return 'Password minimal 6 karakter';
                  return null;
                },
                onFieldSubmitted: (_) => _login(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  child: _isLoading
                      ? const SizedBox(
                          width: 20, height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Login', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

### Latihan 2: Form Profil Pengguna — Kunci Jawaban

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: ProfilePage()));

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _bioController = TextEditingController();

  String _gender = 'Laki-laki';
  DateTime? _birthDate;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime d) {
    const months = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
                    'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
    return '${d.day} ${months[d.month]} ${d.year}';
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(2000),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthDate = picked;
        _birthDateController.text = _formatDate(picked);
      });
    }
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ Profil berhasil disimpan!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nama
              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap *',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Nama wajib diisi';
                  if (v.trim().length < 3) return 'Nama minimal 3 karakter';
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Email
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email *',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Email wajib diisi';
                  final emailRegex = RegExp(r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$');
                  if (!emailRegex.hasMatch(v)) return 'Format email tidak valid';
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // No HP (opsional)
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Nomor HP (opsional)',
                  prefixIcon: Icon(Icons.phone_outlined),
                  border: OutlineInputBorder(),
                  hintText: '081234567890',
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return null; // opsional
                  final phoneRegex = RegExp(r'^(\+62|62|0)[0-9]{8,12}$');
                  if (!phoneRegex.hasMatch(v.replaceAll(RegExp(r'[\s\-]'), ''))) {
                    return 'Format tidak valid (cth: 081234567890)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Tanggal Lahir via DatePicker
              TextFormField(
                controller: _birthDateController,
                readOnly: true,
                onTap: _pickDate,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Lahir',
                  prefixIcon: Icon(Icons.cake_outlined),
                  suffixIcon: Icon(Icons.calendar_today, size: 18),
                  border: OutlineInputBorder(),
                  hintText: 'Klik untuk memilih',
                ),
              ),
              const SizedBox(height: 14),

              // Jenis Kelamin — Radio Button
              const Text('Jenis Kelamin *',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              ...['Laki-laki', 'Perempuan', 'Tidak disebutkan']
                  .map((g) => RadioListTile<String>(
                        title: Text(g),
                        value: g,
                        groupValue: _gender,
                        onChanged: (v) => setState(() => _gender = v!),
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      )),
              const SizedBox(height: 14),

              // Bio — Multiline, opsional, max 200 karakter
              TextFormField(
                controller: _bioController,
                maxLines: 4,
                maxLength: 200,
                decoration: const InputDecoration(
                  labelText: 'Bio (opsional)',
                  prefixIcon: Icon(Icons.notes),
                  border: OutlineInputBorder(),
                  hintText: 'Ceritakan sedikit tentang diri Anda...',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('Simpan Profil',
                      style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

### Latihan 3: Quiz Widget

| Kasus                             | Widget yang Tepat                              | Alasan                                              |
| --------------------------------- | ---------------------------------------------- | --------------------------------------------------- |
| Input kata sandi                  | `TextField(obscureText: true)`                 | Menyembunyikan karakter yang diketik                |
| Pilih **satu** dari banyak opsi   | `Radio` / `RadioListTile`                      | Hanya boleh satu terpilih dalam satu group          |
| Pilih **banyak** dari banyak opsi | `Checkbox` / `CheckboxListTile` / `FilterChip` | Bisa memilih lebih dari satu                        |
| Toggle on/off                     | `Switch` / `SwitchListTile`                    | Boolean state, visual toggle                        |
| Pilih nilai dari rentang          | `Slider`                                       | Nilai kontinu antara min dan max                    |
| Pilih tanggal                     | `showDatePicker()`                             | Dialog bawaan Material Design untuk memilih tanggal |

---

## 🏠 Tugas — Rubrik Penilaian Detail

### Kriteria Wajib (80 poin)

| No  | Kriteria                                | Poin | Indikator                                                             |
| --- | --------------------------------------- | ---- | --------------------------------------------------------------------- |
| 1   | Minimal 6 jenis input widget berbeda    | 30   | `TextField`, `Checkbox/Radio/Switch`, `Dropdown`, `Slider/DatePicker` |
| 2   | Validasi lengkap pada semua field wajib | 20   | `validator` return String saat error, null saat valid                 |
| 3   | Tampilan pesan error informatif         | 10   | Teks error jelas, tidak hanya "field tidak valid"                     |
| 4   | Halaman konfirmasi setelah submit       | 10   | Menampilkan data yang diinput oleh pengguna                           |
| 5   | Kode bersih & terstruktur               | 10   | `dispose()` controller, naming convention, tidak ada kode duplikat    |

### Kriteria Bonus (20 poin)

| Bonus                    | Poin | Indikator                                            |
| ------------------------ | ---- | ---------------------------------------------------- |
| Form multi-step (wizard) | +10  | Min 2 step dengan validasi per step                  |
| Animasi transisi         | +5   | `AnimatedSwitcher` atau `PageView` antar bagian form |
| SharedPreferences        | +5   | Menyimpan data form ke storage lokal                 |

---

## 🔍 Poin Rawan Kesalahan Mahasiswa

### 1. Lupa dispose() controller

```dart
// ❌ SALAH — Memory Leak!
class _MyState extends State<MyWidget> {
  final controller = TextEditingController();
  // Tidak ada dispose!
}

// ✅ BENAR
class _MyState extends State<MyWidget> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
```

### 2. validator return terbalik

```dart
// ❌ SALAH — null saat error, String saat valid
validator: (v) {
  if (v!.isNotEmpty) return null;  // Ini valid
  return 'Wajib diisi';            // Ini error
}

// ✅ BENAR — null = valid, String = pesan error
validator: (v) {
  if (v == null || v.isEmpty) return 'Wajib diisi';  // Error
  return null;  // Valid
}
```

### 3. setState setelah async tanpa mounted check

```dart
// ❌ Bisa crash jika user navigasi saat loading
Future<void> loadData() async {
  await Future.delayed(Duration(seconds: 2));
  setState(() => _data = 'done'); // Berbahaya!
}

// ✅ Aman
Future<void> loadData() async {
  await Future.delayed(Duration(seconds: 2));
  if (mounted) setState(() => _data = 'done');
}
```

### 4. GlobalKey tidak dibuat dengan `final`

```dart
// ❌ SALAH — GlobalKey harus persist, jangan dibuat ulang di build()
Widget build(BuildContext context) {
  final formKey = GlobalKey<FormState>(); // Dibuat ulang setiap rebuild!
  return Form(key: formKey, ...);
}

// ✅ BENAR — Deklarasi sebagai field class
class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
}
```

### 5. Dropdown value tidak ada di items

```dart
// ❌ Error: value 'Bandung' tidak ada di items
DropdownButtonFormField<String>(
  value: 'Bandung',          // value ini harus ada di items!
  items: ['Jakarta', 'Surabaya']
      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
      .toList(),
)

// ✅ Pastikan value ada di items, atau gunakan null sebagai default
DropdownButtonFormField<String>(
  value: null,               // null = belum dipilih (gunakan hint)
  hint: Text('Pilih kota'),
  items: ['Bandung', 'Jakarta', 'Surabaya']
      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
      .toList(),
  onChanged: (v) => ...,
)
```

---

## 📊 Distribusi Nilai yang Diharapkan

| Rentang | Kategori    | Perkiraan Persentase |
| ------- | ----------- | -------------------- |
| 90-100  | Sangat Baik | 10%                  |
| 75-89   | Baik        | 40%                  |
| 60-74   | Cukup       | 35%                  |
| < 60    | Kurang      | 15%                  |

---

## 💡 Pertanyaan Diskusi untuk Kelas

1. **Mengapa** kita harus selalu memanggil `dispose()` pada `TextEditingController` dan `FocusNode`?

   **Jawaban**: Karena controller dan FocusNode menggunakan resource (listener, streams) yang harus dilepas ketika widget sudah tidak digunakan untuk mencegah _memory leak_. `dispose()` dipanggil saat widget dihapus dari widget tree.

2. Apa perbedaan antara `TextField` dan `TextFormField`?

   **Jawaban**: `TextFormField` adalah `TextField` yang terintegrasi dengan `Form` widget. `TextFormField` mendukung properti `validator`, `onSaved`, dan berpartisipasi dalam validasi otomatis `Form`. `TextField` hanya widget input biasa tanpa integrasi `Form`.

3. Kapan sebaiknya menggunakan `autovalidateMode: AutovalidateMode.onUserInteraction`?

   **Jawaban**: Sebaiknya digunakan **setelah** pengguna mencoba submit pertama kali. Jika diaktifkan dari awal, pengguna langsung melihat error di field yang belum pernah disentuh, yang bisa membingungkan. Pola umum: set ke `disabled` awal, ganti ke `onUserInteraction` saat tombol Submit ditekan.

4. Apa itu `GlobalKey<FormState>` dan mengapa tidak boleh dibuat di dalam fungsi `build()`?

   **Jawaban**: `GlobalKey<FormState>` adalah kunci unik yang mengidentifikasi widget `Form` dan memberi akses ke state-nya (untuk memanggil `validate()`, `save()`, `reset()`). Tidak boleh dibuat di `build()` karena `build()` bisa dipanggil berkali-kali, dan setiap pembuatan key baru akan "memutus" referensi ke Form yang sudah ada.

---

## 🗓️ Timeline Koreksi

| Hari        | Kegiatan                                    |
| ----------- | ------------------------------------------- |
| H+1 s/d H+5 | Koreksi tugas (gunakan rubrik di atas)      |
| H+6         | Input nilai ke LMS                          |
| H+7         | Umumkan nilai + feedback umum di grup kelas |

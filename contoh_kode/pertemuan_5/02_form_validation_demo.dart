// DEMO 02: Form Widget & Validasi
//
// Topik yang dibahas:
// - Form widget sebagai container validasi
// - GlobalKey<FormState> untuk trigger validate/save/reset
// - TextFormField dengan validator callback
// - autovalidateMode: disabled vs onUserInteraction vs always
// - Berbagai pola validator (email, password, phone, URL)
// - Konfirmasi password (cross-field validation)

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Validation Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const FormValidationPage(),
    );
  }
}

// =============================================================
// HALAMAN UTAMA: Form Registrasi dengan Validasi Lengkap
// =============================================================
class FormValidationPage extends StatefulWidget {
  const FormValidationPage({super.key});

  @override
  State<FormValidationPage> createState() => _FormValidationPageState();
}

class _FormValidationPageState extends State<FormValidationPage> {
  // ① Kunci unik untuk mengakses FormState
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  // FocusNodes
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmFocus = FocusNode();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _isSubmitting = false;

  // ② Mode validasi otomatis
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  // ============================================================
  // VALIDATOR FUNCTIONS
  // ============================================================

  // Validasi nama: wajib, minimal 3 karakter
  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nama tidak boleh kosong';
    }
    if (value.trim().length < 3) {
      return 'Nama minimal 3 karakter';
    }
    if (value.trim().length > 100) {
      return 'Nama maksimal 100 karakter';
    }
    return null; // null = valid ✓
  }

  // Validasi email dengan RegExp
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    // RegExp standar untuk email
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Format email tidak valid (cth: nama@domain.com)';
    }
    return null;
  }

  // Validasi nomor HP Indonesia
  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Opsional — boleh kosong
    }
    // Hapus spasi dan strip untuk pengecekan
    final cleaned = value.replaceAll(RegExp(r'[\s\-]'), '');
    // Format valid: 08xx, +628xx, 628xx
    final phoneRegex = RegExp(r'^(\+62|62|0)[0-9]{8,12}$');
    if (!phoneRegex.hasMatch(cleaned)) {
      return 'Format tidak valid (cth: 081234567890)';
    }
    return null;
  }

  // Validasi password kuat: min 8 char, ada huruf kapital, ada angka
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 8) {
      return 'Password minimal 8 karakter';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Harus mengandung setidaknya 1 huruf kapital';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Harus mengandung setidaknya 1 angka';
    }
    return null;
  }

  // Validasi konfirmasi password (cross-field)
  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi password tidak boleh kosong';
    }
    if (value != _passwordController.text) {
      return 'Password tidak cocok';
    }
    return null;
  }

  // ============================================================
  // SUBMIT HANDLER
  // ============================================================
  Future<void> _submitForm() async {
    // ③ Setelah user klik submit, aktifkan autovalidate
    setState(() {
      _autovalidateMode = AutovalidateMode.onUserInteraction;
    });

    // ④ validate() menjalankan SEMUA validator sekaligus
    if (!_formKey.currentState!.validate()) {
      // Ada field yang tidak valid
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon perbaiki field yang masih salah'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Semua valid! Proses data
    setState(() => _isSubmitting = true);

    // Simulasi proses (misal: HTTP request)
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isSubmitting = false);

      // ⑤ Tampilkan dialog sukses
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('✅ Registrasi Berhasil!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama: ${_nameController.text}'),
              Text('Email: ${_emailController.text}'),
              Text('No. HP: ${_phoneController.text.isEmpty ? "-" : _phoneController.text}'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                // ⑥ Reset form
                _formKey.currentState!.reset();
                _nameController.clear();
                _emailController.clear();
                _phoneController.clear();
                _passwordController.clear();
                _confirmController.clear();
                setState(() {
                  _autovalidateMode = AutovalidateMode.disabled;
                });
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo 02: Form & Validasi'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey, // ① Hubungkan Form dengan GlobalKey
          autovalidateMode: _autovalidateMode, // ② Mode validasi
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Buat Akun Baru',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Semua field bertanda * wajib diisi',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
              const SizedBox(height: 24),

              // -- Nama --
              TextFormField(
                controller: _nameController,
                focusNode: _nameFocus,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                validator: _validateName, // ③ Pasang validator
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap *',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_emailFocus),
              ),
              const SizedBox(height: 16),

              // -- Email --
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocus,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: _validateEmail,
                decoration: const InputDecoration(
                  labelText: 'Alamat Email *',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_phoneFocus),
              ),
              const SizedBox(height: 16),

              // -- No. HP (opsional) --
              TextFormField(
                controller: _phoneController,
                focusNode: _phoneFocus,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                validator: _validatePhone,
                decoration: const InputDecoration(
                  labelText: 'No. HP (opsional)',
                  prefixIcon: Icon(Icons.phone_outlined),
                  border: OutlineInputBorder(),
                  hintText: '081234567890',
                ),
                onSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_passwordFocus),
              ),
              const SizedBox(height: 16),

              // -- Password --
              TextFormField(
                controller: _passwordController,
                focusNode: _passwordFocus,
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.next,
                validator: _validatePassword,
                decoration: InputDecoration(
                  labelText: 'Password *',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: const OutlineInputBorder(),
                  helperText: 'Min 8 karakter, 1 huruf kapital, 1 angka',
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                onSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_confirmFocus),
                // Paksa re-validasi konfirmasi saat password berubah
                onChanged: (_) {
                  if (_confirmController.text.isNotEmpty) {
                    _formKey.currentState?.validate();
                  }
                },
              ),
              const SizedBox(height: 16),

              // -- Konfirmasi Password --
              TextFormField(
                controller: _confirmController,
                focusNode: _confirmFocus,
                obscureText: _obscureConfirm,
                textInputAction: TextInputAction.done,
                validator: _validateConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Konfirmasi Password *',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureConfirm
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                    onPressed: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                ),
                onSubmitted: (_) => _submitForm(),
              ),

              const SizedBox(height: 32),

              // -- Tombol Submit --
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isSubmitting
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 12),
                            Text('Mendaftarkan...'),
                          ],
                        )
                      : const Text(
                          'Daftar Sekarang',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ),

              const SizedBox(height: 16),

              // -- Tombol Reset --
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    _formKey.currentState!.reset();
                    _nameController.clear();
                    _emailController.clear();
                    _phoneController.clear();
                    _passwordController.clear();
                    _confirmController.clear();
                    setState(() {
                      _autovalidateMode = AutovalidateMode.disabled;
                    });
                  },
                  child: const Text('Reset Form'),
                ),
              ),

              const SizedBox(height: 30),

              // Info Box
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('🔑 Ringkasan Form & Validasi:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('• Form()  →  container yang mengelompokkan field'),
                    Text('• GlobalKey<FormState>  →  mengakses validate/save/reset'),
                    Text('• TextFormField  →  TextField dengan dukungan Form'),
                    Text('• validator  →  return null jika valid, String jika error'),
                    Text('• autovalidateMode  →  kapan validasi otomatis berjalan'),
                    Text('• _formKey.currentState!.validate()  →  trigger semua validator'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

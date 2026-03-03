// =====================================================
// PERTEMUAN 5 - DEMO 02: Form Widget & Validasi
// =====================================================
// File: 02_form_validation_demo.dart
//
// CARA PAKAI:
// 1. Buat Flutter project baru: flutter create demo_app
// 2. Replace isi lib/main.dart dengan code ini
// 3. Run: flutter run
//
// TOPIK:
// - Form widget
// - GlobalKey<FormState>
// - validator function
// - autovalidateMode
// - validate(), save(), reset()
// =====================================================

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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const FormValidationPage(),
    );
  }
}

class FormValidationPage extends StatefulWidget {
  const FormValidationPage({super.key});

  @override
  State<FormValidationPage> createState() => _FormValidationPageState();
}

class _FormValidationPageState extends State<FormValidationPage> {
  // Step 1: GlobalKey — "remote control" untuk Form
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  // Saved values
  Map<String, String> _savedData = {};

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // ==========================================
  // SUBMIT: Validate + Save
  // ==========================================
  void _submitForm() {
    // validate() panggil SEMUA validator sekaligus
    if (_formKey.currentState!.validate()) {
      // Semua valid!
      setState(() {
        _savedData = {
          'Nama': _nameController.text,
          'Email': _emailController.text,
          'Phone': _phoneController.text,
          'Password': '***${_passwordController.text.substring(
            _passwordController.text.length > 3
                ? _passwordController.text.length - 3
                : 0,
          )}',
        };
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ Registrasi berhasil: ${_nameController.text}'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('❌ Ada field yang belum valid!'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _phoneController.clear();
    setState(() => _savedData = {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('✅ Form Validation Demo'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Info Card
            Card(
              color: Colors.green.shade50,
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.green),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Coba submit tanpa isi apa-apa untuk lihat validasi. '
                        'Lalu isi satu per satu dan perhatikan error hilang!',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ==========================================
            // FORM WIDGET — membungkus semua fields
            // ==========================================
            Form(
              key: _formKey,
              // autovalidateMode: validasi real-time setelah user interact
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                      // validator return String = ERROR MESSAGE
                      // validator return null = VALID
                      if (value == null || value.trim().isEmpty) {
                        return 'Nama wajib diisi';
                      }
                      if (value.trim().length < 3) {
                        return 'Nama minimal 3 karakter';
                      }
                      if (value.trim().length > 50) {
                        return 'Nama maksimal 50 karakter';
                      }
                      return null; // Valid!
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
                      // Regex untuk validasi email
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

                  // === PHONE ===
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'No. Telepon *',
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                      hintText: '08xxxxxxxxxx',
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'No. telepon wajib diisi';
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value.trim())) {
                        return 'Hanya angka yang diperbolehkan';
                      }
                      if (value.trim().length < 10) {
                        return 'Minimal 10 digit';
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
                          setState(
                            () => _obscurePassword = !_obscurePassword,
                          );
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
                        return 'Harus ada minimal 1 huruf besar';
                      }
                      if (!value.contains(RegExp(r'[0-9]'))) {
                        return 'Harus ada minimal 1 angka';
                      }
                      if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                        return 'Harus ada minimal 1 karakter spesial';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // === CONFIRM PASSWORD ===
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Konfirmasi Password *',
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirm
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(
                            () => _obscureConfirm = !_obscureConfirm,
                          );
                        },
                      ),
                    ),
                    obscureText: _obscureConfirm,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Konfirmasi password wajib diisi';
                      }
                      // Cross-field validation!
                      if (value != _passwordController.text) {
                        return 'Password tidak cocok!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // === BUTTONS ===
                  ElevatedButton.icon(
                    onPressed: _submitForm,
                    icon: const Icon(Icons.check),
                    label: const Text('SUBMIT'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: _resetForm,
                    icon: const Icon(Icons.refresh),
                    label: const Text('RESET'),
                  ),
                ],
              ),
            ),

            // === SAVED DATA ===
            if (_savedData.isNotEmpty) ...[
              const SizedBox(height: 24),
              Card(
                color: Colors.green.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '✅ Data Tersimpan:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Divider(),
                      ..._savedData.entries.map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 80,
                                child: Text(
                                  '${e.key}:',
                                  style: const TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                              Expanded(child: Text(e.value)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

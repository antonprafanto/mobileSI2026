// =====================================================
// PERTEMUAN 5 - DEMO 01: TextField & TextEditingController Basics
// =====================================================
// File: 01_textfield_basic_demo.dart
//
// CARA PAKAI:
// 1. Buat Flutter project baru: flutter create demo_app
// 2. Replace isi lib/main.dart dengan code ini
// 3. Run: flutter run
//
// TOPIK:
// - TextField dasar
// - TextEditingController
// - InputDecoration
// - obscureText (password)
// - keyboardType
// - onChanged callback
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
      title: 'TextField Basic Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const TextFieldBasicPage(),
    );
  }
}

class TextFieldBasicPage extends StatefulWidget {
  const TextFieldBasicPage({super.key});

  @override
  State<TextFieldBasicPage> createState() => _TextFieldBasicPageState();
}

class _TextFieldBasicPageState extends State<TextFieldBasicPage> {
  // ==========================================
  // CONTROLLERS - untuk mengelola isi TextField
  // ==========================================
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _bioController = TextEditingController();

  bool _obscurePassword = true;
  String _livePreview = '';
  int _charCount = 0;

  // PENTING: Selalu dispose controller!
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📝 TextField Basic Demo'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === SECTION 1: TextField Dasar ===
            _buildSectionHeader('1️⃣ TextField Dasar'),
            const Text(
              'TextField paling sederhana dengan InputDecoration',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                hintText: 'Masukkan nama lengkap kamu',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                helperText: 'Nama akan ditampilkan di profil',
              ),
              textCapitalization: TextCapitalization.words,
              onChanged: (value) {
                setState(() {
                  _livePreview = value.isNotEmpty
                      ? 'Hello, $value! 👋'
                      : '';
                });
              },
            ),

            // Live preview
            if (_livePreview.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.preview, color: Colors.blue),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _livePreview,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),

            // === SECTION 2: Email dengan keyboardType ===
            _buildSectionHeader('2️⃣ Email (keyboardType)'),
            const Text(
              'Keyboard berubah sesuai tipe input',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),

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
            const SizedBox(height: 24),

            // === SECTION 3: Password dengan toggle ===
            _buildSectionHeader('3️⃣ Password (obscureText + toggle)'),
            const Text(
              'Toggle visibility dengan suffixIcon',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Minimal 8 karakter',
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

            // === SECTION 4: Multiline TextField ===
            _buildSectionHeader('4️⃣ Multiline (Bio)'),
            const Text(
              'maxLines dan maxLength untuk textarea',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: _bioController,
              decoration: const InputDecoration(
                labelText: 'Bio',
                hintText: 'Ceritakan tentang dirimu...',
                prefixIcon: Icon(Icons.info_outline),
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 4,
              maxLength: 200,
              keyboardType: TextInputType.multiline,
              onChanged: (value) {
                setState(() {
                  _charCount = value.length;
                });
              },
            ),
            const SizedBox(height: 24),

            // === RINGKASAN ===
            _buildSectionHeader('📊 Ringkasan Input'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('👤 Nama', _nameController.text),
                    _buildInfoRow('📧 Email', _emailController.text),
                    _buildInfoRow(
                      '🔒 Password',
                      _passwordController.text.isNotEmpty
                          ? '***${_passwordController.text.substring(
                              _passwordController.text.length > 3
                                  ? _passwordController.text.length - 3
                                  : 0,
                            )}'
                          : '-',
                    ),
                    _buildInfoRow(
                      '📝 Bio',
                      _bioController.text.isNotEmpty
                          ? '${_bioController.text.substring(0, _bioController.text.length > 50 ? 50 : _bioController.text.length)}...'
                          : '-',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Tombol
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {}); // Refresh summary
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Data di-refresh!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Refresh'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _nameController.clear();
                      _emailController.clear();
                      _passwordController.clear();
                      _bioController.clear();
                      setState(() {
                        _livePreview = '';
                        _charCount = 0;
                      });
                    },
                    icon: const Icon(Icons.clear_all),
                    label: const Text('Clear All'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? '-' : value,
              style: TextStyle(color: value.isEmpty ? Colors.grey : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

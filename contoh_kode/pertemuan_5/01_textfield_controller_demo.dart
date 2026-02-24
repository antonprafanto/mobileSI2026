// DEMO 01: TextField & TextEditingController
//
// Topik yang dibahas:
// - TextField vs TextFormField
// - TextEditingController (baca, tulis, clear, listen)
// - InputDecoration: label, hint, prefix/suffix, border
// - Properti keyboard: keyboardType, textInputAction, obscureText
// - FocusNode: pindah fokus antar field dengan Tab/Enter

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TextField Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
      home: const TextFieldDemoPage(),
    );
  }
}

// =============================================================
// DEMO 1: Dasar TextField & Controller
// =============================================================
class TextFieldDemoPage extends StatefulWidget {
  const TextFieldDemoPage({super.key});

  @override
  State<TextFieldDemoPage> createState() => _TextFieldDemoPageState();
}

class _TextFieldDemoPageState extends State<TextFieldDemoPage> {
  // ① TextEditingController untuk membaca/menulis nilai
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  // ② FocusNode untuk mengontrol fokus keyboard
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _bioFocus = FocusNode();

  bool _obscurePassword = true;
  String _liveValue = ''; // Untuk demo onChanged

  @override
  void initState() {
    super.initState();
    // ③ Mendengarkan perubahan via addListener
    _nameController.addListener(() {
      // Ini dipanggil setiap kali teks berubah
      setState(() => _liveValue = _nameController.text);
    });
  }

  @override
  void dispose() {
    // ④ WAJIB dispose untuk mencegah memory leak!
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _bioFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo 01: TextField & Controller'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SECTION 1: Input Teks Dasar ---
            _sectionTitle('1. Input Teks Dasar'),

            // Nama — FocusNode + TextInputAction.next
            TextField(
              controller: _nameController,
              focusNode: _nameFocus,
              textInputAction: TextInputAction.next, // Tombol "Next" di keyboard
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap *',
                hintText: 'Contoh: Budi Santoso',
                prefixIcon: Icon(Icons.person),
                helperText: 'Nama sesuai KTP',
              ),
              onSubmitted: (_) {
                // ⑤ Pindah fokus ke field berikutnya
                FocusScope.of(context).requestFocus(_emailFocus);
              },
            ),
            const SizedBox(height: 8),
            // Tampilan live value dari addListener
            if (_liveValue.isNotEmpty)
              Text('💬 Live: $_liveValue',
                  style: TextStyle(color: Colors.blue.shade700, fontSize: 13)),

            const SizedBox(height: 16),

            // Email
            TextField(
              controller: _emailController,
              focusNode: _emailFocus,
              keyboardType: TextInputType.emailAddress, // Keyboard email
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Email *',
                hintText: 'contoh@email.com',
                prefixIcon: Icon(Icons.email),
              ),
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(_passwordFocus);
              },
            ),

            const SizedBox(height: 16),

            // Password — obscureText
            TextField(
              controller: _passwordController,
              focusNode: _passwordFocus,
              obscureText: _obscurePassword, // ⑥ Sembunyikan teks
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Password *',
                prefixIcon: const Icon(Icons.lock),
                // suffixIcon untuk toggle tampil/sembunyikan
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
              ),
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(_bioFocus);
              },
            ),

            const SizedBox(height: 16),

            // Bio — multiline
            TextField(
              controller: _bioController,
              focusNode: _bioFocus,
              maxLines: 4,      // ⑦ Multi-baris
              maxLength: 200,   // Batas karakter
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Bio (opsional)',
                hintText: 'Ceritakan sedikit tentang diri Anda...',
                alignLabelWithHint: true, // Label rata atas untuk multiline
              ),
              onSubmitted: (_) => _bioFocus.unfocus(), // Tutup keyboard
            ),

            const SizedBox(height: 24),

            // --- SECTION 2: Aksi Controller ---
            _sectionTitle('2. Aksi Pada Controller'),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // ⑧ Baca nilai controller
                    _showSnackBar(context, 'Nama: ${_nameController.text}');
                  },
                  icon: const Icon(Icons.read_more),
                  label: const Text('Baca Nama'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    // ⑨ Set nilai programatik
                    _nameController.text = 'Contoh Nama';
                    _emailController.text = 'contoh@email.com';
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Isi Contoh'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    // ⑩ Clear semua field
                    _nameController.clear();
                    _emailController.clear();
                    _passwordController.clear();
                    _bioController.clear();
                  },
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Bersihkan'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    // ⑪ Tutup keyboard
                    FocusScope.of(context).unfocus();
                  },
                  icon: const Icon(Icons.keyboard_hide),
                  label: const Text('Tutup Keyboard'),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // --- SECTION 3: InputDecoration Variants ---
            _sectionTitle('3. Variasi InputDecoration'),

            // Filled style
            TextField(
              decoration: InputDecoration(
                labelText: 'Filled Style',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Underline style
            const TextField(
              decoration: InputDecoration(
                labelText: 'Underline Style',
                border: UnderlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            // Rounded style
            TextField(
              decoration: InputDecoration(
                hintText: 'Rounded Style',
                prefixIcon: const Icon(Icons.chat),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _showSnackBar(context, 'Terkirim!'),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // --- INFO BOX ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('💡 Poin Penting:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('1. Selalu dispose() controller & focusNode di dispose()'),
                  Text('2. Gunakan TextInputAction untuk UX keyboard yang baik'),
                  Text('3. addListener() untuk reaksi real-time'),
                  Text('4. FocusScope.of(context).unfocus() untuk tutup keyboard'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }
}

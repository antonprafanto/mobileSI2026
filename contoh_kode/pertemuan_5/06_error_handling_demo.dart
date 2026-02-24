// DEMO 06: Error Handling & Debugging
//
// Topik yang dibahas:
// - try-catch-finally: menangani exception
// - Jenis exception: FormatException, RangeError, TypeError, custom
// - Menangkap exception spesifik vs catch-all
// - rethrow: melempar ulang exception
// - Membuat custom exception class
// - Cara menampilkan error: SnackBar, Dialog, inline widget
// - Pola aman: mounted check setelah async
// - assert() untuk debugging di dev mode
// - debugPrint() vs print()

import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Error Handling Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const ErrorHandlingPage(),
    );
  }
}

// ============================================================
// CUSTOM EXCEPTION — membuat exception sendiri
// ============================================================
class ValidationException implements Exception {
  final String message;
  final String field;

  const ValidationException({required this.message, required this.field});

  @override
  String toString() => 'ValidationException pada "$field": $message';
}

class NetworkException implements Exception {
  final int statusCode;
  final String message;

  const NetworkException({required this.statusCode, required this.message});

  @override
  String toString() => 'NetworkException [$statusCode]: $message';
}

// ============================================================
// HALAMAN UTAMA
// ============================================================
class ErrorHandlingPage extends StatefulWidget {
  const ErrorHandlingPage({super.key});

  @override
  State<ErrorHandlingPage> createState() => _ErrorHandlingPageState();
}

class _ErrorHandlingPageState extends State<ErrorHandlingPage> {
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _result = '';
  String? _errorMessage;
  bool _isLoading = false;

  @override
  void dispose() {
    _numberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // ============================================================
  // DEMO 1: FormatException — parse angka dari teks
  // ============================================================
  void _parseNumber() {
    setState(() {
      _result = '';
      _errorMessage = null;
    });

    try {
      // int.parse() melempar FormatException jika bukan angka valid
      final number = int.parse(_numberController.text);

      if (number < 0) {
        // RangeError untuk nilai di luar rentang
        throw RangeError('Angka harus positif! Nilai: $number');
      }

      if (number > 1000) {
        // Custom exception
        throw ValidationException(
          message: 'Angka maksimal 1000',
          field: 'number_input',
        );
      }

      setState(() => _result = '✅ Angka valid: $number\nDua kali lipat: ${number * 2}');

    } on FormatException {
      // Tangkap tipe error spesifik
      setState(() => _errorMessage = '❌ "${_numberController.text}" bukan angka valid!\nMasukkan bilangan bulat.');
    } on RangeError catch (e) {
      setState(() => _errorMessage = '❌ ${e.message}');
    } on ValidationException catch (e) {
      setState(() => _errorMessage = '❌ ${e.message}');
    } catch (e, stackTrace) {
      // Catch-all untuk error yang tidak terduga
      debugPrint('Error tidak terduga: $e');
      debugPrint('Stack trace: $stackTrace');
      setState(() => _errorMessage = '❌ Error tidak terduga: $e');
    }
  }

  // ============================================================
  // DEMO 2: Validasi custom dengan exception
  // ============================================================
  void _validateEmail() {
    setState(() {
      _result = '';
      _errorMessage = null;
    });

    try {
      _validateEmailWithException(_emailController.text);
      setState(() => _result = '✅ Email valid: ${_emailController.text}');
    } on ValidationException catch (e) {
      setState(() => _errorMessage = '❌ ${e.message}');
    }
  }

  void _validateEmailWithException(String email) {
    if (email.trim().isEmpty) {
      throw const ValidationException(
        message: 'Email tidak boleh kosong',
        field: 'email',
      );
    }

    if (!email.contains('@')) {
      throw const ValidationException(
        message: 'Email harus mengandung karakter @',
        field: 'email',
      );
    }

    final parts = email.split('@');
    if (parts.length != 2 || parts[1].isEmpty || !parts[1].contains('.')) {
      throw const ValidationException(
        message: 'Domain email tidak valid',
        field: 'email',
      );
    }
    // Email valid — tidak throw apa-apa
  }

  // ============================================================
  // DEMO 3: Async dengan try-catch dan mounted check
  // ============================================================
  Future<void> _simulateApiCall() async {
    setState(() {
      _isLoading = true;
      _result = '';
      _errorMessage = null;
    });

    try {
      // Simulasi delay network
      await Future.delayed(const Duration(seconds: 2));

      // Simulasi: 30% kemungkinan gagal
      if (DateTime.now().millisecond % 10 < 3) {
        throw const NetworkException(
          statusCode: 503,
          message: 'Server sedang tidak tersedia',
        );
      }

      // ⚠️ Selalu cek mounted setelah await!
      if (!mounted) return;

      setState(() {
        _result = '✅ Data berhasil dimuat!\n'
            'User: John Doe\n'
            'Email: john@example.com\n'
            'Points: 1250';
      });
    } on NetworkException catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = '❌ ${e.message} (Code: ${e.statusCode})\nCoba lagi beberapa saat.';
      });
    } on TimeoutException {
      if (!mounted) return;
      setState(() {
        _errorMessage = '❌ Koneksi timeout. Periksa jaringan Anda.';
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _errorMessage = '❌ Error: $e');
    } finally {
      // finally SELALU dijalankan, meski error
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // ============================================================
  // DEMO 4: Cara menampilkan error ke pengguna
  // ============================================================
  void _showSnackBarError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.error_outline, color: Colors.white),
            SizedBox(width: 8),
            Text('Terjadi kesalahan!'),
          ],
        ),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        action: SnackBarAction(
          label: 'Coba Lagi',
          textColor: Colors.white,
          onPressed: () {/* retry */},
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _showAlertDialogError() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 48),
        title: const Text('Operasi Gagal'),
        content: const Text(
          'Tidak dapat menyimpan data. Pastikan koneksi internet aktif dan coba lagi.',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _simulateApiCall(); // Retry
            },
            child: const Text('Coba Lagi'),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DEMO 5: debugPrint & assert
  // ============================================================
  void _demoDebugTools() {
    // print() — output standar
    print('🖨️  Biasa print: Hello!');

    // debugPrint() — lebih aman, throttle output panjang
    debugPrint('🐛 debugPrint: Ini pesan debug yang lebih panjang dan aman');

    // dev.log() — dengan zone, timestamp, name
    dev.log('Log dengan dev.log()', name: 'MyApp', level: 800);

    // assert() — hanya aktif di debug mode, diabaikan di release
    assert(() {
      debugPrint('✅ assert: kode ini hanya berjalan di debug mode!');
      return true; // assert perlu return bool
    }());

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Buka Debug Console untuk melihat output!'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo 06: Error Handling & Debugging'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ========================================
            // SECTION 1: FormatException & RangeError
            // ========================================
            _sectionTitle('1. try-catch: FormatException & Custom Exception'),
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Masukkan angka (0-1000)',
                border: OutlineInputBorder(),
                hintText: 'Coba: "abc", "-5", "2000", "42"',
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _parseNumber,
                child: const Text('Parse Angka'),
              ),
            ),

            if (_result.isNotEmpty)
              _resultBox(_result, isSuccess: true),
            if (_errorMessage != null)
              _resultBox(_errorMessage!, isSuccess: false),

            const SizedBox(height: 20),

            // ========================================
            // SECTION 2: Custom Exception
            // ========================================
            _sectionTitle('2. Custom ValidationException'),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Masukkan email',
                border: OutlineInputBorder(),
                hintText: 'Coba email tidak valid',
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _validateEmail,
                child: const Text('Validasi Email'),
              ),
            ),

            const SizedBox(height: 20),

            // ========================================
            // SECTION 3: Async + mounted check
            // ========================================
            _sectionTitle('3. Async try-catch + mounted Check'),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _simulateApiCall,
                icon: _isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.cloud_download),
                label: Text(_isLoading ? 'Memuat...' : 'Simulasi API Call (30% chance error)'),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '💡 Klik beberapa kali — ada kemungkinan 30% gagal!',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),

            if (_result.isNotEmpty)
              _resultBox(_result, isSuccess: true),
            if (_errorMessage != null)
              _resultBox(_errorMessage!, isSuccess: false),

            const SizedBox(height: 20),

            // ========================================
            // SECTION 4: Cara tampilkan error
            // ========================================
            _sectionTitle('4. Cara Menampilkan Error ke Pengguna'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: _showSnackBarError,
                  icon: const Icon(Icons.notifications),
                  label: const Text('SnackBar Error'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade100),
                ),
                ElevatedButton.icon(
                  onPressed: _showAlertDialogError,
                  icon: const Icon(Icons.warning),
                  label: const Text('AlertDialog Error'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade100),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ========================================
            // SECTION 5: Debug tools
            // ========================================
            _sectionTitle('5. Debug Tools'),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _demoDebugTools,
                icon: const Icon(Icons.bug_report),
                label: const Text('Jalankan Debug Tools (lihat console)'),
              ),
            ),

            const SizedBox(height: 24),

            // Info card — pattern try-catch
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.deepOrange.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.deepOrange.shade200),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('🔥 Pola try-catch di Flutter:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('• try { } — kode yang mungkin gagal'),
                  Text('• on XxxException catch (e) { } — tangkap tipe spesifik'),
                  Text('• catch (e, stack) { } — catch-all'),
                  Text('• finally { } — selalu dieksekusi'),
                  Text('• Selalu cek mounted setelah await!'),
                  Text('• Gunakan debugPrint() bukan print() untuk log'),
                  Text('• assert() hanya aktif di debug mode'),
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
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.deepOrange,
        ),
      ),
    );
  }

  Widget _resultBox(String message, {required bool isSuccess}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: isSuccess ? Colors.green.shade50 : Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSuccess ? Colors.green.shade200 : Colors.red.shade200,
        ),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: isSuccess ? Colors.green.shade800 : Colors.red.shade800,
          fontSize: 13,
        ),
      ),
    );
  }
}

// =====================================================
// PERTEMUAN 5 - DEMO 06: FocusNode & Error Handling
// =====================================================
// File: 06_focus_error_handling_demo.dart
//
// CARA PAKAI:
// 1. Buat Flutter project baru: flutter create demo_app
// 2. Replace isi lib/main.dart dengan code ini
// 3. Run: flutter run
//
// TOPIK:
// - FocusNode (pindah focus antar field)
// - textInputAction (next, done, search)
// - try-catch-finally
// - int.tryParse vs int.parse
// - Custom exceptions
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
      title: 'Focus & Error Handling Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const FocusErrorPage(),
    );
  }
}

class FocusErrorPage extends StatefulWidget {
  const FocusErrorPage({super.key});

  @override
  State<FocusErrorPage> createState() => _FocusErrorPageState();
}

class _FocusErrorPageState extends State<FocusErrorPage> {
  // ==========================================
  // FOCUS NODES — untuk kontrol focus
  // ==========================================
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _ageFocus = FocusNode();
  final _scoreFocus = FocusNode();

  // Controllers
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  final _scoreCtrl = TextEditingController();

  // Results
  String _ageResult = '';
  String _scoreResult = '';
  String _activeField = 'Tidak ada';
  List<String> _logs = [];

  @override
  void initState() {
    super.initState();
    // Listen focus changes
    _nameFocus.addListener(() {
      if (_nameFocus.hasFocus) setState(() => _activeField = 'Nama');
    });
    _emailFocus.addListener(() {
      if (_emailFocus.hasFocus) setState(() => _activeField = 'Email');
    });
    _ageFocus.addListener(() {
      if (_ageFocus.hasFocus) setState(() => _activeField = 'Umur');
    });
    _scoreFocus.addListener(() {
      if (_scoreFocus.hasFocus) setState(() => _activeField = 'Skor');
    });
  }

  // PENTING: Dispose semua FocusNode dan Controller!
  @override
  void dispose() {
    _nameFocus.dispose();
    _emailFocus.dispose();
    _ageFocus.dispose();
    _scoreFocus.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _ageCtrl.dispose();
    _scoreCtrl.dispose();
    super.dispose();
  }

  void _addLog(String msg) {
    setState(() {
      _logs.insert(0, '${TimeOfDay.now().format(context)}: $msg');
      if (_logs.length > 10) _logs.removeLast();
    });
  }

  // ==========================================
  // TRY-CATCH: Parse umur
  // ==========================================
  void _processAge() {
    final text = _ageCtrl.text.trim();
    _addLog('Processing age: "$text"');

    try {
      // int.parse BISA throw FormatException!
      int age = int.parse(text);

      if (age < 0) {
        throw const FormatException('Umur tidak boleh negatif');
      }
      if (age > 150) {
        throw const FormatException('Umur tidak realistis');
      }

      setState(() => _ageResult = '✅ Umur valid: $age tahun');
      _addLog('Age parsed successfully: $age');
    } on FormatException catch (e) {
      setState(() => _ageResult = '❌ Error: ${e.message}');
      _addLog('FormatException: ${e.message}');
    } catch (e) {
      setState(() => _ageResult = '❌ Unexpected: $e');
      _addLog('Unexpected error: $e');
    } finally {
      _addLog('Age processing complete');
    }
  }

  // ==========================================
  // TRY-PARSE: Safe parsing (tidak throw)
  // ==========================================
  void _processScore() {
    final text = _scoreCtrl.text.trim();
    _addLog('Processing score: "$text"');

    // int.tryParse return null jika gagal (TIDAK throw!)
    final score = double.tryParse(text);

    if (score == null) {
      setState(() => _scoreResult = '❌ "$text" bukan angka valid');
      _addLog('tryParse failed: null');
      return;
    }

    try {
      if (score < 0 || score > 100) {
        throw RangeError('Skor harus antara 0-100');
      }

      String grade;
      if (score >= 85) {
        grade = 'A';
      } else if (score >= 70) {
        grade = 'B';
      } else if (score >= 55) {
        grade = 'C';
      } else if (score >= 40) {
        grade = 'D';
      } else {
        grade = 'E';
      }

      setState(() => _scoreResult = '✅ Skor: ${score.toStringAsFixed(1)} → Grade: $grade');
      _addLog('Score result: $grade');
    } on RangeError catch (e) {
      setState(() => _scoreResult = '❌ ${e.message}');
      _addLog('RangeError: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🔍 Focus & Error Handling'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // SECTION 1: FOCUS MANAGEMENT
            // ==========================================
            const Text('1️⃣ FocusNode Demo',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text('Tekan Next di keyboard untuk pindah field',
                style: TextStyle(color: Colors.grey)),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.center_focus_strong, color: Colors.teal),
                  const SizedBox(width: 8),
                  Text('Active field: $_activeField',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: _nameCtrl,
              focusNode: _nameFocus,
              textInputAction: TextInputAction.next, // Tampilkan tombol "Next"
              onSubmitted: (_) {
                // Pindah focus ke email
                FocusScope.of(context).requestFocus(_emailFocus);
                _addLog('Focus: Nama → Email');
              },
              decoration: const InputDecoration(
                labelText: 'Nama',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                helperText: 'textInputAction: next → pindah ke Email',
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _emailCtrl,
              focusNode: _emailFocus,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(_ageFocus);
                _addLog('Focus: Email → Umur');
              },
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
                helperText: 'textInputAction: next → pindah ke Umur',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),

            // Manual focus buttons
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () => _nameFocus.requestFocus(),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Focus Nama'),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () => FocusScope.of(context).unfocus(),
                  icon: const Icon(Icons.keyboard_hide),
                  label: const Text('Tutup Keyboard'),
                ),
              ],
            ),
            const Divider(height: 32),

            // ==========================================
            // SECTION 2: TRY-CATCH
            // ==========================================
            const Text('2️⃣ try-catch Demo',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text('Coba input teks / angka negatif / angka normal',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),

            TextField(
              controller: _ageCtrl,
              focusNode: _ageFocus,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Umur (int.parse)',
                prefixIcon: Icon(Icons.cake),
                border: OutlineInputBorder(),
                helperText: 'Coba: "abc", "-5", "200", "25"',
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _processAge(),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(onPressed: _processAge, child: const Text('Parse Umur')),
                const SizedBox(width: 12),
                Expanded(child: Text(_ageResult, style: const TextStyle(fontSize: 14))),
              ],
            ),
            const SizedBox(height: 16),

            // ==========================================
            // SECTION 3: TRY-PARSE (safe)
            // ==========================================
            const Text('3️⃣ tryParse Demo (Safe)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text('tryParse return null instead of throwing',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),

            TextField(
              controller: _scoreCtrl,
              focusNode: _scoreFocus,
              decoration: const InputDecoration(
                labelText: 'Skor (0-100)',
                prefixIcon: Icon(Icons.score),
                border: OutlineInputBorder(),
                helperText: 'Coba: "abc", "105", "85.5"',
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _processScore(),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(onPressed: _processScore, child: const Text('Hitung Grade')),
                const SizedBox(width: 12),
                Expanded(child: Text(_scoreResult, style: const TextStyle(fontSize: 14))),
              ],
            ),
            const Divider(height: 32),

            // ==========================================
            // LOGS
            // ==========================================
            const Text('📋 Activity Log',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Container(
              height: 200,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                itemCount: _logs.length,
                itemBuilder: (_, i) => Text(
                  _logs[i],
                  style: TextStyle(
                    color: _logs[i].contains('Error') || _logs[i].contains('failed')
                        ? Colors.red.shade300
                        : Colors.green.shade300,
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

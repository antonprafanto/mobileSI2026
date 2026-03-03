// =====================================================
// PERTEMUAN 5 - DEMO 07: DevTools & Debugging Practice
// =====================================================
// File: 07_devtools_debug_demo.dart
//
// CARA PAKAI:
// 1. Buat Flutter project baru: flutter create demo_app
// 2. Replace isi lib/main.dart dengan code ini
// 3. Run: flutter run
// 4. Buka DevTools (tekan 'd' di terminal)
//
// TOPIK:
// - Debug print statements
// - Performance tracking (rebuild counters)
// - Widget inspector exploration
// - Common form bugs untuk latihan debugging
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
      title: 'DevTools Debug Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const DebugDemoPage(),
    );
  }
}

class DebugDemoPage extends StatefulWidget {
  const DebugDemoPage({super.key});

  @override
  State<DebugDemoPage> createState() => _DebugDemoPageState();
}

class _DebugDemoPageState extends State<DebugDemoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();

  int _buildCount = 0;
  String _debugOutput = '';
  List<String> _debugLogs = [];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _ageCtrl.dispose();
    super.dispose();
  }

  void _log(String message) {
    final timestamp = DateTime.now().toString().substring(11, 19);
    setState(() {
      _debugLogs.insert(0, '[$timestamp] $message');
      if (_debugLogs.length > 20) _debugLogs.removeLast();
    });
    // Ini juga muncul di Debug Console!
    debugPrint('🐛 $message');
  }

  @override
  Widget build(BuildContext context) {
    _buildCount++;
    // Track rebuilds — buka Debug Console untuk lihat
    debugPrint('🔄 Build #$_buildCount');

    return Scaffold(
      appBar: AppBar(
        title: const Text('🐛 Debug & DevTools Demo'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          // Rebuild counter
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Colors.red.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Builds: $_buildCount',
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // INFO CARD
            // ==========================================
            Card(
              color: Colors.amber.shade50,
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('💡 Petunjuk Debugging', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('1. Buka Debug Console untuk lihat print statements'),
                    Text('2. Perhatikan "Builds" counter di AppBar'),
                    Text('3. Setiap setState = 1 rebuild'),
                    Text('4. Coba buka DevTools (tekan d di terminal)'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ==========================================
            // FORM DENGAN DEBUG PRINTS
            // ==========================================
            const Text('🔍 Form dengan Debug Logging',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Nama',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    onChanged: (value) {
                      _log('Nama changed: "$value" (${value.length} chars)');
                    },
                    validator: (value) {
                      _log('Validating nama: "$value"');
                      if (value == null || value.isEmpty) {
                        _log('❌ Nama validation FAILED: empty');
                        return 'Nama wajib diisi';
                      }
                      _log('✅ Nama validation PASSED');
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  TextFormField(
                    controller: _ageCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Umur',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.cake),
                      helperText: 'Coba input: "abc", "-5", "25"',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      _log('Age changed: "$value"');
                    },
                    validator: (value) {
                      _log('Validating age: "$value"');
                      if (value == null || value.isEmpty) {
                        _log('❌ Age FAILED: empty');
                        return 'Umur wajib diisi';
                      }
                      final age = int.tryParse(value);
                      if (age == null) {
                        _log('❌ Age FAILED: not a number');
                        return 'Harus berupa angka';
                      }
                      if (age < 1 || age > 150) {
                        _log('❌ Age FAILED: out of range ($age)');
                        return 'Umur harus 1-150';
                      }
                      _log('✅ Age validation PASSED: $age');
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _log('--- SUBMIT PRESSED ---');
                            final isValid = _formKey.currentState!.validate();
                            _log('Form valid: $isValid');
                            if (isValid) {
                              setState(() {
                                _debugOutput = 'Name: ${_nameCtrl.text}, Age: ${_ageCtrl.text}';
                              });
                              _log('✅ Form submitted successfully');
                            }
                          },
                          icon: const Icon(Icons.check),
                          label: const Text('Submit'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            _log('--- RESET PRESSED ---');
                            _formKey.currentState!.reset();
                            _nameCtrl.clear();
                            _ageCtrl.clear();
                            setState(() => _debugOutput = '');
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reset'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            if (_debugOutput.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green),
                ),
                child: Text('✅ Output: $_debugOutput'),
              ),
            ],
            const Divider(height: 32),

            // ==========================================
            // REBUILD COUNTER DEMO
            // ==========================================
            const Text('🔄 Rebuild Counter Demo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text(
              'Setiap tombol di bawah akan trigger setState.\n'
              'Perhatikan counter "Builds" di AppBar naik!',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                    _log('Unnecessary setState() called!');
                  },
                  child: const Text('setState() kosong'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _log('No setState = NO rebuild');
                    // Perhatikan: counter TIDAK naik!
                  },
                  child: const Text('Tanpa setState'),
                ),
              ],
            ),
            const Divider(height: 32),

            // ==========================================
            // DEBUG LOG VIEWER
            // ==========================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('📋 Debug Log',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () => setState(() => _debugLogs.clear()),
                  child: const Text('Clear'),
                ),
              ],
            ),
            Container(
              height: 250,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _debugLogs.isEmpty
                  ? const Center(
                      child: Text(
                        'Belum ada log...\nInteract dengan form untuk mulai!',
                        style: TextStyle(color: Colors.grey, fontFamily: 'monospace'),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: _debugLogs.length,
                      itemBuilder: (_, i) {
                        final log = _debugLogs[i];
                        Color color = Colors.white70;
                        if (log.contains('❌')) color = Colors.red.shade300;
                        if (log.contains('✅')) color = Colors.green.shade300;
                        if (log.contains('---')) color = Colors.yellow.shade300;
                        if (log.contains('changed')) color = Colors.cyan.shade300;

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: Text(
                            log,
                            style: TextStyle(
                              color: color,
                              fontFamily: 'monospace',
                              fontSize: 11,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

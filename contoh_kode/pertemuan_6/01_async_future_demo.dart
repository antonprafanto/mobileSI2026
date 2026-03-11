// 01_async_future_demo.dart
// Pertemuan 6 — Demo 1: async, await, Future & Stream basics
// Dependency: TIDAK ADA (pure Dart/Flutter)
//
// CARA PAKAI:
// 1. flutter create demo_app && cd demo_app
// 2. Copy-paste file ini ke lib/main.dart
// 3. flutter run

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AsyncFutureDemoPage(),
    ));

class AsyncFutureDemoPage extends StatefulWidget {
  const AsyncFutureDemoPage({super.key});

  @override
  State<AsyncFutureDemoPage> createState() => _AsyncFutureDemoPageState();
}

class _AsyncFutureDemoPageState extends State<AsyncFutureDemoPage> {
  final List<String> _logs = [];
  bool _isLoading = false;

  void _addLog(String message) {
    setState(() {
      _logs.add('[${DateTime.now().toString().substring(11, 19)}] $message');
    });
  }

  // ============================================
  // DEMO 1: Future dasar dengan delayed
  // ============================================
  Future<String> _simulateNetworkCall() async {
    _addLog('🌐 Mengirim request...');
    await Future.delayed(const Duration(seconds: 2));
    _addLog('✅ Response diterima!');
    return 'Data dari server';
  }

  Future<void> _runBasicFuture() async {
    setState(() => _isLoading = true);
    _logs.clear();
    _addLog('▶ Mulai basic Future demo');

    try {
      String result = await _simulateNetworkCall();
      _addLog('📦 Hasil: $result');
    } catch (e) {
      _addLog('❌ Error: $e');
    }

    setState(() => _isLoading = false);
    _addLog('🏁 Selesai');
  }

  // ============================================
  // DEMO 2: Future.wait (parallel)
  // ============================================
  Future<String> _fetchPosts() async {
    await Future.delayed(const Duration(seconds: 2));
    return '📝 100 posts loaded';
  }

  Future<String> _fetchUsers() async {
    await Future.delayed(const Duration(seconds: 1));
    return '👤 10 users loaded';
  }

  Future<String> _fetchComments() async {
    await Future.delayed(const Duration(seconds: 3));
    return '💬 500 comments loaded';
  }

  Future<void> _runParallelFuture() async {
    setState(() => _isLoading = true);
    _logs.clear();
    _addLog('▶ Mulai Future.wait (PARALLEL) demo');
    _addLog('⏱️ 3 request dimulai BERSAMAAN...');

    final stopwatch = Stopwatch()..start();

    final results = await Future.wait([
      _fetchPosts(),
      _fetchUsers(),
      _fetchComments(),
    ]);

    stopwatch.stop();
    for (final r in results) {
      _addLog(r);
    }
    _addLog('⏱️ Total waktu: ${stopwatch.elapsed.inSeconds} detik');
    _addLog('💡 Kalau sequential: 2+1+3 = 6 detik!');

    setState(() => _isLoading = false);
    _addLog('🏁 Selesai');
  }

  // ============================================
  // DEMO 3: Error handling async
  // ============================================
  Future<String> _fetchThatFails() async {
    await Future.delayed(const Duration(seconds: 1));
    throw Exception('Server down! 💥');
  }

  Future<void> _runErrorDemo() async {
    setState(() => _isLoading = true);
    _logs.clear();
    _addLog('▶ Mulai error handling demo');

    try {
      _addLog('🌐 Mencoba fetch data...');
      String result = await _fetchThatFails();
      _addLog('📦 Hasil: $result');
    } on FormatException catch (e) {
      _addLog('📄 FormatException: ${e.message}');
    } catch (e) {
      _addLog('❌ Error ditangkap: $e');
      _addLog('💡 App tidak crash berkat try-catch!');
    } finally {
      _addLog('🔄 Finally block selalu dijalankan');
    }

    setState(() => _isLoading = false);
    _addLog('🏁 Selesai');
  }

  // ============================================
  // DEMO 4: Stream basics
  // ============================================
  Stream<int> _countdownStream() async* {
    for (int i = 5; i >= 0; i--) {
      await Future.delayed(const Duration(milliseconds: 800));
      yield i;
    }
  }

  Future<void> _runStreamDemo() async {
    setState(() => _isLoading = true);
    _logs.clear();
    _addLog('▶ Mulai Stream demo');
    _addLog('📡 Stream mengirim data satu per satu...');

    await for (final value in _countdownStream()) {
      _addLog(value == 0 ? '🚀 Liftoff!' : '⏳ Countdown: $value');
    }

    setState(() => _isLoading = false);
    _addLog('🏁 Stream selesai');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('async/await/Future Demo')),
      body: Column(
        children: [
          // Buttons
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                _buildButton('Basic Future', Icons.timer, _runBasicFuture),
                _buildButton('Parallel', Icons.alt_route, _runParallelFuture),
                _buildButton('Error', Icons.error, _runErrorDemo),
                _buildButton('Stream', Icons.stream, _runStreamDemo),
              ],
            ),
          ),
          const Divider(),

          // Loading indicator
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8),
              child: LinearProgressIndicator(),
            ),

          // Log output
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _logs.length,
              itemBuilder: (context, index) {
                return Text(
                  _logs[index],
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: _logs[index].contains('❌')
                        ? Colors.red
                        : _logs[index].contains('✅')
                            ? Colors.green
                            : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label, IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton.icon(
        onPressed: _isLoading ? null : onPressed,
        icon: Icon(icon, size: 18),
        label: Text(label),
      ),
    );
  }
}

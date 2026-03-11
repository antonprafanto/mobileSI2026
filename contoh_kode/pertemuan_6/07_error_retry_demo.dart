// 07_error_retry_demo.dart
// Pertemuan 6 — Demo 7: Error handling patterns, retry logic, loading states
// Dependency: http (flutter pub add http)

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ErrorRetryDemoPage(),
    ));

class ErrorRetryDemoPage extends StatefulWidget {
  const ErrorRetryDemoPage({super.key});

  @override
  State<ErrorRetryDemoPage> createState() => _ErrorRetryDemoPageState();
}

class _ErrorRetryDemoPageState extends State<ErrorRetryDemoPage> {
  String _result = '';
  bool _isLoading = false;
  final List<String> _logs = [];

  void _log(String msg) {
    setState(() {
      _logs.add('[${DateTime.now().toString().substring(11, 19)}] $msg');
    });
  }

  // === Proper error handling with specific exceptions ===
  Future<void> _demoProperErrorHandling() async {
    setState(() {
      _isLoading = true;
      _logs.clear();
      _result = '';
    });

    _log('▶ Demo: Proper Error Handling');

    try {
      _log('🌐 Fetching from valid URL...');
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'))
          .timeout(const Duration(seconds: 10));

      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          _log('✅ 200 OK — Title: ${data['title']}');
          break;
        case 404:
          _log('❓ 404 Not Found');
          break;
        case 500:
          _log('💥 500 Server Error');
          break;
        default:
          _log('⚠️ Unexpected: ${response.statusCode}');
      }

      // Now try invalid URL
      _log('');
      _log('🌐 Fetching from invalid endpoint...');
      final badResponse = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/invalid_endpoint'),
      );
      _log('Response: ${badResponse.statusCode}');
    } on TimeoutException {
      _log('⏱️ TimeoutException: Server terlalu lama!');
    } on FormatException catch (e) {
      _log('📄 FormatException: ${e.message}');
    } catch (e) {
      _log('❌ Caught: $e');
    } finally {
      _log('🔄 Finally: Cleanup selesai');
    }

    setState(() => _isLoading = false);
  }

  // === Retry with exponential backoff ===
  Future<void> _demoRetryPattern() async {
    setState(() {
      _isLoading = true;
      _logs.clear();
    });

    _log('▶ Demo: Retry Pattern (3 attempts)');
    const maxRetries = 3;

    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        _log('🔄 Attempt $attempt/$maxRetries...');

        // Simulasi: attempt 1-2 gagal, attempt 3 berhasil
        if (attempt < 3) {
          await Future.delayed(const Duration(milliseconds: 500));
          throw Exception('Simulated failure');
        }

        final response = await http.get(
          Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
        );

        if (response.statusCode == 200) {
          _log('✅ Berhasil di attempt $attempt!');
          final data = jsonDecode(response.body);
          _log('📦 Title: ${data['title']}');
          break;
        }
      } catch (e) {
        _log('❌ Attempt $attempt gagal: $e');

        if (attempt < maxRetries) {
          final waitSec = attempt * 2;
          _log('⏳ Menunggu ${waitSec}s sebelum retry...');
          await Future.delayed(Duration(seconds: waitSec));
        } else {
          _log('🚫 Semua $maxRetries attempt gagal!');
        }
      }
    }

    setState(() => _isLoading = false);
  }

  // === Timeout demo ===
  Future<void> _demoTimeout() async {
    setState(() {
      _isLoading = true;
      _logs.clear();
    });

    _log('▶ Demo: Timeout');
    _log('⏱️ Setting timeout to 2 seconds...');
    _log('🌐 Requesting data (will delay 5s)...');

    try {
      await Future.delayed(const Duration(seconds: 5))
          .timeout(const Duration(seconds: 2));
      _log('✅ Success (should not reach here)');
    } on TimeoutException {
      _log('⏱️ TIMEOUT! Request took too long');
      _log('💡 User tidak perlu menunggu selamanya');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error & Retry Demo')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _demoProperErrorHandling,
                  icon: const Icon(Icons.security),
                  label: const Text('Error Handling'),
                ),
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _demoRetryPattern,
                  icon: const Icon(Icons.replay),
                  label: const Text('Retry Pattern'),
                ),
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _demoTimeout,
                  icon: const Icon(Icons.timer_off),
                  label: const Text('Timeout'),
                ),
              ],
            ),
          ),
          const Divider(),
          if (_isLoading) const LinearProgressIndicator(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _logs.length,
              itemBuilder: (context, index) {
                final log = _logs[index];
                return Text(
                  log,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: log.contains('❌') || log.contains('🚫')
                        ? Colors.red
                        : log.contains('✅')
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
}

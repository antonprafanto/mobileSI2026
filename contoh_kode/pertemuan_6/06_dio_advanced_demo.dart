// 06_dio_advanced_demo.dart
// Pertemuan 6 — Demo 6: Package Dio, interceptors, timeout, cancel
// Dependency: dio (flutter pub add dio)

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DioAdvancedDemoPage(),
    ));

class DioAdvancedDemoPage extends StatefulWidget {
  const DioAdvancedDemoPage({super.key});

  @override
  State<DioAdvancedDemoPage> createState() => _DioAdvancedDemoPageState();
}

class _DioAdvancedDemoPageState extends State<DioAdvancedDemoPage> {
  late final Dio _dio;
  final List<String> _logs = [];
  bool _isLoading = false;
  CancelToken? _cancelToken;

  @override
  void initState() {
    super.initState();
    _dio = Dio(BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ));

    // Interceptor — log semua request/response
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        _log('→ ${options.method} ${options.uri}');
        handler.next(options);
      },
      onResponse: (response, handler) {
        _log('← ${response.statusCode} (${response.data.toString().length} chars)');
        handler.next(response);
      },
      onError: (error, handler) {
        _log('✖ Error: ${error.message}');
        handler.next(error);
      },
    ));
  }

  @override
  void dispose() {
    _dio.close();
    super.dispose();
  }

  void _log(String msg) {
    if (mounted) {
      setState(() {
        _logs.add('[${DateTime.now().toString().substring(11, 19)}] $msg');
      });
    }
  }

  // === GET with auto JSON decode ===
  Future<void> _dioGet() async {
    setState(() {
      _isLoading = true;
      _logs.clear();
    });
    _log('▶ Dio GET — auto decode JSON');

    try {
      final response = await _dio.get('/posts', queryParameters: {'_limit': 3});
      final posts = response.data as List;
      for (final p in posts) {
        _log('📝 [${p['id']}] ${p['title']}');
      }
      _log('💡 Tidak perlu jsonDecode()! Dio auto decode.');
    } on DioException catch (e) {
      _log('❌ DioException: ${e.type} — ${e.message}');
    }

    setState(() => _isLoading = false);
  }

  // === POST ===
  Future<void> _dioPost() async {
    setState(() {
      _isLoading = true;
      _logs.clear();
    });
    _log('▶ Dio POST — auto encode JSON');

    try {
      final response = await _dio.post('/posts', data: {
        'title': 'Post via Dio',
        'body': 'Tidak perlu jsonEncode()!',
        'userId': 1,
      });
      _log('✅ Created! ID: ${response.data['id']}');
      _log('💡 data: {} langsung jadi JSON body.');
    } on DioException catch (e) {
      _log('❌ ${e.message}');
    }

    setState(() => _isLoading = false);
  }

  // === Cancel request ===
  Future<void> _dioCancelDemo() async {
    setState(() {
      _isLoading = true;
      _logs.clear();
    });
    _log('▶ Dio Cancel Token demo');

    _cancelToken = CancelToken();
    _log('🌐 Starting slow request...');
    _log('⏳ Will auto-cancel after 1 second...');

    // Auto cancel after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      if (_cancelToken != null && !_cancelToken!.isCancelled) {
        _cancelToken!.cancel('User cancelled the request');
        _log('🛑 Cancel token triggered!');
      }
    });

    try {
      // This will be cancelled
      await Future.delayed(const Duration(seconds: 3));
      final response = await _dio.get(
        '/posts',
        cancelToken: _cancelToken,
      );
      _log('✅ Got ${(response.data as List).length} posts');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        _log('🛑 Request CANCELLED: ${e.message}');
        _log('💡 Berguna saat user navigasi ke page lain');
      } else {
        _log('❌ ${e.message}');
      }
    }

    setState(() => _isLoading = false);
  }

  // === Timeout demo ===
  Future<void> _dioTimeoutDemo() async {
    setState(() {
      _isLoading = true;
      _logs.clear();
    });
    _log('▶ Dio Timeout demo');

    // Create Dio with very short timeout
    final shortDio = Dio(BaseOptions(
      baseUrl: 'https://httpstat.us', // Delay service
      connectTimeout: const Duration(seconds: 2),
      receiveTimeout: const Duration(seconds: 2),
    ));

    try {
      _log('⏱️ Timeout set to 2s');
      _log('🌐 Requesting endpoint that delays 5s...');
      await shortDio.get('/200?sleep=5000');
      _log('✅ Should not reach here');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionTimeout) {
        _log('⏱️ TIMEOUT! ${e.type}');
        _log('💡 Dio punya connectTimeout DAN receiveTimeout');
      } else {
        _log('❌ ${e.type}: ${e.message}');
      }
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dio Advanced Demo')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _btn('GET', Icons.download, _dioGet),
                _btn('POST', Icons.upload, _dioPost),
                _btn('Cancel', Icons.cancel, _dioCancelDemo),
                _btn('Timeout', Icons.timer_off, _dioTimeoutDemo),
              ],
            ),
          ),
          const Divider(),
          if (_isLoading) const LinearProgressIndicator(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _logs.length,
              itemBuilder: (context, i) => Text(
                _logs[i],
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: _logs[i].contains('❌') || _logs[i].contains('🛑')
                      ? Colors.red
                      : _logs[i].contains('✅')
                          ? Colors.green
                          : _logs[i].contains('→')
                              ? Colors.blue
                              : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _btn(String label, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: _isLoading ? null : onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}

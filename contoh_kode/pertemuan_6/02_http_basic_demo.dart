// 02_http_basic_demo.dart
// Pertemuan 6 — Demo 2: HTTP GET/POST dasar dengan package http
// Dependency: http (flutter pub add http)
//
// CARA PAKAI:
// 1. flutter create demo_app && cd demo_app
// 2. flutter pub add http
// 3. Copy-paste file ini ke lib/main.dart
// 4. Pastikan internet permission di AndroidManifest.xml
// 5. flutter run

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HttpBasicDemoPage(),
    ));

class HttpBasicDemoPage extends StatefulWidget {
  const HttpBasicDemoPage({super.key});

  @override
  State<HttpBasicDemoPage> createState() => _HttpBasicDemoPageState();
}

class _HttpBasicDemoPageState extends State<HttpBasicDemoPage> {
  static const baseUrl = 'https://jsonplaceholder.typicode.com';
  String _result = 'Tap tombol untuk fetch data dari API';
  bool _isLoading = false;

  void _setResult(String result) {
    if (mounted) setState(() => _result = result);
  }

  // === GET — Ambil 1 post ===
  Future<void> _getPost() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.get(Uri.parse('$baseUrl/posts/1'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _setResult(
          '📥 GET /posts/1\n'
          'Status: ${response.statusCode} OK\n\n'
          'Title: ${data['title']}\n\n'
          'Body: ${data['body']}',
        );
      } else {
        _setResult('Error: ${response.statusCode}');
      }
    } catch (e) {
      _setResult('❌ Exception: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // === GET — Ambil list posts ===
  Future<void> _getPostsList() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts?_limit=5'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> posts = jsonDecode(response.body);
        final titles = posts
            .map((p) => '• [${p['id']}] ${p['title']}')
            .join('\n');
        _setResult(
          '📥 GET /posts?_limit=5\n'
          'Status: ${response.statusCode} OK\n'
          'Count: ${posts.length}\n\n'
          '$titles',
        );
      }
    } catch (e) {
      _setResult('❌ Exception: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // === POST — Buat post baru ===
  Future<void> _createPost() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'title': 'Post dari Flutter App!',
          'body': 'Ini konten yang dibuat via HTTP POST dari Flutter.',
          'userId': 1,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        _setResult(
          '📤 POST /posts\n'
          'Status: ${response.statusCode} Created\n\n'
          'New ID: ${data['id']}\n'
          'Title: ${data['title']}\n'
          'Body: ${data['body']}',
        );
      }
    } catch (e) {
      _setResult('❌ Exception: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // === PUT — Update post ===
  Future<void> _updatePost() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/posts/1'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'id': 1,
          'title': 'Title yang sudah diupdate',
          'body': 'Body yang sudah diupdate via PUT.',
          'userId': 1,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _setResult(
          '🔄 PUT /posts/1\n'
          'Status: ${response.statusCode} OK\n\n'
          'Updated Title: ${data['title']}\n'
          'Updated Body: ${data['body']}',
        );
      }
    } catch (e) {
      _setResult('❌ Exception: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // === DELETE — Hapus post ===
  Future<void> _deletePost() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.delete(Uri.parse('$baseUrl/posts/1'));

      _setResult(
        '🗑️ DELETE /posts/1\n'
        'Status: ${response.statusCode}\n\n'
        '${response.statusCode == 200 ? '✅ Post berhasil dihapus!' : '❌ Gagal menghapus'}',
      );
    } catch (e) {
      _setResult('❌ Exception: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HTTP Basic Demo')),
      body: Column(
        children: [
          // Method buttons
          Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _methodButton('GET /post', Colors.green, _getPost),
                _methodButton('GET /posts', Colors.teal, _getPostsList),
                _methodButton('POST', Colors.blue, _createPost),
                _methodButton('PUT', Colors.orange, _updatePost),
                _methodButton('DELETE', Colors.red, _deletePost),
              ],
            ),
          ),
          const Divider(),

          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),

          // Result
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SelectableText(
                      _result,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _methodButton(String label, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: _isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}

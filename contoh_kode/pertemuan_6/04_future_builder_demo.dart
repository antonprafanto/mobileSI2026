// 04_future_builder_demo.dart
// Pertemuan 6 — Demo 4: FutureBuilder & StreamBuilder
// Dependency: http (flutter pub add http)

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilderDemoPage(),
    ));

class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['id'] as int,
        title: json['title'] as String,
        body: json['body'] as String,
      );
}

class FutureBuilderDemoPage extends StatefulWidget {
  const FutureBuilderDemoPage({super.key});

  @override
  State<FutureBuilderDemoPage> createState() => _FutureBuilderDemoPageState();
}

class _FutureBuilderDemoPageState extends State<FutureBuilderDemoPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _postsFuture = _fetchPosts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<List<Post>> _fetchPosts() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=15'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((j) => Post.fromJson(j)).toList();
    } else {
      throw Exception('Failed: ${response.statusCode}');
    }
  }

  // Stream: simulate live data
  Stream<int> _liveCounter() async* {
    int count = 0;
    while (count < 20) {
      await Future.delayed(const Duration(seconds: 1));
      yield ++count;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureBuilder & StreamBuilder'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'FutureBuilder'),
            Tab(text: 'StreamBuilder'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() => _postsFuture = _fetchPosts());
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // TAB 1: FutureBuilder
          FutureBuilder<List<Post>>(
            future: _postsFuture,
            builder: (context, snapshot) {
              // Loading
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('ConnectionState.waiting...'),
                    ],
                  ),
                );
              }

              // Error
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text('snapshot.hasError: true\n${snapshot.error}',
                          textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () =>
                            setState(() => _postsFuture = _fetchPosts()),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              // Empty
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('snapshot.hasData: false'));
              }

              // Success
              final posts = snapshot.data!;
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.green.shade50,
                    child: Text(
                      'ConnectionState: ${snapshot.connectionState}\n'
                      'hasData: ${snapshot.hasData} • count: ${posts.length}',
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return ListTile(
                          leading: CircleAvatar(child: Text('${post.id}')),
                          title: Text(post.title,
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                          subtitle: Text(post.body,
                              maxLines: 2, overflow: TextOverflow.ellipsis),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),

          // TAB 2: StreamBuilder
          Center(
            child: StreamBuilder<int>(
              stream: _liveCounter(),
              builder: (context, snapshot) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${snapshot.data ?? 0}',
                      style: const TextStyle(
                          fontSize: 72, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'ConnectionState: ${snapshot.connectionState}',
                      style: const TextStyle(fontFamily: 'monospace'),
                    ),
                    const SizedBox(height: 8),
                    Text('hasData: ${snapshot.hasData}'),
                    const SizedBox(height: 24),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'StreamBuilder updates UI setiap kali\n'
                        'Stream mengirim data baru (yield).\n\n'
                        'Berbeda dengan FutureBuilder yang\n'
                        'hanya update SEKALI saat Future selesai.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

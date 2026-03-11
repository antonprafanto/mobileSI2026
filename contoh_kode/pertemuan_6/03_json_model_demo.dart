// 03_json_model_demo.dart
// Pertemuan 6 — Demo 3: JSON parsing, fromJson, toJson, model class
// Dependency: http (flutter pub add http)

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JsonModelDemoPage(),
    ));

// ============================================
// MODEL CLASSES
// ============================================

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
      };

  @override
  String toString() => 'Post(id: $id, title: $title)';
}

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String city;
  final String phone;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.city,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      city: json['address']['city'] as String, // Nested JSON!
      phone: json['phone'] as String,
    );
  }
}

// ============================================
// PAGE
// ============================================

class JsonModelDemoPage extends StatefulWidget {
  const JsonModelDemoPage({super.key});

  @override
  State<JsonModelDemoPage> createState() => _JsonModelDemoPageState();
}

class _JsonModelDemoPageState extends State<JsonModelDemoPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Post> _posts = [];
  List<User> _users = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchPosts() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=10'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        setState(() {
          _posts = jsonList.map((j) => Post.fromJson(j)).toList();
        });
      }
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchUsers() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        setState(() {
          _users = jsonList.map((j) => User.fromJson(j)).toList();
        });
      }
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSON & Model Class Demo'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.article), text: 'Posts'),
            Tab(icon: Icon(Icons.people), text: 'Users'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPostsTab(),
          _buildUsersTab(),
        ],
      ),
    );
  }

  Widget _buildPostsTab() {
    if (_posts.isEmpty && !_isLoading) {
      return Center(
        child: ElevatedButton.icon(
          onPressed: _fetchPosts,
          icon: const Icon(Icons.download),
          label: const Text('Fetch Posts (with model class)'),
        ),
      );
    }

    if (_isLoading) return const Center(child: CircularProgressIndicator());

    if (_error != null) return Center(child: Text('Error: $_error'));

    return ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        final post = _posts[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ExpansionTile(
            leading: CircleAvatar(child: Text('${post.id}')),
            title: Text(post.title, maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text('userId: ${post.userId}'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.body),
                    const Divider(),
                    const Text('toJson() output:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.grey.shade100,
                      child: Text(
                        const JsonEncoder.withIndent('  ').convert(post.toJson()),
                        style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUsersTab() {
    if (_users.isEmpty && !_isLoading) {
      return Center(
        child: ElevatedButton.icon(
          onPressed: _fetchUsers,
          icon: const Icon(Icons.download),
          label: const Text('Fetch Users (nested JSON)'),
        ),
      );
    }

    if (_isLoading) return const Center(child: CircularProgressIndicator());

    if (_error != null) return Center(child: Text('Error: $_error'));

    return ListView.builder(
      itemCount: _users.length,
      itemBuilder: (context, index) {
        final user = _users[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(child: Text('${user.id}')),
            title: Text(user.name),
            subtitle: Text('${user.email}\n📍 ${user.city} • 📞 ${user.phone}'),
            isThreeLine: true,
          ),
        );
      },
    );
  }
}

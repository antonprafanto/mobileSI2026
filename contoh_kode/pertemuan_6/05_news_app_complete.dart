// 05_news_app_complete.dart
// Pertemuan 6 — Demo 5: Post Explorer App Lengkap (Solusi Praktikum)
// Dependency: http, provider
// flutter pub add http provider
//
// Ini adalah SINGLE-FILE version dari main project di Part 6.
// Untuk versi multi-file, lihat contoh_proyek/pertemuan_6_news_app/

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => PostProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PostListPage(),
      ),
    ),
  );
}

// ============================================
// MODEL
// ============================================
class Post {
  final int? id;
  final int userId;
  final String title;
  final String body;

  Post({this.id, required this.userId, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['id'] as int?,
        userId: json['userId'] as int,
        title: json['title'] as String,
        body: json['body'] as String,
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'userId': userId,
        'title': title,
        'body': body,
      };

  Post copyWith({int? id, int? userId, String? title, String? body}) => Post(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        body: body ?? this.body,
      );
}

// ============================================
// API SERVICE
// ============================================
class ApiService {
  static const baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    if (response.statusCode == 200) {
      final List<dynamic> list = jsonDecode(response.body);
      return list.map((j) => Post.fromJson(j)).toList();
    }
    throw Exception('Failed to load posts');
  }

  Future<Post> createPost(Post post) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(post.toJson()),
    );
    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to create post');
  }

  Future<Post> updatePost(Post post) async {
    final response = await http.put(
      Uri.parse('$baseUrl/posts/${post.id}'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(post.toJson()),
    );
    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to update post');
  }

  Future<bool> deletePost(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/posts/$id'));
    return response.statusCode == 200;
  }

  Future<List<Map<String, dynamic>>> getComments(int postId) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/$postId/comments'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    }
    throw Exception('Failed to load comments');
  }
}

// ============================================
// PROVIDER
// ============================================
class PostProvider extends ChangeNotifier {
  final _api = ApiService();
  List<Post> _posts = [];
  bool _isLoading = false;
  String? _error;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchPosts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _posts = await _api.getPosts();
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> createPost(String title, String body) async {
    try {
      final created = await _api.createPost(
        Post(userId: 1, title: title, body: body),
      );
      _posts.insert(0, created);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updatePost(Post post) async {
    try {
      final updated = await _api.updatePost(post);
      final i = _posts.indexWhere((p) => p.id == post.id);
      if (i != -1) _posts[i] = updated;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletePost(int id) async {
    try {
      await _api.deletePost(id);
      _posts.removeWhere((p) => p.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}

// ============================================
// POST LIST PAGE
// ============================================
class PostListPage extends StatefulWidget {
  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<PostProvider>().fetchPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📱 Post Explorer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<PostProvider>().fetchPosts(),
          ),
        ],
      ),
      body: Consumer<PostProvider>(
        builder: (context, prov, _) {
          if (prov.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (prov.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(prov.error!, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => prov.fetchPosts(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (prov.posts.isEmpty) {
            return const Center(child: Text('No posts yet'));
          }
          return RefreshIndicator(
            onRefresh: () => prov.fetchPosts(),
            child: ListView.builder(
              itemCount: prov.posts.length,
              itemBuilder: (context, i) {
                final post = prov.posts[i];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${post.id ?? "?"}')),
                    title: Text(post.title,
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text(post.body,
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PostDetailPage(post: post),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PostFormPage()),
          );
          if (result == true && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('✅ Post created!')),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ============================================
// POST DETAIL PAGE
// ============================================
class PostDetailPage extends StatefulWidget {
  final Post post;
  const PostDetailPage({super.key, required this.post});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  late Future<List<Map<String, dynamic>>> _commentsFuture;

  Post get post => widget.post;

  @override
  void initState() {
    super.initState();
    _commentsFuture = ApiService().getComments(post.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post #${post.id}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PostFormPage(post: post),
                ),
              );
              if (result == true && context.mounted) Navigator.pop(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Delete?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
              if (confirm == true && context.mounted) {
                await context.read<PostProvider>().deletePost(post.id!);
                if (context.mounted) Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title,
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('User #${post.userId}',
                style: const TextStyle(color: Colors.grey)),
            const Divider(height: 24),
            Text(post.body, style: const TextStyle(fontSize: 16, height: 1.6)),
            const Divider(height: 32),
            const Text('💬 Comments',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _commentsFuture, // Disimpan di initState!
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snap.hasError) return Text('Error: ${snap.error}');
                final comments = snap.data ?? [];
                return Column(
                  children: comments
                      .map((c) => Card(
                            child: ListTile(
                              title: Text(c['name'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 13)),
                              subtitle: Text(c['body']),
                              dense: true,
                            ),
                          ))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================
// POST FORM PAGE (Create / Edit)
// ============================================
class PostFormPage extends StatefulWidget {
  final Post? post;
  const PostFormPage({super.key, this.post});

  @override
  State<PostFormPage> createState() => _PostFormPageState();
}

class _PostFormPageState extends State<PostFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _bodyCtrl = TextEditingController();
  bool _submitting = false;

  bool get isEdit => widget.post != null;

  @override
  void initState() {
    super.initState();
    if (isEdit) {
      _titleCtrl.text = widget.post!.title;
      _bodyCtrl.text = widget.post!.body;
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _bodyCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);

    final prov = context.read<PostProvider>();
    bool ok;
    if (isEdit) {
      ok = await prov.updatePost(widget.post!.copyWith(
        title: _titleCtrl.text.trim(),
        body: _bodyCtrl.text.trim(),
      ));
    } else {
      ok = await prov.createPost(
        _titleCtrl.text.trim(),
        _bodyCtrl.text.trim(),
      );
    }

    if (mounted) {
      if (ok) {
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ Failed')),
        );
        setState(() => _submitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Post' : 'New Post')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bodyCtrl,
                decoration: const InputDecoration(
                  labelText: 'Body',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitting ? null : _submit,
                  child: Text(_submitting
                      ? 'Sending...'
                      : (isEdit ? 'Update' : 'Create')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

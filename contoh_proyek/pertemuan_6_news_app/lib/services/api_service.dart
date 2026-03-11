// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Post>> getPosts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/posts'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat posts (${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<Post> getPost(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/posts/$id'));
      if (response.statusCode == 200) {
        return Post.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Post tidak ditemukan');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<Post> createPost(Post post) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(post.toJson()),
      );
      if (response.statusCode == 201) {
        return Post.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Gagal membuat post');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<Post> updatePost(Post post) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/posts/${post.id}'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(post.toJson()),
      );
      if (response.statusCode == 200) {
        return Post.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Gagal mengupdate post');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<bool> deletePost(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/posts/$id'));
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getComments(int postId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts/$postId/comments'),
      );
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(jsonDecode(response.body));
      } else {
        throw Exception('Gagal memuat komentar');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}

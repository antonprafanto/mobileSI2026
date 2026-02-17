// 04_navigation_with_data_demo.dart
// Demo: Navigation dengan Passing Data
// Pertemuan 3 - ListView, GridView, dan Navigasi

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation with Data',
      theme: ThemeData(primarySwatch: Colors.teal, useMaterial3: true),
      home: const UserListPage(),
    );
  }
}

class User {
  final String name;
  final int age;
  final String email;
  final String bio;

  User({required this.name, required this.age, required this.email, required this.bio});
}

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final users = [
      User(name: 'Alice', age: 25, email: 'alice@example.com', bio: 'Software Engineer at Tech Corp'),
      User(name: 'Bob', age: 30, email: 'bob@example.com', bio: 'UI/UX Designer'),
      User(name: 'Charlie', age: 28, email: 'charlie@example.com', bio: 'Product Manager'),
      User(name: 'Diana', age: 27, email: 'diana@example.com', bio: 'Data Scientist'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.teal,
                child: Text(user.name[0], style: const TextStyle(color: Colors.white)),
              ),
              title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(user.email),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Pass entire user object to detail page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetailPage(user: user),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class UserDetailPage extends StatelessWidget {
  final User user; // Receive data via constructor parameter

  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.teal,
              child: Text(
                user.name[0],
                style: const TextStyle(fontSize: 48, color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(Icons.person, 'Name', user.name),
                    const Divider(),
                    _buildInfoRow(Icons.cake, 'Age', '${user.age} years old'),
                    const Divider(),
                    _buildInfoRow(Icons.email, 'Email', user.email),
                    const Divider(),
                    _buildInfoRow(Icons.work, 'Bio', user.bio),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.teal),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

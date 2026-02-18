# -*- coding: utf-8 -*-
"""Create remaining demo files for Pertemuan 3 efficiently"""

import os

# Pertemuan 3 - File 04: Navigation with Data
file_04 = """// 04_navigation_with_data_demo.dart
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
      User(name: 'Alice', age: 25, email: 'alice@example.com', bio: 'Software Engineer'),
      User(name: 'Bob', age: 30, email: 'bob@example.com', bio: 'Designer'),
      User(name: 'Charlie', age: 28, email: 'charlie@example.com', bio: 'Product Manager'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Select User')),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            leading: CircleAvatar(child: Text(user.name[0])),
            title: Text(user.name),
            subtitle: Text(user.email),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Pass user data to detail page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetailPage(user: user),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class UserDetailPage extends StatelessWidget {
  final User user; // Receive data via constructor

  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                child: Text(user.name[0], style: const TextStyle(fontSize: 40)),
              ),
            ),
            const SizedBox(height: 24),
            Text('Name: ${user.name}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Age: ${user.age}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Bio: ${user.bio}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
"""

# Write file 04
with open('contoh_kode/pertemuan_3/04_navigation_with_data_demo.dart', 'w', encoding='utf-8') as f:
    f.write(file_04)

print("✅ Created 04_navigation_with_data_demo.dart")

# Pertemuan 3 - File 05: Return Data
file_05 = """// 05_return_data_demo.dart
// Demo: Menerima Return Value dari Page
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
      title: 'Return Data Demo',
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedColor = 'No color selected';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Color:',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              _selectedColor,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                // await untuk terima return value
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectColorPage(),
                  ),
                );

                // Update UI with returned result
                if (result != null) {
                  setState(() {
                    _selectedColor = result;
                  });
                }
              },
              child: const Text('Select Color'),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectColorPage extends StatelessWidget {
  const SelectColorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ['Red', 'Blue', 'Green', 'Yellow', 'Purple', 'Orange'];

    return Scaffold(
      appBar: AppBar(title: const Text('Select Color')),
      body: ListView.builder(
        itemCount: colors.length,
        itemBuilder: (context, index) {
          final color = colors[index];
          return ListTile(
            leading: Icon(Icons.circle, color: _getColor(color)),
            title: Text(color),
            onTap: () {
              // Return color to previous page
              Navigator.pop(context, color);
            },
          );
        },
      ),
    );
  }

  Color _getColor(String colorName) {
    switch (colorName) {
      case 'Red': return Colors.red;
      case 'Blue': return Colors.blue;
      case 'Green': return Colors.green;
      case 'Yellow': return Colors.yellow;
      case 'Purple': return Colors.purple;
      case 'Orange': return Colors.orange;
      default: return Colors.grey;
    }
  }
}
"""

with open('contoh_kode/pertemuan_3/05_return_data_demo.dart', 'w', encoding='utf-8') as f:
    f.write(file_05)

print("✅ Created 05_return_data_demo.dart")

print(\"\\n🎉 Pertemuan 3 remaining files created!\")

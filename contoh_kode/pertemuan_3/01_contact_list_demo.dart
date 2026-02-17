// 01_contact_list_demo.dart
// Demo: Contact List dengan ListView
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
      title: 'Contact List Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ContactListPage(),
    );
  }
}

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data kontak
    final contacts = [
      {'name': 'Alice Johnson', 'phone': '+62 812-3456-7890', 'email': 'alice@email.com'},
      {'name': 'Bob Smith', 'phone': '+62 813-4567-8901', 'email': 'bob@email.com'},
      {'name': 'Charlie Brown', 'phone': '+62 814-5678-9012', 'email': 'charlie@email.com'},
      {'name': 'Diana Prince', 'phone': '+62 815-6789-0123', 'email': 'diana@email.com'},
      {'name': 'Ethan Hunt', 'phone': '+62 816-7890-1234', 'email': 'ethan@email.com'},
      {'name': 'Fiona Apple', 'phone': '+62 817-8901-2345', 'email': 'fiona@email.com'},
      {'name': 'George Martin', 'phone': '+62 818-9012-3456', 'email': 'george@email.com'},
      {'name': 'Hannah Montana', 'phone': '+62 819-0123-4567', 'email': 'hannah@email.com'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  contact['name']![0], // First letter
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                contact['name']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(contact['phone']!),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.email, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(contact['email']!),
                    ],
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.call, color: Colors.green),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Calling ${contact['name']}...')),
                  );
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactDetailPage(contact: contact),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add new contact (not implemented)')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ContactDetailPage extends StatelessWidget {
  final Map<String, String> contact;

  const ContactDetailPage({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact['name']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                child: Text(
                  contact['name']![0],
                  style: const TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Name'),
              subtitle: Text(contact['name']!),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Phone'),
              subtitle: Text(contact['phone']!),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: Text(contact['email']!),
            ),
          ],
        ),
      ),
    );
  }
}

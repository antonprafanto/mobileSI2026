import 'package:flutter/material.dart';

class DataPassingDemoPage extends StatelessWidget {
  const DataPassingDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final users = [
      {'name': 'Alice', 'age': 25},
      {'name': 'Bob', 'age': 30},
      {'name': 'Charlie', 'age': 28},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Passing Demo'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user['name'] as String),
            subtitle: Text('Age: ${user['age']}'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetailPage (
                    name: user['name'] as String,
                    age: user['age'] as int,
                  ),
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
  final String name;
  final int age;

  const UserDetailPage({
    super.key,
    required this.name,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Text(name[0], style: const TextStyle(fontSize: 40)),
            ),
            const SizedBox(height: 20),
            Text('Name: $name', style: const TextStyle(fontSize: 20)),
            Text('Age: $age', style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

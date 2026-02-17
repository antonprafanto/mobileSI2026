import 'package:flutter/material.dart';

class ListDemosPage extends StatelessWidget {
  const ListDemosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ListView Demos'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Builder'),
              Tab(text: 'Separated'),
              Tab(text: 'Basic'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ListBuilderDemo(),
            ListSeparatedDemo(),
            ListBasicDemo(),
          ],
        ),
      ),
    );
  }
}

class ListBuilderDemo extends StatelessWidget {
  const ListBuilderDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final contacts = List.generate(
      20,
      (i) => {'name': 'Contact ${i + 1}', 'phone': '+62 81${i.toString().padLeft(8, '0')}'},
    );

    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return ListTile(
          leading: CircleAvatar(child: Text('${index + 1}')),
          title: Text(contact['name']!),
          subtitle: Text(contact['phone']!),
          trailing: const Icon(Icons.call),
        );
      },
    );
  }
}

class ListSeparatedDemo extends StatelessWidget {
  const ListSeparatedDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(15, (i) => 'Item ${i + 1}');

    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.star, color: Colors.amber[700]),
          title: Text(items[index]),
          subtitle: Text('This is item number ${index + 1}'),
        );
      },
    );
  }
}

class ListBasicDemo extends StatelessWidget {
  const ListBasicDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: const [
        Card(child: ListTile(title: Text('Static Item 1'))),
        Card(child: ListTile(title: Text('Static Item 2'))),
        Card(child: ListTile(title: Text('Static Item 3'))),
        Card(child: ListTile(title: Text('Static Item 4'))),
        Card(child: ListTile(title: Text('Static Item 5'))),
      ],
    );
  }
}

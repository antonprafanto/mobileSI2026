import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderMethodsPage extends StatelessWidget {
  const ProviderMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SimpleCounter(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Provider Methods')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Card(
              color: Colors.blue,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('1. context.read<T>()', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text('Use in callbacks. Does NOT rebuild.', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
            ),
            Consumer<SimpleCounter>(
              builder: (context, counter, child) {
                return Card(
                  child: ListTile(
                    title: Text('Count: ${counter.value}'),
                    trailing: ElevatedButton(
                      onPressed: () => context.read<SimpleCounter>().increment(),
                      child: const Text('context.read'),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Card(
              color: Colors.green,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('2. context.watch<T>()', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text('Use in build. Rebuilds when value changes.', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
            ),
            Builder(builder: (context) {
              final counter = context.watch<SimpleCounter>();
              return Card(
                child: ListTile(
                  title: Text('Count: ${counter.value}'),
                  subtitle: const Text('This rebuilds on every change'),
                ),
              );
            }),
            const SizedBox(height: 20),
            const Card(
              color: Colors.orange,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('3. Consumer<T>', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text('Best practice. Only rebuilds Consumer.', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
            ),
            Consumer<SimpleCounter>(
              builder: (context, counter, child) {
                return Card(
                  child: ListTile(
                    title: Text('Count: ${counter.value}'),
                    subtitle: const Text('Only this Consumer rebuilds'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleCounter extends ChangeNotifier {
  int _value = 0;
  int get value => _value;
  void increment() {
    _value++;
    notifyListeners();
  }
}

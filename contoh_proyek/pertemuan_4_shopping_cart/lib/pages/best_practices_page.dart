import 'package:flutter/material.dart';

class BestPracticesPage extends StatelessWidget {
  const BestPracticesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Best Practices')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          PracticeCard(
            isGood: true,
            title: 'Use context.read for actions',
            description: 'In callbacks, use context.read<T>() to avoid unnecessary rebuilds.',
          ),
          PracticeCard(
            isGood: false,
            title: 'Don\'t use context.watch in callbacks',
            description: 'context.watch triggers rebuilds. Only use in build method.',
          ),
          PracticeCard(
            isGood: true,
            title: 'Use Consumer for targeted rebuilds',
            description: 'Wrap only the widget that needs to rebuild with Consumer.',
          ),
          PracticeCard(
            isGood: false,
            title: 'Don\'t put UI logic in models',
            description: 'Models should only contain business logic and data.',
          ),
          PracticeCard(
            isGood: true,
            title: 'Use Selector for optimization',
            description: 'When you need only one property, use Selector instead of Consumer.',
          ),
          PracticeCard(
            isGood: false,
            title: 'Don\'t overuse Provider',
            description: 'For local/ephemeral state, use setState. Provider is for app state.',
          ),
          PracticeCard(
            isGood: true,
            title: 'Call notifyListeners after changes',
            description: 'Always call notifyListeners() after updating model state.',
          ),
          PracticeCard(
            isGood: false,
            title: 'Don\'t call notifyListeners in getters',
            description: 'Only call in methods that modify state, never in getters.',
          ),
        ],
      ),
    );
  }
}

class PracticeCard extends StatelessWidget {
  final bool isGood;
  final String title;
  final String description;

  const PracticeCard({
    super.key,
    required this.isGood,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isGood ? Colors.green.shade50 : Colors.red.shade50,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              isGood ? Icons.check_circle : Icons.cancel,
              color: isGood ? Colors.green : Colors.red,
              size: 32,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isGood ? '✅ DO' : '❌ DON\'T',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isGood ? Colors.green.shade900 : Colors.red.shade900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(description, style: const TextStyle(fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

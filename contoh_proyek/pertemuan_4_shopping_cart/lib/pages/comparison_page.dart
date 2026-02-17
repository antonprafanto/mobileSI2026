import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComparisonPage extends StatelessWidget {
  const ComparisonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('setState vs Provider')),
      body: Row(
        children: [
          Expanded(child: SetStateCounter()),
          const VerticalDivider(width: 2),
          Expanded(child: ChangeNotifierProvider(
            create: (_) => CounterModel(),
            child: const ProviderCounter(),
          )),
        ],
      ),
    );
  }
}

class SetStateCounter extends StatefulWidget {
  @override
  State<SetStateCounter> createState() => _SetStateCounterState();
}

class _SetStateCounterState extends State<SetStateCounter> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    debugPrint('🔴 setState: Full widget rebuild!');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('setState', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const Text('(Rebuilds entire widget)', style: TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 20),
        Text('$_count', style: const TextStyle(fontSize: 48, color: Colors.red)),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () => setState(() => _count++), child: const Text('Increment')),
      ],
    );
  }
}

class CounterModel extends ChangeNotifier {
  int _count = 0;
  int get count => _count;
  void increment() {
    _count++;
    notifyListeners();
  }
}

class ProviderCounter extends StatelessWidget {
  const ProviderCounter({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('🟢 Provider: Outer widget NOT rebuilt');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Provider', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const Text('(Only Consumer rebuilds)', style: TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 20),
        Consumer<CounterModel>(
          builder: (context, counter, child) {
            debugPrint('🟢 Provider: Only Consumer rebuilt!');
            return Text('${counter.count}', style: const TextStyle(fontSize: 48, color: Colors.green));
          },
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => context.read<CounterModel>().increment(),
          child: const Text('Increment'),
        ),
      ],
    );
  }
}

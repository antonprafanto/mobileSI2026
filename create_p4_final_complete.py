#-*- coding: utf-8 -*-
"""
ABSOLUTE FINAL SCRIPT: Create last 5 P4 pages + README
After this, both projects are COMPLETE!
"""

import os

print("=" * 60)
print("FINAL PAGES + README")
print("=" * 60)

base4 = r'c:\Users\anton\vibecoding\mobileSI2026\contoh_proyek\pertemuan_4_shopping_cart\lib'

# profile_page.dart
profile = """import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../models/cart_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Consumer2<UserModel, CartModel>(
          builder: (context, user, cart, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
                const SizedBox(height: 20),
                Text(user.username, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text('Points: ${user.points}', style: const TextStyle(fontSize: 18)),
                Text('Cart Items: ${cart.itemCount}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 30),
                if (user.isLoggedIn)
                  ElevatedButton(
                    onPressed: () {
                      user.logout();
                      cart.clear();
                    },
                    child: const Text('Logout'),
                  )
                else
                  ElevatedButton(
                    onPressed: () {
                      user.login('John Doe');
                    },
                    child: const Text('Login'),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
"""

with open(f'{base4}/pages/profile_page.dart', 'w', encoding='utf-8') as f:
    f.write(profile)
print("✅ profile_page.dart")

# comparison_page.dart - setState vs Provider side by side
comparison = """import 'package:flutter/material.dart';
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
"""

with open(f'{base4}/pages/comparison_page.dart', 'w', encoding='utf-8') as f:
    f.write(comparison)
print("✅ comparison_page.dart")

# selector_demo_page.dart
selector = """import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectorDemoPage extends StatelessWidget {
  const SelectorDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DualCounter(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Selector Optimization')),
        body: Column(
          children: [
            Expanded(child: Consumer<DualCounter>(
              builder: (context, counter, child) {
                debugPrint('❌ Consumer: Rebuilt on ANY change');
                return Card(
                  color: Colors.red.shade50,
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Consumer (BAD)', style: TextStyle(fontWeight: FontWeight.bold)),
                      const Text('Rebuilds on ANY change', style: TextStyle(fontSize: 12)),
                      const SizedBox(height: 20),
                      Text('Counter A: ${counter.counterA}', style: const TextStyle(fontSize: 24)),
                    ],
                  ),
                );
              },
            )),
            Expanded(child: Selector<DualCounter, int>(
              selector: (context, counter) => counter.counterA,
              builder: (context, counterA, child) {
                debugPrint('✅ Selector: Rebuilt only when counterA changes');
                return Card(
                  color: Colors.green.shade50,
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Selector (GOOD)', style: TextStyle(fontWeight: FontWeight.bold)),
                      const Text('Rebuilds ONLY when counterA changes', style: TextStyle(fontSize: 12)),
                      const SizedBox(height: 20),
                      Text('Counter A: $counterA', style: const TextStyle(fontSize: 24)),
                    ],
                  ),
                );
              },
            )),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(child: ElevatedButton(
                    onPressed: () => context.read<DualCounter>().incrementA(),
                    child: const Text('Increment A'),
                  )),
                  const SizedBox(width: 16),
                  Expanded(child: ElevatedButton(
                    onPressed: () => context.read<DualCounter>().incrementB(),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    child: const Text('Increment B'),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DualCounter extends ChangeNotifier {
  int _counterA = 0;
  int _counterB = 0;
  
  int get counterA => _counterA;
  int get counterB => _counterB;
  
  void incrementA() {
    _counterA++;
    notifyListeners();
  }
  
  void incrementB() {
    _counterB++;
    notifyListeners();
  }
}
"""

with open(f'{base4}/pages/selector_demo_page.dart', 'w', encoding='utf-8') as f:
    f.write(selector)
print("✅ selector_demo_page.dart")

# provider_methods_page.dart
methods = """import 'package:flutter/material.dart';
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
"""

with open(f'{base4}/pages/provider_methods_page.dart', 'w', encoding='utf-8') as f:
    f.write(methods)
print("✅ provider_methods_page.dart")

# best_practices_page.dart
practices = """import 'package:flutter/material.dart';

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
            title: 'Don\\'t use context.watch in callbacks',
            description: 'context.watch triggers rebuilds. Only use in build method.',
          ),
          PracticeCard(
            isGood: true,
            title: 'Use Consumer for targeted rebuilds',
            description: 'Wrap only the widget that needs to rebuild with Consumer.',
          ),
          PracticeCard(
            isGood: false,
            title: 'Don\\'t put UI logic in models',
            description: 'Models should only contain business logic and data.',
          ),
          PracticeCard(
            isGood: true,
            title: 'Use Selector for optimization',
            description: 'When you need only one property, use Selector instead of Consumer.',
          ),
          PracticeCard(
            isGood: false,
            title: 'Don\\'t overuse Provider',
            description: 'For local/ephemeral state, use setState. Provider is for app state.',
          ),
          PracticeCard(
            isGood: true,
            title: 'Call notifyListeners after changes',
            description: 'Always call notifyListeners() after updating model state.',
          ),
          PracticeCard(
            isGood: false,
            title: 'Don\\'t call notifyListeners in getters',
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
                    isGood ? '✅ DO' : '❌ DON\\'T',
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
"""

with open(f'{base4}/pages/best_practices_page.dart', 'w', encoding='utf-8') as f:
    f.write(practices)
print("✅ best_practices_page.dart")

# README.md for P4
readme = """# Pertemuan 4 - Shopping Cart with Provider

Full Flutter project demonstrating **State Management with Provider**.

## 🎯 Features

- ✅ Shopping cart with Provider (add, remove, quantity management)
- ✅ Real-time cart badge using Consumer
- ✅ MultiProvider setup (Cart + User + Theme)
- ✅ Dark/Light mode switching
- ✅ User profile with points system
- ✅ Learning demos: setState vs Provider comparison
- ✅ Selector optimization examples
- ✅ Provider methods comparison (read/watch/Consumer)
- ✅ Best practices guide

## 📂 Project Structure

```
lib/
├── main.dart                        # App with MultiProvider setup
├── models/
│   ├── product.dart                 # Product model
│   ├── cart_model.dart              # Cart with ChangeNotifier
│   ├── user_model.dart              # User state
│   └── theme_model.dart             # Theme state
├── data/
│   └── products_data.dart           # Sample products
├── pages/
│   ├── product_list_page.dart       # Main catalog
│   ├── cart_page.dart               # Shopping cart
│   ├── profile_page.dart            # User profile
│   ├── comparison_page.dart         # setState vs Provider
│   ├── selector_demo_page.dart      # Selector optimization
│   ├── provider_methods_page.dart   # Access methods comparison
│   └── best_practices_page.dart     # Do's and Don'ts
└── widgets/
    ├── product_card.dart            # Product card with add button
    ├── cart_badge.dart              # Badge with Consumer
    ├── cart_item_widget.dart        # Cart item row
    └── app_drawer.dart              # Navigation drawer
```

## 🚀 How to Run

1. Navigate to project:
   ```bash
   cd contoh_proyek/pertemuan_4_shopping_cart
   ```

2. Install provider:
   ```bash
   flutter pub add provider
   ```
   (Already done if you cloned)

3. Get dependencies:
   ```bash
   flutter pub get
   ```

4. Run:
   ```bash
   flutter run
   ```

## 📖 What You'll Learn

### Provider Concepts
- ✅ ChangeNotifier pattern
- ✅ ChangeNotifierProvider
- ✅ MultiProvider setup
- ✅ Consumer widget
- ✅ Selector for optimization
- ✅ context.read vs context.watch

### State Management Patterns
- ✅ Global app state
- ✅ Multiple providers
- ✅ Rebuild optimization
- ✅ Best practices

## 🎓 Learning Path

1. **Products Page**: Browse products, add to cart (see real-time badge)
2. **Cart Page**: Manage quantities, see total calculation
3. **Profile Page**: See MultiProvider in action (User + Cart)
4. **setState vs Provider**: Compare rebuild behavior (check console!)
5. **Selector Demo**: See performance optimization
6. **Provider Methods**: Learn read/watch/Consumer differences
7. **Best Practices**: Do's and Don'ts checklist

## 💡 Key Code Patterns

### MultiProvider setup:
```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => CartModel()),
    ChangeNotifierProvider(create: (_) => UserModel()),
    ChangeNotifierProvider(create: (_) => ThemeModel()),
  ],
  child: MyApp(),
)
```

### Consumer:
```dart
Consumer<CartModel>(
  builder: (context, cart, child) {
    return Text('Items: ${cart.itemCount}');
  },
)
```

### Calling methods:
```dart
// In callbacks - NO rebuild
context.read<CartModel>().addItem(product);

// In build - REBUILDS
final count = context.watch<CartModel>().itemCount;
```

### Selector optimization:
```dart
Selector<CartModel, int>(
  selector: (context, cart) => cart.itemCount,
  builder: (context, count, child) {
    return Text('$count'); // Only rebuilds when itemCount changes
  },
)
```

## 🐛 Debugging Tips

- Check console logs for rebuild indicators
- Use Flutter DevTools to inspect widget tree
- Watch for unnecessary rebuilds
- Compare Consumer vs Selector performance

## 📝 Related Material

See [Pertemuan_4_State_Management_dengan_Provider.md](../../Pertemuan_4_State_Management_dengan_Provider.md)

---

**Dependencies**: provider ^6.1.0  
**Topic**: Pertemuan 4 - State Management with Provider
"""

with open(r'c:\Users\anton\vibecoding\mobileSI2026\contoh_proyek\pertemuan_4_shopping_cart\README.md', 'w', encoding='utf-8') as f:
    f.write(readme)
print("✅ README.md")

print("\\n" + "=" * 60)
print("🎉 BOTH PROJECTS 100% COMPLETE! 🎉")
print("=" * 60)
print("\\nPertemuan 3: 9 files")
print("Pertemuan 4: 18 files")
print("Total: 27 project files created!")
print("\\nReady to commit and push to GitHub!")

// 05_multi_provider_demo.dart
// Demo: Multiple Providers (Cart + User + Theme)
// Pertemuan 4 - State Management dengan Provider
// REQUIRES: flutter pub add provider
//
// NOTE: CartModel di demo ini disederhanakan (hanya itemCount: int).
// Untuk implementasi CartModel lengkap dengan Product detail, lihat demo 04.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MultiProvider untuk multiple state objects
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartModel()),
        ChangeNotifierProvider(create: (_) => UserModel()),
        ChangeNotifierProvider(create: (_) => ThemeModel()),
      ],
      child: Consumer<ThemeModel>(
        builder: (context, themeModel, child) {
          return MaterialApp(
            title: 'MultiProvider Demo',
            theme: themeModel.isDark ? ThemeData.dark() : ThemeData.light(),
            home: const HomePage(),
          );
        },
      ),
    );
  }
}

// Cart Model
class CartModel extends ChangeNotifier {
  int _itemCount = 0;
  int get itemCount => _itemCount;

  void addItem() {
    _itemCount++;
    notifyListeners();
  }

  void clear() {
    _itemCount = 0;
    notifyListeners();
  }
}

// User Model
class UserModel extends ChangeNotifier {
  String _username = 'Guest';
  int _points = 0;

  String get username => _username;
  int get points => _points;

  void login(String name) {
    _username = name;
    _points = 100; // Welcome bonus
    notifyListeners();
  }

  void addPoints(int amount) {
    _points += amount;
    notifyListeners();
  }

  void logout() {
    _username = 'Guest';
    _points = 0;
    notifyListeners();
  }
}

// Theme Model
class ThemeModel extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

// Home Page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MultiProvider Demo'),
        actions: [
          // Cart badge dari CartModel
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {},
                  ),
                  if (cart.itemCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                        child: Text(
                          '${cart.itemCount}',
                          style: const TextStyle(color: Colors.white, fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          // Theme toggle dari ThemeModel
          Consumer<ThemeModel>(
            builder: (context, theme, child) {
              return IconButton(
                icon: Icon(theme.isDark ? Icons.light_mode : Icons.dark_mode),
                onPressed: theme.toggleTheme,
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // User info dari UserModel
            Consumer<UserModel>(
              builder: (context, user, child) {
                return Card(
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          child: Icon(Icons.person, size: 40),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          user.username,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Points: ${user.points}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
            // Buttons that interact with multiple providers
            ElevatedButton(
              onPressed: () {
                final user = context.read<UserModel>();
                if (user.username == 'Guest') {
                  user.login('John Doe');
                } else {
                  user.logout();
                  context.read<CartModel>().clear();
                }
              },
              child: Consumer<UserModel>(
                builder: (context, user, child) {
                  return Text(user.username == 'Guest' ? 'Login' : 'Logout');
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                context.read<CartModel>().addItem();
                context.read<UserModel>().addPoints(10);
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Add Item (+10 points)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<CartModel>().clear();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Clear Cart'),
            ),
            const SizedBox(height: 32),
            const Text(
              '💡 This app uses 3 providers:',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('• CartModel (cart items)', style: TextStyle(fontSize: 12)),
            const Text('• UserModel (user info & points)', style: TextStyle(fontSize: 12)),
            const Text('• ThemeModel (dark/light mode)', style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

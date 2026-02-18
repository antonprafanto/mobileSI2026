# -*- coding: utf-8 -*-
"""
Create ALL Pertemuan 4 Shopping Cart files with Provider
This is Part 1: Models, Data, and Main setup
"""

import os

print("=" * 60)
print("CREATING PERTEMUAN 4 SHOPPING CART FILES")
print("=" * 60)

base4 = r'c:\Users\anton\vibecoding\mobileSI2026\contoh_proyek\pertemuan_4_shopping_cart\lib'
os.makedirs(f'{base4}/models', exist_ok=True)
os.makedirs(f'{base4}/data', exist_ok=True)
os.makedirs(f'{base4}/pages', exist_ok=True)
os.makedirs(f'{base4}/widgets', exist_ok=True)

# Product model (same as P3 but separate)
product = """// lib/models/product.dart
class Product {
  final String id;
  final String name;
  final double price;
  final String emoji;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.emoji,
    required this.description,
  });
}
"""

with open(f'{base4}/models/product.dart', 'w', encoding='utf-8') as f:
    f.write(product)
print("✅ P4: product.dart")

# Cart model with ChangeNotifier
cart_model = """// lib/models/cart_model.dart
import 'package:flutter/foundation.dart';
import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;
}

class CartModel extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;
  
  int get itemCount => _items.length;
  
  int get totalQuantity => _items.values.fold(0, (sum, item) => sum + item.quantity);
  
  double get totalPrice => _items.values.fold(0.0, (sum, item) => sum + item.totalPrice);

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity++;
    } else {
      _items[product.id] = CartItem(product: product);
    }
    notifyListeners();
    debugPrint('✅ Added ${product.name} to cart');
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
    debugPrint('🗑️ Removed item from cart');
  }

  void increaseQuantity(String productId) {
    if (_items.containsKey(productId)) {
      _items[productId]!.quantity++;
      notifyListeners();
      debugPrint('➕ Increased quantity');
    }
  }

  void decreaseQuantity(String productId) {
    if (_items.containsKey(productId)) {
      if (_items[productId]!.quantity > 1) {
        _items[productId]!.quantity--;
        notifyListeners();
        debugPrint('➖ Decreased quantity');
      } else {
        removeItem(productId);
      }
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
    debugPrint('🧹 Cart cleared');
  }
}
"""

with open(f'{base4}/models/cart_model.dart', 'w', encoding='utf-8') as f:
    f.write(cart_model)
print("✅ P4: cart_model.dart")

# User model
user_model = """// lib/models/user_model.dart
import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  String _username = 'Guest';
  int _points = 0;

  String get username => _username;
  int get points => _points;
  bool get isLoggedIn => _username != 'Guest';

  void login(String name) {
    _username = name;
    _points = 100; // Welcome bonus
    notifyListeners();
    debugPrint('👤 User logged in: $name');
  }

  void addPoints(int amount) {
    _points += amount;
    notifyListeners();
    debugPrint('⭐ Added $amount points');
  }

  void logout() {
    _username = 'Guest';
    _points = 0;
    notifyListeners();
    debugPrint('👋 User logged out');
  }
}
"""

with open(f'{base4}/models/user_model.dart', 'w', encoding='utf-8') as f:
    f.write(user_model)
print("✅ P4: user_model.dart")

# Theme model
theme_model = """// lib/models/theme_model.dart
import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
    debugPrint('🎨 Theme toggled to: ${_isDark ? "Dark" : "Light"}');
  }
}
"""

with open(f'{base4}/models/theme_model.dart', 'w', encoding='utf-8') as f:
    f.write(theme_model)
print("✅ P4: theme_model.dart")

# Products data
products_data = """// lib/data/products_data.dart
import '../models/product.dart';

final List<Product> sampleProducts = [
  Product(
    id: '1',
    name: 'Laptop Pro',
    price: 15000000,
    emoji: '💻',
    description: 'High-performance laptop for professionals',
  ),
  Product(
    id: '2',
    name: 'Smartphone X',
    price: 8000000,
    emoji: '📱',
    description: 'Latest smartphone with amazing camera',
  ),
  Product(
    id: '3',
    name: 'Wireless Headphones',
    price: 1500000,
    emoji: '🎧',
    description: 'Premium noise-canceling headphones',
  ),
  Product(
    id: '4',
    name: 'Smart Watch',
    price: 3000000,
    emoji: '⌚',
    description: 'Track your fitness and health',
  ),
  Product(
    id: '5',
    name: 'DSLR Camera',
    price: 12000000,
    emoji: '📷',
    description: 'Professional camera for stunning photos',
  ),
  Product(
    id: '6',
    name: 'Gaming Keyboard',
    price: 1200000,
    emoji: '⌨️',
    description: 'Mechanical keyboard with RGB lighting',
  ),
];
"""

with open(f'{base4}/data/products_data.dart', 'w', encoding='utf-8') as f:
    f.write(products_data)
print("✅ P4: products_data.dart")

# Main with MultiProvider
main = """import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/cart_model.dart';
import 'models/user_model.dart';
import 'models/theme_model.dart';
import 'pages/product_list_page.dart';
import 'pages/cart_page.dart';
import 'pages/profile_page.dart';
import 'pages/comparison_page.dart';
import 'pages/selector_demo_page.dart';
import 'pages/provider_methods_page.dart';
import 'pages/best_practices_page.dart';

void main() {
  runApp(const ShoppingCartApp());
}

class ShoppingCartApp extends StatelessWidget {
  const ShoppingCartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartModel()),
        ChangeNotifierProvider(create: (_) => UserModel()),
        ChangeNotifierProvider(create: (_) => ThemeModel()),
      ],
      child: Consumer<ThemeModel>(
        builder: (context, themeModel, child) {
          return MaterialApp(
            title: 'Shopping Cart - Pertemuan 4',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: themeModel.isDark ? Brightness.dark : Brightness.light,
              ),
              useMaterial3: true,
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => const ProductListPage(),
              '/cart': (context) => const CartPage(),
              '/profile': (context) => const ProfilePage(),
              '/comparison': (context) => const ComparisonPage(),
              '/selector-demo': (context) => const SelectorDemoPage(),
              '/provider-methods': (context) => const ProviderMethodsPage(),
              '/best-practices': (context) => const BestPracticesPage(),
            },
          );
        },
      ),
    );
  }
}
"""

with open(f'{base4}/main.dart', 'w', encoding='utf-8') as f:
    f.write(main)
print("✅ P4: main.dart")

print("\\n✅ Part 1 complete!")
print("Now run Part 2 for pages and widgets...")

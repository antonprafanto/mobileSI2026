# -*- coding: utf-8 -*-
"""
COMPLETE ALL REMAINING P4 FILES: Widgets + Remaining Pages + README
This is the FINAL script to finish Pertemuan 4
"""

import os

print("=" * 60)
print("FINAL SCRIPT: Creating ALL remaining P4 files")
print("=" * 60)

base4 = r'c:\Users\anton\vibecoding\mobileSI2026\contoh_proyek\pertemuan_4_shopping_cart\lib'

# === WIDGETS (4 files) ===

# product_card.dart
product_card = """import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/cart_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  String _formatPrice(double price) {
    return price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\\\\d{1,3})(?=(\\\\d{3})+(?!\\\\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.deepPurple.shade50,
              child: Center(
                child: Text(product.emoji, style: const TextStyle(fontSize: 64)),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Rp ${_formatPrice(product.price)}',
                    style: const TextStyle(color: Colors.deepPurple, fontSize: 12),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<CartModel>().addItem(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Added ${product.name}'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_shopping_cart, size: 14),
                      label: const Text('Add', style: TextStyle(fontSize: 12)),
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 4)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
"""

with open(f'{base4}/widgets/product_card.dart', 'w', encoding='utf-8') as f:
    f.write(product_card)
print("✅ product_card.dart")

# cart_badge.dart
cart_badge = """import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';

class CartBadge extends StatelessWidget {
  const CartBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => Navigator.pushNamed(context, '/cart'),
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
    );
  }
}
"""

with open(f'{base4}/widgets/cart_badge.dart', 'w', encoding='utf-8') as f:
    f.write(cart_badge)
print("✅ cart_badge.dart")

# cart_item_widget.dart
cart_item = """import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({super.key, required this.item});

  String _formatPrice(double price) {
    return price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\\\\d{1,3})(?=(\\\\d{3})+(?!\\\\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Text(item.product.emoji, style: const TextStyle(fontSize: 40)),
        title: Text(item.product.name),
        subtitle: Text('Rp ${_formatPrice(item.product.price)} x ${item.quantity}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () {
                context.read<CartModel>().decreaseQuantity(item.product.id);
              },
            ),
            Text('${item.quantity}', style: const TextStyle(fontSize: 16)),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () {
                context.read<CartModel>().increaseQuantity(item.product.id);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                context.read<CartModel>().removeItem(item.product.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
"""

with open(f'{base4}/widgets/cart_item_widget.dart', 'w', encoding='utf-8') as f:
    f.write(cart_item)
print("✅ cart_item_widget.dart")

# app_drawer.dart
drawer = """import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/theme_model.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.shopping_bag, size: 50, color: Colors.white),
                SizedBox(height: 16),
                Text('Shopping Cart', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.store),
            title: const Text('Products'),
            onTap: () => Navigator.pushNamed(context, '/'),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Cart'),
            onTap: () => Navigator.pushNamed(context, '/cart'),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () => Navigator.pushNamed(context, '/profile'),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Learning Demos', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(Icons.compare),
            title: const Text('setState vs Provider'),
            onTap: () => Navigator.pushNamed(context, '/comparison'),
          ),
          ListTile(
            leading: const Icon(Icons.speed),
            title: const Text('Selector Optimization'),
            onTap: () => Navigator.pushNamed(context, '/selector-demo'),
          ),
          ListTile(
            leading: const Icon(Icons.code),
            title: const Text('Provider Methods'),
            onTap: () => Navigator.pushNamed(context, '/provider-methods'),
          ),
          ListTile(
            leading: const Icon(Icons.check_circle),
            title: const Text('Best Practices'),
            onTap: () => Navigator.pushNamed(context, '/best-practices'),
          ),
          const Divider(),
          Consumer<ThemeModel>(
            builder: (context, theme, child) {
              return SwitchListTile(
                secondary: Icon(theme.isDark ? Icons.dark_mode : Icons.light_mode),
                title: const Text('Dark Mode'),
                value: theme.isDark,
                onChanged: (value) => theme.toggleTheme(),
              );
            },
          ),
        ],
      ),
    );
  }
}
"""

with open(f'{base4}/widgets/app_drawer.dart', 'w', encoding='utf-8') as f:
    f.write(drawer)
print("✅ app_drawer.dart")

print("\\n✅ ALL WIDGETS CREATED!")
print("Now creating remaining pages...")

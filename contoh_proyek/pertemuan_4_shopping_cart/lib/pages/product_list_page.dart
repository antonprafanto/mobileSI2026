import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/products_data.dart';
import '../models/cart_model.dart';
import '../widgets/product_card.dart';
import '../widgets/cart_badge.dart';
import '../widgets/app_drawer.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: const [CartBadge()],
      ),
      drawer: const AppDrawer(),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: sampleProducts.length,
        itemBuilder: (context, index) {
          return ProductCard(product: sampleProducts[index]);
        },
      ),
    );
  }
}

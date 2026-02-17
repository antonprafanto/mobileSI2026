import 'package:flutter/material.dart';
import '../data/products_data.dart';
import '../widgets/product_card.dart';
import 'product_detail_page.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = getCategories();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final products = getProductsByCategory(category);
          
          return Card(
            margin: const EdgeInsets.all(8),
            child: ExpansionTile(
              title: Text(
                category,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${products.length} products'),
              children: products.map((product) {
                return ListTile(
                  leading: Text(product.emoji, style: const TextStyle(fontSize: 32)),
                  title: Text(product.name),
                  subtitle: Text('Rp ${product.price.toStringAsFixed(0)}'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(product: product),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}

// lib/models/product.dart
class Product {
  final String id;
  final String name;
  final double price;
  final String category;
  final String emoji;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.emoji,
    required this.description,
  });
}

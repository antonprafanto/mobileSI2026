// lib/data/products_data.dart
import '../models/product.dart';

final List<Product> sampleProducts = [
  Product(
    id: '1',
    name: 'Laptop Pro',
    price: 15000000,
    category: 'Electronics',
    emoji: '💻',
    description: 'High-performance laptop with latest processor and graphics card. Perfect for programming, design, and gaming.',
  ),
  Product(
    id: '2',
    name: 'Smartphone X',
    price: 8000000,
    category: 'Electronics',
    emoji: '📱',
    description: 'Latest smartphone with amazing camera, long battery life, and stunning display.',
  ),
  Product(
    id: '3',
    name: 'Wireless Headphones',
    price: 1500000,
    category: 'Audio',
    emoji: '🎧',
    description: 'Premium noise-canceling headphones with crystal clear sound quality.',
  ),
  Product(
    id: '4',
    name: 'Smart Watch',
    price: 3000000,
    category: 'Wearables',
    emoji: '⌚',
    description: 'Track your fitness, receive notifications, and monitor your health.',
  ),
  Product(
    id: '5',
    name: 'DSLR Camera',
    price: 12000000,
    category: 'Photography',
    emoji: '📷',
    description: 'Professional camera for stunning photos and 4K video recording.',
  ),
  Product(
    id: '6',
    name: 'Gaming Keyboard',
    price: 1200000,
    category: 'Accessories',
    emoji: '⌨️',
    description: 'Mechanical keyboard with RGB lighting and programmable keys.',
  ),
  Product(
    id: '7',
    name: 'Wireless Mouse',
    price: 500000,
    category: 'Accessories',
    emoji: '🖱️',
    description: 'Ergonomic mouse with precision tracking and long battery life.',
  ),
  Product(
    id: '8',
    name: '4K Monitor',
    price: 5000000,
    category: 'Electronics',
    emoji: '🖥️',
    description: 'Ultra HD monitor with vibrant colors and wide viewing angles.',
  ),
  Product(
    id: '9',
    name: 'Tablet',
    price: 6000000,
    category: 'Electronics',
    emoji: '📱',
    description: 'Portable tablet perfect for reading, drawing, and entertainment.',
  ),
  Product(
    id: '10',
    name: 'Speaker Bluetooth',
    price: 800000,
    category: 'Audio',
    emoji: '🔊',
    description: 'Portable speaker with powerful bass and 360° sound.',
  ),
];

List<String> getCategories() {
  return sampleProducts
      .map((p) => p.category)
      .toSet()
      .toList()
    ..sort();
}

List<Product> getProductsByCategory(String category) {
  return sampleProducts.where((p) => p.category == category).toList();
}

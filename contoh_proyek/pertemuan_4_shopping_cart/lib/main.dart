import 'package:flutter/material.dart';
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

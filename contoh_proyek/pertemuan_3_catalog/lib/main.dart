import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/product_detail_page.dart';
import 'pages/category_page.dart';
import 'pages/list_demos_page.dart';
import 'pages/grid_demos_page.dart';
import 'pages/navigation_demo_page.dart';
import 'pages/data_passing_demo_page.dart';

void main() {
  runApp(const CatalogApp());
}

class CatalogApp extends StatelessWidget {
  const CatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catalog Demo - Pertemuan 3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      // Named routes
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/categories': (context) => const CategoryPage(),
        '/list-demos': (context) => const ListDemosPage(),
        '/grid-demos': (context) => const GridDemosPage(),
        '/navigation-demo': (context) => const NavigationDemoPage(),
        '/data-passing-demo': (context) => const DataPassingDemoPage(),
      },
      // Handle routes with arguments
      onGenerateRoute: (settings) {
        // Product detail requires product argument
        if (settings.name == '/product-detail') {
          return MaterialPageRoute(
            builder: (context) => const ProductDetailPage(),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}

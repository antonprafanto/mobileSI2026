import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/registration_provider.dart';
import 'pages/registration_page.dart';
import 'pages/registrant_list_page.dart';
import 'pages/registrant_detail_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => RegistrationProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registrasi Event',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const RegistrationPage(),
        '/list': (context) => const RegistrantListPage(),
        '/detail': (context) => const RegistrantDetailPage(),
      },
    );
  }
}

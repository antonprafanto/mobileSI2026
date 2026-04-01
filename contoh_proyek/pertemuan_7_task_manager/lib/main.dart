import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/prefs_service.dart';
import 'providers/task_provider.dart';
import 'pages/task_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider()..loadTasks(),
      child: MaterialApp(
        title: 'Task Manager',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: PrefsService.darkMode ? ThemeMode.dark : ThemeMode.light,
        home: const TaskListPage(),
      ),
    );
  }
}

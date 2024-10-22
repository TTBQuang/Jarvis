import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/view/home/notifier/drawer_notifier.dart';
import 'package:provider/provider.dart';
import 'package:jarvis/view/home/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DrawerNotifier(0),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jarvis',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.lightBlueAccent, brightness: Brightness.light),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      builder: (context, child) {
        return FTheme(data: FThemes.blue.light, child: child!);
      },
      home: const HomeScreen(),
    );
  }
}

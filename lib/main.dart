import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const HabitMateApp());
}

class HabitMateApp extends StatelessWidget {
  const HabitMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitMate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomePage(
        studentFullName: 'Гнитецкий Даниил Геннадьевич',
        group: 'ИКБО-12-22',
      ),
    );
  }
}

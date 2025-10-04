import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const HabitMateApp());
}

class HabitMateApp extends StatelessWidget {
  const HabitMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Базовая палитра приложения
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF4F46E5), // индиго-фиолетовый
      brightness: Brightness.light,
    );

    return MaterialApp(
      title: 'HabitMate',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        // Мяглый общий фон, чтобы все «не выглядело белым»
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
        appBarTheme: AppBarTheme(
          backgroundColor: scheme.surface,
          foregroundColor: scheme.onSurface,
          centerTitle: true,
          elevation: 0,
        ),
        // Современная панель навигации внизу с цветным индикатором
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: scheme.surfaceVariant, // НЕ белый
          indicatorColor: scheme.primary.withOpacity(0.18),
          elevation: 3,
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            final selected = states.contains(MaterialState.selected);
            return TextStyle(
              fontSize: 12,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            );
          }),
          iconTheme: MaterialStateProperty.resolveWith(
            (states) => IconThemeData(
              color: states.contains(MaterialState.selected)
                  ? scheme.primary
                  : scheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
      home: const HomePage(
        studentFullName: 'Гнитецкий Даниил Геннадьевич',
        group: 'ИКБО-12-22',
      ),
    );
  }
}

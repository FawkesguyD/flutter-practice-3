import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    super.key,
    required this.studentFullName,
    required this.group,
    required this.onGoAdd,
    required this.onGoList,
  });

  final String studentFullName;
  final String group;
  final VoidCallback onGoAdd;
  final VoidCallback onGoList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Практическая работа №3',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Text(
                'Студент: $studentFullName\nГруппа: $group',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Добро пожаловать в HabitMate!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Создавай привычки, отмечай выполнение и смотри прогресс.',
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            ElevatedButton(onPressed: onGoList, child: const Text('К списку')),
            const SizedBox(width: 8),
            OutlinedButton(onPressed: onGoAdd, child: const Text('Добавить')),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'На всех экранах используются базовые виджеты: '
          'Text, ElevatedButton, OutlinedButton, TextButton, Column, Row, '
          'Container, SizedBox, Padding.',
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

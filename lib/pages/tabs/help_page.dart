import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({
    super.key,
    required this.studentFullName,
    required this.group,
  });

  final String studentFullName;
  final String group;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const _SectionTitle('О приложении'),
        const _Paragraph(
          'HabitMate — учебное приложение-трекер привычек. '
          'Позволяет добавлять привычки, отмечать выполнение и смотреть совокупный прогресс.',
        ),
        const _SectionTitle('Структура экранов (ровно 5)'),
        const _Bullets(items: [
          'Главная — сведения о студенте и быстрые действия.',
          'Привычки — список с карточками и действиями.',
          'Добавить/Редактировать — форма создания и правки привычки.',
          'Прогресс — сводный индикатор и метрики.',
          'Справка — описание и подсказки.',
        ]),
        const _SectionTitle('Используемые базовые виджеты'),
        const _Bullets(items: [
          'Text, ElevatedButton, OutlinedButton, TextButton',
          'Column, Row, Container, SizedBox, Padding',
          'LinearProgressIndicator, ListView',
        ]),
        const _SectionTitle('Навигация'),
        const _Paragraph(
          'Навигация — BottomNavigationBar (вкладки). '
          'Редактирование без открытия новых экранов: переключение на вкладку «Добавить/Редактировать».',
        ),
        const SizedBox(height: 12),
        _SectionTitle('Автор'),
        _Paragraph('Студент: $studentFullName\nГруппа: $group'),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _Paragraph extends StatelessWidget {
  const _Paragraph(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text),
    );
  }
}

class _Bullets extends StatelessWidget {
  const _Bullets({required this.items, super.key});
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• '),
                  Expanded(child: Text(e)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

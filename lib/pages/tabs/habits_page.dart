import 'package:flutter/material.dart';
import '../../models/habit.dart';
import '../../widgets/habit_card.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({
    super.key,
    required this.habits,
    required this.onDone,
    required this.onEdit,
    required this.onDelete,
  });

  final List<Habit> habits;
  final void Function(int id) onDone;
  final void Function(Habit habit) onEdit;
  final void Function(int id) onDelete;

  @override
  Widget build(BuildContext context) {
    if (habits.isEmpty) {
      return const Center(
        child: Text('Пока нет привычек. Добавь первую на вкладке "Добавить".'),
      );
    }

    return ListView.builder(
      itemCount: habits.length,
      itemBuilder: (context, index) {
        final h = habits[index];
        return HabitCard(
          habit: h,
          onDone: () => onDone(h.id),
          onEdit: () => onEdit(h),
          onDelete: () => onDelete(h.id),
        );
      },
    );
  }
}

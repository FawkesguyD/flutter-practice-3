import 'package:flutter/material.dart';
import '../models/habit.dart';

class HabitCard extends StatelessWidget {
  const HabitCard({
    super.key,
    required this.habit,
    required this.onDone,
    required this.onEdit,
    required this.onDelete,
  });

  final Habit habit;
  final VoidCallback onDone;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Заголовок + частота
          Row(
            children: [
              Expanded(
                child: Text(
                  habit.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: cs.secondaryContainer,
                ),
                child: Text(
                  habit.frequencyLabel,
                  style:
                      TextStyle(fontSize: 12, color: cs.onSecondaryContainer),
                ),
              ),
            ],
          ),
          if ((habit.description ?? '').isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              habit.description!,
              style: TextStyle(fontSize: 14, color: cs.onSurfaceVariant),
            ),
          ],
          const SizedBox(height: 12),
          // Прогресс
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: (habit.targetPerPeriod == 0)
                      ? 0
                      : (habit.doneThisPeriod / habit.targetPerPeriod)
                          .clamp(0, 1)
                          .toDouble(),
                ),
              ),
              const SizedBox(width: 12),
              Text('${habit.doneThisPeriod}/${habit.targetPerPeriod}'),
            ],
          ),
          const SizedBox(height: 12),
          // Кнопки действий
          Row(
            children: [
              ElevatedButton(
                onPressed: onDone,
                child: const Text('Выполнено'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: onEdit,
                child: const Text('Редактировать'),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: onDelete,
                child: const Text('Удалить'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

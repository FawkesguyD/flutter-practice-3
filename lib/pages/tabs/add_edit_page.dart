import 'package:flutter/material.dart';
import '../../models/habit.dart';

class AddEditPage extends StatefulWidget {
  const AddEditPage({
    super.key,
    required this.makeId,
    required this.onSaved,
    required this.onCancel,
    this.existing,
  });

  final int Function() makeId;
  final Habit? existing;
  final void Function(Habit habit, bool isNew) onSaved;
  final VoidCallback onCancel;

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  late final TextEditingController _title;
  late final TextEditingController _desc;
  HabitFrequency _frequency = HabitFrequency.daily;
  int _target = 1;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.existing?.title ?? '');
    _desc = TextEditingController(text: widget.existing?.description ?? '');
    _frequency = widget.existing?.frequency ?? HabitFrequency.daily;
    _target = widget.existing?.targetPerPeriod ?? 1;
  }

  @override
  void didUpdateWidget(covariant AddEditPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Если родитель переключил режим (новая/редактирование) — обновим поля.
    if (oldWidget.existing?.id != widget.existing?.id) {
      _title.text = widget.existing?.title ?? '';
      _desc.text = widget.existing?.description ?? '';
      _frequency = widget.existing?.frequency ?? HabitFrequency.daily;
      _target = widget.existing?.targetPerPeriod ?? 1;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    super.dispose();
  }

  void _save() {
    if (_title.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите название привычки')),
      );
      return;
    }

    final isNew = widget.existing == null;
    final habit = Habit(
      id: widget.existing?.id ?? widget.makeId(),
      title: _title.text.trim(),
      description: _desc.text.trim().isEmpty ? null : _desc.text.trim(),
      frequency: _frequency,
      targetPerPeriod: _target,
      doneThisPeriod: widget.existing?.doneThisPeriod ?? 0,
    );

    widget.onSaved(habit, isNew);

    // Очистим форму (готово к следующему вводу)
    setState(() {
      _title.clear();
      _desc.clear();
      _frequency = HabitFrequency.daily;
      _target = 1;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(isNew ? 'Привычка добавлена' : 'Изменения сохранены')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(isEdit ? 'Редактирование' : 'Новая привычка',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            TextField(
              controller: _title,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Название',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _desc,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Описание (необязательно)',
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<HabitFrequency>(
                    value: _frequency,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Частота',
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: HabitFrequency.daily,
                        child: Text('Ежедневно'),
                      ),
                      DropdownMenuItem(
                        value: HabitFrequency.weekly,
                        child: Text('Еженедельно'),
                      ),
                    ],
                    onChanged: (v) => setState(() => _frequency = v!),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    initialValue: _target.toString(),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Цель за период',
                    ),
                    onChanged: (v) {
                      final parsed = int.tryParse(v) ?? 1;
                      setState(() => _target = parsed.clamp(1, 99));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _save,
                  child: Text(isEdit ? 'Сохранить' : 'Добавить'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    widget.onCancel();
                    setState(() {
                      _title.clear();
                      _desc.clear();
                      _frequency = HabitFrequency.daily;
                      _target = 1;
                    });
                  },
                  child: const Text('Отмена'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

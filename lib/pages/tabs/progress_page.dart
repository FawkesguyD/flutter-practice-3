import 'package:flutter/material.dart';
import '../../widgets/metric_tile.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({
    super.key,
    required this.totalDone,
    required this.totalTarget,
    required this.onReset,
  });

  final int totalDone;
  final int totalTarget;
  final VoidCallback onReset;

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  bool _showPercent = true;

  @override
  Widget build(BuildContext context) {
    final progress =
        (widget.totalTarget == 0) ? 0.0 : widget.totalDone / widget.totalTarget;
    final progressText = _showPercent
        ? '${(progress * 100).clamp(0, 100).toStringAsFixed(0)}%'
        : '${widget.totalDone} из ${widget.totalTarget}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Прогресс',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        LinearProgressIndicator(value: progress.clamp(0, 1).toDouble()),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(progressText, style: const TextStyle(fontSize: 14)),
            const Spacer(),
            Switch(
              value: _showPercent,
              onChanged: (v) => setState(() => _showPercent = v),
            ),
            const SizedBox(width: 4),
            const Text('Проценты'),
          ],
        ),
        const SizedBox(height: 16),
        MetricTile(
          title: 'Всего выполнено',
          value: '${widget.totalDone}',
          subtitle: 'Сумма отметок за период',
        ),
        MetricTile(
          title: 'Общая цель',
          value: '${widget.totalTarget}',
          subtitle: 'Сумма целей всех привычек',
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            ElevatedButton(
              onPressed: widget.onReset,
              child: const Text('Сбросить прогресс'),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () => setState(() => _showPercent = !_showPercent),
              child: const Text('Переключить режим'),
            ),
          ],
        ),
      ],
    );
  }
}

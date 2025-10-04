import 'package:flutter/material.dart';
import '../models/habit.dart';
import 'tabs/dashboard_page.dart';
import 'tabs/habits_page.dart';
import 'tabs/add_edit_page.dart';
import 'tabs/progress_page.dart';
import 'tabs/help_page.dart';

/// ВАЖНО: Ровно 5 экранов-приложения (каждый — отдельный Widget экрана):
/// 1) DashboardPage
/// 2) HabitsPage
/// 3) AddEditPage
/// 4) ProgressPage
/// 5) HelpPage
///
/// Никаких дополнительных экранов через Navigator не открывается —
/// редактирование делаем через переключение на вкладку AddEditPage.
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.studentFullName,
    required this.group,
  });

  final String studentFullName;
  final String group;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  int _nextId = 1;

  final List<Habit> _habits = [];
  Habit? _editing; // если не null — редактируем эту привычку на экране Add/Edit

  void _addHabit(Habit habit) {
    setState(() {
      _habits.add(habit);
      _nextId = (_nextId <= habit.id) ? habit.id + 1 : _nextId;
    });
  }

  void _updateHabit(Habit updated) {
    setState(() {
      final idx = _habits.indexWhere((h) => h.id == updated.id);
      if (idx != -1) _habits[idx] = updated;
    });
  }

  void _deleteHabit(int id) {
    setState(() {
      _habits.removeWhere((h) => h.id == id);
    });
  }

  void _markDone(int id) {
    setState(() {
      final h = _habits.firstWhere((e) => e.id == id);
      if (h.doneThisPeriod < h.targetPerPeriod) {
        h.doneThisPeriod += 1;
      }
    });
  }

  void _resetProgress() {
    setState(() {
      for (final h in _habits) {
        h.doneThisPeriod = 0;
      }
    });
  }

  int get _totalTarget =>
      _habits.fold<int>(0, (sum, e) => sum + e.targetPerPeriod);
  int get _totalDone =>
      _habits.fold<int>(0, (sum, e) => sum + e.doneThisPeriod);

  void _goToAddNew() {
    setState(() {
      _editing = null;
      _currentIndex = 2; // вкладка Add/Edit
    });
  }

  void _goToEdit(Habit habit) {
    setState(() {
      _editing = habit;
      _currentIndex = 2; // вкладка Add/Edit
    });
  }

  void _clearEditing() {
    setState(() {
      _editing = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      DashboardPage(
        studentFullName: widget.studentFullName,
        group: widget.group,
        onGoAdd: _goToAddNew,
        onGoList: () => setState(() => _currentIndex = 1),
      ),
      HabitsPage(
        habits: _habits,
        onDone: _markDone,
        onEdit: _goToEdit, // без Navigator — переключаемся на вкладку Add/Edit
        onDelete: _deleteHabit,
      ),
      AddEditPage(
        makeId: () => _nextId++,
        existing: _editing,
        onSaved: (habit, isNew) {
          if (isNew) {
            _addHabit(habit);
          } else {
            _updateHabit(habit);
          }
          _clearEditing();
        },
        onCancel: _clearEditing,
      ),
      ProgressPage(
        totalDone: _totalDone,
        totalTarget: _totalTarget,
        onReset: _resetProgress,
      ),
      HelpPage(
        studentFullName: widget.studentFullName,
        group: widget.group,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('HabitMate — трекер привычек'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: pages[_currentIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt), label: 'Привычки'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Добавить'),
          BottomNavigationBarItem(
              icon: Icon(Icons.insights), label: 'Прогресс'),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline), label: 'Справка'),
        ],
      ),
    );
  }
}

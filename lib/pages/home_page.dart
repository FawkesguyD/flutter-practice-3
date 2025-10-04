import 'package:flutter/material.dart';
import '../models/habit.dart';
import 'tabs/dashboard_page.dart';
import 'tabs/habits_page.dart';
import 'tabs/add_edit_page.dart';
import 'tabs/progress_page.dart';
import 'tabs/help_page.dart';

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
  Habit? _editing;

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
      _currentIndex = 2;
    });
  }

  void _goToEdit(Habit habit) {
    setState(() {
      _editing = habit;
      _currentIndex = 2;
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
        onEdit: _goToEdit,
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
      // НЕ белая нижняя панель — NavigationBar c темой из main.dart
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Главная',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_alt_outlined),
            selectedIcon: Icon(Icons.list_alt),
            label: 'Привычки',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle),
            label: 'Добавить',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights),
            label: 'Прогресс',
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outline),
            selectedIcon: Icon(Icons.info),
            label: 'Справка',
          ),
        ],
      ),
    );
  }
}

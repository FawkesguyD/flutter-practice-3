enum HabitFrequency { daily, weekly }

class Habit {
  final int id;
  String title;
  String? description;
  HabitFrequency frequency;
  int targetPerPeriod; // цель за период (день/неделя)
  int doneThisPeriod;

  Habit({
    required this.id,
    required this.title,
    this.description,
    this.frequency = HabitFrequency.daily,
    this.targetPerPeriod = 1,
    this.doneThisPeriod = 0,
  });

  bool get isCompleted => doneThisPeriod >= targetPerPeriod;

  String get frequencyLabel =>
      frequency == HabitFrequency.daily ? 'Ежедневно' : 'Еженедельно';
}

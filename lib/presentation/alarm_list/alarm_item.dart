class AlarmItem {
  final int id;
  final String time;
  final AlarmType type;
  final String? name;

  AlarmItem({
    required this.id,
    required this.time,
    required this.type,
    this.name,
  });
}

enum AlarmType {
  regular,
  dailyRecurring,
}

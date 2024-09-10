class AlarmSet {
  final int id;
  final List<int> alarmIds;

  AlarmSet({
    required this.id,
    required this.alarmIds,
  });

  factory AlarmSet.fromJson(Map<String, dynamic> json) => AlarmSet(
      id: json['id'], alarmIds: List<int>.from(json['alarmIds'] ?? []));

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'alarmIds': alarmIds,
    };
  }
}

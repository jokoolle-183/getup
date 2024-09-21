sealed class AlarmItem {
  final int id;
  final String? name;

  AlarmItem._({required this.id, this.name});

  factory AlarmItem.regular(
    int id,
    String? name,
    String time,
  ) = RegularAlarmItem;

  factory AlarmItem.set(
    int id,
    String? name,
    String startTime,
    String endTime,
  ) = AlarmSetItem;
}

class RegularAlarmItem extends AlarmItem {
  RegularAlarmItem(
    this.id,
    this.name,
    this.time,
  ) : super._(id: id, name: name);

  @override
  final int id;
  @override
  final String? name;
  final String time;
}

class AlarmSetItem extends AlarmItem {
  AlarmSetItem(
    this.id,
    this.name,
    this.startTime,
    this.endTime,
  ) : super._(id: id, name: name);

  @override
  final int id;
  @override
  final String? name;
  final String startTime;
  final String endTime;
}

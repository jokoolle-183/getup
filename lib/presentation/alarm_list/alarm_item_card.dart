import 'package:flutter/material.dart';
import 'package:walk_it_up/presentation/alarm_list/alarm_item.dart';

@immutable
class AlarmItemCard extends StatelessWidget {
  const AlarmItemCard({
    required this.alarmItem,
    required this.navigateToEditAlarm,
    super.key,
  });

  final AlarmItem alarmItem;
  final Future<void> Function({AlarmItem? alarmItem}) navigateToEditAlarm;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigateToEditAlarm(alarmItem: alarmItem),
      child: Card(
        child: Builder(builder: (context) {
          switch (alarmItem) {
            case RegularAlarmItem regular:
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(regular.time),
                  Text(regular.name ?? ''),
                ],
              );
            case AlarmSetItem set:
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(set.startTime),
                      Text(set.endTime),
                    ],
                  ),
                  Text(set.name ?? ''),
                ],
              );
          }
        }),
      ),
    );
  }
}

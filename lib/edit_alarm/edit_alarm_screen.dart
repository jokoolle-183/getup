import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:walk_it_up/alarm_list/alarm_item.dart';
import 'package:walk_it_up/edit_alarm/durations.dart';
import 'package:walk_it_up/edit_alarm/edit_alarm_cubit.dart';
import 'package:walk_it_up/edit_alarm/edit_alarm_state.dart';

class EditAlarmScreen extends StatelessWidget {
  const EditAlarmScreen({super.key});
  static const routeName = '/edit-alarm';

  @override
  Widget build(BuildContext context) {
    final AlarmItem? alarmItem =
        ModalRoute.of(context)!.settings.arguments as AlarmItem?;
    return BlocProvider(
      create: (_) => EditAlarmCubit(
        alarmId: alarmItem?.id,
      ),
      child: BlocBuilder<EditAlarmCubit, EditAlarmState>(
        builder: (context, state) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(
              left: 24.0,
              right: 24.0,
              top: 48.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(24.0),
                Text("Alarm id: ${state.alarmId}"),
                const Gap(16.0),
                const Text('Focus duration'),
                const Gap(16.0),
                SegmentedButton<FocusDuration>(
                  showSelectedIcon: false,
                  style: const ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity(horizontal: 0, vertical: -1),
                  ),
                  segments: [
                    for (final dur in FocusDuration.values)
                      ButtonSegment(
                        value: dur,
                        label: Text('${dur.duration} min'),
                      ),
                  ],
                  selected: {state.focusDuration},
                  onSelectionChanged: (Set<FocusDuration> durations) {
                    if (durations.firstOrNull != null) {
                      context
                          .read<EditAlarmCubit>()
                          .selectFocusDuration(durations.first);
                    }
                  },
                ),
                const Gap(24.0),
                const Text('Time frame'),
                Row(
                  children: [
                    const Text('From: '),
                    ActionChip(
                      label: Text(state.fromTimeOfDay.format(context)),
                      onPressed: () async {
                        final TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: state.fromTimeOfDay,
                          initialEntryMode: TimePickerEntryMode.dial,
                        );
                        if (time != null && context.mounted) {
                          context
                              .read<EditAlarmCubit>()
                              .selectFromTimeOfDay(time);
                        }
                      },
                    ),
                    const Text(' To: '),
                    ActionChip(
                        label: Text(state.toTimeOfDay.format(context)),
                        onPressed: () async {
                          final TimeOfDay? time = await showTimePicker(
                            context: context,
                            initialTime: state.toTimeOfDay,
                            initialEntryMode: TimePickerEntryMode.dial,
                          );
                          if (time != null && context.mounted) {
                            context
                                .read<EditAlarmCubit>()
                                .selectToTimeOfDay(time);
                          }
                        }),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    context.read<EditAlarmCubit>().setAlarms();
                  },
                  child: const Text('Set alarm'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    context.read<EditAlarmCubit>().stopAllAlarms();
                  },
                  child: const Text('Stop all alarms'),
                ),
                if (state.nextAlarm != null)
                  Text(
                      'Alarm ${state.nextAlarm!.id} at ${state.nextAlarm!.dateTime}')
              ],
            ),
          ),
        ),
      ),
    );
  }
}

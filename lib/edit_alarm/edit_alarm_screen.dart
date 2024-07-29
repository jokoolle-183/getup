import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:getup/edit_alarm/durations.dart';
import 'package:getup/edit_alarm/edit_alarm_cubit.dart';
import 'package:getup/edit_alarm/edit_alarm_state.dart';

class EditAlarmScreen extends StatelessWidget {
  const EditAlarmScreen({super.key});
  static const routeName = '/edit-alarm';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditAlarmCubit(),
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
                const Text('Break duration'),
                const Gap(16.0),
                SegmentedButton<BreakDuration>(
                  showSelectedIcon: false,
                  style: const ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity(horizontal: -1, vertical: -1),
                  ),
                  segments: [
                    ButtonSegment(
                        value: BreakDuration.five,
                        label: Text('${BreakDuration.five.duration} min')),
                    ButtonSegment(
                        value: BreakDuration.ten,
                        label: Text('${BreakDuration.ten.duration} min')),
                    ButtonSegment(
                        value: BreakDuration.fifteen,
                        label: Text('${BreakDuration.fifteen.duration} min')),
                  ],
                  selected: {state.breakDuration},
                  onSelectionChanged: (Set<BreakDuration> durations) {
                    if (durations.firstOrNull != null) {
                      context
                          .read<EditAlarmCubit>()
                          .selectBreakDuration(durations.first);
                    }
                  },
                ),
                const Gap(24.0),
                const Text('Time frame'),
                Row(
                  children: [
                    const Text('From: '),
                    ActionChip(
                      label: Text(TimeOfDay.fromDateTime(state.fromDate)
                          .format(context)),
                      onPressed: () async {
                        final TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(state.fromDate),
                          initialEntryMode: TimePickerEntryMode.dial,
                        );
                        if (time != null && context.mounted) {
                          context
                              .read<EditAlarmCubit>()
                              .selectFromDate(convertTimeOfDayToDateTime(time));
                        }
                      },
                    ),
                    const Text(' To: '),
                    ActionChip(
                        label: Text(TimeOfDay.fromDateTime(state.toDate)
                            .format(context)),
                        onPressed: () async {
                          final TimeOfDay? time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(state.toDate),
                            initialEntryMode: TimePickerEntryMode.dial,
                          );
                          if (time != null && context.mounted) {
                            context
                                .read<EditAlarmCubit>()
                                .selectToDate(convertTimeOfDayToDateTime(time));
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

DateTime convertTimeOfDayToDateTime(TimeOfDay timeOfDay, [DateTime? date]) {
  final currentDate = date ?? DateTime.now();
  return DateTime(currentDate.year, currentDate.month, currentDate.day,
      timeOfDay.hour, timeOfDay.minute);
}

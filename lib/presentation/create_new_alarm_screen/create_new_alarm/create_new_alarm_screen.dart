import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:walk_it_up/main.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/alarm_type/alarm_type.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/alarm_type/alarm_type_dialog.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/create_new_alarm/create_new_alarm_cubit.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/create_new_alarm/create_new_alarm_state.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/day_picker/day_picker.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/pair.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/snooze_duration_dialog.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/time_pickers/time_picker_cubit.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/time_pickers/time_picker_factory.dart';

class CreateNewAlarmScreen extends StatelessWidget {
  const CreateNewAlarmScreen({super.key});

  static const route = '/create-new-alarm';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CreateNewAlarmCubit>(
          create: (BuildContext context) => CreateNewAlarmCubit(
            timeStore: getIt.get(),
            alarmSetRepository: getIt.get(),
            alarmScheduler: getIt.get(),
          ),
        ),
        BlocProvider(create: (context) => TimePickerCubit(getIt.get())),
      ],
      child: BlocBuilder<CreateNewAlarmCubit, CreateNewAlarmState>(
        builder: (context, state) => Scaffold(
          backgroundColor: Colors.white,
          body: LayoutBuilder(builder: (context, constraints) {
            return Stack(children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Gap(50),
                    TimePickerFactory.getPicker(
                      state.type,
                      context.read<TimePickerCubit>(),
                    ).buildPicker(),
                    const Gap(24),
                    DayPicker(
                      selectedDays: state.daysOfWeek,
                      selectedTime: state.selectedTime,
                      onSelected:
                          context.read<CreateNewAlarmCubit>().onDaySelected,
                    ),
                    const Gap(16),
                    InkWell(
                      onTap: () => openAlarmTypeDialog(
                        context,
                        state,
                        context.read<CreateNewAlarmCubit>().onTypeChanged,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Gap(16.0),
                            const Expanded(
                                child: Text(
                              'Type',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                            Text(state.type.typeName,
                                style: const TextStyle(
                                  fontSize: 16,
                                )),
                            const Gap(4.0),
                            const Icon(Icons.chevron_right_outlined),
                            const Gap(16.0),
                          ],
                        ),
                      ),
                    ),
                    if (state.type == AlarmType.recurringDaily)
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Gap(16.0),
                              const Expanded(
                                  child: Text(
                                'Interval',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                              Text(
                                state.intervalBetweenAlarms?.toString() ??
                                    'N/A',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const Gap(4.0),
                              const Icon(Icons.chevron_right_outlined),
                              const Gap(16.0),
                            ],
                          ),
                        ),
                      ),
                    InkWell(
                      onTap: () => {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Gap(16.0),
                            const Expanded(
                                child: Text(
                              'Sound',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                            Text(
                              state.soundPath.substring(
                                state.soundPath.indexOf('/') + 1,
                                state.soundPath.indexOf('.'),
                              ),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const Gap(4.0),
                            const Icon(Icons.chevron_right_outlined),
                            const Gap(16.0),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => openSnoozeDurationDialog(
                        context,
                        state,
                        context
                            .read<CreateNewAlarmCubit>()
                            .onSnoozeSettingsChanged,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Gap(16.0),
                            const Expanded(
                                child: Text(
                              'Snooze',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                            Text(
                              state.isSnoozeEnabled
                                  ? '${state.snoozeDuration} min'
                                  : 'Off',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const Gap(4.0),
                            const Gap(4.0),
                            const Icon(Icons.chevron_right_outlined),
                            const Gap(16.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 24.0),
                  child: FilledButton(
                    style: ButtonStyle(
                      fixedSize: WidgetStatePropertyAll(
                        Size(
                          constraints.maxWidth,
                          50,
                        ),
                      ),
                      backgroundColor:
                          const WidgetStatePropertyAll(Colors.black),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await context.read<CreateNewAlarmCubit>().scheduleAlarm();
                      if (context.mounted) Navigator.of(context).pop();
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ]);
          }),
        ),
      ),
    );
  }

  Future<void> openAlarmTypeDialog(
    BuildContext context,
    CreateNewAlarmState state,
    void Function(AlarmType) onTypeChanged,
  ) async {
    AlarmType type = await showDialog(
      context: context,
      builder: (context) => AlarmTypeDialog(selectedType: state.type),
    );
    onTypeChanged(type);
  }

  Future<void> openSnoozeDurationDialog(
    BuildContext context,
    CreateNewAlarmState state,
    void Function(Pair<bool, int>) onSnoozeSettingsChanged,
  ) async {
    final Pair<bool, int> result = await showDialog(
      context: context,
      builder: (context) => SnoozeDurationDialog(
        selectedDuration: state.snoozeDuration,
        isSnoozeEnabled: state.isSnoozeEnabled,
      ),
    );
    onSnoozeSettingsChanged(result);
  }
}

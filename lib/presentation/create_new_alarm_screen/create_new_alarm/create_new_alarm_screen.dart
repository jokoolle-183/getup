import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:walk_it_up/main.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/alarm_type/alarm_type.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/alarm_type/alarm_type_dialog.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/create_new_alarm/create_new_alarm_cubit.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/create_new_alarm/create_new_alarm_state.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/day_picker/day_picker.dart';
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
            alarmSetRepository: getIt.get(),
            regularAlarmRepository: getIt.get(),
          ),
        ),
        BlocProvider(create: (context) => TimePickerCubit()),
      ],
      child: BlocBuilder<CreateNewAlarmCubit, CreateNewAlarmState>(
        builder: (context, state) => Scaffold(
          backgroundColor: Colors.white,
          body: LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                const Gap(50),
                TimePickerFactory.getPicker(
                  state.type,
                  context.read<TimePickerCubit>(),
                ).buildPicker(),
                DayPicker(
                  selectedDays: state.daysOfWeek,
                  onSelected: context.read<CreateNewAlarmCubit>().onDaySelected,
                ),
                InkWell(
                  onTap: () => openDialog(
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
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Future<void> openDialog(
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
}

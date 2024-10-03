import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:walk_it_up/main.dart';
import 'package:walk_it_up/presentation/create_new_alarm/alarm_type.dart';
import 'package:walk_it_up/presentation/create_new_alarm/alarm_type_dialog.dart';
import 'package:walk_it_up/presentation/create_new_alarm/create_new_alarm_cubit.dart';
import 'package:walk_it_up/presentation/create_new_alarm/create_new_alarm_state.dart';
import 'package:walk_it_up/presentation/create_new_alarm/recurring_picker.dart';
import 'package:walk_it_up/presentation/create_new_alarm/time_picker.dart';
import 'package:walk_it_up/presentation/create_new_alarm/time_wheel_picker.dart';

class CreateNewAlarmScreen extends StatelessWidget {
  const CreateNewAlarmScreen({super.key});

  static const route = '/create-new-alarm';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateNewAlarmCubit(
        alarmSetRepository: getIt.get(),
        regularAlarmRepository: getIt.get(),
      ),
      child: BlocBuilder<CreateNewAlarmCubit, CreateNewAlarmState>(
        builder: (context, state) => Scaffold(
          body: LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                const Gap(50),
                TimePickerFactory.getPicker(state.type).buildPicker(),
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

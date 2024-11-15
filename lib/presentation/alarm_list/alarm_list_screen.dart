import 'dart:async';
import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walk_it_up/data/repository/regular_alarm_repository.dart';
import 'package:walk_it_up/presentation/alarm_list/alarm_item.dart';
import 'package:walk_it_up/presentation/alarm_list/alarm_item_card.dart';
import 'package:walk_it_up/presentation/alarm_list/alarm_list_cubit.dart';
import 'package:walk_it_up/presentation/alarm_list/alarm_list_state.dart';
import 'package:walk_it_up/data/repository/alarm_set_repository.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/create_new_alarm/create_new_alarm_screen.dart';
import 'package:walk_it_up/presentation/edit_alarm/edit_alarm_screen.dart';
import 'package:walk_it_up/main.dart';
import 'package:walk_it_up/presentation/ring_alarm/ring_alarm_screen.dart';

StreamSubscription<AlarmSettings>? ringStream;

class AlarmListScreen extends StatefulWidget {
  static const routeName = '/alarm-list';
  const AlarmListScreen({super.key});

  @override
  State<AlarmListScreen> createState() => _AlarmListScreenState();
}

class _AlarmListScreenState extends State<AlarmListScreen> {
  @override
  void initState() {
    super.initState();

    ringStream ??= Alarm.ringStream.stream.listen((AlarmSettings data) {
      navigateToRingScreen(data);
    });
  }

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.pushNamed(
      context,
      RingAlarmScreen.routeName,
      arguments: alarmSettings,
    );
  }

  @override
  void dispose() {
    ringStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AlarmListCubit(
        getIt.get<AlarmSetRepository>(),
        getIt.get<RegularAlarmRepository>(),
      ),
      child: BlocBuilder<AlarmListCubit, AlarmListState>(
        builder: (context, state) => Scaffold(
          body: Scaffold(
            body: Builder(
              builder: (context) {
                if (state.alarmItems.isEmpty) {
                  return const Center(
                    child: Text('No alarms have been set.'),
                  );
                } else {
                  return ListView.builder(
                      itemCount: state.alarmItems.length,
                      itemBuilder: (context, i) => AlarmItemCard(
                            alarmItem: state.alarmItems[i],
                            navigateToEditAlarm: navigateToEditAlarm,
                          ));
                }
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => navigateToCreateNewAlarm(context)),
        ),
      ),
    );
  }

  Future<void> navigateToEditAlarm({AlarmItem? alarmItem}) async {
    await Navigator.pushNamed(
      context,
      EditAlarmScreen.routeName,
      arguments: alarmItem,
    );
  }

  Future<void> navigateToCreateNewAlarm(BuildContext context) async {
    await Navigator.pushNamed(context, CreateNewAlarmScreen.route)
        .then((shouldRefresh) {
      context.read<AlarmListCubit>().loadAlarms();
    });
  }
}

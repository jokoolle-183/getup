import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:walk_it_up/debouncer.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/pair.dart';

class SnoozeDurationDialog extends StatefulWidget {
  SnoozeDurationDialog({
    this.selectedDuration,
    this.isSnoozeEnabled,
    super.key,
  });

  int? selectedDuration;
  bool? isSnoozeEnabled;

  @override
  State<SnoozeDurationDialog> createState() => _SnoozeDurationDialogState();
}

class _SnoozeDurationDialogState extends State<SnoozeDurationDialog> {
  final Debouncer _debouncer =
      Debouncer(delay: const Duration(milliseconds: 300));
  late FixedExtentScrollController _controller;
  late bool isSnoozeEnabled = widget.isSnoozeEnabled ?? false;
  late int selectedDuration = widget.selectedDuration ?? 1;
  @override
  void initState() {
    super.initState();
    final initialItemIndex =
        getMinuteStrings().indexOf(selectedDuration.toString());
    _controller = FixedExtentScrollController(initialItem: initialItemIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _debouncer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Snooze',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                isSnoozeEnabled = !isSnoozeEnabled;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Gap(16.0),
                  Expanded(
                      child: Text(
                    isSnoozeEnabled ? 'On' : 'Off',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                  Switch.adaptive(
                    value: isSnoozeEnabled,
                    onChanged: (value) {
                      setState(() {
                        isSnoozeEnabled = value;
                      });
                    },
                  ),
                  const Gap(16.0),
                ],
              ),
            ),
          ),
          if (isSnoozeEnabled)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: const Color.fromARGB(255, 211, 222, 227),
                        ),
                        width: 80,
                        height: 32,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 50,
                      height: 140,
                      child: ListWheelScrollView(
                        physics: const FixedExtentScrollPhysics(),
                        itemExtent: 30,
                        controller: _controller,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        overAndUnderCenterOpacity: 0.5,
                        onSelectedItemChanged: (index) {
                          _debouncer.call(() {
                            setState(() {
                              selectedDuration =
                                  int.parse(getMinuteStrings()[index]);
                            });
                          });
                        },
                        children: [
                          ...getMinuteStrings().map((e) => Align(
                                alignment: Alignment.center,
                                child: Text(
                                  e,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
      actions: [
        Align(
          alignment: Alignment.bottomRight,
          child: FilledButton(
            style: ButtonStyle(
              fixedSize: const WidgetStatePropertyAll(
                Size(
                  72,
                  36,
                ),
              ),
              backgroundColor: const WidgetStatePropertyAll(Colors.black),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(
              Pair(
                isSnoozeEnabled,
                selectedDuration,
              ),
            ),
            child: const Text(
              'OK',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  List<String> getMinuteStrings() {
    List<String> minuteList = [];

    // Loop through minutes from 1 to 60
    for (int minute = 1; minute <= 60; minute++) {
      // Format the minute as a two-digit string
      minuteList.add(minute.toString());
    }

    return minuteList;
  }
}

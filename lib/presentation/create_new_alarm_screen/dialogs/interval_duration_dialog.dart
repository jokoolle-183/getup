import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

@immutable
class IntervalDurationDialog extends StatefulWidget {
  const IntervalDurationDialog({required this.duration, super.key});
  final int duration;

  @override
  State<IntervalDurationDialog> createState() => _IntervalDurationDialogState();
}

class _IntervalDurationDialogState extends State<IntervalDurationDialog> {
  late int selectedDuration = widget.duration;
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
              'Interval between alarms',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                children: [],
              )),
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
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'OK',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

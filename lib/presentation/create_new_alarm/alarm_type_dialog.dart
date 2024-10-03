import 'package:flutter/material.dart';
import 'package:walk_it_up/presentation/create_new_alarm/alarm_type.dart';

class AlarmTypeDialog extends StatefulWidget {
  AlarmTypeDialog({
    required this.selectedType,
    super.key,
  });

  AlarmType? selectedType;

  @override
  State<AlarmTypeDialog> createState() => _AlarmTypeDialogState();
}

class _AlarmTypeDialogState extends State<AlarmTypeDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(AlarmType.regular.typeName),
            leading: Radio<AlarmType>.adaptive(
              value: AlarmType.regular,
              groupValue: widget.selectedType,
              onChanged: (AlarmType? value) {
                setState(() {
                  widget.selectedType = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text(AlarmType.recurringDaily.typeName),
            leading: Radio<AlarmType>.adaptive(
                value: AlarmType.recurringDaily,
                groupValue: widget.selectedType,
                onChanged: (AlarmType? value) {
                  setState(() {
                    widget.selectedType = value;
                  });
                }),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(widget.selectedType),
          child: const Text('Ok'),
        )
      ],
    );
  }
}

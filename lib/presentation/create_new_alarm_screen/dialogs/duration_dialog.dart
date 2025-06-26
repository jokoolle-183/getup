import 'package:flutter/material.dart';

@immutable
class DurationDialog extends StatefulWidget {
  const DurationDialog({required this.title, required this.duration, super.key});
  final String title;
  final int duration;

  @override
  State<DurationDialog> createState() => _DurationDialogState();
}

class _DurationDialogState extends State<DurationDialog> {
  late String title = widget.title;
  late int selectedDuration = widget.duration;

  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.duration.toString());
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        isDense: true,
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24),
                      onChanged: (value) {
                        setState(() {
                          selectedDuration = int.tryParse(value) ?? widget.duration;
                        });
                      },
                    ),
                  ),
                  const Text(
                    'minutes',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
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
            onPressed: () => Navigator.of(context).pop(selectedDuration),
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

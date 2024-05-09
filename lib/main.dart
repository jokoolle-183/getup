import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:getup/setup_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SetupModel())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TimeOfDay selectedFromTime =
      TimeOfDay.fromDateTime(DateTime.now().copyWith(hour: 9, minute: 0));
  TimeOfDay selectedToTime =
      TimeOfDay.fromDateTime(DateTime.now().copyWith(hour: 17, minute: 0));

  Set<FocusDuration> focusDurations = <FocusDuration>{
    FocusDuration.thirty,
  };
  Set<BreakDuration> breakDurations = <BreakDuration>{
    BreakDuration.five,
  };

  @override
  void initState() {
    super.initState();
    // _checkPermissions();
  }

  int selectedValue = 0;
  var list = List.generate(60, (index) => index + 1);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  ButtonSegment(
                      value: FocusDuration.thirty,
                      label: Text('${FocusDuration.thirty.duration} min')),
                  ButtonSegment(
                      value: FocusDuration.fortyFive,
                      label: Text('${FocusDuration.fortyFive.duration} min')),
                  ButtonSegment(
                      value: FocusDuration.sixty,
                      label: Text('${FocusDuration.sixty.duration} min')),
                ],
                selected: focusDurations,
                onSelectionChanged: (Set<FocusDuration> durations) {
                  setState(() {
                    focusDurations = durations;
                  });
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
                selected: breakDurations,
                onSelectionChanged: (Set<BreakDuration> durations) {
                  setState(() {
                    breakDurations = durations;
                  });
                },
              ),
              const Gap(24.0),
              const Text('Time frame'),
              Row(
                children: [
                  const Text('From: '),
                  ActionChip(
                    label: Text(selectedFromTime.format(context)),
                    onPressed: () async {
                      final TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: selectedFromTime,
                        initialEntryMode: TimePickerEntryMode.dial,
                      );
                      setState(() {
                        if (time != null) {
                          selectedFromTime = time;
                        }
                      });
                    },
                  ),
                  const Text(' To: '),
                  ActionChip(
                      label: Text(selectedToTime.format(context)),
                      onPressed: () async {
                        final TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: selectedToTime,
                          initialEntryMode: TimePickerEntryMode.dial,
                        );
                        setState(() {
                          if (time != null) {
                            selectedToTime = time;
                          }
                        });
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum FocusDuration {
  thirty(30),
  fortyFive(45),
  sixty(60);

  const FocusDuration(this.duration);

  final int duration;
}

enum BreakDuration {
  five(5),
  ten(10),
  fifteen(15);

  const BreakDuration(this.duration);

  final int duration;
}

var hoursList = [
  "00",
  "01",
  "02",
  "03",
  "04",
  "05",
  "06",
  "07",
  "08",
  "09",
  "10",
  "11",
  "12",
  "13",
  "14",
  "15",
  "16",
  "17",
  "18",
  "19",
  "20",
  "21",
  "22",
  "23",
];

var minutesList = [
  "00",
  "01",
  "02",
  "03",
  "04",
  "05",
  "06",
  "07",
  "08",
  "09",
  "10",
  "11",
  "12",
  "13",
  "14",
  "15",
  "16",
  "17",
  "18",
  "19",
  "20",
  "21",
  "22",
  "23",
  "24",
  "25",
  "26",
  "27",
  "28",
  "29",
  "30",
  "31",
  "32",
  "33",
  "34",
  "35",
  "36",
  "37",
  "38",
  "39",
  "40",
  "41",
  "42",
  "43",
  "44",
  "45",
  "46",
  "47",
  "48",
  "49",
  "50",
  "51",
  "52",
  "53",
  "54",
  "55",
  "56",
  "57",
  "58",
  "59"
];

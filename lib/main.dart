import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
            top: 200.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(24.0),
              Row(
                children: [
                  const Text(
                    'Get up',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(36),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Every',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 36,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(126, 185, 201, 214),
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: ListWheelScrollView.useDelegate(
                              physics: const FixedExtentScrollPhysics(),
                              itemExtent: 36,
                              perspective: 0.005,
                              onSelectedItemChanged: (value) =>
                                  {setState(() => selectedValue = value)},
                              childDelegate: ListWheelChildLoopingListDelegate(
                                children: List<Widget>.generate(
                                  list.length,
                                  (index) {
                                    double distance =
                                        (selectedValue - index).abs() > 1
                                            ? 1.0
                                            : (selectedValue - index)
                                                .toDouble();

                                    double scale = 1.0 - (0.1 * distance.abs());

                                    return TweenAnimationBuilder<double>(
                                      tween:
                                          Tween<double>(begin: 0.5, end: scale),
                                      duration:
                                          const Duration(milliseconds: 100),
                                      builder: (context, value, child) {
                                        return Transform.scale(
                                          scale: value,
                                          child: Opacity(
                                            opacity: value,
                                            child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                  '${index + 1}',
                                                )),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        'minutes',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(36),
              Row(
                children: [
                  const Text(
                    'Take a break',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gap(36),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'For',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 36,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(126, 185, 201, 214),
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: ListWheelScrollView.useDelegate(
                              physics: const FixedExtentScrollPhysics(),
                              itemExtent: 36,
                              perspective: 0.005,
                              onSelectedItemChanged: (value) =>
                                  {setState(() => selectedValue = value)},
                              childDelegate: ListWheelChildLoopingListDelegate(
                                children: List<Widget>.generate(
                                  list.length,
                                  (index) {
                                    double distance =
                                        (selectedValue - index).abs() > 1
                                            ? 1.0
                                            : (selectedValue - index)
                                                .toDouble();

                                    double scale = 1.0 - (0.1 * distance.abs());

                                    return TweenAnimationBuilder<double>(
                                      tween:
                                          Tween<double>(begin: 0.5, end: scale),
                                      duration:
                                          const Duration(milliseconds: 100),
                                      builder: (context, value, child) {
                                        return Transform.scale(
                                          scale: value,
                                          child: Opacity(
                                            opacity: value,
                                            child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                  '${index + 1}',
                                                )),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        'minutes',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(36),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Text(
                          'From',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Gap(16),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 40,
                              child: ListWheelScrollView.useDelegate(
                                  physics: const FixedExtentScrollPhysics(),
                                  itemExtent: 36,
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: hoursList.length,
                                    builder: (context, index) => Text(
                                      hoursList[index].toString(),
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  )),
                            ),
                            const Text(
                              ':',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              width: 40,
                              child: ListWheelScrollView.useDelegate(
                                  physics: const FixedExtentScrollPhysics(),
                                  itemExtent: 36,
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: minutesList.length,
                                    builder: (context, index) => Text(
                                      minutesList[index].toString(),
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const Text(
                          'To',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Gap(16),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 40,
                              child: ListWheelScrollView.useDelegate(
                                  physics: const FixedExtentScrollPhysics(),
                                  itemExtent: 36,
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: hoursList.length,
                                    builder: (context, index) => Text(
                                      hoursList[index].toString(),
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  )),
                            ),
                            const Text(
                              ':',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              width: 40,
                              child: ListWheelScrollView.useDelegate(
                                  physics: const FixedExtentScrollPhysics(),
                                  itemExtent: 36,
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: minutesList.length,
                                    builder: (context, index) => Text(
                                      minutesList[index].toString(),
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
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

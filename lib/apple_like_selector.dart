// Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           Container(
//                             width: 100,
//                             height: 36,
//                             decoration: const BoxDecoration(
//                               color: Color.fromARGB(126, 185, 201, 214),
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(12.0),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 100,
//                             width: 100,
//                             child: ListWheelScrollView.useDelegate(
//                               physics: const FixedExtentScrollPhysics(),
//                               itemExtent: 36,
//                               perspective: 0.005,
//                               onSelectedItemChanged: (value) =>
//                                   {setState(() => selectedValue = value)},
//                               childDelegate: ListWheelChildLoopingListDelegate(
//                                 children: List<Widget>.generate(
//                                   list.length,
//                                   (index) {
//                                     double distance =
//                                         (selectedValue - index).abs() > 1
//                                             ? 1.0
//                                             : (selectedValue - index)
//                                                 .toDouble();

//                                     double scale = 1.0 - (0.1 * distance.abs());

//                                     return TweenAnimationBuilder<double>(
//                                       tween:
//                                           Tween<double>(begin: 0.5, end: scale),
//                                       duration:
//                                           const Duration(milliseconds: 100),
//                                       builder: (context, value, child) {
//                                         return Transform.scale(
//                                           scale: value,
//                                           child: Opacity(
//                                             opacity: value,
//                                             child: Container(
//                                                 alignment: Alignment.center,
//                                                 child: Text(
//                                                   style: const TextStyle(
//                                                     fontSize: 24,
//                                                     fontWeight: FontWeight.w300,
//                                                   ),
//                                                   '${index + 1}',
//                                                 )),
//                                           ),
//                                         );
//                                       },
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
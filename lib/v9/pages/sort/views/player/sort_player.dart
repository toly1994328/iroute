import 'package:flutter/material.dart';

import '../../provider/state.dart';
import 'data_painter.dart';

class SortPlayer extends StatelessWidget {
  const SortPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    SortState state = SortStateScope.of(context);
    List<int> numbers = state.data;
    MaterialColor color = kColorSupport[state.config.colorIndex];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CustomPaint(
        painter: DataPainter(data: numbers,color: color),
        child: ConstrainedBox(constraints: const BoxConstraints.expand()),
      ),
    );
  }
}


import 'package:flutter/material.dart';

import '../provider/state.dart';
import 'data_painter.dart';

class SortPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    SortState state = SortStateScope.of(context);
    List<int> numbers = state.data;

    return Scaffold(
      body: CustomPaint(
        painter: DataPainter(data: numbers),
        child: ConstrainedBox(constraints: BoxConstraints.expand()),
      ),
    );
  }
}


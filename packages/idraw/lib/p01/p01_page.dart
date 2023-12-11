import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/events.dart';
import 'package:idraw/components/demo_shower.dart';
import 's01_page.dart' as s1;
import 's02_page.dart' as s2;

class P01Page extends StatelessWidget {
  const P01Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const DemoShower(
      demos: [
        s1.Paper(),
        s2.Paper(),
      ],
    );
  }
}

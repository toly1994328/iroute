import 'package:flutter/material.dart';

import 'package:idraw/components/demo_shower.dart';
import 's01.dart' as s1;
import 's02.dart' as s2;
import 's03.dart' as s3;
import 's04.dart' as s4;
import 's05.dart' as s5;
import 's06.dart' as s6;

class P07Page extends StatelessWidget {
  const P07Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const DemoShower(
      demos:  [
        s1.Paper(),
        s2.Paper(),
        s3.Paper(),
        s4.Paper(),
        s5.Paper(),
        s6.Paper(),
      ],
    );
  }
}

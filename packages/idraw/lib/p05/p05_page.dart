import 'package:flutter/material.dart';

import 'package:idraw/components/demo_shower.dart';
import 's01.dart' as s1;
import 's02.dart' as s2;
import 's03.dart' as s3;
import 's04.dart' as s4;
import 's05.dart' as s5;
import 's06.dart' as s6;
import 's07.dart' as s7;
import 's08.dart' as s8;
import 's09.dart' as s9;
import 's10.dart' as s10;
import 's11.dart' as s11;


class P05Page extends StatelessWidget {
  const P05Page({super.key});

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
        s7.Paper(),
        s8.Paper(),
        s9.Paper(),
        s10.Paper(),
        s11.Paper(),
      ],
    );
  }
}

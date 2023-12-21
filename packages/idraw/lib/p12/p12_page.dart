import 'package:flutter/material.dart';

import 'package:components/components.dart';
import 's01.dart' as s1;
import 's02.dart' as s2;
import 's03.dart' as s3;
import 's04.dart' as s4;

class P12Page extends StatelessWidget {
  const P12Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const DemoShower(
      srcCodeDir: 'draw/p12',

      demos:  [
        s1.Paper(),
        s2.Paper(),
        s3.Paper(),
        s4.Paper(),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'package:components/components.dart';
import 's01.dart' as s1;
import 's02.dart' as s2;

class P20Page extends StatelessWidget {
  const P20Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const DemoShower(
      srcCodeDir: 'draw/p20',

      demos:  [
        s1.Paper(),
        s2.Paper(),
      ],
    );
  }
}

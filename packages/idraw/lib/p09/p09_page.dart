import 'package:flutter/material.dart';

import 'package:components/components.dart';
import 's01.dart' as s1;
import 's02.dart' as s2;
import 's03.dart' as s3;

class P09Page extends StatelessWidget {
  const P09Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const DemoShower(
      srcCodeDir: 'draw/p09',

      demos:  [
        s1.Paper(),
        s2.Paper(),
        s3.Paper(),
      ],
    );
  }
}

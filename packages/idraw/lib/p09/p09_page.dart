import 'package:flutter/material.dart';

import 'package:idraw/components/demo_shower.dart';
import 's01.dart' as s1;
import 's02.dart' as s2;
import 's03.dart' as s3;

class P09Page extends StatelessWidget {
  const P09Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const DemoShower(
      demos:  [
        s1.Paper(),
        s2.Paper(),
        s3.Paper(),
      ],
    );
  }
}

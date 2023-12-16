import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 's01.dart' as s1;
import 's02.dart' as s2;

class P01Page extends StatelessWidget {
  const P01Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const DemoShower(
      srcCodeDir: 'draw/p01',
      demos: [
        s1.Paper(),
        s2.Paper(),
      ],
    );
  }
}

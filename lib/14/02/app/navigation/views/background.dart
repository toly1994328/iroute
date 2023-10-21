import 'dart:math';

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient:
              LinearGradient(transform: GradientRotation(pi / 2), colors: [
        Color(0xffF1EFF1),
        Color(0xffFFFFFF),
      ])),
    );
  }
}

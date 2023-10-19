import 'package:flutter/material.dart';

import '../main.dart';

class PageC extends StatelessWidget {
  const PageC({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xffFFE6CC);

    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          title: const Text('C 界面'),
          backgroundColor: bgColor,
        ),
        body: Center(
          child: Text('到达终点'),
        ));
  }

}

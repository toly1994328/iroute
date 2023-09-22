import 'package:flutter/material.dart';
import 'package:iroute/06/02/pages/page_a.dart';

class PageD extends StatelessWidget {
  const PageD({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xffFFCCFF);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('D'),
        backgroundColor: bgColor,
      ),
      body:  Center(
        child: const Text('到达终点'),
      ),
    );
  }
}

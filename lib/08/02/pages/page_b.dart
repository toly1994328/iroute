import 'package:flutter/material.dart';

import 'page_c.dart';

class PageB extends StatelessWidget {
  const PageB({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xffCCE5FF);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(title: const Text('B',),
        backgroundColor: bgColor,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: ()=>toPageC(context),
          child: const Text('Push C'),
        ),
      ),
    );
  }

  void toPageC(BuildContext context){
    Navigator.of(context).pushNamed('/c');
  }
}
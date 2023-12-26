
import 'package:flutter/material.dart';

import 'app/app_navigation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xffCCFFCC);

    return Scaffold(
      backgroundColor: bgColor,
        appBar: AppBar(
          title: const Text('主页起点'),
          backgroundColor: bgColor,
        ),
      body: Center(child: ElevatedButton(
        onPressed: () => toPageA(context),
        child: const Text('Push A'),
      ),
    ));
  }

  void toPageA(BuildContext context) {
    router.value = ['/', 'a'];
  }
}

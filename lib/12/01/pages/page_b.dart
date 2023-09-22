import 'package:flutter/material.dart';

import 'app/app_navigation.dart';


class PageB extends StatelessWidget {
  const PageB({super.key});


  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xffCCE5FF);

    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          title: const Text('B 界面'),
          backgroundColor: bgColor,
          leading: BackButton(
            onPressed: _pop,
          ),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () => toPageC(context),
            child: const Text('Push C'),
          ),
        ));
  }


  void toPageC(BuildContext context){
    router.value = ['/','a','b','c'];
  }

  void _pop() {
    router.value = List.of(router.value)..removeLast();
  }
}
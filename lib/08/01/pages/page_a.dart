import 'package:flutter/material.dart';
import 'page_b.dart';

class PageA extends StatelessWidget {
  const PageA({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xffCCFFFF);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(title: const Text('A'),
        backgroundColor: bgColor,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: ()=>toPageB(context),
          child: const Text('Push B'),
        ),
      ),
    );
  }

  void toPageB(BuildContext context){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> const PageB()));
  }
}

import 'package:flutter/material.dart';
import 'package:iroute/07/01/pages/page_b.dart';

class PageA extends StatelessWidget {
  const PageA({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xffCCFFFF);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(title: Text('A'),
      elevation: 0,
        backgroundColor: bgColor,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: ()=>toPageB(context),
          child: Text('Push B'),
        ),
      ),
    );
  }

  void toPageB(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const PageB()));
  }
}

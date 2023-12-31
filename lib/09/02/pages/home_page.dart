import 'package:flutter/material.dart';
import 'package:iroute/06/02/pages/page_a.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xffFFCCFF);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('起点'),
        backgroundColor: bgColor,
      ),
      body:  Center(
        child: ElevatedButton(
          onPressed: ()=>toPageA(context),
          child: const Text('Push A'),
        ),
      ),
    );
  }

  void toPageA(BuildContext context){
    Navigator.of(context).pushNamed('/a');
  }
}

import 'package:flutter/material.dart';

import 'page_d.dart';

class PageC extends StatelessWidget {
  const PageC({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xffFFE6CD);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('C'),
        backgroundColor: bgColor,
      ),
      body:  Center(
        child: ElevatedButton(
          onPressed: ()=>toPageD(context),
          child: const Text('Push D Remove Until A'),
        ),
      ),
    );
  }

  void toPageD(BuildContext context){
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (BuildContext context) => const PageD()),
      ModalRoute.withName('/a'),
    );
  }
}




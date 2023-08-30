import 'package:flutter/material.dart';

import 'page_c.dart';

class PageB extends StatelessWidget {
  const PageB({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xffCCE5FF);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(title: Text('B',style: TextStyle(color: Colors.black),),
        elevation: 0,
        backgroundColor: bgColor,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: ()=>toPageC(context),
          child: Text('Push C'),
        ),
      ),
    );
  }

  void toPageC(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const PageC()));
  }
}
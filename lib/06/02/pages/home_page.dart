import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xffFFE6CD);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('主页面'),
        backgroundColor: bgColor,
      ),
      body: Center(
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

import 'package:flutter/material.dart';


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
          child: const Text('pop Until A'),
        ),
      ),
    );
  }

  void toPageD(BuildContext context){
    Navigator.of(context).popUntil(
        ModalRoute.withName('/a')
    );
  }
}




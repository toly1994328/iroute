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
        leading: BackButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: const Center(
        child: Text('到达终点'),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PageC extends StatelessWidget {
  const PageC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('C'),),
      body: Center(
        child: Text(
          'C'
        ),
      ),
    );
  }
}

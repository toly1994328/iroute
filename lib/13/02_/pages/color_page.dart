import 'package:flutter/material.dart';

class ColorPage extends StatelessWidget {
  final String title;
  const ColorPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(title)));
  }
}

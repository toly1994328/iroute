import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ColorDetailPage extends StatelessWidget {
  final Color color;
  const ColorDetailPage({super.key, required this.color});

  @override
  Widget build(BuildContext context) {

    const TextStyle style = TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.white
    );
    String text = '# ${color.value.toRadixString(16)}';
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: color,
        child: Text(text ,style: style,),
      ),
    );
  }
}

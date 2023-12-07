import 'package:flutter/material.dart';

class ColorDetailPage extends StatelessWidget {
  final Color color;
  const ColorDetailPage({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
        backgroundColor: color,
        title: Text('颜色详情页'),
      ),
      body: Center(
        child: Text(   '#${color.value.toRadixString(16)}',style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.bold),),
      ),
    );
  }
}


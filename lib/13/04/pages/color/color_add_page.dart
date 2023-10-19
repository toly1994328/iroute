import 'dart:math';

import 'package:flutter/material.dart';

class ColorAddPage extends StatefulWidget {
  const ColorAddPage({super.key});

  @override
  State<ColorAddPage> createState() => _ColorAddPageState();
}

class _ColorAddPageState extends State<ColorAddPage> {
  late Color _color;

  @override
  void initState() {
    super.initState();
    _color = randomColor;
  }

  @override
  Widget build(BuildContext context) {
    String text = '# ${_color.value.toRadixString(16)}';
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('添加颜色'),
      //   actions: [IconButton(onPressed: _selectColor, icon: Icon(Icons.check ))],
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 20),
        child: Row(
          children: [
            Expanded(child: Text(text,style: TextStyle(color: _color,fontSize: 24,letterSpacing: 4),)),
            Container(
              margin: EdgeInsets.only(left: 10),
              width: 40,
              height: 40,
              child: Icon(
                Icons.sell_outlined,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                color: _color,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Random _random = Random();

  Color get randomColor {
    return Color.fromARGB(
      255,
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
  }

  void _selectColor() {
    Navigator.of(context).pop(_color);
  }
}

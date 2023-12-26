import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(right:20,bottom: 20),
        // color: Colors.redAccent,
        child: Row(
            textDirection:TextDirection.rtl,
          children: [
            ElevatedButton(onPressed: (){
              Navigator.of(context).pop(_color);

            }, child: Text('添加')),
            SizedBox(width: 12,),
            OutlinedButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('取消')),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
          ColorPicker(
            colorPickerWidth:200,
            // enableAlpha: false,
            displayThumbColor:true,
            pickerColor: _color,
            paletteType: PaletteType.hueWheel,
            onColorChanged: changeColor,

          ),
        ],
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

  void changeColor(Color value) {
    _color = value;
    setState(() {

    });
  }
}

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
      appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light
          ),
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle:TextStyle(color: Colors.white,fontSize: 18) ,
        backgroundColor: color,
        title: Text('颜色界面',),),
      body: Container(
        alignment: Alignment.center,
        color: color,
        child: Text(text ,style: style,),
      ),
    );
  }
}

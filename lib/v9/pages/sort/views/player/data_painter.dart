import 'package:flutter/material.dart';



class DataPainter extends CustomPainter{

  final List<int> data;
  final MaterialColor color;

  DataPainter( {required this.data,required this.color,});

  @override
  void paint(Canvas canvas, Size size) {
    double itemWidth = size.width/data.length;
    double height = size.height;

    Paint paint = Paint();
    paint.strokeWidth = itemWidth;
    paint.strokeCap = StrokeCap.round;


    for(int i=0;i<data.length;i++){
      int value = data[i];
      if (value < 1000 * .10) {
        paint.color = color.shade50;
      } else if (value < 1000 * .20) {
        paint.color = color.shade100;
      } else if (value < 1000 * .30) {
        paint.color = color.shade200;
      } else if (value < 1000 * .40) {
        paint.color = color.shade300;
      } else if (value < 1000 * .50) {
        paint.color = color.shade400;
      } else if (value < 1000 * .60) {
        paint.color = color.shade500;
      } else if (value < 1000 * .70) {
        paint.color = color.shade600;
      } else if (value < 1000 * .80) {
        paint.color = color.shade700;
      } else if (value < 1000 * .90) {
        paint.color = color.shade800;
      } else {
        paint.color = color.shade900;
      }
      canvas.drawLine(
          Offset(i * itemWidth+itemWidth/2, 0),
          Offset(
            i * itemWidth+itemWidth/2,
            size.height*(value/1000),
          ),
          paint);
    }


  }

  @override
  bool shouldRepaint(covariant DataPainter oldDelegate) {
    return true;
  }

}
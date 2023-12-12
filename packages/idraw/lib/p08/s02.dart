
import 'package:flutter/material.dart';

import 'dart:ui' as ui;

import '../components/coordinate_pro.dart';


/// create by 张风捷特烈 on 2020-03-19
/// contact me by email 1981462002@qq.com
/// 说明: 纸

class Paper extends StatelessWidget {
  const Paper({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  Coordinate coordinate = Coordinate();
  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    drawShaderRadial(canvas);
  }

  void drawShaderRadial(Canvas canvas) {
    var colors = [
      Color(0xFFF60C0C),
      Color(0xFFF3B913),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0DF6EF),
      Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];

    var pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];
    Paint paint =  Paint();
    paint
      ..style = PaintingStyle.fill
      ..color = Colors.blue;

    paint.shader = ui.Gradient.radial(
        Offset(0, 0), 25, colors, pos, TileMode.clamp);
    canvas.drawCircle(
      Offset(0, 0),
      50,
      paint,
    );

    canvas.translate(160, 0);
    paint.shader = ui.Gradient.radial(
        Offset(0, 0), 25, colors, pos, TileMode.repeated);
    canvas.drawCircle(
      Offset(0, 0),
      50,
      paint,
    );

    canvas.translate(-160*2.0, 0);
    paint.shader = ui.Gradient.radial(
        Offset(0, 0), 25, colors, pos, TileMode.mirror);
    canvas.drawCircle(
      Offset(0, 0),
      50,
      paint,
    );

    canvas.translate(0, 120);
    paint.shader = ui.Gradient.radial(Offset(0, 0), 25, colors,
        pos, TileMode.mirror, null, Offset(10, 10), 1);
    canvas.drawCircle(
      Offset.zero,
      50,
      paint,
    );

    canvas.translate(160, 0);
    paint.shader = ui.Gradient.radial(Offset(0, 0), 25, colors,
        pos, TileMode.mirror, null, Offset(-10, -10), 3);
    canvas.drawCircle(
      Offset.zero,
      50,
      paint,
    );


    canvas.translate(160, 0);
    paint.shader = ui.Gradient.radial(Offset(0, 0), 25, colors,
        pos, TileMode.mirror, null, Offset(-10, -10), 0);
    canvas.drawCircle(
      Offset.zero,
      50,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

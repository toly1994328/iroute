import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:ui'as ui;
import '../components/coordinate_pro.dart';

/// create by 张风捷特烈 on 2020/5/1
/// contact me by email 1981462002@qq.com
/// 说明:

class Paper extends StatelessWidget{
  const Paper({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        // 使用CustomPaint
        painter: PaperPainter(),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  final Coordinate coordinate = Coordinate();

  final List<Offset> points = [];

  final double step = 6;
  final double min = -240;
  final double max = 240;

  void initPoints() {
    for (double x = min; x < max; x += step) {
      points.add(Offset(x, f(x)));
    }
    points.add(Offset(max, f(max)));
    points.add(Offset(max, f(max)));
  }

  void initPointsWithPolar() {
    for (double x = min; x < max; x += step) {
      double thta = (pi / 180 * x); // 角度转化为弧度
      var p = f(thta);
      points.add(Offset(p * cos(thta), p * sin(thta)));
    }
  }

  // double f(double x) {
  //   double y = -x * x / 200 + 100;
  //   return y;
  // }

  // double f(double thta) {
  //   double p = 10 * thta;
  //   return p;
  // }

  // double f(double thta) {
  //   double p = 100 * (1-cos(thta));
  //   return p;
  // }

  // double f(double thta) {
  //   double p = 150*sin(5*thta).abs();
  //   return p;
  // }


  double f(double thta) { // 100*(1-4*sinθ)
    double p =  50*(pow(e,cos(thta)) - 2 * cos(4 * thta) +pow(sin(thta / 12), 5));
    return p;
  }


  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);
    // initPoints();
    initPointsWithPolar();
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
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

    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(100, 0), colors, pos,TileMode.mirror);


    Offset p1 = points[0];
    Path path = Path()..moveTo(p1.dx, p1.dy);

    for (var i = 1; i < points.length-1; i++) {
      double xc = (points[i].dx + points[i + 1].dx) / 2;
      double yc = (points[i].dy + points[i + 1].dy) / 2;
      Offset p2 = points[i];
      path.quadraticBezierTo(p2.dx, p2.dy, xc, yc);
    }

    canvas.drawPath(path, paint);

    // canvas.drawPoints(PointMode.points, points, paint..shader=null..strokeWidth=3);
    // canvas.drawPoints(PointMode.polygon, points, paint..shader=null..strokeWidth=1..color=Colors.blue);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

import 'dart:math';

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/11/2
/// contact me by email 1981462002@qq.com
/// 说明:
///

class Paper extends StatefulWidget {
  final Color color;

  const Paper({Key? key, this.color = Colors.lightBlue}) : super(key: key);

  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(100, 100),
        painter: PicManPainter(_controller), // 背景
      ),
    );
  }
}

class PicManPainter extends CustomPainter {
  final Animation<double> repaint; // 角度(与x轴交角 角度制)

  final ColorTween colorTween = ColorTween(begin: Colors.blue, end: Colors.red);
  final Tween<double> angleTween = Tween(begin: 10.0, end: 40.0);

  Paint _paint = Paint();

  PicManPainter(this.repaint)
      : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size); //剪切画布
    final double radius = size.width / 2;
    canvas.translate(radius, size.height / 2);
    _drawHead(canvas, size);
    _drawEye(canvas, radius);
  }

  //绘制头
  void _drawHead(Canvas canvas, Size size) {
    var rect = Rect.fromCenter(
        center: Offset(0, 0), height: size.width, width: size.height);
    double a = angleTween.evaluate(repaint) / 180 * pi;
    canvas.drawArc(rect, a, 2 * pi - a.abs() * 2, true,
        _paint..color = colorTween.evaluate(repaint)??Colors.black);
  }

  //绘制眼睛
  void _drawEye(Canvas canvas, double radius) {
    canvas.drawCircle(Offset(radius * 0.15, -radius * 0.6), radius * 0.12,
        _paint..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant PicManPainter oldDelegate) =>
      oldDelegate.repaint != repaint;
}

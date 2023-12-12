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
        size: Size(100, 100), painter: PicManPainter(_controller), // 背景
      ),
    );
  }
}

class PicManPainter extends CustomPainter {
  final Animation<double> repaint;

  // 创建 Tween
  final ColorDoubleTween tween = ColorDoubleTween(
      begin: ColorDouble(color: Colors.blue, value: 10),
      end: ColorDouble(color: Colors.red, value: 10));

  Paint _paint = Paint();

  PicManPainter(this.repaint) : super(repaint: repaint);

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
    var a = tween.evaluate(repaint).value / 180 * pi;
    canvas.drawArc(rect, a, 2 * pi - a.abs() * 2, true,
        _paint..color = tween.evaluate(repaint).color ?? Colors.black);
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

class ColorDouble {
  final Color? color;
  final double value;

  ColorDouble({this.color = Colors.blue, this.value = 0});
}

class ColorDoubleTween extends Tween<ColorDouble> {
  ColorDoubleTween({required ColorDouble begin, required ColorDouble end})
      : super(begin: begin, end: end);

  @override
  ColorDouble lerp(double t) => ColorDouble(
        color: Color.lerp(begin?.color, end?.color, t),
        value: (begin!.value + (end!.value - begin!.value) * t),
      );
}

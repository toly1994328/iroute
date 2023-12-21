
import 'package:flutter/material.dart';

import '../components/coordinate_pro.dart';

class Paper extends StatefulWidget {
  const Paper({super.key});

  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(_controller),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  final Coordinate coordinate = Coordinate();
  Paint _helpPaint = Paint();

  final Animation<double> repaint;

  PaperPainter(this.repaint) : super(repaint: repaint);

  double waveWidth = 80;
  double wrapHeight = 100;
  double waveHeight = 20;

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.save();
    // canvas.translate(-2*waveWidth, 0);
    canvas.translate(-2 * waveWidth + 2 * waveWidth * repaint.value, 0);
    path.moveTo(0, 0);
    path.relativeQuadraticBezierTo(
        waveWidth / 2, -waveHeight * 2, waveWidth, 0);
    path.relativeQuadraticBezierTo(waveWidth / 2, waveHeight * 2, waveWidth, 0);
    path.relativeQuadraticBezierTo(
        waveWidth / 2, -waveHeight * 2, waveWidth, 0);
    path.relativeQuadraticBezierTo(waveWidth / 2, waveHeight * 2, waveWidth, 0);
    path.relativeLineTo(0, wrapHeight);
    path.relativeLineTo(-waveWidth * 2 * 2.0, 0);
    path.close();
    canvas.drawPath(path, paint..style = PaintingStyle.fill);
    canvas.restore();

    _drawHelp(canvas);
  }

  void _drawHelp(Canvas canvas) {
    _helpPaint
      ..color = Colors.purple
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawRect(Rect.fromPoints(Offset(0, -100), Offset(160, 100)),
        _helpPaint..strokeWidth = 2);
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) =>
      oldDelegate.repaint != repaint;
}
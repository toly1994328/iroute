
import 'dart:math';

import 'package:flutter/material.dart';

import '../components/coordinate_pro.dart';



/// create by 张风捷特烈 on 2020-03-19
/// contact me by email 1981462002@qq.com
/// 说明: 纸
class Paper extends StatelessWidget {
  const Paper({super.key});

  @override
  Widget build(BuildContext context) {
    final curvesMap = {
      "linear": Curves.linear,
      "decelerate": Curves.decelerate,
      "fastLinearToSlowEaseIn": Curves.fastLinearToSlowEaseIn,
      "ease": Curves.ease,
      "easeIn": Curves.easeIn,
      "easeInToLinear": Curves.easeInToLinear,
      "easeInSine": Curves.easeInSine,
      "easeInQuad": Curves.easeInCubic,
      "easeInCubic": Curves.easeInCubic,
      "easeInQuart": Curves.easeInQuart,
      "easeInQuint": Curves.easeInQuint,
      "easeInExpo": Curves.easeInExpo,
      "easeInCirc": Curves.easeInCirc,
      "easeInBack": Curves.easeInBack,
      "easeOut": Curves.easeOut,
      "linearToEaseOut": Curves.linearToEaseOut,
      "easeOutSine": Curves.easeOutSine,
      "easeOutQuad": Curves.easeOutQuad,
      "easeOutCubic": Curves.easeOutCubic,
      "easeOutQuart": Curves.easeOutQuart,
      "easeOutQuint": Curves.easeOutQuint,

      // "easeOutExpo": Curves.easeOutExpo,
      // "easeOutCirc": Curves.easeOutCirc,
      // "easeOutBack": Curves.easeOutBack,
      // "easeInOut": Curves.easeInOut,
      // "easeInOutSine": Curves.easeInOutSine,
      // "easeInOutQuad": Curves.easeInOutQuad,
      // "easeInOutCubic": Curves.easeInOutCubic,
      // "easeInOutQuart": Curves.easeInOutQuart,
      // "easeInOutQuint": Curves.easeInOutQuint,
      // "easeInOutExpo": Curves.easeInOutExpo,
      // "easeInOutCirc": Curves.easeInOutCirc,
      // "easeInOutBack": Curves.easeInOutBack,
      // "fastOutSlowIn": Curves.fastOutSlowIn,
      // "slowMiddle": Curves.slowMiddle,
      // "bounceIn": Curves.bounceIn,
      // "bounceOut": Curves.bounceOut,
      // "bounceInOut": Curves.bounceInOut,
      // "elasticIn": Curves.elasticIn,
      // "elasticInOut": Curves.elasticInOut,
      // "elasticOut": Curves.elasticOut,
    };
    return Center(
      child:
      Wrap(
        runSpacing: 20,
        children: curvesMap.keys.map((e) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CurveBox(curve: curvesMap[e]!,),
            SizedBox(height: 3,),
            Text(e,style: TextStyle(fontSize: 10),)
          ],
        )).toList(),
      ),
    );
  }
}

class CurveBox extends StatefulWidget {
  final Color color;
  final Curve curve;

  const CurveBox({Key? key, this.color = Colors.lightBlue, this.curve = Curves.linear})
      : super(key: key);

  @override
  _CurveBoxState createState() => _CurveBoxState();
}

class _CurveBoxState extends State<CurveBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _angleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _angleAnimation = CurveTween(curve: widget.curve).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(100, 100),
      painter: CurveBoxPainter(_controller, _angleAnimation), // 背景
    );
  }
}

class CurveBoxPainter extends CustomPainter {
  final Animation<double> repaint; //
  Animation<double> angleAnimation;

  Paint _paint = Paint();

  CurveBoxPainter(this.repaint, this.angleAnimation) : super(repaint: repaint) {}

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    canvas.translate(size.width / 2, size.height / 2);
    _drawRing(canvas, size);
    _drawRedCircle(canvas, size);
    _drawGreenCircle(canvas, size);
  }

  //绘制环
  void _drawRing(Canvas canvas, Size size) {
    final double strokeWidth = 5;
    _paint
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(Offset.zero, size.width / 2 - strokeWidth, _paint);
  }

  // 绘制红球
  void _drawRedCircle(Canvas canvas, Size size) {
    canvas.save();
    canvas.rotate(angleAnimation.value * 2 * pi);
    _paint
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset.zero.translate(0, -(size.width / 2 - 5)), 5, _paint);
    canvas.restore();
  }

  // 绘制绿球
  void _drawGreenCircle(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(0,angleAnimation.value * (size.height-10));
    _paint
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset.zero.translate(0, -(size.width / 2 - 5)), 5, _paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CurveBoxPainter oldDelegate) =>
      oldDelegate.repaint != repaint;
}


import 'package:flutter/material.dart';




/// create by 张风捷特烈 on 2020-03-19
/// contact me by email 1981462002@qq.com
/// 说明: 纸

class Paper extends StatelessWidget {
  const Paper({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomPaint(
            // painter: BgPainter(), // 背景
            foregroundPainter: BgPainter(Colors.blue.withOpacity(0.9)), // 前景
            child:
            Text(
              "张风捷特烈",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ),
        Expanded(
          child: CustomPaint(
            painter: BgPainter(Colors.red), // 背景
            // foregroundPainter: BgPainter(), // 前景
            child:
            Text(
              "张风捷特烈",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}

class BgPainter extends CustomPainter {
  final Color color;

  BgPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero&size);
    canvas.drawPaint(Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

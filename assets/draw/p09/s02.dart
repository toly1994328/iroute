import 'dart:ui';
import 'package:flutter/material.dart';

import '../components/coordinate_pro.dart';
/// create by 张风捷特烈 on 2020-03-19
/// contact me by email 1981462002@qq.com
/// 说明: 纸

class Paper extends StatelessWidget {
  const Paper({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: _buildChild());
  }

  Widget _buildChild() {
    final Widget just = CustomPaint(
      painter: BgPainter(), // 背景
    );

    final Widget withSize = CustomPaint(
      size: Size(100,100),
      painter: BgPainter(), // 背景
    );


    final Widget withLayoutBuilder = LayoutBuilder(
      builder: _builderByLayout,
    );


    final Widget withChild = CustomPaint(
      painter: BgPainter(),
      child: Container(
        width: 100,
        height: 100,
      ), // 背景
    );

    return withChild;
  }

  Widget _builderByLayout(BuildContext context, BoxConstraints constraints) {
    return CustomPaint(
      size: Size(constraints.maxWidth, constraints.maxHeight),
      painter: BgPainter(), // 背景
    );
  }
}

class BgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero&size);

    canvas.drawRect(
        Rect.fromPoints(Offset.zero, Offset(size.width, size.height)),
        Paint()..color = Colors.red);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


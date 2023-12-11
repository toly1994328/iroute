import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../components/coordinate.dart';

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
        // 使用CustomPaint
        painter: PaperPainter(),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  final Coordinate coordinate = Coordinate(step: 25);

  late Paint _paint;

  final double strokeWidth = 0.5;
  final Color color = Colors.blue;

  PaperPainter() {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    _drawTextLeft(canvas);
    _drawTextTextAlignRight(canvas);
    _drawTextPaint(canvas, "100", offset: Offset(0, 0));
  }

  void _drawTextLeft(Canvas canvas) {
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.left,
      fontSize: 40,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    ))
      ..pushStyle(
        ui.TextStyle(
            color: Colors.black87, textBaseline: ui.TextBaseline.alphabetic),
      )
      ..addText("Flutter Unit");

    canvas.drawParagraph(
        builder.build()..layout(ui.ParagraphConstraints(width: 300)),
        Offset(0, -100));
    canvas.drawRect(Rect.fromLTRB(0, 0 - 100.0, 300, 40 - 100.0),
        _paint..color = Colors.blue.withAlpha(33));
  }

  void _drawTextCenter(Canvas canvas,String str) {
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.center,
      fontSize: 12,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    ))
      ..pushStyle(
        ui.TextStyle(
            color: Colors.black87, textBaseline: ui.TextBaseline.alphabetic),
      )
      ..addText(str);

    canvas.drawParagraph(
        builder.build()..layout(ui.ParagraphConstraints(width: 12.0*str.length)),
        Offset(0, 0));

  }

  void _drawTextTextAlignRight(Canvas canvas) {
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.right,
      fontSize: 40,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    ))
      ..pushStyle(
        ui.TextStyle(
            color: Colors.black87, textBaseline: ui.TextBaseline.alphabetic),
      )
      ..addText("Flutter Unit");

    canvas.drawParagraph(
        builder.build()..layout(ui.ParagraphConstraints(width: 300)),
        Offset(0, 100));

    canvas.drawRect(Rect.fromLTRB(0, 0 + 100.0, 300, 40 + 100.0),
        _paint..color = Colors.blue.withAlpha(33));
  }

  void _drawTextPaint(Canvas canvas, String text,
      {Offset offset = Offset.zero}) {
    TextPainter(
        text: TextSpan(
            text: text, style: TextStyle(fontSize: 12, color: Colors.black)),
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: 300)
      ..paint(canvas, offset);

    canvas.drawRect(Rect.fromLTRB(0, 0, 300, 40),
        _paint..color = Colors.blue.withAlpha(33));
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) => false;
}

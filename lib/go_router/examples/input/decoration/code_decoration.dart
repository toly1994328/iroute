import 'dart:ui';

import 'package:flutter/material.dart';

abstract class CodeDecoration {
  final Color activeColor;
  final Color inactiveColor;
  final Size cursorSize;
  final Color cursorColor;

  final TextStyle textStyle;
  final String? obscureText;

  CodeDecoration({
    required this.activeColor,
    required this.inactiveColor,
    required this.textStyle,
    required this.cursorSize,
    required this.cursorColor,
    this.obscureText,
  });

  void paint(
      Canvas canvas, Size size, int alpha, String text, int count, double gap) {
    double boxWidth = (size.width - (count - 1) * gap) / count;

    /// 绘制装饰
    paintDecoration(canvas, size, text, count, gap);

    /// 绘制游标
    paintCursor(canvas, alpha,size, text.length, boxWidth, gap);

    /// 绘制文字
    paintText(canvas,size, text, boxWidth, gap);
  }

  void paintCursor(
      Canvas canvas, int alpha,Size size, int count, double boxWidth, double gap) {
    Paint cursorPaint = Paint()
      ..color = cursorColor.withAlpha(alpha)
      ..strokeWidth = cursorSize.width
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    double startX = count * (boxWidth + gap) + boxWidth / 2;
    double startY = size.height/2-cursorSize.height/2;
    var endX = startX + cursorSize.width;
    var endY = size.height/2 + cursorSize.height/2;
//    var endY = size.height - 28.0 - 12;
//    canvas.drawLine(Offset(startX, startY), Offset(startX, endY), cursorPaint);
    //绘制圆角光标
    Rect rect = Rect.fromLTRB(startX, startY, endX, endY);
    RRect rrect =
        RRect.fromRectAndRadius(rect, Radius.circular(cursorSize.width));
    canvas.drawRRect(rrect, cursorPaint);
  }

  void paintText(Canvas canvas, Size size,String text, double boxWidth, double gap) {
    /// 画文本
    double startX = 0.0;
    /// Determine whether display obscureText.
    bool obscure = obscureText != null;

    for (int i = 0; i < text.runes.length; i++) {
      int rune = text.runes.elementAt(i);
      String code = obscure ? obscureText! : String.fromCharCode(rune);
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          style: textStyle,
          text: code,
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      /// Layout the text.
      textPainter.layout();
      var startY = size.height/2-textPainter.height/2;
      startX = boxWidth * i + boxWidth / 2 - textPainter.width / 2 + gap * i;
      textPainter.paint(canvas, Offset(startX, startY));
    }
  }

  void paintDecoration(
      Canvas canvas, Size size, String text, int count, double gap);
}

class UnderlineCodeDecoration extends CodeDecoration {
  final double strokeWidth;

  UnderlineCodeDecoration(
      {required this.strokeWidth,
      required super.activeColor,
      required super.inactiveColor,
      required super.cursorColor,
      required super.textStyle,
      required super.cursorSize,
      super.obscureText});

  @override
  void paintDecoration(
      Canvas canvas, Size size, String text, int count, double gap) {
    Paint underlinePaint = Paint()
      ..color = activeColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    /// 画下划线
    double singleWidth = (size.width - (count - 1) * gap) / count;
    var startX = 0.0;
    var startY = size.height;

    for (int i = 0; i < count; i++) {
      if (i == text.length) {
        underlinePaint.color = activeColor;
        // underlinePaint.strokeWidth = strokeWidth;
      } else {
        underlinePaint.color = inactiveColor;
        // underlinePaint.strokeWidth = strokeWidth;
      }
      canvas.drawLine(Offset(startX, startY),
          Offset(startX + singleWidth, startY), underlinePaint);
      startX += singleWidth + gap;
    }
  }
}

class RRectCodeDecoration extends CodeDecoration {
  final double strokeWidth;
  final double height;

  RRectCodeDecoration(
      {required this.height,
      required this.strokeWidth,
      required super.activeColor,
      required super.inactiveColor,
      required super.cursorColor,
      required super.textStyle,
      required super.cursorSize,
      super.obscureText});

  @override
  void paintDecoration(
      Canvas canvas, Size size, String text, int count, double gap) {
    Paint paint = Paint()
      ..color = activeColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    /// 画下划线
    double singleWidth = (size.width - (count - 1) * gap) / count;
    var startX = 0.0;
    var startY = size.height;

    for (int i = 0; i < count; i++) {
      if (i == text.length) {
        paint.color = activeColor;
      } else {
        paint.color = inactiveColor;
      }
      RRect rRect = RRect.fromRectAndRadius(
          Rect.fromPoints(
            Offset(startX, 0),
            Offset(startX + singleWidth, startY),
          ),
          Radius.circular(6));
      canvas.drawRRect(rRect, paint);
      // canvas.drawLine(Offset(startX, startY),
      //     Offset(startX + singleWidth, startY), underlinePaint);
      startX += singleWidth + gap;
    }
  }
}

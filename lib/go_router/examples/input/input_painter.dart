import 'package:flutter/cupertino.dart';

import 'decoration/code_decoration.dart' as c;
import 'input.dart';

class InputPainter extends CustomPainter {
  final TextEditingController controller;
  final int count;
  final double space;
  final CodeDecoration decoration;
  final c.CodeDecoration underlineCodeDecoration;
  final Animation<int> alpha;

  InputPainter(
    this.underlineCodeDecoration, {
    required this.controller,
    required this.count,
    required this.decoration,
    this.space = 4.0,
    required this.alpha,
  }) : super(repaint: Listenable.merge([controller, alpha]));

  void _drawUnderLine(Canvas canvas, Size size) {
    /// Force convert to [UnderlineDecoration].
    var dr = decoration as UnderlineDecoration;
    Paint underlinePaint = Paint()
      ..color = dr.color
      ..strokeWidth = dr.lineHeight
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    var startX = 0.0;
    var startY = size.height;

    /// 画下划线
    double singleWidth = (size.width - (count - 1) * dr.gapSpace) / count;

    for (int i = 0; i < count; i++) {
      if (i == controller.text.length && dr.enteredColor != null) {
        underlinePaint.color = dr.enteredColor!;
        underlinePaint.strokeWidth = 1;
      } else {
        underlinePaint.color = dr.color;
        underlinePaint.strokeWidth = 0.5;
      }
      canvas.drawLine(Offset(startX, startY),
          Offset(startX + singleWidth, startY), underlinePaint);
      startX += singleWidth + dr.gapSpace;
    }

    /// 画文本
    var index = 0;
    startX = 0.0;
    startY = 28;

    /// Determine whether display obscureText.
    bool obscureOn;
    obscureOn = decoration.obscureStyle != null &&
        decoration.obscureStyle!.isTextObscure;

    /// The text style of pin.
    TextStyle textStyle;
    if (decoration.textStyle == null) {
      textStyle = defaultStyle;
    } else {
      textStyle = decoration.textStyle!;
    }

    controller.text.runes.forEach((rune) {
      String code;
      if (obscureOn) {
        code = decoration.obscureStyle!.obscureText;
      } else {
        code = String.fromCharCode(rune);
      }
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

      startX = singleWidth * index +
          singleWidth / 2 -
          textPainter.width / 2 +
          dr.gapSpace * index;
      textPainter.paint(canvas, Offset(startX, startY));
      index++;
    });

    ///画光标  如果外部有传，则直接使用外部
    Color cursorColor = dr.enteredColor ?? const Color(0xff3776E9);
    cursorColor = cursorColor.withAlpha(alpha.value);

    double cursorWidth = 1;
    double cursorHeight = 24;

    //LogUtil.v("animation.value=$alpha");

    Paint cursorPaint = Paint()
      ..color = cursorColor
      ..strokeWidth = cursorWidth
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    startX =
        controller.text.length * (singleWidth + dr.gapSpace) + singleWidth / 2;

    var endX = startX + cursorWidth;
    var endY = startY + cursorHeight;
//    var endY = size.height - 28.0 - 12;
//    canvas.drawLine(Offset(startX, startY), Offset(startX, endY), cursorPaint);
    //绘制圆角光标
    Rect rect = Rect.fromLTRB(startX, startY, endX, endY);
    RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(cursorWidth));
    canvas.drawRRect(rrect, cursorPaint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // _drawUnderLine(canvas, size);
    underlineCodeDecoration.paint(
      canvas,
      size,
      alpha.value,
      controller.text,
      count,
      space,
    );
  }

  @override
  bool shouldRepaint(covariant InputPainter oldDelegate) {
    return oldDelegate.controller.text != controller.text;
  }
}

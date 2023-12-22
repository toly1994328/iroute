import 'dart:math';

import 'dart:ui' as ui;

import 'package:dash_painter/dash_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

/// create by 张风捷特烈 on 2020/11/5
/// contact me by email 1981462002@qq.com
/// 说明:

class Paper extends StatefulWidget {
  const Paper({Key? key}) : super(key: key);


  @override
  State<Paper> createState() => _PaperState();
}

class _PaperState extends State<Paper>
    with SingleTickerProviderStateMixin {

  Line line = Line();

  late AnimationController ctrl;
  ui.Image? _image;
  ui.Image? _bgImage;

  void _loadImage() async {
    ByteData data = await rootBundle.load('assets/images/hand.webp');
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    _image = await decodeImageFromList(Uint8List.fromList(bytes));
    line.attachImage(ImageZone(
      rect: const Rect.fromLTRB(0, 93, 104, 212),
      image: _image!,
    ));
  }

  void _loadImage2() async {
    ByteData bgData = await rootBundle.load('assets/images/body.webp');
    List<int> bgBytes = bgData.buffer.asUint8List(bgData.offsetInBytes, bgData.lengthInBytes);
    _bgImage = await decodeImageFromList(Uint8List.fromList(bgBytes));
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(_updateLine)..forward();
    _loadImage();
    _loadImage2();
  }

  @override
  void dispose() {
    line.dispose();
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // line.start = Offset.zero;
    // line.end = Offset(40, 0);
    // line.rotate(2.4085543677521746);

    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            // line.record();
            ctrl.repeat(reverse: true);
          },
          child:
          CustomPaint(
            painter: AnglePainter(line: line,
                // linker: linker
                image:_bgImage),
            child: Container(
              // color: Colors.grey.withOpacity(0.1),
              // height: 200,
              // width: 200,
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _updateLine() {
    // print("${ctrl.value * 2 * pi}");
    line.rotate(ctrl.value * 2* pi/50);
  }
}
class ImageZone {
  final ui.Image image;
  final Rect rect;

  Line? _line;

  final Paint imagePaint = Paint()..filterQuality = FilterQuality.high;

  ImageZone({required this.image, this.rect = Rect.zero});

  Line get line {
    if (_line != null) {
      return _line!;
    }
    Offset start = Offset(
        -(image.width / 2 - rect.right), -(image.height / 2 - rect.bottom));
    Offset end = start.translate(-rect.width, -rect.height);
    _line = Line(start: start, end: end);
    return _line!;
  }

  void paint(Canvas canvas, Line line) {
    canvas.save();
    canvas.translate(line.start.dx, line.start.dy);
    canvas.rotate(line.positiveRad - this.line.positiveRad);
    canvas.translate(-line.start.dx, -line.start.dy);
    canvas.drawImageRect(
      image,
      rect,
      rect.translate(-image.width / 2, -image.height / 2),
      imagePaint,
    );
    canvas.restore();
  }
}
class AnglePainter extends CustomPainter {
  final DashPainter dashPainter = const DashPainter(span: 4, step: 4);
  ui.Image? image;

  AnglePainter({required this.line, this.image}) : super(repaint: line);

  final Paint helpPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.lightBlue
    ..strokeWidth = 1;

  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  final Line line;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    line.paint(canvas);
    // drawHelp(canvas, size);

    if (image != null) {
      canvas.drawImage(
          image!, Offset(-image!.width / 2, -image!.height / 2), Paint());
      // drawHelp(canvas, Size(image!.width.toDouble() , image!.height.toDouble()));
    }
  }

  void drawHelp(Canvas canvas, Size size) {

    Path helpPath = Path()
      ..moveTo(-size.width / 2, 0)
      ..relativeLineTo(size.width, 0)
      ..moveTo(0, -size.height / 2)
      ..relativeLineTo(0, size.height);

    dashPainter.paint(canvas, helpPath, helpPaint);

    // drawHelpText('0°', canvas, Offset(size.width / 2 - 20, 0));
    // drawHelpText('p0', canvas, line.start.translate(-20, 0));
    // drawHelpText('p1', canvas, line.end.translate(-20, 0));
    //
    // drawHelpText(
    //   '角度: ${(line.positiveRad * 180 / pi).toStringAsFixed(2)}°',
    //   canvas,
    //   Offset(
    //     -size.width / 2 + 10,
    //     -size.height / 2 + 10,
    //   ),
    // );

    // canvas.drawArc(
    //   Rect.fromCenter(center: line.start, width: 20, height: 20),
    //   0,
    //   line.positiveRad,
    //   false,
    //   helpPaint,
    // );

    // canvas.save();
    // Offset center = const Offset(60, 60);
    // canvas.translate(center.dx, center.dy);
    // canvas.rotate(line.positiveRad);
    // canvas.translate(-center.dx, -center.dy);
    // canvas.drawCircle(center, 4, helpPaint);
    // canvas.drawRect(
    //     Rect.fromCenter(center: center, width: 30, height: 60), helpPaint);
    // canvas.restore();
  }

  void drawHelpText(
      String text,
      Canvas canvas,
      Offset offset, {
        Color color = Colors.lightBlue,
      }) {
    textPainter.text = TextSpan(
      text: text,
      style: TextStyle(fontSize: 12, color: color),
    );
    textPainter.layout(maxWidth: 200);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant AnglePainter oldDelegate) {
    return oldDelegate.image != image;
  }
}

class Line with ChangeNotifier {
  Line({
    this.start = Offset.zero,
    this.end = Offset.zero,
  });

  Offset start;
  Offset end;
  ImageZone? _zone;

  void attachImage(ImageZone zone) {
    _zone = zone;
    start = zone.line.start;
    end = zone.line.end;
    notifyListeners();
  }

  final Paint pointPaint = Paint()
    ..style = PaintingStyle.fill
    ..color = Colors.red
    ..strokeWidth = 1;

  void paint(Canvas canvas) {
    _zone?.paint(canvas, this);
    // canvas.save();
    // canvas.translate(start.dx, start.dy);
    // canvas.rotate(positiveRad);
    // Path arrowPath = Path();
    // arrowPath
    //   ..relativeLineTo(length - 10, 3)
    //   ..relativeLineTo(0, 2)
    //   ..lineTo(length, 0)
    //   ..relativeLineTo(-10, -5)
    //   ..relativeLineTo(0, 2)
    //   ..close();
    // canvas.drawPath(arrowPath, pointPaint);
    // canvas.restore();
  }

  double get rad => (end - start).direction;

  double get positiveRad => rad < 0 ? 2 * pi + rad : rad;

  double get length => (end - start).distance;

  double detaRotate = 0;

  void rotate(double rotate) {
    detaRotate = rotate - detaRotate;
    end = Offset(
      length * cos(rad + detaRotate),
      length * sin(rad + detaRotate),
    ) +
        start;
    detaRotate = rotate;
    notifyListeners();
  }

  void tick() {
    notifyListeners();
  }
}
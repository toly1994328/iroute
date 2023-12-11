import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/coordinate.dart';

/// create by 张风捷特烈 on 2020-03-19
/// contact me by email 1981462002@qq.com
/// 说明: 纸
///
class Paper extends StatefulWidget {
  const Paper({super.key});

  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  @override
  void initState() {
    super.initState();
    _loadImage();
  }


  void _loadImage() async {
    _image =
    await loadImageFromAssets('assets/images/right_chat.png');
    setState(() {});
  }

  ui.Image? _image;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: CustomPaint(
            painter: PaperPainter(
              _image,
            )));
  }

  //读取 assets 中的图片
  Future<ui.Image>? loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    return decodeImageFromList(data.buffer.asUint8List());
  }
}

class PaperPainter extends CustomPainter {
  late Paint _paint;

  final double strokeWidth = 0.5;
  final Color color = Colors.blue;

  final ui.Image? image;
  final Coordinate coordinate = Coordinate();

  PaperPainter(this.image) {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);
    _drawImageNine(canvas);
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) => image != oldDelegate.image;

  void _drawImageNine(Canvas canvas) {
    if (image != null) {
      canvas.drawImageNine(
          image!,
          Rect.fromCenter(
              center: Offset(image!.width / 2, image!.height - 6.0),
              width: image!.width - 20.0,
              height: 2.0),
          Rect.fromCenter(
              center: Offset(
                0,
                0,
              ),
              width: 300,
              height: 120),
          _paint);

      canvas.drawImageNine(
          image!,
          Rect.fromCenter(
              center: Offset(image!.width / 2, image!.height - 6.0),
              width: image!.width - 20.0,
              height: 2.0),
          Rect.fromCenter(
              center: Offset(
                0,
                0,
              ),
              width: 100,
              height: 50)
              .translate(250, 0),
          _paint);

      canvas.drawImageNine(
          image!,
          Rect.fromCenter(
              center: Offset(image!.width / 2, image!.height - 6.0),
              width: image!.width - 20.0,
              height: 2.0),
          Rect.fromCenter(
              center: Offset(
                0,
                0,
              ),
              width: 80,
              height: 250)
              .translate(-250, 0),
          _paint);
    }
  }
}

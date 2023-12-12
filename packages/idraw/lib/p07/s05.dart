import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as image;

import '../components/coordinate_pro.dart';

/// create by 张风捷特烈 on 2020-03-19
/// contact me by email 1981462002@qq.com
/// 说明: 纸
class Paper extends StatefulWidget {
  const Paper({super.key});

  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  image.Image? _image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    _image = await loadImageFromAssets('assets/images/wy_300x200.jpg');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white, child: CustomPaint(painter: PaperPainter(_image)));
  }

  //读取 assets 中的图片
  Future<image.Image?> loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    List<int> bytes = data.buffer.asUint8List();
    return image.decodeImage(Uint8List.fromList(bytes));
  }
}

class PaperPainter extends CustomPainter {
  late Paint _paint;

  final double strokeWidth = 0.5;
  final Color color = Colors.blue;

  final image.Image? imageSrc;
  final Coordinate coordinate = Coordinate();

  PaperPainter(this.imageSrc) {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);
    _drawImage(canvas);
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) =>true;

  void _drawImage(Canvas canvas) {
    if (imageSrc == null)  return;
    image.Pixel pixel = imageSrc!.getPixel(imageSrc!.width, 0);
    var color = Color.fromARGB(pixel.a.toInt(),pixel.r.toInt(),pixel.g.toInt(),pixel.b.toInt());
    canvas.drawCircle(Offset.zero, 10, _paint..color = color);
  }
}

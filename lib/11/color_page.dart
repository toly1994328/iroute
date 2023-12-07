import 'package:flutter/material.dart';
import '../common/components/colors_panel.dart';
import 'color_detail.dart';
import 'transition.dart';

class ColorPage extends StatefulWidget {
  const ColorPage({super.key});

  @override
  State<ColorPage> createState() => _ColorPageState();
}

class _ColorPageState extends State<ColorPage> {
  final List<Color> _colors = [
    Colors.red,
    Colors.black,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.indigo,
    Colors.amber,
    Colors.cyan,
    Colors.redAccent,
    Colors.grey,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.orangeAccent,
    Colors.pinkAccent,
    Colors.purpleAccent,
    Colors.indigoAccent,
    Colors.amberAccent,
    Colors.cyanAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('颜色主页')),
      floatingActionButton: FloatingActionButton(
        onPressed: _toAddPage,
        child: const Icon(Icons.add),
      ),
      body: ColorsPanel(
        colors: _colors,
        onSelect: _selectColor,
      ),
    );
  }

  void _selectColor(Color color) {
    Route route = PageRouteBuilder<void>(
      barrierColor: Colors.white,
      pageBuilder: (_, __, ___) => ColorDetailPage(color:color),
      transitionsBuilder: kSlideBottomToTopWithSecondary,
    );
    Navigator.push(context, route);
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (_)=>ColorDetailPage(color:color)));
  }

  void _toAddPage() {
  }
}

import 'package:flutter/material.dart';
import 'package:iroute/common/components/colors_panel.dart';
import '../../app/navigation/app_router_delegate.dart';

class ColorPage extends StatefulWidget {
  const ColorPage({super.key});

  @override
  State<ColorPage> createState() => _ColorPageState();
}

class _ColorPageState extends State<ColorPage> {
  final List<Color> _colors = [
    Colors.red, Colors.black, Colors.blue, Colors.green, Colors.orange,
    Colors.pink, Colors.purple, Colors.indigo, Colors.amber, Colors.cyan,
    Colors.redAccent, Colors.grey, Colors.blueAccent, Colors.greenAccent, Colors.orangeAccent,
    Colors.pinkAccent, Colors.purpleAccent, Colors.indigoAccent, Colors.amberAccent, Colors.cyanAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title:const Text('颜色主页')),
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

  void _selectColor(Color color){
    String value = color.value.toRadixString(16);
    router.path = '/color/detail?color=$value';
  }

  void _toAddPage() async {
   Color? color = await router.changePathForResult('/color/add');
   if (color != null) {
     setState(() {
       _colors.add(color);
     });
   }
  }
}
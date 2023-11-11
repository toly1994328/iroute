import 'package:flutter/material.dart';
import 'package:iroute/components/project/colors_panel.dart';
import '../../app/navigation/router/app_router_delegate.dart';

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
      body: Align(
        alignment: Alignment.topCenter,
        child: ColorsPanel(
          colors: _colors,
          onSelect: _selectColor,
        ),
      ),
    );
  }

  void _selectColor(Color color){
    // String value = color.value.toRadixString(16);
    // router.path = '/color/detail?color=$value';
    router.changePath('/color/detail',extra: color);

  }

  void _toAddPage() async {
   Color? color = await router.changePath('/color/add',forResult: true,recordHistory: false);
   if (color != null) {
     setState(() {
       _colors.add(color);
     });
   }
  }
}
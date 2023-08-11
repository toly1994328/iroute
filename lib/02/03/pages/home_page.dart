import 'package:flutter/material.dart';
import 'package:iroute/02/01/pages/color_add_page.dart';
import 'package:iroute/02/03/router1/router1.dart';

import '../../../common/components/colors_panel.dart';
import '../../../common/pages/stl_color_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Color> _colors = [
    Colors.red, Colors.black, Colors.blue, Colors.green, Colors.orange,
    Colors.pink, Colors.purple, Colors.indigo, Colors.amber, Colors.cyan,
    Colors.redAccent, Colors.grey, Colors.blueAccent, Colors.greenAccent, Colors.orangeAccent,
    Colors.pinkAccent, Colors.purpleAccent, Colors.indigoAccent, Colors.amberAccent, Colors.cyanAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('颜色主页 V3')),
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
    Router1.nav.pushNamed(Router1.kColorDetail,arguments: color);
  }

  void _toAddPage() async {
    dynamic color = await Router1.nav.pushNamed(Router1.kAddColor);
    if (color != null) {
      setState(() {
        _colors.add(color);
      });
    }
  }
}

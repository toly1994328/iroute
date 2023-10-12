import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../route/route_state.dart';
import 'app.dart';
import 'color_add_page.dart';

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
  void dispose() {
    print('_HomePageState#dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('颜色主页')),
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
    context.push('/color/detail?color=$value');
    context.go('/color/detail?color=$value');
    // routerDelegate.go('/color/detail?color=$value');
  }

  void _toAddPage() async {
    Color? color = await context.push<Color?>('/color/add');
    if (color != null) {
      setState(() {
        _colors.add(color);
      });
    }
  }
}

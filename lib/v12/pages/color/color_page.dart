import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iroute/components/project/colors_panel.dart';

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
  void initState() {
    print('======_ColorPageState#initState==============');
    super.initState();
  }

  @override
  void dispose() {
    print('======_ColorPageState#dispose==============');
    super.dispose();
  }

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

  void _selectColor(Color color) {
    String value = color.value.toRadixString(16);
    context.push('/color/detail?color=$value');
    // GoRouter.of(context) .pushNamed('colorDetail', queryParameters: {'color': value});
  }

  void _toAddPage() async {
    Color? color = await context.push('/color/add');

    if (color != null) {
      setState(() {
        _colors.add(color);
      });
    }
  }
}

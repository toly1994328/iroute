import 'package:flutter/material.dart';

import '../../../common/components/colors_panel.dart';
import '../../../common/pages/stl_color_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColorsPanel(
        colors: const [
          Colors.red, Colors.black, Colors.blue, Colors.green, Colors.orange,
          Colors.pink, Colors.purple, Colors.indigo, Colors.amber, Colors.cyan,
          Colors.redAccent, Colors.grey, Colors.blueAccent, Colors.greenAccent, Colors.orangeAccent,
          Colors.pinkAccent, Colors.purpleAccent, Colors.indigoAccent, Colors.amberAccent, Colors.cyanAccent,
        ],
        onSelect: (Color color) => selectColor(context, color),
      ),
    );
  }

  void selectColor(BuildContext context,Color color){
    Route route = MaterialPageRoute(builder: (ctx) => StlColorPage(color: color));
    Navigator.of(context).push(route);
  }

}

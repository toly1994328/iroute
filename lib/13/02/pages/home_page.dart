import 'package:flutter/material.dart';
import 'package:iroute/13/02/store/app_state.dart';
import '../route/route_state.dart';
import 'color_add_page.dart';

import '../../../common/components/colors_panel.dart';
import '../../../common/pages/stl_color_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    AppState state = AppStateScope.of(context);
    return Scaffold(
      appBar: AppBar(title:const Text('颜色主页')),
      floatingActionButton: FloatingActionButton(
        onPressed: _toAddPage,
        child: const Icon(Icons.add),
      ),
      body: ColorsPanel(
        colors: state.colors,
        onSelect: _selectColor,
      ),
    );
  }

  void _selectColor(Color color){
    String value = '#${color.value.toRadixString(16)}';
    RouteStateScope.of(context).update('/color/detail/$value');
  }

  void _toAddPage() async {
    RouteStateScope.of(context).update('/color/add');
  }
}

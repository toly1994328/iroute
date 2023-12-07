import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_info.dart';
import 'cupertino_context_menu_demo.dart';
import 'dropdown_button_color.dart';
import 'more_pop_icon.dart';
import 'search_anchor_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
         Locale('zh', 'CN'),
      ],
      locale: const Locale('zh', 'CN'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("弹出层测试"),
        actions: [
          MorePopIcon(onTapItem: _onTapItem,)
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: showConformDialog,
              child: Text('关于应用'),
            ),
            DropdownButtonColor(),
            ElevatedButton(
              onPressed: _showModalBottomSheet,
              child: Text('showModalBottomSheet'),
            ),
            ElevatedButton(
              onPressed: _showCupertinoModalPopup,
              child: Text('showCupertinoModalPopup'),
            ),
            ElevatedButton(
              onPressed: _toSearchAnchor,
              child: Text('SearchAnchor 案例'),
            ),        ElevatedButton(
              onPressed: _toCupertinoContextMenu,
              child: Text('CupertinoContextMenu 案例'),
            ),
          ],
        ),
      ),
    );
  }

  void showConformDialog(){
    showDialog(context: context, builder: _buildAbout);
    // showCupertinoModalPopup(context: context, builder: builder)
    // showCupertinoDialog(context: context, builder: _buildAbout);
  }

  void _showModalBottomSheet(){
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        ),
        context: context, builder: (_)=>AppInfo());
  }

  void _showCupertinoModalPopup(){
    showCupertinoModalPopup(
        context: context, builder: (_)=>Material(child: const AppInfo()));
  }

  Widget _buildAbout(BuildContext context){
    const String msg = 'FlutterUnit 是一个辅助开发者,了解 Flutter 组件和编程技术的开源项目。';
    return const AboutDialog(
      applicationName: "FlutterUnit",
      applicationVersion: "v2.9.3",
      applicationIcon: FlutterLogo(),
      children: [
        Text(msg,style: TextStyle(color: Colors.grey),)
      ],
    );
  }

  void _onTapItem(MenuAction value) {
    print(value.label);
    switch(value){
      case MenuAction.setting:
        break;
      case MenuAction.about:
        showConformDialog();
        break;
      case MenuAction.help:
        break;
    }
  }

  void _toSearchAnchor() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SearchAnchorDemo()));

  }

  void _toCupertinoContextMenu() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>CupertinoContextMenuDemo()));
  }
}

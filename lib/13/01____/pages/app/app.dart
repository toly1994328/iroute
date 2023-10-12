import 'package:flutter/material.dart';


import '../../main.dart';
import 'app_tool_bar.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ))),
        debugShowCheckedModeBanner: false,
        home:  Scaffold(
          appBar: AppToolBar(),
          body: Router(routerDelegate: router),
        ));
  }
}


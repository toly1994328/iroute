import 'package:flutter/material.dart';

import 'pages/page_a.dart';
import 'pages/page_b.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold)
        )
      ),
      initialRoute: '/a/b',
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route? _onGenerateRoute(RouteSettings settings) {
    String? name = settings.name;
    Widget? page ;
    if(name=='/'){
      page = const HomePage();
    }
    if(name=='/a'){
      page = const PageA();
    }
    if(name=='/a/b'){
      page = const PageB();
    }

    if(page!=null){
      return MaterialPageRoute(builder: (_)=> page!,settings: settings);
    }
    return null;
  }
}

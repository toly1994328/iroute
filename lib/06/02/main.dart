import 'package:flutter/material.dart';

import 'pages/page_a.dart';
import 'pages/page_b.dart';
import 'pages/page_c.dart';

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
      home:  const PageA(),
      onUnknownRoute: _onUnknownRoute,
    );
  }

  Route? _onUnknownRoute(RouteSettings settings) {
    String? name = settings.name;
    Widget? page ;
    if(name=='/a'){
      page = const PageA();
    }
    if(name=='/b'){
      page = const PageB();
    }
    if(name=='/c'){
      page = const PageC();
    }
    if(page!=null){
      return MaterialPageRoute(builder: (_)=> const PageB());
    }
    return null;
  }
}

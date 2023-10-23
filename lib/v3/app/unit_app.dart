import 'package:flutter/material.dart';
import 'navigation/views/app_navigation.dart';

class UnitApp extends StatelessWidget {
  const UnitApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
          fontFamily: "宋体",
            appBarTheme: const AppBarTheme(
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ))),
        debugShowCheckedModeBanner: false,
        home: AppNavigation());
  }
}


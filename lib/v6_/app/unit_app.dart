import 'package:flutter/material.dart';
import '../pages/sort/provider/state.dart';
import 'navigation/router/app_router_delegate.dart';
import 'navigation/views/app_navigation.dart';
import 'navigation/views/app_navigation_rail.dart';

class UnitApp extends StatelessWidget {
  const UnitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SortStateScope(
      notifier: SortState(),
      child: MaterialApp(
          theme: ThemeData(
            fontFamily: "宋体",
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.black),
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ))),
          debugShowCheckedModeBanner: false,
          home: AppNavigation()
      ),
    );
  }
}



import 'package:flutter/material.dart';
import '../pages/sort/provider/state.dart';
import 'navigation/transition/fade_page_transitions_builder.dart';
import 'navigation/views/app_navigation.dart';


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
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: ZoomPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.macOS: FadePageTransitionsBuilder(),
                  TargetPlatform.windows: FadePageTransitionsBuilder(),
                  TargetPlatform.linux: FadePageTransitionsBuilder(),
                }
              ),
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



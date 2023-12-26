import 'package:flutter/material.dart';
import 'navigation/app_router_delegate.dart';
import 'navigation/views/app_navigation_rail.dart';

class UnitApp extends StatelessWidget {
  const UnitApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        theme: ThemeData(
          useMaterial3: false,
            appBarTheme: const AppBarTheme(
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ))),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Row(
            children: [
              const AppNavigationRail(),
              Expanded(
                child: Router(
                  routerDelegate: router,
                  backButtonDispatcher: RootBackButtonDispatcher(),
                ),
              ),
            ],
          ),
        ));
  }
}



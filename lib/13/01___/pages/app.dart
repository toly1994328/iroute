import 'package:flutter/material.dart';
import '../route/parser.dart';
import '../route/route_state.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

AppRouteParser parser = AppRouteParser();
AppRouterDelegate routerDelegate = AppRouterDelegate();

class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: routerDelegate,
      routeInformationParser: parser,
      // backButtonDispatcher: RootBackButtonDispatcher(),
      theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ))),
      debugShowCheckedModeBanner: false,
    );
  }
}

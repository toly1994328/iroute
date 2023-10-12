import 'package:flutter/material.dart';
import '../route/parser.dart';
import '../route/route_state.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final RootRouterDelegate _delegate;
  late final AppRouteParser _parser;
  late final RouteState _routeState;

  @override
  void initState() {
    super.initState();
    _parser = AppRouteParser();
    _routeState = RouteState(_parser,initial: '/color');
    _delegate = RootRouterDelegate(_routeState);
  }

  @override
  Widget build(BuildContext context) {
    return RouteStateScope(
      notifier: _routeState,
      child: MaterialApp.router(
        routerDelegate: _delegate,
        routeInformationParser: _parser,
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
      ),
    );
  }
}

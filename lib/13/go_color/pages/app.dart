import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iroute/common/pages/stl_color_page.dart';
import '../route/parser.dart';
import 'home_page.dart';
import 'color_add_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  GoRouter router = GoRouter(
      initialLocation: '/color',
      routes: <GoRoute>[
        GoRoute(path: '/color',builder: (ctx,state)=>HomePage()),
        GoRoute(path: '/color/detail',builder: (ctx,state) {
          String selectedColor = state.uri.queryParameters['color']??'';
          return StlColorPage(
          color: Color(int.parse(selectedColor,radix: 16)),
        );
        }),
        GoRoute(path: '/color/add',builder: (ctx,state)=>ColorAddPage()),
      ]

  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
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

import 'package:flutter/material.dart';
import 'router1/router1.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      routes: Router1.routeMap,
      navigatorKey: Router1.globalNavKey,
      onUnknownRoute: Router1.onUnknownRoute,
      initialRoute: Router1.initialRoute,
      onGenerateRoute: Router1.onGenerateRoute,
    );
  }
}

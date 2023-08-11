import 'package:flutter/material.dart';
import 'package:iroute/02/01/pages/color_add_page.dart';
import '../../common/pages/stl_color_page.dart';
import 'pages/empty_page.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: routeMap,
      // initialRoute: '/add_color',
      onUnknownRoute: _onUnknownRoute,
      onGenerateRoute: _onGenerateRoute,
    );
  }

  /// 路由映射 [字符串 --> 组件构造器]
  Map<String, WidgetBuilder> get routeMap => {
        '/': (ctx) => const HomePage(),
        '/add_color': (ctx) => const ColorAddPage(),
      };

  /// 根据路由配置 [settings] 创建路由
  Route? _onGenerateRoute(RouteSettings settings) {
    String? name = settings.name;
    Widget? child;
    if (name == '/color_detail') {
      Color color = settings.arguments as Color;
      child = StlColorPage(color: color);
    }

    if (child != null) {
      return MaterialPageRoute(
        builder: (ctx) => child!,
        settings: settings,
      );
    }
    return null;
  }

  Route? _onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (ctx) => const EmptyPage(),
      settings: settings,
    );
  }
}

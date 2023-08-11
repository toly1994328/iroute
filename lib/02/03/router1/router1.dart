import 'package:flutter/material.dart';

import '../../../common/pages/stl_color_page.dart';
import '../pages/color_add_page.dart';
import '../pages/empty_page.dart';
import '../pages/home_page.dart';

class Router1 {

  /// 主页面 [HomePage]
  static const String kHome = '/';

  /// 颜色详情页 [StlColorPage]
  static const String kColorDetail = '${kHome}color_detail';

  /// 添加颜色页 [ColorAddPage]
  static const String kAddColor = '${kHome}add_color';


  static String get initialRoute => kHome;

  static final GlobalKey<NavigatorState> globalNavKey = GlobalKey();

  static NavigatorState get nav => globalNavKey.currentState!;

  /// 路由映射 [字符串 --> 组件构造器]
  static Map<String, WidgetBuilder> get routeMap => {
        kHome: (ctx) => const HomePage(),
        kAddColor: (ctx) => const ColorAddPage(),
  };

  /// 根据路由配置 [settings] 创建路由
  static Route? onGenerateRoute(RouteSettings settings) {
    String? name = settings.name;
    Widget? child;
    if (name == kColorDetail) {
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

  static Route? onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (ctx) => const EmptyPage(),
      settings: settings,
    );
  }
}

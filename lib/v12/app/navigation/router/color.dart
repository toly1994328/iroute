import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../pages/color/color_add_page.dart';
import '../../../pages/color/color_detail_page.dart';
import '../../../pages/color/color_page.dart';



final RouteBase colorRouters = GoRoute(
  path: 'color',
  builder: (BuildContext context, GoRouterState state) {
    return const ColorPage();
  },
  routes: <RouteBase>[
    GoRoute(
      path: 'detail',
      name: 'colorDetail',
      builder: (BuildContext context, GoRouterState state) {
        String? selectedColor = state.uri.queryParameters['color'];
        Color color = Colors.black;
        if (selectedColor != null) {
          color = Color(int.parse(selectedColor, radix: 16));
        }
        return ColorDetailPage(color: color);
      },
    ),
    GoRoute(
      path: 'add',
      builder: (BuildContext context, GoRouterState state) {
        return const ColorAddPage();
      },
    ),
  ],
);


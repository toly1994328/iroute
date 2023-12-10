import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../pages/counter/counter_page.dart';
import '../../../pages/user/user_page.dart';
import '../../../pages/settings/settings_page.dart';
import '../../../pages/empty/empty_panel.dart';
import '../views/app_navigation.dart';
import 'color.dart';
import 'sort.dart';


final RouteBase appRoute = ShellRoute(
  builder: (BuildContext context, GoRouterState state, Widget child) {
    return AppNavigation(navigator: child);
  },
  routes: <RouteBase>[
    colorRouters,
    GoRoute(
        path: 'counter',
        builder: (BuildContext context, GoRouterState state) {
          return const CounterPage();
        }),
    sortRouters,
    GoRoute(
      path: 'user',
      builder: (BuildContext context, GoRouterState state) {
        return const UserPage();
      },
    ),
    GoRoute(
      path: 'settings',
      builder: (BuildContext context, GoRouterState state) {
        return const SettingPage();
      },
    ),
    GoRoute(
      path: '404',
      builder: (BuildContext context, GoRouterState state) {
        String msg = '无法访问: ${state.extra}';
        return EmptyPanel(msg: msg);
      },
    )
  ],
);

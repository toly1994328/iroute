import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iroute/v12/pages/empty/empty_panel.dart';

import '../../../navigation/app_navigation.dart';
import 'dashboard.dart';
import 'draw.dart';


final RouteBase appRoute = ShellRoute(
  builder: (BuildContext context, GoRouterState state, Widget child) {
    return BookAppNavigation(content: child);
  },
  routes: <RouteBase>[
    dashboardRouters,
    drawRouters,
    // GoRoute(
    //     path: 'counter',
    //     builder: (BuildContext context, GoRouterState state) {
    //       return const CounterPage();
    //     }),
    // sortRouters,
    // GoRoute(
    //   path: 'user',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const UserPage();
    //   },
    // ),
    // GoRoute(
    //   path: 'settings',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const SettingPage();
    //   },
    // ),
    GoRoute(
      path: '/404',
      builder: (BuildContext context, GoRouterState state) {
        String msg = '无法访问: ${state.extra}';
        return EmptyPanel(msg: msg);
      },
    )
  ],
);

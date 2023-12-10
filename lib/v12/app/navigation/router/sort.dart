import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../pages/sort/provider/state.dart';

import '../../../pages/sort/views/player/sort_player.dart';
import '../../../pages/sort/views/settings/sort_setting.dart';
import '../../../pages/sort/views/sort_page/sort_page.dart';

final RouteBase sortRouters = ShellRoute(
  builder: (BuildContext context, GoRouterState state, Widget child) {
    return SortNavigation(navigator: child);
  },
  routes: [
    GoRoute(
      path: 'sort',
      redirect: _redirectSort,
      routes: [
        GoRoute(
          path: 'player/:name',
          builder: (BuildContext context, GoRouterState state) {
            print(state.pathParameters);// 获取路径参数
            return const SortPlayer();
          },
        ),
        GoRoute(
          path: 'settings',
          builder: (BuildContext context, GoRouterState state) {
            return const SortSettings();
          },
        ),
      ],
    ),
  ],
);

FutureOr<String?> _redirectSort(BuildContext context, GoRouterState state) {
  if (state.fullPath == '/sort') {
    String name = SortStateScope.read(context).config.name;
    return '/sort/player/$name';
  }
  return null;
}

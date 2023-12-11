
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:idraw/idraw.dart';
import 'package:iroute/pages/dashboard/chat_room.dart';


final RouteBase drawRouters = GoRoute(
  path: '/draw',
  redirect: (_,state) {
    if (state.fullPath == '/draw') {
      return '/draw/chapter1';
    }
    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      path: 'chapter1',
      builder: (BuildContext context, GoRouterState state) {
        return const P01Page();
      },
    ),
    GoRoute(
      path: 'chapter2',
      builder: (BuildContext context, GoRouterState state) {
        return const P02Page();
      },
    ),
    GoRoute(
      path: 'chapter3',
      builder: (BuildContext context, GoRouterState state) {
        return const P03Page();
      },
    ),
    GoRoute(
      path: 'chapter4',
      builder: (BuildContext context, GoRouterState state) {
        return const P04Page();
      },
    ),    GoRoute(
      path: 'chapter5',
      builder: (BuildContext context, GoRouterState state) {
        return const P05Page();
      },
    ),
  ],
);

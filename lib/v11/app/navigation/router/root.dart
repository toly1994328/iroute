import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../pages/login/login.dart';
import 'app.dart';

final RouteBase rootRoute = GoRoute(
  path: '/',
  redirect: _redirect,
  routes: [
    appRoute,
    GoRoute(
      path: 'login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
    ),
  ],
);

FutureOr<String?> _redirect(BuildContext context, GoRouterState state) {
  if(state.fullPath=='/'){
    return '/color';
  }
  return null;
}

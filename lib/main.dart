import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

import 'navigation/router/menus/menu_scope/menu_scope.dart';
import 'navigation/router/routers/app.dart';
import 'navigation/transition/fade_page_transitions_builder.dart';
import 'navigation/views/app_navigation.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setSize();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(TolyBooksApp());
}


class TolyBooksApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    initialLocation: '/dashboard/view',
    routes: <RouteBase>[appRoute],
    onException: (BuildContext ctx, GoRouterState state, GoRouter router) {
      router.go('/404', extra: state.uri.toString());
    },
  );

  late final MenuStore menuStore = MenuStore(
    activeMenu: '/dashboard/view',
    expandMenus: ['/dashboard'],
    goRouter: _router,
  );

  @override
  Widget build(BuildContext context) {
    return MenuScope(
      notifier: menuStore,
      child: MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: "宋体",
          primarySwatch: Colors.blue,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.macOS: FadePageTransitionsBuilder(),
            TargetPlatform.windows: FadePageTransitionsBuilder(),
            TargetPlatform.linux: FadePageTransitionsBuilder(),
          }),
        ),
      ),
    );
  }
}

void setSize() async{
  if(kIsWeb||Platform.isAndroid||Platform.isIOS) return;
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(1024, 1024*3/4),
      minimumSize: Size(600, 400),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
}

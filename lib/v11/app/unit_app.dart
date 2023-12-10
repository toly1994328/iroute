import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../pages/empty/empty_page.dart';
import 'navigation/router/root.dart';
import '../pages/sort/provider/state.dart';
import 'navigation/helper/router_history.dart';
import 'navigation/transition/fade_page_transitions_builder.dart';

class UnitApp extends StatelessWidget {
  UnitApp({super.key});

  final GoRouter _router = GoRouter(
    routes: <RouteBase>[rootRoute],
    onException: (BuildContext ctx,GoRouterState state, GoRouter router){
      router.go('/404', extra: state.uri.toString());
    },
    // errorBuilder: (_,state) {
    //   return EmptyPage(msg: '无法访问: ${state.matchedLocation}',);
    // }
  );

  @override
  Widget build(BuildContext context) {
    return SortStateScope(
      notifier: SortState(),
      child: RouterHistoryScope(
        notifier: RouterHistory(_router.routerDelegate, exclusives: ['/login']),
        child: MaterialApp.router(
          routerConfig: _router,
          theme: ThemeData(
              fontFamily: "宋体",
              scaffoldBackgroundColor: Colors.white,
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: ZoomPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                TargetPlatform.macOS: FadePageTransitionsBuilder(),
                TargetPlatform.windows: FadePageTransitionsBuilder(),
                TargetPlatform.linux: FadePageTransitionsBuilder(),
              }),
              appBarTheme: const AppBarTheme(
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.black),
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ))),
          debugShowCheckedModeBanner: false,
          // home: AppNavigation()
        ),
      ),
    );
  }
}

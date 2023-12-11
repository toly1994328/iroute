import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iroute/components/components.dart';
import 'package:toly_menu/src/menu.dart';
import 'package:toly_menu/src/model/menu_state.dart';
import 'package:toly_menu/toly_menu.dart';

import '../v12/app/navigation/transition/fade_page_transitions_builder.dart';
import 'router/menus/menu_tree.dart';
import 'views/top_logo.dart';
import 'views/top_bar.dart';
import 'package:iroute/navigation/router/routers/app.dart';

class TolyBooksApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    initialLocation: '/dashboard/view',
    routes: <RouteBase>[appRoute],
    onException: (BuildContext ctx, GoRouterState state, GoRouter router) {
      router.go('/404', extra: state.uri.toString());
    },
    // redirect: _authRedirect
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
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
    );
  }
}

class BookAppNavigation extends StatefulWidget {
  final Widget content;
  const BookAppNavigation({super.key, required this.content});

  @override
  State<BookAppNavigation> createState() => _BookAppNavigationState();
}

class _BookAppNavigationState extends State<BookAppNavigation> {
  MenuState state = MenuState(
      expandMenus: ['/dashboard'],
      activeMenu: '/dashboard/view',
      items: rootMenu.children);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          DragToMoveWrap(
            child: Container(
              color: const Color(0xff001529),
              width: 210,
              child: Column(
                children: [
                  TopLogo(),
                  Expanded(child: TolyMenu(state: state, onSelect: _onSelect)),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [AppTopBar(), Expanded(child: widget.content)],
            ),
          )
        ],
      ),
    );
  }

  void _onSelect(MenuNode menu) {
    if (menu.isLeaf) {
      state = state.copyWith(activeMenu: menu.path);
      print(menu.path);
      // print(;
      context.go(menu.path);
    } else {
      List<String> menus = [];
      String path = menu.path.substring(1);
      List<String> parts = path.split('/');

      if (parts.isNotEmpty) {
        String path = '';
        for (String part in parts) {
          path += '/$part';
          menus.add(path);
        }
      }

      if (state.expandMenus.contains(menu.path)) {
        menus.remove(menu.path);
      }

      state = state.copyWith(expandMenus: menus);
    }
    setState(() {});
  }
}

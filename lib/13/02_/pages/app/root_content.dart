import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iroute/cases/cases.dart';

import '../color_page.dart';

// GoRouter configuration
final goRouter = GoRouter(
  initialLocation: '/manager',
  routes: [
    GoRoute(
        path: '/dashboard',
        builder: (_,__)=>SizedBox(),
        routes: [
          GoRoute(
            path: 'data_analyse',
            // builder: (context, state) => ColorPage(title: 'data_analyse',),
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: ColorPage(title: 'data_analyse',),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  // Change the opacity of the screen using a Curve based on the the animation's
                  // value
                  return FadeTransition(
                    opacity:
                    CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                    child: child,
                  );
                },
              );
            },
          ),

          GoRoute(
            path: 'work_board',
              builder: (_,__)=>SizedBox(),
            routes: [
              GoRoute(
                path: 'a',
                builder: (context, state) => ColorPage(title: '第一工作区',),
              ),
              GoRoute(
                path: 'b',
                builder: (context, state) => ColorPage(title: '第二工作区',),
              ),
              GoRoute(
                path: 'c',
                builder: (context, state) => ColorPage(title: '第三工作区',),
              ),
            ]
          ),

        ]
    ),

    GoRoute(
        path: '/cases',
        builder: (_,__)=>SizedBox(),
        routes: [
          GoRoute(
            path: 'counter',
            builder: (context, state) => CounterPage(),
          ),
          GoRoute(
            path: 'guess',
            builder: (context, state) => GuessPage(),
          ),
          GoRoute(
            path: 'muyu',
            builder: (context, state) => ColorPage(title: '第三工作区',),
          ),       GoRoute(
            path: 'canvas',
            builder: (context, state) => Paper(),
          ),       GoRoute(
            path: 'muyu',
            builder: (context, state) => ColorPage(title: '第三工作区',),
          ),
        ]
    ),
    GoRoute(
        path: '/manager', builder: (_,__)=>SizedBox(),
        routes: [
          GoRoute(
            path: 'account',
            builder: (context, state) => ColorPage(title: 'account',),
          ),
          GoRoute(
            path: 'role',
            builder: (context, state) => ColorPage(title: 'role',),
          ),
        ]
    ),
  ],
);


class RootContent extends StatelessWidget {
  const RootContent({super.key});

  @override
  Widget build(BuildContext context) {


    return Router.withConfig(config: goRouter);
  }
}

class RootContentDelegate extends RouterDelegate with ChangeNotifier,PopNavigatorRouterDelegateMixin{


  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [

      ],
      onPopPage: (route, result) {
        // appState.selectedBook = null;
        // notifyListeners();
        return route.didPop(result);
      },
    );
  }


  @override
  Future<void> setNewRoutePath(configuration) {
    // TODO: implement setNewRoutePath
    throw UnimplementedError();
  }



}
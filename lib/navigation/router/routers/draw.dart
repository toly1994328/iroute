import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:idraw/idraw.dart';
import 'package:iroute/pages/empty/empty_panel.dart';

final RouteBase drawRouters = GoRoute(
  path: '/draw/chapter:index',
  pageBuilder: (BuildContext context, GoRouterState state) {
    String? index = state.pathParameters['index'];
    Widget child = const EmptyPanel(msg: '暂未实现');
    switch (index) {
      case '1':
        child = const P01Page();
        break;
      case '2':
        child = const P02Page();
        break;
      case '3':
        child = const P03Page();
        break;
      case '4':
        child = const P04Page();
        break;
      case '5':
        child = const P05Page();
        break;
      case '6':
        child = const P06Page();
        break;
      case '7':
        child = const P07Page();
        break;
      case '8':
        child = const P08Page();
        break;
      case '9':
        child = const P09Page();
        break;
      case '10':
        child = const P10Page();
        break;
      case '11':
        child = const P11Page();
        break;
      case '12':
        child = const P12Page();
        break;
      case '13':
        child = const P13Page();
        break;
      case '14':
        child = const P14Page();
        break;
      case '15':
        child = const P15Page();
        break;
      case '16':
        child = const P16Page();
        break;
      case '17':
        child = const P17Page();
        break;
      case '18':
        child = const P18Page();
        break;
    }

    return CustomTransitionPage(
        child: child,
        transitionsBuilder: (ctx, a1, a2, child) => FadeTransition(
              opacity: a1.drive(CurveTween(curve: Curves.easeIn)),
              child: SlideTransition(
                position: Tween<Offset>(
                        begin: Offset.zero, end: const Offset(-1.0, 0.0))
                    .animate(a2),
                child: child,
              ),
            ));
  },
);

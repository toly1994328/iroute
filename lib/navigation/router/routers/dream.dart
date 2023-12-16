import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:idraw/idraw.dart';
import 'package:iroute/pages/empty/empty_panel.dart';

final RouteBase dreamRouters = GoRoute(
  path: '/dream/chapter:index',
  builder:  (BuildContext context, GoRouterState state) {
    String? index = state.pathParameters['index'];
    switch(index){
      case '1':
        return const P01Page();
      case '2':
        return const P01Page();
      case '3':
        return const P03Page();
      case '4':
        return const P04Page();
      case '5':
        return const P05Page();
      case '6':
        return const P06Page();
      case '7':
        return const P07Page();
      case '8':
        return const P08Page();
      case '9':
        return const P09Page();
      case '10':
        return const P10Page();
       case '11':
        return const P11Page();
    }
    return const EmptyPanel(msg: '暂未实现');
  },
);

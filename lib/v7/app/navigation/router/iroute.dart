import 'package:flutter/material.dart';

import '../../../pages/color/color_add_page.dart';
import '../../../pages/color/color_detail_page.dart';
import '../../../pages/color/color_page.dart';
import '../../../pages/counter/counter_page.dart';
import '../../../pages/user/user_page.dart';
import '../../../pages/settings/settings_page.dart';
import '../transition/fade_transition_page.dart';

class IRoute {
  final String path;
  final IRoutePageBuilder? builder;
  final List<IRoute> children;

  const IRoute({
    required this.path,
    this.children = const [],
    this.builder,
  });

  @override
  String toString() {
    return 'IRoute{path: $path, children: $children}';
  }

  IRoute? match(String path) {
    return matchRoute(this, path);
  }

  List<IRoute> find(String input){
    String fixInput = input.substring(1);
    List<IRoute> nodes = findNodes(this,fixInput,0,'/',[]);
    if(nodes.isNotEmpty&&nodes.last.path!=input){
      return [];
    }
    return nodes;
  }

  List<IRoute> findNodes(IRoute node,String input,int deep,String prefix,List<IRoute> result){
    String separator = '/';

    List<String> parts = input.split(separator);
    if(deep>parts.length-1){
      return result;
    }
    String target = parts[deep];
    if(node.children.isNotEmpty){
      List<IRoute> nodes = node.children.where((e) => e.path==prefix+target).toList();
      bool match = nodes.isNotEmpty;
      if(match){
        IRoute matched = nodes.first;
        result.add(matched);
        String nextPrefix = '${matched.path}$separator';
        findNodes(matched, input, ++deep,nextPrefix,result);
      }
    }else{
      return result;
    }
    return result;
  }

  // List<IRoute> findNodes(IRoute node,String input,int deep,String prefix,List<IRoute> result){
  //   String separator = '/';
  //   List<String> parts = input.split(separator);
  //   if(deep>parts.length-1){
  //     return result;
  //   }
  //   String target = parts[deep];
  //   if(node.children.isNotEmpty){
  //     List<IRoute> nodes = node.children.where((e) => e.path==prefix+target).toList();
  //     bool match = nodes.isNotEmpty;
  //     if(match){
  //       IRoute matched = nodes.first;
  //       result.add(matched);
  //       String nextPrefix = '${matched.path}$separator';
  //       findNodes(matched, input, ++deep,nextPrefix,result);
  //     }
  //   }else{
  //     return result;
  //   }
  //   return result;
  // }

  IRoute? matchRoute(IRoute route, String path) {
    if (route.path == path) {
      return route;
    } else {
      if (route.children.isNotEmpty) {
        for (int i = 0; i < route.children.length; i++) {
          IRoute current = route.children[i];
          IRoute? target = matchRoute(current, path);
          if (target != null) {
            return target;
          }
        }
      } else {
        return null;
      }
    }
    return null;
  }
}

typedef IRoutePageBuilder = Page? Function(
    BuildContext context, IRouteData data);

class IRouteData {
  final Object? extra;
  final bool forResult;
  final Uri uri;
  final bool keepAlive;

  IRouteData({
    this.extra,
    required this.uri,
    this.forResult = false,
    this.keepAlive = false,
  });
}

IRoute root = IRoute(path: 'root', children: kDestinationsIRoutes);

List<IRoute> kDestinationsIRoutes = [
  IRoute(
    path: '/color',
    builder: (ctx, data) {
      return const FadeTransitionPage(
        key: ValueKey('/color'),
        child: ColorPage(),
      );
    },
    children: [
      IRoute(
        path: '/color/detail',
        builder: (ctx, data) {
          final Map<String, String> queryParams = data.uri.queryParameters;
          String? selectedColor = queryParams['color'];
          Color color = Colors.black;
          if (selectedColor != null) {
            color = Color(int.parse(selectedColor, radix: 16));
          } else if (data.extra is Color) {
            color = data.extra as Color;
          }
          return FadeTransitionPage(
            key: const ValueKey('/color/detail'),
            child: ColorDetailPage(color: color),
          );
        },
      ),
      IRoute(
          path: '/color/add',
          builder: (ctx, data) {
            return const FadeTransitionPage(
              key: ValueKey('/color/add'),
              child: ColorAddPage(),
            );
          }),
    ],
  ),
  IRoute(
      path: '/counter',
      builder: (ctx, data) {
        return const FadeTransitionPage(
          key: ValueKey('/counter'),
          child: CounterPage(),
        );
      }),
  IRoute(
      path: '/user',
      builder: (ctx, data) {
        return const FadeTransitionPage(
          key: ValueKey('/user'),
          child: UserPage(),
        );
      }),
  IRoute(
      path: '/settings',
      builder: (ctx, data) {
        return const FadeTransitionPage(
          key: ValueKey('/settings'),
          child: SettingPage(),
        );
      }),
];

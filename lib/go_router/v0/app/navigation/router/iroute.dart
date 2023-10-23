import 'package:flutter/cupertino.dart';

import '../../../pages/color/color_add_page.dart';
import '../../../pages/color/color_detail_page.dart';
import '../../../pages/color/color_page.dart';
import '../transition/fade_transition_page.dart';

class IRoute {
  final String path;
  final IRoutePageBuilder builder;
  final List<IRoute> children;

  const IRoute({
    required this.path,
    this.children = const [],
    required this.builder,
  });

  @override
  String toString() {
    return 'IRoute{path: $path, children: $children}';
  }

  List<String> list() {
    return [];
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
    required this.extra,
    required this.uri,
    required this.forResult,
    required this.keepAlive,
  });
}

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
          if (selectedColor != null) {
            Color color = Color(int.parse(selectedColor, radix: 16));
            return FadeTransitionPage(
              key: const ValueKey('/color/detail'),
              child: ColorDetailPage(color: color),
            );
          }
          return null;
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
          child: ColorAddPage(),
        );
      }),
  IRoute(
      path: '/user',
      builder: (ctx, data) {
        return const FadeTransitionPage(
          key: ValueKey('/user'),
          child: ColorAddPage(),
        );
      }),
  IRoute(
      path: '/settings',
      builder: (ctx, data) {
        return const FadeTransitionPage(
          key: ValueKey('/settings'),
          child: ColorAddPage(),
        );
      }),
];

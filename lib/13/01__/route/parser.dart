import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iroute/common/pages/stl_color_page.dart';
import 'package:path_to_regexp/path_to_regexp.dart';
import '../pages/home_page.dart';
import '../pages/color_add_page.dart';
import 'parsed_route.dart';
import 'route_state.dart';

class AppRouteParser extends RouteInformationParser<ParsedRoute> {

  @override
  Future<ParsedRoute> parseRouteInformation(
      RouteInformation routeInformation) async {
    print("=======parseRouteInformation:${routeInformation.uri.path}===================");

    final uri = routeInformation.uri;
    final path = uri.toString();
    final queryParams = uri.queryParameters;

    return ParsedRoute(path, queryParams);
  }

  @override
  RouteInformation? restoreRouteInformation(ParsedRoute configuration) {
    print("=======restoreRouteInformation:${configuration}===================");

    return RouteInformation(uri: Uri.parse(configuration.path));
  }
}

class RootRouterDelegate extends RouterDelegate<ParsedRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {

  final RouteState routeState;


  RootRouterDelegate(this.routeState) {
    routeState.addListener(notifyListeners);
  }

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  ParsedRoute get currentConfiguration {
    print("=======currentConfiguration:${routeState.route.path}===================");

    return routeState.route;
  }

  @override
  void dispose() {
    routeState.removeListener(notifyListeners);
    routeState.dispose();
    super.dispose();
  }

  final _addColorKey = const ValueKey('addColor');

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    List<Page> pages =[];
    final String path = routeState.route.path;

    pages.add(MaterialPage(child: HomePage()));

    String? selectedColor;
    if (path.startsWith('/color/detail') ) {
      selectedColor = routeState.route.queryParameters['color'];
    }

    if(selectedColor!=null){
      pages.add(MaterialPage(child: StlColorPage(
        color: Color(int.parse(selectedColor,radix: 16)),
      )));
    }

    bool isAddPage = path == '/color/add';
    if(isAddPage){
      pages.add(MaterialPage(
          key: _addColorKey,
          child: ColorAddPage()));
    }

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        if (route.settings is Page && (route.settings as Page).key == _addColorKey) {
          routeState.go('/color');
        }

        if(selectedColor!=null){
          selectedColor = null;
          routeState.go('/color');
        }

        return route.didPop(result);
      },
    );
  }

  /// 格式: /a /b

  @override
  Future<void> setNewRoutePath(ParsedRoute configuration) async {
    print("===setNewRoutePath===${configuration}=================");
    routeState.route = configuration;
    return;
  }

// @override
// Future<void> setInitialRoutePath( configuration) async{
//   _pages = [_pageMap['/']!];
//   notifyListeners();
// }
}
